local shrekbox = {}

---@class Layer
---@field _render fun(rblit:blitmap)
---@field pixel fun(lx:integer,ly:integer,color:ccTweaked.colors.color)
---@field text fun(lx:integer,ly:integer,text:string,fg:ccTweaked.colors.color?,bg:ccTweaked.colors.color?)
---@field set_pos fun(sx:integer,sy:integer)
---@field get_pos fun():integer,integer
---@field stl_coords fun(sx:number,sy:number):number,number
---@field lts_coords fun(sx:number,sy:number):number,number
---@field buffer ccTweaked.colors.color[][]
---@field size fun():number,number
---@field clear fun()
---@field scale_x number
---@field scale_y number
---@field z number
---@field label string?
---@field hidden boolean?

---@alias blittable {[1]:string,[2]:string,[3]:string}
---@alias blitmap table<integer,table<integer,blittable>>
---@alias blitbuffer {[1]:string[],[2]:blitchar[],[3]:blitchar[]}[]

---@generic A
---@generic B
---@generic V
---@param f fun(a:A,b:B,v:V):boolean?
local function iter_2d(t, f)
    for a, at in pairs(t) do
        for b, v in pairs(at) do
            if f(a, b, v) then return end
        end
    end
end

local function assert_int(n)
    if n ~= math.floor(n) then
        error(("Number %f is not an integer!"):format(n), 2)
    end
end

---@generic A
---@generic B
---@generic V
---@param t table<A,table<B,V>>
---@param a A
---@param b B
---@param v V
local function set_index_2d(t, a, b, v)
    t[a] = t[a] or {}
    t[a][b] = v
end
---@generic A
---@generic B
---@generic V
---@param t table<A,table<B,V>>
---@param a A
---@param b B
---@return V?
local function get_index_2d(t, a, b)
    if not t[a] then return end
    return t[a][b]
end

---@alias oblit_part {v:blittable,y:integer,x:integer}
---@alias oblit oblit_part[]
---@alias background_lookup ccTweaked.colors.color[][]


---@param win ccTweaked.Window
---@param oblit oblit
---@param bg blitchar
local function normalize_blit_strings(a, b, c, width, bg)
    a = a or ""
    b = b or ""
    c = c or ""
    local lenA = #a
    local lenB = #b
    local lenC = #c
    local target = width
    local function adjust(str, len, padChar)
        if len > target then
            return str:sub(1, target)
        elseif len < target then
            return str .. string.rep(padChar, target - len)
        end
        return str
    end
    -- Default to space when background char is unavailable.
    local bgChar = bg or " "
    a = adjust(a, lenA, " ")
    b = adjust(b, lenB, bgChar)
    c = adjust(c, lenC, bgChar)
    return a, b, c
end

local function render_blit(win, oblit, bg)
    local w, h = win.getSize()
    for i = 1, h do
        local v = oblit[i]
        win.setCursorPos(1, i)
        if v then
            local text = table.concat(v[1])
            local fg = table.concat(v[2]):gsub(shrekbox.transparent_char, bg)
            local bgStr = table.concat(v[3]):gsub(shrekbox.transparent_char, bg)
            text, fg, bgStr = normalize_blit_strings(text, fg, bgStr, w, bg)
            win.blit(text, fg, bgStr)
            v[1] = {}
        else
            local blank = string.rep(" ", w)
            local bgRow = string.rep(bg, w)
            win.blit(blank, bgRow, bgRow)
        end
    end
end

local blit_lut = {}
for i = 0, 15 do
    local n = 2 ^ i
    local s = colors.toBlit(n)
    blit_lut[n] = s
    blit_lut[s] = n
end
shrekbox._blit_lut = blit_lut
-- Transparency
shrekbox.transparent = 0
shrekbox.transparent_char = " "
blit_lut[shrekbox.transparent] = shrekbox.transparent_char
blit_lut[shrekbox.transparent_char] = shrekbox.transparent

shrekbox.contrast = -1
shrekbox.contrast_char = "_"
blit_lut[shrekbox.contrast] = shrekbox.contrast_char
blit_lut[shrekbox.contrast_char] = shrekbox.contrast


