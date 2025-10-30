local term = assert(rawget(_G, "term"), "term API unavailable")
local fs = assert(rawget(_G, "fs"), "fs API unavailable")
local http = assert(rawget(_G, "http"), "http API unavailable")
local read = assert(rawget(_G, "read"), "read API unavailable")
local osLib = assert(rawget(_G, "os"), "os API unavailable")
local sleep = osLib.sleep or function() end

local VERSION_TARGETS = {
  regular = {
    key = "regular",
    description = "PixelUI (regular)",
    url = "https://raw.githubusercontent.com/Shlomo1412/PixelUI-v2/main/pixelui.lua",
    defaultPath = "pixelui.lua"
  },
  compressed = {
    key = "compressed",
    description = "PixelUI (compressed)",
    url = "https://raw.githubusercontent.com/Shlomo1412/PixelUI-v2/main/compressed/pixelui.lua",
    defaultPath = "pixelui_compressed.lua"
  }
}

local SHREKBOX_URL = "https://codeberg.org/ShreksHellraiser/shrekbox/raw/branch/main/shrekbox.lua"
local SHREKBOX_DEFAULT_PATH = "shrekbox.lua"

local function trim(value)
  if not value then return "" end
  return value:match("^%s*(.-)%s*$")
end

local function ensureParent(path)
  local dir = fs.getDir(path)
  if dir ~= "" and not fs.exists(dir) then
    fs.makeDir(dir)
  end
end

local function promptLine(text)
  term.write(text)
  return trim(read())
end

local function promptVersion()
  while true do
    local input = promptLine("Install compressed or regular? (Def: regular) r/c > ")
    if input == "" then
      return VERSION_TARGETS.regular
    end
    input = input:lower()
    if input == "r" or input == "regular" then
      return VERSION_TARGETS.regular
    elseif input == "c" or input == "compressed" then
      return VERSION_TARGETS.compressed
    end
    print("Please enter 'r' for regular or 'c' for compressed.")
  end
end

local function promptYesNo(message, defaultYes)
  local hint = defaultYes and " (Def: yes) y/n > " or " (Def: no) y/n > "
  while true do
    local input = promptLine(message .. hint)
    if input == "" then
      return defaultYes
    end
    input = input:lower()
    if input == "y" or input == "yes" then
      return true
    elseif input == "n" or input == "no" then
      return false
    end
    print("Please enter 'y' for yes or 'n' for no.")
  end
end

local function promptPath(message, defaultPath)
  local input = promptLine(message .. " (Def: " .. defaultPath .. ") > ")
  if input == "" then
    return defaultPath
  end
  return input
end

local function downloadFile(url, outputPath, label)
  print("Downloading " .. label .. "...")
  local succeeded, handle = pcall(http.get, url, nil, true)
  if not succeeded or not handle then
    local reason = handle or "unknown error"
    print("  Failed: " .. tostring(reason))
    return false
  end

  local data = handle.readAll() or ""
  handle.close()

  ensureParent(outputPath)
  local file, err = fs.open(outputPath, "w")
  if not file then
    print("  Failed to open " .. outputPath .. ": " .. tostring(err))
    return false
  end
  file.write(data)
  file.close()

  print("  Saved " .. label .. " -> " .. outputPath .. " (" .. #data .. " bytes)")
  return true
end

local function main()
  print("PixelUI Installer (Console)")
  print(string.rep("-", 28))

  if not http.get then
    print("HTTP API is disabled. Enable it in the ComputerCraft config and retry.")
    return
  end

  local versionChoice = promptVersion()
  local pixeluiPath = promptPath("Save PixelUI as?", versionChoice.defaultPath)
  local grabShrekbox = promptYesNo("Download ShrekBox too?", false)
  local shrekboxPath
  if grabShrekbox then
    shrekboxPath = promptPath("Save ShrekBox as?", SHREKBOX_DEFAULT_PATH)
  end

  print("")
  print("Summary:")
  print("  PixelUI build: " .. versionChoice.description)
  print("  PixelUI file : " .. pixeluiPath)
  if grabShrekbox then
    print("  ShrekBox file: " .. shrekboxPath)
  else
    print("  ShrekBox     : skipped")
  end

  local proceed = promptYesNo("Proceed with download?", true)
  if not proceed then
    print("Aborted by user.")
    return
  end

  local okPixel = downloadFile(versionChoice.url, pixeluiPath, versionChoice.description)
  local okShrek = true
  if grabShrekbox then
    okShrek = downloadFile(SHREKBOX_URL, shrekboxPath, "ShrekBox")
  end

  if okPixel and okShrek then
    print("")
    print("All downloads completed successfully.")
  else
    print("")
    print("Completed with errors. See messages above.")
  end

  sleep() -- allow logs to flush before returning
end

main()