---@alias blitchar "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|"a"|"b"|"c"|"d"|"e"|"f"|" "|"_"

local closest_color_to_lookup = {}
---@type table<blitchar,number[]>
local palette_colors = {}
---@type table<blitchar,blitchar>
local contrast_lookup = {}
---@param a number[]
---@param b number[]
---@return number
local function color_dist(a, b)
    return (a[1] - b[1]) ^ 2 + (a[2] - b[2]) ^ 2 + (a[3] - b[3]) ^ 2
end

--- Array of colors from darkest (1) to brightest (16)
---@type blitchar[]
local color_bright_order = {}
--- Lookup from blitcolor to brightness index into color_bright_order
---@type table<blitchar,integer>
local bright_pos_lookup = {}

--- Array of colors from desaturated (1) to saturated (16)
---@type blitchar[]
local color_sat_order = {}
--- Lookup from blitcolor to saturation index into color_sat_order
---@type table<blitchar,integer>
local sat_pos_lookup = {}

---Shift a given blitchar color brighter/darker by a number of levels
---@param ch blitchar
---@param dir integer
function shrekbox.shift_brightness(ch, dir)
    local index = bright_pos_lookup[ch]
    index = math.max(1, math.min(index + dir, 16))
    return color_bright_order[index]
end

---Shift a given blitchar color saturated/desaturated by a number of levels
---@param ch blitchar
---@param dir integer
function shrekbox.shift_saturation(ch, dir)
    local index = sat_pos_lookup[ch]
    index = math.max(1, math.min(index + dir, 16))
    return color_sat_order[index]
end

---@return integer
---@return ...
function shrekbox.round(n, ...)
    ---@diagnostic disable-next-line: missing-return-value
    if not n then return end
    return math.floor(n + 0.5), shrekbox.round(...)
end

---@param c number[]
---@return number
local function brightness(c)
    return c[1] ^ 2 + c[2] ^ 2 + c[3] ^ 2
end

local function rgb_2_hsl(c)
    local r, g, b = c[1], c[2], c[3]
    local cmax = math.max(r, g, b)
    local cmin = math.min(r, g, b)
    local delta = cmax - cmin
    local hue, sat = 0, 0
    local lum = (cmax + cmin) / 2
    sat = lum > 0.5 and (delta / (2 - cmax - cmin)) or delta / (cmax + cmin)
    if delta == 0 then
        hue = 0
        sat = 0
    elseif delta == r then
        hue = (g - b) / delta + (g < b and 6 or 0)
    elseif delta == g then
        hue = (b - r) / delta + 2
    elseif delta == b then
        hue = (r - g) / delta + 4
    end
    hue = hue / 6
    return { hue, sat, lum }
end
local expect = require("cc.expect").expect
---@param color blitchar
---@param a blitchar
---@param b blitchar
---@return blitchar
local function closer_color(color, a, b)
    expect(1, color, "string")
    expect(2, a, "string")
    expect(3, b, "string")
    a, b = a < b and a or b, b >= a and b or a
    if color == a then return a end
    if color == b then return b end
    if a == b then return a end
    if color == shrekbox.transparent_char then
        return color
    elseif a == shrekbox.transparent_char then
        return b
    elseif b == shrekbox.transparent_char then
        return a
    end
    local lookup_index = a .. b
    local lookup = get_index_2d(closest_color_to_lookup, lookup_index, color)
    if lookup then return lookup end
    local rgb = palette_colors[color]
    if not rgb then error(("Invalid color %s"):format(color), 2) end
    if not palette_colors[a] then error(("Invalid color a %s"):format(a), 2) end
    if not palette_colors[b] then error(("Invalid color b %s"):format(b), 2) end
    local a_dist = color_dist(rgb, palette_colors[a])
    local b_dist = color_dist(rgb, palette_colors[b])
    local closest = a_dist < b_dist and a or b
    set_index_2d(closest_color_to_lookup, lookup_index, color, closest)
    return closest
end
local function get_palette_colors()
    local brighness_calc = {}
    local saturation_calc = {}
    for i = 0, 15 do
        local color = 2 ^ i
        local ch = blit_lut[color]
        local rgb = { term.getPaletteColor(color) }
        palette_colors[ch] = rgb
        local bright = brightness(rgb)
        brighness_calc[#brighness_calc + 1] = { bright, ch }
        local hsl = rgb_2_hsl(rgb)
        saturation_calc[#saturation_calc + 1] = { hsl[2], ch }
    end
    table.sort(brighness_calc, function(a, b)
        return a[1] > b[1]
    end)
    table.sort(saturation_calc, function(a, b)
        return a[1] > b[1]
    end)
    for i = 1, 16 do
        color_bright_order[i] = brighness_calc[i][2]
        bright_pos_lookup[brighness_calc[i][2]] = i
        color_sat_order[i] = saturation_calc[i][2]
        sat_pos_lookup[saturation_calc[i][2]] = i
    end
    local darkest, brightest = color_bright_order[1], color_bright_order[16]
    closest_color_to_lookup = {}
    for i = 0, 15 do
        local color = 2 ^ i
        local ch = blit_lut[color]
        contrast_lookup[ch] = closer_color(ch, darkest, brightest) == darkest and brightest or darkest
    end
end
get_palette_colors()

---@type table<string,string[]>
local textel_blit_lut = {}
local textel_majority_color_lut = {}
---@param textel_layout string[]
---@return blitchar
---@return blitchar
local function get_majority_color(textel_layout)
    local color_frequency_map = {}
    local max_count = 0
    local max_color = "0"
    local max_2_count = 0
    local max_2_color = "0"
    for i = 1, 6 do
        local ch = textel_layout[i]
        color_frequency_map[ch] = (color_frequency_map[ch] or 0) + 1
        if color_frequency_map[ch] > max_count then
            if max_color ~= ch then
                max_2_count = max_count
                max_2_color = max_color
            end
            max_color = ch
            max_count = color_frequency_map[ch]
        elseif color_frequency_map[ch] > max_2_count then
            max_2_count = color_frequency_map[ch]
            max_2_color = ch
        end
    end
    return max_color, max_2_color
end
local function clone_blit(t)
    return { table.unpack(t, 1, 3) }
end
textel_blit_lut[shrekbox.transparent_char:rep(6)] = {}
---@param textel_layout string[]
---@return string[]
---@return blitchar common
local function get_textel_blit(textel_layout, box)
    local textel_layout_s = table.concat(textel_layout, "")
    if textel_blit_lut[textel_layout_s] then
        return clone_blit(textel_blit_lut[textel_layout_s]), textel_majority_color_lut[textel_layout_s]
    end
    box.profiler.start_region("textel_blit")
    local ch = textel_layout[6]
    local textel = 0
    local max_color, max_2_color = get_majority_color(textel_layout)
    local majority_color = max_color
    ch = closer_color(ch, max_color, max_2_color)
    if ch == max_color then
        -- swap colors
        max_color, max_2_color = max_2_color, max_color
    end
    local interp_colors = ch
    for i = 5, 1, -1 do
        ch = textel_layout[i]
        ch = closer_color(ch, max_color, max_2_color)
        interp_colors = interp_colors .. ch
        textel = bit32.lshift(textel, 1) + (ch == max_color and 1 or 0)
    end
    ch = string.char(textel + 128)
    local blit = {
        ch,
        max_color,
        max_2_color
    }
    textel_blit_lut[textel_layout_s] = clone_blit(blit)
    textel_majority_color_lut[textel_layout_s] = majority_color
    box.profiler.end_region("textel_blit")
    return blit, majority_color
end

local transparency_lookup = {
    [shrekbox.transparent_char] = true,
    [shrekbox.contrast_char] = true
}
---@param fg blitchar
---@param bg blitchar
---@return boolean
local function is_blit_transparent(fg, bg)
    return transparency_lookup[fg] or transparency_lookup[bg]
end
---@param box ShrekBox
---@param rblit blitbuffer
---@param x integer
---@param y integer
local function apply_transparent(ch, fg, bg, color, box, rblit, x, y)
    box.profiler.start_region("trans")
    bg = bg == shrekbox.transparent_char and color or bg
    fg = (fg == shrekbox.transparent_char and color) or
        (fg == shrekbox.contrast_char and contrast_lookup[bg]) or fg
    rblit[y][1][x] = ch
    rblit[y][2][x] = fg
    rblit[y][3][x] = bg
    box.profiler.end_region("trans")
end

---@param box ShrekBox
---@param layer Layer
local function insert_default_layer_funcs(box, layer)
    --- Get the size of this layer (in layer units)
    ---@return number
    ---@return number
    function layer.size()
        local sw, sh = box._get_window().getSize()
        return sw * layer.scale_x, sh * layer.scale_y
    end

    --- Screen To Layer Coordinates
    ---@param sx number
    ---@param sy number
    ---@return number
    ---@return number
    function layer.stl_coords(sx, sy)
        local lpx, lpy = layer.get_pos()
        return (sx - lpx + 1) * layer.scale_x, (sy - lpy + 1) * layer.scale_y
    end

    --- Layer to screen coordinates
    ---@param lx number
    ---@param ly number
    ---@return number
    ---@return number
    function layer.lts_coords(lx, ly)
        local lpx, lpy = layer.get_pos()
        return lx / layer.scale_x - lpx + 1, ly / layer.scale_y - lpy + 1
    end
end

local buffer_meta = {
    __index = function(t, k)
        t[k] = {}
        return t[k]
    end
}
---@return table<integer,table<integer,ccTweaked.colors.color>>
local function generate_buffer()
    return setmetatable({}, buffer_meta)
end

local rblit_buffer_meta = {
    __index = function(t, k)
        t[k] = generate_buffer()
        return t[k]
    end
}
local function generate_rblit_buffer()
    return setmetatable({}, rblit_buffer_meta)
end

local function emtpy_textel()
    return { ' ', ' ', ' ', ' ', ' ', ' ' }
end

---@param buffer table<integer,table<integer,ccTweaked.colors.color>>
local function pixel_layer_render(buffer, textel_buffer)
    for ly, line in pairs(buffer) do
        for lx, color in pairs(line) do
            local iy = math.ceil(ly / 3)
            local dy = (ly - 1) % 3
            local ix = math.ceil(lx / 2)
            local dx = (lx - 1) % 2
            local i = (dy * 2 + dx) + 1
            local t = textel_buffer[iy][ix] or emtpy_textel()
            t[i] = blit_lut[color]
            textel_buffer[iy][ix] = t
            -- if t[1] == shrekbox.transparent_char and t[1] == t[2] and t[2] == t[3] and t[4] == t[5] and t[5] == t[6] then
            --     textel_buffer[iy][ix] = nil
            -- end
        end
    end
end

---@param box ShrekBox
---@param label string?
---@return Layer
local function new_pixel_layer(box, label)
    local px, py = 1, 1
    local layer
    local textel_buffer = generate_buffer()
    layer = {
        label = label,
        scale_x = 2,
        scale_y = 3,
        z = 0,
        clear = function()
            textel_buffer = generate_buffer()
        end,
        buffer = generate_buffer(),
        pixel = function(lx, ly, color)
            box.profiler.start_region("pixel")
            assert_int(lx)
            assert_int(ly)
            layer.buffer[ly][lx] = color
            box.profiler.end_region("pixel")
        end,
        _render = function(rblit)
            local tid = layer.label or ("pr_" .. layer.z)
            box.profiler.start_region(tid)
            pixel_layer_render(layer.buffer, textel_buffer)
            box.profiler.start_region("gen_blit")
            iter_2d(textel_buffer, function(y, x, v)
                x = x + px - 1
                y = y + py - 1
                if not box.pos_on_screen(x, y) then return end
                local ch, fg, bg = rblit[y][1][x], rblit[y][2][x], rblit[y][3][x]
                if ch and is_blit_transparent(fg, bg) then
                    local c = get_majority_color(v)
                    apply_transparent(ch, fg, bg, c, box, rblit, x, y)
                    return
                elseif ch then
                    return
                end
                local textel_blit, majority = get_textel_blit(v, box)
                rblit[y][1][x] = textel_blit[1]
                rblit[y][2][x] = textel_blit[2]
                rblit[y][3][x] = textel_blit[3]
            end)
            box.profiler.end_region("gen_blit")
            layer.buffer = generate_buffer()
            box.profiler.end_region(tid)
        end,
        text = function(lx, ly, text, fg, bg)
            assert_int(lx)
            assert_int(ly)
            error("NYI", 2)
        end,
        set_pos = function(sx, sy)
            assert_int(sx)
            assert_int(sy)
            px, py = sx, sy
        end,
        get_pos = function()
            return px, py
        end
    }
    insert_default_layer_funcs(box, layer)
    return layer
end

local function empty_bixtel()
    return { ' ', ' ', ' ' }
end
---@param buffer table<integer,table<integer,ccTweaked.colors.color>>
local function bixel_layer_render(buffer, bixtel_buffer)
    for ly, line in pairs(buffer) do
        for lx, color in pairs(line) do
            local iy = math.ceil(ly / 3)
            local dy = (ly - 1) % 3
            local i = dy + 1
            local t = bixtel_buffer[iy][lx] or empty_bixtel()
            t[i] = blit_lut[color]
            bixtel_buffer[iy][lx] = t
            -- if t[1] == shrekbox.transparent_char and t[1] == t[2] and t[2] == t[3] then
            --     set_index_2d(bixtel_buffer, iy, lx, nil)
            -- end
        end
    end
end
---@param box ShrekBox
---@param label string?
---@return Layer
local function new_bixel_layer(box, label)
    local px, py = 1, 1
    local layer
    local bixtel_buffer = generate_buffer()
    layer = {
        label = label,
        scale_x = 1,
        scale_y = 1.5,
        z = 0,
        clear = function()
            bixtel_buffer = generate_buffer()
        end,
        buffer = generate_buffer(),
        pixel = function(lx, ly, color)
            box.profiler.start_region("bixel")
            assert_int(lx)
            assert_int(ly)
            layer.buffer[ly][lx] = color
            box.profiler.end_region("bixel")
        end,
        _render = function(rblit)
            local tid = layer.label or ("br_" .. layer.z)
            box.profiler.start_region(tid)
            bixel_layer_render(layer.buffer, bixtel_buffer)
            iter_2d(bixtel_buffer, function(y, x, v)
                x = x + px - 1
                y = y + py - 1
                local upper_y = (y * 2) - 1
                local lower_y = y * 2
                if not box.pos_on_screen(x, y) then return end
                local uch, ufg, ubg = rblit[upper_y][1][x], rblit[upper_y][2][x], rblit[upper_y][3][x]
                local lch, lfg, lbg = rblit[lower_y][1][x], rblit[lower_y][2][x], rblit[lower_y][3][x]
                local col_1 = v[1]
                local col_2 = v[2]
                local col_3 = v[3]
                if uch and is_blit_transparent(ufg, ubg) then
                    apply_transparent(uch, ufg, ubg, col_1, box, rblit, x, upper_y)
                elseif not uch then
                    rblit[upper_y][1][x] = "\143"
                    rblit[upper_y][2][x] = col_1
                    rblit[upper_y][3][x] = col_2
                end
                if lch and is_blit_transparent(lfg, lbg) then
                    apply_transparent(lch, lfg, lbg, col_3, box, rblit, x, lower_y)
                elseif not lch then
                    rblit[lower_y][1][x] = "\131"
                    rblit[lower_y][2][x] = col_2
                    rblit[lower_y][3][x] = col_3
                end
            end)
            layer.buffer = generate_buffer()
            box.profiler.end_region(tid)
        end,
        text = function(lx, ly, text, fg, bg)
            assert_int(lx)
            assert_int(ly)
            error("NYI", 2)
        end,
        set_pos = function(sx, sy)
            assert_int(sx)
            assert_int(sy)
            px, py = sx, sy
        end,
        get_pos = function()
            return px, py
        end
    }
    insert_default_layer_funcs(box, layer)
    return layer
end

---@param box ShrekBox
---@return Layer
local function new_text_layer(box, label)
    local text_buffer = {}
    local px, py = 1, 1
    local layer
    layer = {
        label = label,
        scale_x = 1,
        scale_y = 1,
        z = 0,
        clear = function()
            text_buffer = {}
            layer.buffer = generate_buffer()
        end,
        buffer = generate_buffer(),
        text = function(lx, ly, text, fg, bg)
            assert_int(lx)
            assert_int(ly)
            local fgc = fg and blit_lut[fg] or shrekbox.contrast_char
            local bgc = bg and blit_lut[bg] or shrekbox.transparent_char
            for i = 1, #text do
                local ch = text:sub(i, i)
                set_index_2d(text_buffer, ly, lx + i - 1, {
                    ch,
                    fgc,
                    bgc
                })
            end
        end,
        pixel = function(lx, ly, color)
            assert_int(lx)
            assert_int(ly)
            if color == shrekbox.transparent then
                set_index_2d(text_buffer, ly, lx, nil)
                return
            end
            set_index_2d(text_buffer, ly, lx, {
                " ",
                blit_lut[color],
                blit_lut[color]
            })
        end,
        _render = function(rblit)
            local tid = layer.label or ("tr_" .. layer.z)
            box.profiler.start_region(tid)
            iter_2d(text_buffer, function(y, x, v)
                x = x + px - 1
                y = y + py - 1
                if not box.pos_on_screen(x, y) then return end
                local ofg, obg = v[2], v[3]
                local ch, efg, ebg = rblit[y][1][x], rblit[y][2][x], rblit[y][3][x]
                if ch and is_blit_transparent(efg, ebg) then
                    apply_transparent(ch, efg, ebg, obg, box, rblit, x, y)
                    return
                elseif ch then
                    return
                end
                rblit[y][1][x] = v[1]
                rblit[y][2][x] = ofg
                rblit[y][3][x] = obg
            end)
            box.profiler.end_region(tid)
        end,
        set_pos = function(sx, sy)
            assert_int(sx)
            assert_int(sy)
            px, py = sx, sy
        end,
        get_pos = function()
            return px, py
        end
    }
    insert_default_layer_funcs(box, layer)
    return layer
end


---@diagnostic disable-next-line: undefined-global
local is_craftos_pc = not not periphemu
local epoch_unit = is_craftos_pc and "nano" or "utc"
local time_ms_divider = is_craftos_pc and 1000000 or 1
local time_divider = is_craftos_pc and 1000000000 or 1000
---@param root_name string
---@return Profiler
local function new_profiler(root_name)
    ---@class Profile
    ---@field total number
    ---@field frame number
    ---@field name string
    ---@field t0 number?
    ---@field children Profile[]
    ---@field child_map table<string,Profile>
    ---@field parent Profile?
    ---@field depth integer
    ---@field count number
    ---@field total_count number
    ---@field average_time_ms number
    ---@type Profile
    local active_profile = nil
    ---@class Profiler
    local profiler = {}
    ---@type table<string,boolean>
    local hidden_regions = {}
    ---@type table<string,boolean>
    local collapsed_regions = {}
    ---@type table<string,boolean>
    local yield_regions = {}
    local total_frames = 1
    local active = false

    ---@param name string
    local function add_profile(name)
        ---@type Profile
        local region_timer = {
            total = 0,
            frame = 0,
            name = name,
            parent = active_profile,
            children = {},
            child_map = {},
            depth = 0,
            count = 0,
            total_count = 0,
            average_time_ms = 1
        }
        if active_profile then
            region_timer.depth = active_profile.depth + 1
            active_profile.children[#active_profile.children + 1] = region_timer
            active_profile.child_map[name] = region_timer
        end
        return region_timer
    end
    local root_profile = add_profile(root_name)

    ---Start a new region, creating it if it hasn't been made before.
    ---Any code within this region will be timed.
    ---Multiple calls in the same frame (and parent region) are timed together.
    ---@param name string
    function profiler.start_region(name)
        if not active then return end
        local child_region
        if not active_profile and name == root_profile.name then
            child_region = root_profile
        else
            child_region = active_profile.child_map[name]
        end
        if not child_region then
            child_region = add_profile(name)
        end
        active_profile = child_region
        ---@diagnostic disable-next-line: param-type-mismatch
        active_profile.t0 = os.epoch(epoch_unit)
    end

    ---Mark the end of a started region, will error if there is some other active region
    ---@param name string
    function profiler.end_region(name, _allow_empty)
        if not active then return end
        if not active_profile and _allow_empty then
            return
        end
        assert(active_profile.name == name, ("Attempt to end region not active! %s"):format(name))
        local delta = os.epoch(epoch_unit) - active_profile.t0
        active_profile.frame = active_profile.frame + delta
        active_profile.count = active_profile.count + 1
        active_profile = active_profile.parent
    end

    ---Start a new yield region, creating it if it hasn't been made before.
    ---Any code within this region will be timed and subtracted from the frametime.
    ---Multiple calls in the same frame (and parent region) are timed together.
    ---@param name string
    function profiler.start_yield(name)
        yield_regions[name] = true
        profiler.start_region(name)
    end

    ---Mark the end of a started yield region, will error if there is some other active region
    ---@param name string
    function profiler.end_yield(name)
        profiler.end_region(name)
    end

    function profiler.start_frame()
        active = true
        profiler.start_region(root_profile.name)
    end

    ---@param profile Profile
    local function profiler_end_frame(profile)
        profile.total = profile.total + profile.frame
        profile.total_count = profile.total_count + profile.count
        if yield_regions[profile.name] then
            local parent = assert(profile.parent)
            repeat
                parent.total = parent.total - profile.frame
                parent = parent.parent
            until not parent
        end
        profile.count = 0
        profile.frame = 0
        for i, v in ipairs(profile.children) do
            profiler_end_frame(v)
        end
    end
    function profiler.end_frame()
        total_frames = total_frames + 1
        profiler.end_region(root_profile.name, true)
        profiler_end_frame(root_profile)
    end

    ---@param layer Layer
    ---@param profile Profile
    local function render_profile(layer, profile, y)
        if hidden_regions[profile.name] then
            return y
        end
        local s = ("|"):rep(profile.depth)
        if collapsed_regions[profile.name] then
            s = s .. "+"
        else
            s = s .. "\\"
        end
        local average_time_ms = profile.total / total_frames / time_ms_divider
        profile.average_time_ms = average_time_ms
        local average_count = profile.total_count / total_frames
        local parent_time_ms = profile.parent and profile.parent.average_time_ms or average_time_ms
        local percent = average_time_ms / parent_time_ms * 100
        if percent ~= percent then percent = 100 end
        percent = shrekbox.round(percent)
        if yield_regions[profile.name] then
            s = s .. "[YLD] "
            percent = 0
        else
            s = s .. ("[%3d] "):format(percent)
        end
        s = s .. ("%s) avg:%.2fms, avg#:%.1f, #:%d"):format(profile.name,
            average_time_ms, average_count, profile.count)
        layer.text(1, y, s, colors.white, colors.black)
        y = y + 1
        if not collapsed_regions[profile.name] then
            for i, v in ipairs(profile.children) do
                y = render_profile(layer, v, y)
            end
        end
        return y
    end

    ---@param layer Layer
    ---@param y integer
    function profiler.render(layer, y)
        render_profile(layer, root_profile, y)
    end

    ---Hide a profile and it's children by name
    ---@param name string
    ---@param hide boolean? true default
    function profiler.hide(name, hide)
        if hide == nil then hide = true end
        hidden_regions[name] = hide
    end

    ---Collapse (hide) a profile's children by name
    ---@param name string
    ---@param collapse boolean? true default
    function profiler.collapse(name, collapse)
        if collapse == nil then collapse = true end
        collapsed_regions[name] = collapse
    end

    ---@return Profile
    function profiler._get_root()
        return root_profile
    end

    return profiler
end

---@param win ccTweaked.Window
function shrekbox.new(win)
    ---@class ShrekBox
    local box = {
        overlay = false
    }

    local overlay_layer = new_text_layer(box, "overlay")
    overlay_layer.z = math.huge
    local background_layer = new_text_layer(box, "bg_fill")
    overlay_layer.z = -math.huge
    local layers = {}
    local profiler = new_profiler("total")
    -- By default collapse the internal shrekbox timings
    -- You can uncollapse this by doing box.profiler.collapse("shrekbox", false)
    profiler.collapse("shrekbox")
    box.profiler = profiler

    function box.sort_layers()
        table.sort(layers, function(a, b)
            return a.z > b.z -- sort this the opposite way, render front to back
        end)
    end

    function box._get_window()
        return win
    end

    ---@param z number
    ---@param label string?
    function box.add_pixel_layer(z, label)
        local layer = new_pixel_layer(box, label)
        layers[#layers + 1] = layer
        layer.z = z
        box.sort_layers()
        return layer
    end

    ---@param z number
    ---@param label string?
    function box.add_bixel_layer(z, label)
        local layer = new_bixel_layer(box, label)
        layers[#layers + 1] = layer
        layer.z = z
        box.sort_layers()
        return layer
    end

    ---@param z number
    ---@param label string?
    function box.add_text_layer(z, label)
        local layer = new_text_layer(box, label)
        layers[#layers + 1] = layer
        layer.z = z
        box.sort_layers()
        return layer
    end

    ---Fill the background layer with a color
    ---@param color ccTweaked.colors.color
    function box.fill(color)
        local ww, wh = win.getSize()
        local s = (" "):rep(ww)
        for y = 1, wh do
            background_layer.text(1, y, s, color, color)
        end
    end

    local total_time = 1
    local last_frametime = 0
    local total_frames = 0
    local function render_debug()
        local real_fps = total_frames / (total_time / time_divider)
        local root = profiler._get_root()
        local theoretical_fps = root.total_count / (root.total / time_divider)
        if theoretical_fps ~= theoretical_fps then theoretical_fps = 0 end
        overlay_layer.text(1, 1,
            ("%3dfps (t:%3dfps)"):format(real_fps, theoretical_fps),
            colors.white, colors.black)
        profiler.render(overlay_layer, 2)
    end

    ---@type blitbuffer
    local rblit = generate_rblit_buffer()
    local t0 = os.epoch(epoch_unit)
    local function _render()
        profiler.end_region("user", true)
        win.setVisible(false)
        win.setCursorPos(1, 1)
        ---@diagnostic disable-next-line: param-type-mismatch
        local t1 = os.epoch(epoch_unit)
        last_frametime = (t1 - t0)
        total_time = total_time + last_frametime
        total_frames = total_frames + 1
        ---@diagnostic disable-next-line: param-type-mismatch
        t0 = os.epoch(epoch_unit)
        overlay_layer.clear()
        if box.overlay then
            render_debug()
            overlay_layer._render(rblit)
        end
        profiler.end_frame()
        profiler.start_frame()
        profiler.start_region("shrekbox")
        for i, v in ipairs(layers) do -- rendering from front to back
            if not v.hidden then
                v._render(rblit)
            end
        end
        background_layer._render(rblit)
        profiler.start_region("blit!")
        render_blit(win, rblit, "a")
        profiler.end_region("blit!")
        profiler.end_region("shrekbox")
        win.setVisible(true)
        profiler.start_region("user")
    end

    function box.render()
        local ok, err = pcall(_render)
        if not ok then
            term.clear()
            term.setCursorPos(1, 1)
            print("An error occured while rendering!")
            error(err, 0)
        end
    end

    ---Check if a position is on the visible window
    ---@param sx number
    ---@param sy number
    ---@return boolean
    function box.pos_on_screen(sx, sy)
        local sw, sh = win.getSize()
        if sx < 1 or sy < 1 then return false end
        if sx > sw or sy > sh then return false end
        return true
    end

    box.fill(colors.black)

    return box
end

function shrekbox.load_file(fn)
    local f = assert(fs.open(fn, "r"))
    local s = f.readAll() --[[@as string]]
    f.close()
    return s
end

function shrekbox.save_file(fn, s)
    local f = assert(fs.open(fn, "w"))
    f.write(s)
    f.close()
end

return shrekbox
