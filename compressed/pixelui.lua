local F=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local _=assert(rawget(_G,"os"),"os API unavailable")
local Z=assert(_.pullEvent,"os.pullEvent unavailable")
local ee=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local W=table.pack or function(...)
return{n=select("#",...),...}
end
local Y=assert(table.unpack,"table.unpack unavailable")
local t=require("cc.expect").expect
local P=require("shrekbox")
local w={
version="0.1.0"
}
local L={
linear=function(e)
return e
end,
easeInQuad=function(e)
return e*e
end,
easeOutQuad=function(e)
local e=1-e
return 1-e*e
end,
easeInOutQuad=function(e)
if e<.5 then
return 2*e*e
end
local e=-2*e+2
return 1-(e*e)/2
end,
easeOutCubic=function(e)
local e=1-e
return 1-e*e*e
end
}
local i={}
i.__index=i
local p={}
p.__index=p
setmetatable(p,{__index=i})
local r={}
r.__index=r
setmetatable(r,{__index=p})
local A={}
A.__index=A
setmetatable(A,{__index=i})
local j={}
j.__index=j
setmetatable(j,{__index=i})
local q={}
q.__index=q
setmetatable(q,{__index=i})
local x={}
x.__index=x
setmetatable(x,{__index=i})
local v={}
v.__index=v
setmetatable(v,{__index=i})
local l={}
l.__index=l
setmetatable(l,{__index=i})
local k={}
k.__index=k
local E={}
E.__index=E
local c={}
c.__index=c
setmetatable(c,{__index=i})
local d={}
d.__index=d
setmetatable(d,{__index=i})
local u={}
u.__index=u
setmetatable(u,{__index=i})
local m={}
m.__index=m
setmetatable(m,{__index=i})
local b={}
b.__index=b
setmetatable(b,{__index=i})
local g={}
g.__index=g
setmetatable(g,{__index=i})
local n={}
n.__index=n
setmetatable(n,{__index=i})
local f={}
f.__index=f
setmetatable(f,{__index=i})
local O={}
O.__index=O
setmetatable(O,{__index=i})
local s={}
s.__index=s
local h={"top","right","bottom","left"}
local X=string.char(7)
local R={
info={bg=e.blue,fg=e.white,accent=e.lightBlue,icon="i"},
success={bg=e.green,fg=e.black,accent=e.lime,icon="+"},
warning={bg=e.orange,fg=e.black,accent=e.yellow,icon="!"},
error={bg=e.red,fg=e.white,accent=e.white,icon="x"}
}
local function B(e)
if e==nil then
return"info"
end
local e=tostring(e):lower()
if R[e]then
return e
end
return"info"
end
local function M(e)
if e==nil then
return 1,1,1,1
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
return e,e,e,e
end
local n,s,i,o=1,1,1,1
if type(e)=="table"then
local a=e.horizontal or e.x
local t=e.vertical or e.y
if a~=nil then
a=math.max(0,math.floor(a))
n=a
s=a
end
if t~=nil then
t=math.max(0,math.floor(t))
i=t
o=t
end
if e.left~=nil then
n=math.max(0,math.floor(e.left))
end
if e.right~=nil then
s=math.max(0,math.floor(e.right))
end
if e.top~=nil then
i=math.max(0,math.floor(e.top))
end
if e.bottom~=nil then
o=math.max(0,math.floor(e.bottom))
end
end
return n,s,i,o
end
local function y(t,a,e)
if a<=0 then
e[#e+1]=""
return
end
t=(t or""):gsub("\r","")
if t==""then
e[#e+1]=""
return
end
local t=t
while#t>a do
local n=t:sub(1,a)
local o
for e=a,1,-1 do
local t=n:sub(e,e)
if t:match("%s")then
o=e-1
break
end
end
if o and o>=1 then
local i=t:sub(1,o)
i=i:gsub("%s+$","")
if i==""then
i=t:sub(1,a)
o=a
end
e[#e+1]=i
t=t:sub(o+1)
else
e[#e+1]=n
t=t:sub(a+1)
end
t=t:gsub("^%s+","")
if t==""then
break
end
end
if t~=""then
e[#e+1]=t
elseif#e==0 then
e[#e+1]=""
end
end
local function G(e)
if e==nil then
return nil
end
if e==false then
return nil
end
if type(e)~="string"then
return nil
end
local e=e:lower():gsub("%s+","_"):gsub("-","_")
if e=="manual"or e=="none"then
return nil
end
if e=="topright"then
e="top_right"
elseif e=="topleft"then
e="top_left"
elseif e=="bottomright"then
e="bottom_right"
elseif e=="bottomleft"then
e="bottom_left"
end
if e=="top_right"or e=="top_left"or e=="bottom_right"or e=="bottom_left"then
return e
end
return nil
end
local function C(e)
local o,i,a,t=1,1,1,1
if e==nil then
return{top=o,right=i,bottom=a,left=t}
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
o,i,a,t=e,e,e,e
elseif type(e)=="table"then
if e.all~=nil then
local e=math.max(0,math.floor(e.all))
o,i,a,t=e,e,e,e
end
if e.vertical~=nil then
local e=math.max(0,math.floor(e.vertical))
o,a=e,e
end
if e.horizontal~=nil then
local e=math.max(0,math.floor(e.horizontal))
i,t=e,e
end
if e.top~=nil then
o=math.max(0,math.floor(e.top))
end
if e.right~=nil then
i=math.max(0,math.floor(e.right))
end
if e.bottom~=nil then
a=math.max(0,math.floor(e.bottom))
end
if e.left~=nil then
t=math.max(0,math.floor(e.left))
end
end
return{top=o,right=i,bottom=a,left=t}
end
local function J(t,i)
local e={}
if i<=0 then
e[1]=""
return e
end
t=tostring(t or"")
if t==""then
e[1]=""
return e
end
local a=1
while true do
local o=t:find("\n",a,true)
if not o then
y(t:sub(a),i,e)
break
end
y(t:sub(a,o-1),i,e)
a=o+1
end
if#e==0 then
e[1]=""
end
return e
end
local function o(e)
if not e then
return nil
end
local t={}
for e,a in pairs(e)do
t[e]=a
end
return t
end
local function D(a,e)
t(nil,a,"string")
t(nil,e,"number")
if e<1 or e~=math.floor(e)then
error(('%s must be a positive integer, got "%s"'):format(a,tostring(e)),3)
end
end
local function I(a)
if not a or a==false then
return nil
end
if a==true then
return{
color=e.lightGray,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
}
end
t(1,a,"table")
local e={
color=a.color or e.lightGray,
top=true,
right=true,
bottom=true,
left=true,
thickness=math.max(1,math.floor(a.thickness or 1))
}
local function o(a,t)
if t~=nil then
e[a]=not not t
end
end
if a.sides then
e.top=false
e.right=false
e.bottom=false
e.left=false
if#a.sides>0 then
for t=1,#a.sides do
local t=a.sides[t]
if e[t]~=nil then
e[t]=true
end
end
else
for t,a in pairs(a.sides)do
if e[t]~=nil then
e[t]=not not a
end
end
end
else
for e=1,#h do
o(h[e],a[h[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function T(a)
local e=a.border
local t=e and math.max(1,math.floor(e.thickness or 1))or 0
local i=(e and e.left)and t or 0
local n=(e and e.right)and t or 0
local o=(e and e.top)and t or 0
local e=(e and e.bottom)and t or 0
local t=math.max(0,a.width-i-n)
local a=math.max(0,a.height-o-e)
return i,n,o,e,t,a
end
local function Q(e,a)
if e==nil then
return{
enabled=a~=false,
height=1,
bg=nil,
fg=nil,
align="left"
}
end
if e==false then
return{enabled=false,height=0,bg=nil,fg=nil,align="left"}
end
if e==true then
return{enabled=true,height=1,bg=nil,fg=nil,align="left"}
end
t(1,e,"table")
local t=e.enabled
if t==nil then
t=true
end
if not t then
return{enabled=false,height=0,bg=nil,fg=nil,align="left"}
end
local t=e.height
if type(t)~="number"or t<1 then
t=1
else
t=math.floor(t)
end
local a=e.align and tostring(e.align):lower()or"left"
if a~="left"and a~="center"and a~="right"then
a="left"
end
return{
enabled=true,
height=t,
bg=e.bg,
fg=e.fg,
align=a
}
end
local function K(a,e,t)
if t~=nil and e~=nil and t<e then
return e
end
if e~=nil and a<e then
return e
end
if t~=nil and a>t then
return t
end
return a
end
local y="^(%a[%w_]*)%.([%a_][%w_]*)$"
local function h(e)
if type(e)~="string"then
return nil,nil
end
local t,e=e:match(y)
return t,e
end
local function z(e,t)
local e=tonumber(e)
if not e then
error("constraints."..t.." must be numeric",3)
end
if e>1 then
e=e/100
end
if e<0 then
e=0
elseif e>1 then
e=1
end
return e
end
local function y(e,t)
if e==nil then
return nil
end
local a=type(e)
if a=="number"then
return{kind="absolute",value=math.max(1,math.floor(e))}
end
if a=="boolean"then
if e then
return{kind="relative",target="parent",property=t}
end
return nil
end
if a=="string"then
local e,a=h(e)
if not e then
error("constraints."..t.." string references must look like 'parent.<property>'",3)
end
if e~="parent"then
error("constraints."..t.." currently only supports references to the parent",3)
end
return{kind="relative",target=e,property=a,offset=0}
end
if a=="table"then
if e.reference or e.of then
local a=e.reference or e.of
local a,o=h(a)
if not a then
error("constraints."..t.." reference tables must include 'reference' or 'of' matching 'parent.<property>'",3)
end
if a~="parent"then
error("constraints."..t.." references currently only support the parent",3)
end
local e=e.offset and math.floor(e.offset)or 0
return{kind="relative",target=a,property=o,offset=e}
end
if e.percent~=nil then
local o=z(e.percent,t..".percent")
local a=e.of or("parent."..t)
local a,i=h(a)
if not a then
error("constraints."..t..".percent requires an 'of' reference such as 'parent.width'",3)
end
if a~="parent"then
error("constraints."..t..".percent currently only supports the parent",3)
end
local e=e.offset and math.floor(e.offset)or 0
return{
kind="percent",
percent=o,
target=a,
property=i,
offset=e
}
end
if e.match~=nil then
return y(e.match,t)
end
if e.value~=nil then
return y(e.value,t)
end
error("constraints."..t.." table must include percent, reference/of, match, or value fields",3)
end
return nil
end
local function N(e,t)
if e==nil then
return nil
end
local a=type(e)
if a=="boolean"then
if not e then
return nil
end
return{
kind="center",
target="parent",
property=t=="x"and"centerX"or"centerY",
offset=0
}
end
if a=="string"then
local e,a=h(e)
if not e then
error("constraints.center"..(t=="x"and"X"or"Y").." string references must look like 'parent.<property>'",3)
end
if e~="parent"then
error("constraints.center"..(t=="x"and"X"or"Y").." currently only supports the parent",3)
end
return{kind="center",target=e,property=a,offset=0}
end
if a=="table"then
local a=e.reference or e.of or e.target or e.align
local o=e.offset and math.floor(e.offset)or 0
if a then
local e,a=h(a)
if not e then
error("constraints.center"..(t=="x"and"X"or"Y").." reference tables must use 'parent.<property>'",3)
end
if e~="parent"then
error("constraints.center"..(t=="x"and"X"or"Y").." currently only supports the parent",3)
end
return{kind="center",target=e,property=a,offset=o}
end
return{
kind="center",
target="parent",
property=t=="x"and"centerX"or"centerY",
offset=o
}
end
return nil
end
local function V(e)
if e==nil then
return nil
end
if type(e)~="table"then
error("constraints must be a table if provided",3)
end
local t={}
if e.minWidth~=nil then
if type(e.minWidth)~="number"then
error("constraints.minWidth must be a number",3)
end
t.minWidth=math.max(1,math.floor(e.minWidth))
end
if e.maxWidth~=nil then
if type(e.maxWidth)~="number"then
error("constraints.maxWidth must be a number",3)
end
t.maxWidth=math.max(1,math.floor(e.maxWidth))
end
if e.minHeight~=nil then
if type(e.minHeight)~="number"then
error("constraints.minHeight must be a number",3)
end
t.minHeight=math.max(1,math.floor(e.minHeight))
end
if e.maxHeight~=nil then
if type(e.maxHeight)~="number"then
error("constraints.maxHeight must be a number",3)
end
t.maxHeight=math.max(1,math.floor(e.maxHeight))
end
if t.minWidth and t.maxWidth and t.maxWidth<t.minWidth then
t.maxWidth=t.minWidth
end
if t.minHeight and t.maxHeight and t.maxHeight<t.minHeight then
t.maxHeight=t.minHeight
end
if e.width~=nil then
t.width=y(e.width,"width")
end
if e.height~=nil then
t.height=y(e.height,"height")
end
if e.widthPercent~=nil then
t.widthPercent=z(e.widthPercent,"widthPercent")
end
if e.heightPercent~=nil then
t.heightPercent=z(e.heightPercent,"heightPercent")
end
if e.centerX~=nil then
t.centerX=N(e.centerX,"x")
end
if e.centerY~=nil then
t.centerY=N(e.centerY,"y")
end
if e.offsetX~=nil then
if type(e.offsetX)~="number"then
error("constraints.offsetX must be numeric",3)
end
t.offsetX=math.floor(e.offsetX)
end
if e.offsetY~=nil then
if type(e.offsetY)~="number"then
error("constraints.offsetY must be numeric",3)
end
t.offsetY=math.floor(e.offsetY)
end
if not next(t)then
return nil
end
return t
end
local S=string.char(30)
local z=string.char(31)
local function N(o,h,s)
if o==false then
return nil
end
local a
if o==nil or o==true then
a={}
elseif type(o)=="table"then
a=o
if a.enabled==false then
return nil
end
else
t(1,o,"table")
a=o
if a.enabled==false then
return nil
end
end
local n=a.trackColor or e.gray
local i=a.thumbColor or e.lightGray
local t=a.arrowColor or s or e.white
local e=a.background or h or e.black
local o=math.max(1,math.floor(a.width or 1))
local s=math.max(1,math.floor(a.minThumbSize or 1))
return{
enabled=true,
alwaysVisible=not not a.alwaysVisible,
width=o,
trackColor=n,
thumbColor=i,
arrowColor=t,
background=e,
minThumbSize=s
}
end
local function y(e)
if e<0 then
return 0
end
if e>1 then
return 1
end
return e
end
local function U(t,o,e,a)
if not t or t.enabled==false then
return 0,nil
end
o=math.max(0,o or 0)
e=math.max(0,e or 0)
a=math.max(0,a or 0)
if a<=1 or e<=0 then
return 0,nil
end
if e<=2 then
return 0,nil
end
if not t.alwaysVisible and o<=e then
return 0,nil
end
local a=math.max(1,a-1)
local e=math.max(1,math.floor(t.width or 1))
if e>a then
e=a
end
if e<=0 then
return 0,nil
end
return e,t
end
local function H(n,s,a,o,l,d,m,e)
if not e or o<=0 then
return
end
local h=math.max(1,math.floor(e.width or 1))
local t=e.trackColor
local i=e.arrowColor
local r=e.thumbColor
local c=math.max(1,math.floor(e.minThumbSize or 1))
local e=math.max(0,h-1)
local u=S..string.rep(" ",e)
n.text(s,a,u,i,t)
if o>=2 then
local e=z..string.rep(" ",e)
n.text(s,a+o-1,e,i,t)
end
local a=a+1
local e=math.max(0,o-2)
local o=string.rep(" ",h)
for e=0,e-1 do
n.text(s,a+e,o,t,t)
end
local i=math.max(0,(l or 0)-(d or 0))
if i<=0 or e<=0 then
return
end
local u=math.max(0,math.min(i,math.floor((m or 0)+.5)))
local t=d/l
local t=math.max(c,math.floor(e*t+.5))
if t>e then
t=e
end
if t<1 then
t=1
end
local e=e-t
local o=a
if e>0 then
local t=y(i==0 and 0 or(u/i))
o=a+math.floor(t*e+.5)
if o>a+e then
o=a+e
end
end
local e=string.rep(" ",h)
for t=0,t-1 do
n.text(s,o+t,e,r,r)
end
end
local function S(o,t,e,i,a)
if t<=0 then
return a or 0
end
local e=math.max(0,(e or 0)-(i or 0))
if e<=0 then
return 0
end
local i=math.max(0,math.min(e,math.floor((a or 0)+.5)))
if o<=0 then
return math.max(0,i-1)
elseif o>=t-1 then
return math.min(e,i+1)
end
local a=t-2
if a<=0 then
return i
end
local t=o-1
if t<0 then
t=0
elseif t>a then
t=a
end
local t=math.floor((t/a)*e+.5)
if t<0 then
t=0
elseif t>e then
t=e
end
return t
end
local function h(a,o,i,e,t,n,h,s)
if e<=0 or t<=0 then
return
end
local s=s or" "
local s=s:rep(e)
for e=0,t-1 do
a.text(o,i+e,s,n,h)
end
end
local function z(n,i,a,o,t)
if o<=0 or t<=0 then
return
end
local e=P.transparent
for o=0,o-1 do
n.pixel(i+o,a,e)
if t>1 then
n.pixel(i+o,a+t-1,e)
end
end
for t=1,math.max(0,t-2)do
n.pixel(i,a+t,e)
if o>1 then
n.pixel(i+o-1,a+t,e)
end
end
end
local function y(s,a,r,o,i,e,t)
if o<=0 or i<=0 then
return
end
local n=e.color
local h=t or n
local a=(a-1)*2+1
local t=(r-1)*3+1
local o=o*2
local i=i*3
local l=3
local u=2
local r=math.min(e.thickness,i)
local d=math.min(e.thickness,o)
local l=math.min(i,math.max(r,l))
local u=math.min(o,math.max(d,u))
local function c(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(a+t,e,n)
end
end
end
local function m(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(a+t,e,n)
end
end
end
local function w(h,e,n)
for e=0,e-1 do
local e=h+e
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(e,t+a,n)
end
end
end
local function f(h,e,n)
for e=0,e-1 do
local e=h+e
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(e,t+a,n)
end
end
end
if e.left then
w(a,u,h)
end
if e.right then
w(a+o-u,u,h)
end
if e.top then
c(t,l,h)
end
if e.bottom then
c(t+i-l,l,h)
end
if e.top then
m(t,r,n)
end
if e.bottom then
m(t+i-r,r,n)
end
if e.left then
f(a,d,n)
end
if e.right then
f(a+o-d,d,n)
end
end
function n:new(i,a)
a=a or{}
t(1,i,"table")
if a~=nil then
t(2,a,"table")
end
local t=o(a)or{}
t.focusable=false
t.width=math.max(12,math.floor(t.width or 24))
t.height=math.max(3,math.floor(t.height or 5))
if t.visible==nil then
t.visible=false
end
local e=setmetatable({},n)
e:_init_base(i,t)
e.focusable=false
local i=a.anchor~=nil
local t=G(a.anchor)
if not t and not i then
if a.x~=nil or a.y~=nil then
t=nil
else
t="top_right"
end
end
e.anchor=t
e.anchorMargins=C(a.anchorMargin)
e.anchorAnimationDuration=math.max(.05,tonumber(a.anchorAnimationDuration)or .2)
e.anchorEasing=a.anchorEasing or"easeOutCubic"
e._anchorDirty=true
e._anchorAnimationHandle=nil
e.title=a.title~=nil and tostring(a.title)or nil
e.message=a.message~=nil and tostring(a.message)or""
e.icon=a.icon~=nil and tostring(a.icon)or nil
e.severity=B(a.severity)
local t=a.duration
if t~=nil then
t=tonumber(t)or 0
else
t=3
end
if t<0 then
t=0
end
e.duration=t
e.autoHide=a.autoHide~=false
e.dismissOnClick=a.dismissOnClick~=false
e.onDismiss=a.onDismiss
if e.onDismiss~=nil and type(e.onDismiss)~="function"then
error("config.onDismiss must be a function",2)
end
e.variantOverrides=a.variants and o(a.variants)or nil
e.styleOverride=a.style and o(a.style)or nil
e.paddingLeft,e.paddingRight,e.paddingTop,e.paddingBottom=M(a.padding)
e._hideTimer=nil
e._wrappedLines={""}
e._lastWrapWidth=nil
e._lastMessage=nil
e:_refreshWrap(true)
return e
end
function n:_applyPadding(e,i)
local e,o,t,a=M(e)
if i or e~=self.paddingLeft or o~=self.paddingRight or t~=self.paddingTop or a~=self.paddingBottom then
self.paddingLeft=e
self.paddingRight=o
self.paddingTop=t
self.paddingBottom=a
self:_refreshWrap(true)
self._anchorDirty=true
end
end
function n:setPadding(e)
self:_applyPadding(e,false)
end
function n:getAnchor()
return self.anchor
end
function n:getAnchorMargins()
return o(self.anchorMargins)
end
function n:refreshAnchor(e)
if not self.anchor then
self._anchorDirty=false
return
end
self._anchorDirty=true
if e and self.visible then
self:_applyAnchorPosition(true)
else
self:_applyAnchorPosition(false)
end
end
function n:setAnchor(e)
local t=G(e)
if t==nil and e~=nil then
self.anchor=nil
else
self.anchor=t
end
self:refreshAnchor(false)
end
function n:setAnchorMargin(e)
self.anchorMargins=C(e)
self:refreshAnchor(false)
end
function n:_computeAnchorPosition()
local n=self.anchor
if not n then
return nil,nil
end
local e=self.parent
if not e then
return nil,nil
end
local o=e.width
local i=e.height
if type(o)~="number"or type(i)~="number"then
return nil,nil
end
local s=self.width
local h=self.height
local a=self.anchorMargins or C(nil)
local e
local t
if n=="top_right"then
e=o-s-(a.right or 0)+1
t=(a.top or 0)+1
elseif n=="top_left"then
e=(a.left or 0)+1
t=(a.top or 0)+1
elseif n=="bottom_right"then
e=o-s-(a.right or 0)+1
t=i-h-(a.bottom or 0)+1
elseif n=="bottom_left"then
e=(a.left or 0)+1
t=i-h-(a.bottom or 0)+1
else
return nil,nil
end
if e<1 then
e=1
end
if t<1 then
t=1
end
if e+s-1>o then
e=math.max(1,o-s+1)
end
if t+h-1>i then
t=math.max(1,i-h+1)
end
return e,t
end
function n:getAnchorTargetPosition()
return self:_computeAnchorPosition()
end
function n:_applyAnchorPosition(a)
if not self.anchor then
self._anchorDirty=false
return
end
local t,e=self:_computeAnchorPosition()
if not t or not e then
return
end
if self._anchorAnimationHandle then
self._anchorAnimationHandle:cancel()
self._anchorAnimationHandle=nil
end
if a and self.app and self.app.animate then
local n=math.max(2,math.floor(self.width/6))
local s=math.max(1,math.floor(self.height/3))
local o=t
local a=e
if self.anchor=="top_right"then
o=t+n
a=math.max(1,e-s)
elseif self.anchor=="top_left"then
o=t-n
a=math.max(1,e-s)
elseif self.anchor=="bottom_right"then
o=t+n
a=e+s
elseif self.anchor=="bottom_left"then
o=t-n
a=e+s
end
i.setPosition(self,o,a)
local s=self.anchorAnimationDuration or .2
local n=self.anchorEasing or"easeOutCubic"
local o=o
local a=a
local h=t-o
local r=e-a
self._anchorAnimationHandle=self.app:animate({
duration=s,
easing=n,
update=function(e)
local t=math.floor(o+h*e+.5)
local e=math.floor(a+r*e+.5)
i.setPosition(self,t,e)
end,
onComplete=function()
i.setPosition(self,t,e)
self._anchorAnimationHandle=nil
end,
onCancel=function()
i.setPosition(self,t,e)
self._anchorAnimationHandle=nil
end
})
self._anchorDirty=false
return
end
if self.x~=t or self.y~=e then
i.setPosition(self,t,e)
end
self._anchorDirty=false
end
function n:_getActiveBorder()
if self.border then
return self.border
end
return nil
end
function n:_refreshWrap(o,t)
local e
if t~=nil then
e=math.max(0,math.floor(t))
else
local t=self:_getActiveBorder()
local a=(t and t.left)and t.thickness or 0
local t=(t and t.right)and t.thickness or 0
e=math.max(0,self.width-a-t-(self.paddingLeft or 0)-(self.paddingRight or 0))
end
if e<0 then
e=0
end
if not o and self._lastWrapWidth==e and self._lastMessage==self.message then
return
end
self._wrappedLines=J(self.message,e)
self._lastWrapWidth=e
self._lastMessage=self.message
end
function n:_getStyle()
local a=self.severity
local e=R.info
if a~=nil then
local t=R[a]
if t then
e=t
end
else
a="info"
end
local t=e
if self.variantOverrides then
local a=self.variantOverrides[a]
if a then
t=o(e)or e
for e,a in pairs(a)do
t[e]=a
end
end
end
if self.styleOverride then
if t==e then
t=o(e)or e
end
for a,e in pairs(self.styleOverride)do
t[a]=e
end
end
return t or e
end
function n:_cancelTimer()
if self._hideTimer then
if _.cancelTimer then
pcall(_.cancelTimer,self._hideTimer)
end
self._hideTimer=nil
end
end
function n:_scheduleHide(e)
if not self.autoHide then
return
end
local e=e
if e==nil then
e=self.duration
end
if not e or e<=0 then
return
end
self._hideTimer=_.startTimer(e)
end
function n:setTitle(e)
if e==nil then
self.title=nil
else
self.title=tostring(e)
end
end
function n:getTitle()
return self.title
end
function n:setMessage(e)
if e==nil then
e=""
end
local e=tostring(e)
if self.message~=e then
self.message=e
self:_refreshWrap(true)
end
end
function n:getMessage()
return self.message
end
function n:setSeverity(e)
local e=B(e)
if self.severity~=e then
self.severity=e
end
end
function n:getSeverity()
return self.severity
end
function n:setIcon(e)
if e==nil or e==""then
self.icon=nil
return
end
self.icon=tostring(e)
end
function n:getIcon()
return self.icon
end
function n:setAutoHide(e)
e=not not e
if self.autoHide~=e then
self.autoHide=e
if not e then
self:_cancelTimer()
end
end
end
function n:isAutoHide()
return self.autoHide
end
function n:setDuration(e)
if e==nil then
return
end
local e=tonumber(e)or 0
if e<0 then
e=0
end
self.duration=e
if self.visible and self.autoHide then
self:_cancelTimer()
self:_scheduleHide(e)
end
end
function n:getDuration()
return self.duration
end
function n:setDismissOnClick(e)
self.dismissOnClick=not not e
end
function n:isDismissOnClick()
return self.dismissOnClick
end
function n:setOnDismiss(e)
if e~=nil and type(e)~="function"then
error("onDismiss handler must be a function",2)
end
self.onDismiss=e
end
function n:setVariants(e)
if e~=nil and type(e)~="table"then
error("variants must be a table",2)
end
self.variantOverrides=e and o(e)or nil
end
function n:setStyle(e)
if e~=nil and type(e)~="table"then
error("style must be a table",2)
end
self.styleOverride=e and o(e)or nil
end
function n:present(e)
t(1,e,"table")
if e.title~=nil then
self:setTitle(e.title)
end
if e.message~=nil then
self:setMessage(e.message)
end
if e.icon~=nil then
self:setIcon(e.icon)
end
if e.severity~=nil then
self:setSeverity(e.severity)
end
if e.duration~=nil then
self:setDuration(e.duration)
end
if e.autoHide~=nil then
self:setAutoHide(e.autoHide)
end
if e.style~=nil then
self:setStyle(e.style)
end
if e.variants~=nil then
self:setVariants(e.variants)
end
self:show(e.duration)
end
function n:show(t)
local e=self.visible
self.visible=true
self:_refreshWrap(true)
self:_cancelTimer()
if self.anchor then
if not e then
self:_applyAnchorPosition(true)
elseif self._anchorDirty then
self:_applyAnchorPosition(false)
end
end
local e=nil
if t~=nil then
e=tonumber(t)or 0
if e<0 then
e=0
end
end
self:_scheduleHide(e)
end
function n:hide(t)
local e=self.visible
self.visible=false
self:_cancelTimer()
if self._anchorAnimationHandle then
self._anchorAnimationHandle:cancel()
self._anchorAnimationHandle=nil
end
if t~=false and e and self.onDismiss then
self.onDismiss(self)
end
end
function n:setSize(t,e)
i.setSize(self,t,e)
self:_refreshWrap(true)
self._anchorDirty=true
if self.anchor then
self:_applyAnchorPosition(false)
end
end
function n:setBorder(e)
i.setBorder(self,e)
self:_refreshWrap(true)
self._anchorDirty=true
end
function n:_renderLine(o,n,i,t,e,s,a)
if t<=0 then
return
end
local e=e or""
if#e>t then
e=e:sub(1,t)
end
if#e<t then
e=e..string.rep(" ",t-#e)
end
o.text(n,i,e,s,a)
end
function n:draw(o,l)
if not self.visible then
return
end
if self._anchorDirty and not self._anchorAnimationHandle then
self:_applyAnchorPosition(false)
end
local s,r,n,a=self:getAbsoluteRect()
if n<=0 or a<=0 then
return
end
local i=self:_getStyle()or R.info
local t=i.bg or self.bg or e.gray
local d=i.fg or self.fg or e.white
local c=i.accent or d
local m=i.titleColor or d
local u=i.iconColor or c
h(o,s,r,n,a,t,t)
z(o,s,r,n,a)
local e=self.border
if e then
y(l,s,r,n,a,e,t)
else
y(l,s,r,n,a,{
color=c,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
},t)
end
local e=e
local l=(e and e.left)and e.thickness or 0
local f=(e and e.right)and e.thickness or 0
local h=(e and e.top)and e.thickness or 0
local c=(e and e.bottom)and e.thickness or 0
local s=s+l
local e=r+h
local n=math.max(0,n-l-f)
local a=math.max(0,a-h-c)
local s=s+(self.paddingLeft or 0)
local e=e+(self.paddingTop or 0)
local h=math.max(0,n-(self.paddingLeft or 0)-(self.paddingRight or 0))
local n=math.max(0,a-(self.paddingTop or 0)-(self.paddingBottom or 0))
if h<=0 or n<=0 then
return
end
local a=self.icon
if not a or a==""then
a=i.icon or""
end
a=tostring(a or"")
local i=0
local r=s
local e=e
if a~=""and h>0 then
local a=a:sub(1,1)
o.text(s,e,a,u,t)
if h>=3 then
o.text(s+1,e," ",u,t)
i=2
else
i=1
end
r=s+i
end
local a=math.max(0,h-i)
self:_refreshWrap(false,a)
if self.title and self.title~=""and n>0 and a>0 then
self:_renderLine(o,r,e,a,self.title,m,t)
e=e+1
n=n-1
end
if n>0 and a>0 then
local i=self._wrappedLines or{""}
local n=math.min(n,#i)
for n=1,n do
self:_renderLine(o,r,e,a,i[n],d,t)
e=e+1
end
end
end
function n:handleEvent(e,...)
if not self.visible then
return false
end
if e=="timer"then
local e=...
if self._hideTimer and e==self._hideTimer then
self._hideTimer=nil
self:hide(true)
return true
end
elseif e=="mouse_click"then
local a,e,t=...
if self.dismissOnClick and self:containsPoint(e,t)then
self:hide(true)
return true
end
elseif e=="monitor_touch"then
local a,t,e=...
if self.dismissOnClick and self:containsPoint(t,e)then
self:hide(true)
return true
end
end
return false
end
function n:onFocusChanged()
end
function f:new(n,a)
a=a or{}
t(1,n,"table")
if a~=nil then
t(2,a,"table")
end
local i=o(a)or{}
i.focusable=false
i.width=math.max(3,math.floor(i.width or 8))
i.height=math.max(3,math.floor(i.height or 5))
local t=setmetatable({},f)
t:_init_base(n,i)
t.focusable=false
t.color=a.color or e.cyan
t.secondaryColor=a.secondaryColor or e.lightBlue
t.tertiaryColor=a.tertiaryColor or e.blue
t.trailColor=a.trailColor or e.gray
t.trailPalette=a.trailPalette and o(a.trailPalette)or nil
t.segmentCount=math.max(6,math.floor(a.segments or a.segmentCount or 12))
t.thickness=math.max(1,math.floor(a.thickness or 2))
t.radiusPixels=a.radius and math.max(2,math.floor(a.radius))or nil
local e=tonumber(a.speed)
if not e or e<=0 then
e=.08
end
t.speed=math.max(.01,e)
t.fadeSteps=math.max(0,math.floor(a.fadeSteps or 2))
local e=a.direction
if type(e)=="string"then
local t=e:lower()
if t=="counterclockwise"or t=="anticlockwise"or t=="ccw"then
e=-1
else
e=1
end
elseif type(e)=="number"then
e=e>=0 and 1 or-1
else
e=1
end
t.direction=e
t._phase=0
t._tickTimer=nil
t._paused=a.autoStart==false
if not t._paused then
t:_scheduleTick()
end
return t
end
function f:_cancelTick()
if self._tickTimer then
if _.cancelTimer then
pcall(_.cancelTimer,self._tickTimer)
end
self._tickTimer=nil
end
end
function f:_scheduleTick()
self:_cancelTick()
if self._paused then
return
end
if not self.speed or self.speed<=0 then
return
end
self._tickTimer=_.startTimer(self.speed)
end
function f:start()
if not self._paused then
return
end
self._paused=false
self:_scheduleTick()
end
function f:stop()
if self._paused then
return
end
self._paused=true
self:_cancelTick()
end
function f:setSpeed(e)
if e==nil then
return
end
local e=tonumber(e)
if not e then
return
end
if e<=0 then
self.speed=0
self:_cancelTick()
return
end
e=math.max(.01,e)
if e~=self.speed then
self.speed=e
if not self._paused then
self:_scheduleTick()
end
end
end
function f:setDirection(e)
if e==nil then
return
end
local e=e
if type(e)=="string"then
local t=e:lower()
if t=="counterclockwise"or t=="anticlockwise"or t=="ccw"then
e=-1
else
e=1
end
elseif type(e)=="number"then
e=e>=0 and 1 or-1
else
e=1
end
if e~=self.direction then
self.direction=e
end
end
function f:setSegments(e)
if e==nil then
return
end
local e=math.max(3,math.floor(e))
if e~=self.segmentCount then
self.segmentCount=e
self._phase=self._phase%e
end
end
function f:setThickness(e)
if e==nil then
return
end
local e=math.max(1,math.floor(e))
self.thickness=e
end
function f:setRadius(e)
if e==nil then
self.radiusPixels=nil
return
end
local e=math.max(2,math.floor(e))
self.radiusPixels=e
end
function f:setColor(e)
if e==nil then
return
end
t(1,e,"number")
self.color=e
end
function f:setSecondaryColor(e)
if e==nil then
self.secondaryColor=nil
return
end
t(1,e,"number")
self.secondaryColor=e
end
function f:setTertiaryColor(e)
if e==nil then
self.tertiaryColor=nil
return
end
t(1,e,"number")
self.tertiaryColor=e
end
function f:setTrailColor(e)
if e==nil then
self.trailColor=nil
return
end
t(1,e,"number")
self.trailColor=e
end
function f:setTrailPalette(e)
if e~=nil then
t(1,e,"table")
end
self.trailPalette=e and o(e)or nil
end
function f:setFadeSteps(e)
if e==nil then
return
end
local e=math.max(0,math.floor(e))
self.fadeSteps=e
end
function f:_computeTrailColors()
local e={}
local t=self.trailPalette
if type(t)=="table"then
for a=1,#t do
local t=t[a]
if t then
e[#e+1]=t
end
end
end
if#e==0 then
if self.secondaryColor then
e[#e+1]=self.secondaryColor
end
if self.tertiaryColor then
e[#e+1]=self.tertiaryColor
end
end
local t=math.max(0,math.floor(self.fadeSteps or 0))
if t>0 then
local a=self.trailColor or e[#e]or self.color
for t=1,t do
e[#e+1]=a
end
elseif#e==0 and self.trailColor then
e[1]=self.trailColor
end
if#e==0 then
e[1]=self.color
end
return e
end
function f:draw(s,r)
if not self.visible then
return
end
local o,i,t,a=self:getAbsoluteRect()
if t<=0 or a<=0 then
return
end
local e=self.bg or self.app.background
h(s,o,i,t,a,e,e)
z(s,o,i,t,a)
if self.border then
y(r,o,i,t,a,self.border,e)
end
local l=(self.border and self.border.left)and 1 or 0
local c=(self.border and self.border.right)and 1 or 0
local d=(self.border and self.border.top)and 1 or 0
local u=(self.border and self.border.bottom)and 1 or 0
local n=o+l
local i=i+d
local o=math.max(0,t-l-c)
local a=math.max(0,a-d-u)
if o<=0 or a<=0 then
return
end
h(s,n,i,o,a,e,e)
local l=n+(o-1)/2
local u=i+(a-1)/2
local s=math.floor(math.min(o,a)/2)
local t=self.radiusPixels and math.floor(self.radiusPixels)or s
if t>s then
t=s
end
if t<1 then
t=1
end
local h=math.max(1,math.min(math.floor(self.thickness or 1),t))
local s=t+.35
local t=math.max(0,t-h+.35)
local w=s*s
local m=t*t
local t=math.max(3,math.floor(self.segmentCount or 12))
local s=self._phase%t
local f=self.direction>=0 and 1 or-1
local h=math.pi*2
local c=self:_computeTrailColors()
for a=0,a-1 do
local d=i+a
local a=d-u
for o=0,o-1 do
local n=n+o
local o=n-l
local l=o*o+a*a
local i=e
if l<=w and l>=m then
local a=math.atan(a,o)
if a<0 then
a=a+h
end
local o=math.floor(a/h*t)%t
local a
if f>=0 then
a=(s-o)%t
else
a=(o-s)%t
end
if a==0 then
i=self.color or e
else
local t=math.floor(a+1e-4)
if t<1 then
t=1
end
i=c[t]or e
end
end
r.pixel(n,d,i)
end
end
end
function f:handleEvent(a,...)
if a=="timer"then
local e=...
if self._tickTimer and e==self._tickTimer then
self._tickTimer=nil
local t=math.max(3,math.floor(self.segmentCount or 12))
local e=self.direction>=0 and 1 or-1
local e=(self._phase+e)%t
if e<0 then
e=e+t
end
self._phase=e
if not self._paused then
self:_scheduleTick()
end
return true
end
end
return i.handleEvent(self,a,...)
end
local function R(e)
local a,t=e.x,e.y
local e=e.parent
while e do
a=a+e.x-1
t=t+e.y-1
e=e.parent
end
return a,t
end
function i:_init_base(o,a)
t(1,o,"table")
a=a or{}
t(2,a,"table","nil")
self.app=o
self.parent=nil
self.x=math.floor(a.x or 1)
self.y=math.floor(a.y or 1)
self.width=math.floor(a.width or 1)
self.height=math.floor(a.height or 1)
self.bg=a.bg or e.black
self.fg=a.fg or e.white
self.visible=a.visible~=false
self.z=a.z or 0
self.id=a.id
self.border=I(a.border)
self.focusable=a.focusable==true
self._focused=false
self.constraints=nil
D("width",self.width)
D("height",self.height)
if a.constraints~=nil then
self.constraints=V(a.constraints)
local t,e=self:_applySizeConstraints(self.width,self.height)
self.width=t
self.height=e
end
end
function i:setSize(t,e)
D("width",t)
D("height",e)
local e,t=self:_applySizeConstraints(t,e)
self.width=e
self.height=t
end
function i:_applyConstraintLayout()
local t=self.constraints
if not t then
return
end
local e=self.parent
local function s(t)
if not e then
return nil
end
if t=="width"then
return e.width
elseif t=="height"then
return e.height
elseif t=="centerX"then
if e.width then
return(e.width-1)/2+1
end
elseif t=="centerY"then
if e.height then
return(e.height-1)/2+1
end
elseif t=="right"then
return e.width
elseif t=="bottom"then
return e.height
elseif t=="left"or t=="x"then
return 1
elseif t=="top"or t=="y"then
return 1
end
return nil
end
local function o(e,t)
if not e then
return nil
end
if e.kind=="absolute"then
return e.value
end
if e.kind=="relative"then
local t=s(e.property)
if t==nil then
return nil
end
local e=e.offset or 0
local e=math.floor(t+e)
return math.max(1,e)
end
if e.kind=="percent"then
local t=s(e.property)
if t==nil then
return nil
end
local a=e.offset or 0
local e=math.floor(t*e.percent+.5)+a
return math.max(1,e)
end
return nil
end
local a=o(t.width,"width")
local o=o(t.height,"height")
local i=e and e.width or nil
local n=e and e.height or nil
if not a and t.widthPercent and i then
a=math.max(1,math.floor(i*t.widthPercent+.5))
end
if not o and t.heightPercent and n then
o=math.max(1,math.floor(n*t.heightPercent+.5))
end
local h=a or self.width
local a=o or self.height
local o,a=self:_applySizeConstraints(h,a)
if o~=self.width or a~=self.height then
self:setSize(o,a)
end
i=e and e.width or nil
n=e and e.height or nil
local function h(i,t,a,o,n)
if not i then
return nil
end
if not e or not a or a<=0 then
return nil
end
local t=i.property or(t=="x"and"centerX"or"centerY")
local e
if t=="centerX"or t=="centerY"then
e=math.floor((a-o)/2)+1
elseif t=="right"or t=="bottom"or t=="width"or t=="height"then
e=a-o+1
elseif t=="left"or t=="top"or t=="x"or t=="y"then
e=1
else
local t=s(t)
if t then
e=math.floor(t-math.floor(o/2))
else
e=math.floor((a-o)/2)+1
end
end
local t=(i.offset or 0)+n
e=math.floor(e+t)
if e<1 then
e=1
end
local t=math.max(1,a-o+1)
if e>t then
e=t
end
return e
end
local o=math.floor(t.offsetX or 0)
local s=math.floor(t.offsetY or 0)
local e=self.x
local a=self.y
local o=h(t.centerX,"x",i,self.width,o)
if o then
e=o
end
local t=h(t.centerY,"y",n,self.height,s)
if t then
a=t
end
if e~=self.x or a~=self.y then
self:setPosition(e,a)
end
end
function i:_applySizeConstraints(t,e)
local a=math.floor(t)
local t=math.floor(e)
if a<1 then
a=1
end
if t<1 then
t=1
end
local e=self.constraints
if e then
if e.minWidth and a<e.minWidth then
a=e.minWidth
end
if e.maxWidth and a>e.maxWidth then
a=e.maxWidth
end
if e.minHeight and t<e.minHeight then
t=e.minHeight
end
if e.maxHeight and t>e.maxHeight then
t=e.maxHeight
end
end
return a,t
end
function i:setConstraints(e)
if e==nil or e==false then
self.constraints=nil
else
self.constraints=V(e)
end
local e,t=self:_applySizeConstraints(self.width,self.height)
if e~=self.width or t~=self.height then
self:setSize(e,t)
end
self:_applyConstraintLayout()
end
local function D(e)
if not e then
return nil
end
if e.kind=="absolute"then
return e.value
elseif e.kind=="relative"then
local t=string.format("%s.%s",e.target or"parent",e.property or"width")
if e.offset and e.offset~=0 then
return{reference=t,offset=e.offset}
end
return t
elseif e.kind=="percent"then
local t=string.format("%s.%s",e.target or"parent",e.property or"width")
local t={percent=e.percent,of=t}
if e.offset and e.offset~=0 then
t.offset=e.offset
end
return t
end
return nil
end
local function C(e)
if not e then
return nil
end
local t=string.format("%s.%s",e.target or"parent",e.property or"center")
if e.offset and e.offset~=0 then
return{reference=t,offset=e.offset}
end
return t
end
function i:getConstraints()
if not self.constraints then
return nil
end
local e=self.constraints
local t={}
if e.minWidth then
t.minWidth=e.minWidth
end
if e.maxWidth then
t.maxWidth=e.maxWidth
end
if e.minHeight then
t.minHeight=e.minHeight
end
if e.maxHeight then
t.maxHeight=e.maxHeight
end
local a=D(e.width)
if a~=nil then
t.width=a
end
local a=D(e.height)
if a~=nil then
t.height=a
end
if e.widthPercent then
t.widthPercent=e.widthPercent
end
if e.heightPercent then
t.heightPercent=e.heightPercent
end
local a=C(e.centerX)
if a~=nil then
t.centerX=a
end
local a=C(e.centerY)
if a~=nil then
t.centerY=a
end
if e.offsetX and e.offsetX~=0 then
t.offsetX=e.offsetX
end
if e.offsetY and e.offsetY~=0 then
t.offsetY=e.offsetY
end
if next(t)then
return t
end
return nil
end
function i:setPosition(e,a)
t(1,e,"number")
t(2,a,"number")
self.x=math.floor(e)
self.y=math.floor(a)
end
function i:setZ(e)
t(1,e,"number")
self.z=e
end
function i:setBorder(e)
if e==nil then
self.border=nil
return
end
if e==false then
self.border=nil
return
end
if e==true then
self.border=I(true)
return
end
t(1,e,"table","boolean")
self.border=I(e)
end
function i:isFocused()
return self._focused
end
function i:setFocused(e)
e=not not e
if self._focused==e then
return
end
self._focused=e
self:onFocusChanged(e)
end
function i:onFocusChanged(e)
end
function i:getAbsoluteRect()
local e,t=R(self)
return e,t,self.width,self.height
end
function i:containsPoint(a,o)
local e,t,n,i=self:getAbsoluteRect()
return a>=e and a<e+n and o>=t and o<t+i
end
function i:draw(e,e)
error("draw needs implementation for widget",2)
end
function i:handleEvent(e,...)
return false
end
function p:new(a,t)
local e=setmetatable({},p)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function p:addChild(e)
t(1,e,"table")
if e.app~=self.app then
error("Cannot add widget from a different PixelUI app",2)
end
if e.parent and e.parent~=self then
local t=rawget(e.parent,"removeChild")
if type(t)=="function"then
t(e.parent,e)
end
end
e.parent=self
self._orderCounter=self._orderCounter+1
e._orderIndex=self._orderCounter
table.insert(self._children,e)
if e.constraints then
e:_applyConstraintLayout()
end
local t=e._applyConstraintsToChildren
if type(t)=="function"then
t(e)
end
return e
end
function p:_applyConstraintsToChildren()
local e=self._children
if not e then
return
end
for t=1,#e do
local e=e[t]
if e then
e:_applyConstraintLayout()
local t=e._applyConstraintsToChildren
if type(t)=="function"then
t(e)
end
end
end
end
function p:setSize(e,t)
i.setSize(self,e,t)
self:_applyConstraintsToChildren()
end
function p:removeChild(e)
for t=1,#self._children do
if self._children[t]==e then
table.remove(self._children,t)
e.parent=nil
if self.app and self.app._focusWidget==e then
self.app:setFocus(nil)
end
return true
end
end
return false
end
local function D(a)
local t={}
for e=1,#a do
t[e]=a[e]
end
return t
end
local function C(e)
table.sort(e,function(t,e)
if t.z==e.z then
return(t._orderIndex or 0)<(e._orderIndex or 0)
end
return t.z<e.z
end)
end
function p:getChildren()
return D(self._children)
end
function p:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function p:draw(s,r)
if not self.visible then
return
end
local n,i,t,a=self:getAbsoluteRect()
local o=self.bg or self.app.background
local d,u=n+1,i+1
local e=math.max(0,t-2)
local l=math.max(0,a-2)
if e>0 and l>0 then
h(s,d,u,e,l,o,o)
elseif t>0 and a>0 then
h(s,n,i,t,a,o,o)
end
z(s,n,i,t,a)
local h=self.title
if type(h)=="string"and#h>0 then
local t=e>0 and e or t
local n=e>0 and d or n
local a=(a>2)and(i+1)or i
if t>0 then
local e=h
if#e>t then
e=e:sub(1,t)
end
if#e<t then
e=e..string.rep(" ",t-#e)
end
s.text(n,a,e,self.fg,o)
end
end
if self.border then
y(r,n,i,t,a,self.border,o)
end
local e=D(self._children)
C(e)
for t=1,#e do
e[t]:draw(s,r)
end
end
function p:handleEvent(t,...)
if not self.visible then
return false
end
if i.handleEvent(self,t,...)then
return true
end
local e=D(self._children)
C(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function r:new(e,t)
t=t or{}
local e=p.new(p,e,t)
setmetatable(e,r)
e.draggable=t.draggable~=false
e.resizable=t.resizable~=false
e.closable=t.closable~=false
e.maximizable=t.maximizable~=false
e._titleBar=Q(t.titleBar,nil)
e:_refreshTitleBarState()
e:_invalidateTitleLayout()
e._dragging=false
e._dragSource=nil
e._dragIdentifier=nil
e._dragOffsetX=0
e._dragOffsetY=0
e._resizing=false
e._resizeSource=nil
e._resizeIdentifier=nil
e._resizeEdges=nil
e._resizeStart=nil
e._isMaximized=false
e._restoreRect=nil
return e
end
function r:_refreshTitleBarState()
if not self._titleBar then
self._titleBarHeight=0
return
end
if not self._titleBar.enabled then
self._titleBarHeight=0
return
end
self._titleBar.height=math.max(1,math.floor(self._titleBar.height or 1))
if not self._titleBar.align then
self._titleBar.align="left"
end
self._titleBarHeight=self._titleBar.height
end
function r:_invalidateTitleLayout()
self._titleLayoutCache=nil
self._titleButtonRects=nil
end
function r:_computeTitleLayout()
local i=self:_getVisibleTitleBarHeight()
local e=self._titleBar
if i<=0 or not e or not e.enabled then
self:_invalidateTitleLayout()
return nil
end
local e,o=R(self)
local a,n=T(self)
local t=e+a
local a=math.max(0,self.width-a-n)
if a<=0 then
t=e
a=self.width
end
local e={
barX=e,
barY=o,
barWidth=self.width,
barHeight=i,
textX=t,
textWidth=a,
textBaseline=o,
buttonRects={},
buttonOrder={},
maximizeState=self._isMaximized and"restore"or"maximize"
}
local n=3
local h=1
local a=t+a-1
local function s(i)
if a-n+1<t then
return nil
end
local t=a
local n=t-n+1
local t={x1=n,y1=o,x2=t,y2=o}
e.buttonRects[i]=t
e.buttonOrder[#e.buttonOrder+1]=i
a=n-h
return t
end
if self.closable then
s("close")
end
if self.maximizable then
s("maximize")
end
e.titleStart=t
e.titleEnd=a
if e.titleEnd<e.titleStart then
e.titleWidth=0
else
e.titleWidth=e.titleEnd-e.titleStart+1
end
self._titleLayoutCache=e
self._titleButtonRects=e.buttonRects
return e
end
function r:_hitTestTitleButton(a,t)
local e=self._titleLayoutCache or self:_computeTitleLayout()
if not e then
return nil
end
for o,e in pairs(e.buttonRects)do
if a>=e.x1 and a<=e.x2 and t>=e.y1 and t<=e.y2 then
return o
end
end
return nil
end
function r:_fillTitleBarPixels(t,e,n)
if not t or not e then
return
end
local o=(e.barX-1)*2+1
local i=(e.barY-1)*3+1
local a=e.barWidth*2
local e=math.min(e.barHeight*3,self.height*3)
for e=0,e-1 do
for a=0,a-1 do
t.pixel(o+a,i+e,n)
end
end
end
function r:_hitTestResize(a,i)
if not self.resizable then
return nil
end
local o,e=R(self)
local n=o+math.max(0,self.width-1)
local s=e+math.max(0,self.height-1)
local t=1
if self.border and self.border.thickness then
t=math.max(1,math.floor(self.border.thickness))
end
local e={}
local n=a>=n-t+1 and a<=n
local a=a>=o and a<=o+t-1
if n then
e.right=true
elseif a then
e.left=true
end
if i>=s-t+1 and i<=s then
e.bottom=true
end
if not e.right and not e.left and not e.bottom then
return nil
end
return e
end
function r:_beginResize(i,o,t,a,e)
if not e then
return
end
self:_restoreFromMaximize()
self._resizing=true
self._resizeSource=i
self._resizeIdentifier=o
self._resizeEdges=e
local e=self.constraints or{}
self._resizeStart={
pointerX=t,
pointerY=a,
width=self.width,
height=self.height,
x=self.x,
y=self.y,
minWidth=e.minWidth or 1,
minHeight=e.minHeight or 1
}
self:bringToFront()
if self.app then
self.app:setFocus(nil)
end
end
function r:_updateResize(a,t)
if not self._resizing or not self._resizeStart then
return
end
local e=self._resizeStart
local o=a-e.pointerX
local i=t-e.pointerY
local t=e.width
local a=e.height
if self._resizeEdges.right then
t=e.width+o
elseif self._resizeEdges.left then
t=e.width-o
end
if self._resizeEdges.bottom then
a=e.height+i
end
if t<e.minWidth then
t=e.minWidth
end
if a<e.minHeight then
a=e.minHeight
end
t=math.max(1,t)
a=math.max(1,a)
self:setSize(t,a)
if self._resizeEdges.left then
local t=self.width
local e=e.x+(e.width-t)
if self.parent then
local t=math.max(1,self.parent.width-t+1)
if e<1 then
e=1
elseif e>t then
e=t
end
else
if e<1 then
e=1
end
end
if e~=self.x then
self:setPosition(e,self.y)
end
end
end
function r:_endResize()
self._resizing=false
self._resizeSource=nil
self._resizeIdentifier=nil
self._resizeEdges=nil
self._resizeStart=nil
end
function r:_restoreFromMaximize()
if not self._isMaximized then
return
end
local e=self._restoreRect
self._isMaximized=false
self._restoreRect=nil
if e then
self:setPosition(e.x,e.y)
self:setSize(e.width,e.height)
end
self:_invalidateTitleLayout()
end
function r:_computeMaximizedGeometry()
local e=self.parent
if e then
local t,i,a,o=T(e)
local i=math.max(1,e.width-t-i)
local o=math.max(1,e.height-a-o)
local t=t+1
local e=a+1
return{x=t,y=e,width=i,height=o}
end
local e=self.app and self.app.root or nil
if e then
return{x=1,y=1,width=e.width,height=e.height}
end
return{x=self.x,y=self.y,width=self.width,height=self.height}
end
function r:maximize()
if not self.maximizable or self._isMaximized then
return
end
self._restoreRect={x=self.x,y=self.y,width=self.width,height=self.height}
local e=self:_computeMaximizedGeometry()
self:setPosition(e.x,e.y)
self:setSize(e.width,e.height)
self._isMaximized=true
self:bringToFront()
self:_invalidateTitleLayout()
if self.onMaximize then
self:onMaximize()
end
end
function r:restore()
if not self._isMaximized then
return
end
local e=self._restoreRect
self._isMaximized=false
self._restoreRect=nil
if e then
self:setPosition(e.x,e.y)
self:setSize(e.width,e.height)
end
self:_invalidateTitleLayout()
if self.onRestore then
self:onRestore()
end
end
function r:toggleMaximize()
if self._isMaximized then
self:restore()
else
self:maximize()
end
end
function r:close()
if self.onClose then
local e=self:onClose()
if e==false then
return
end
end
self.visible=false
self:_endDrag()
self:_endResize()
end
function r:_getVisibleTitleBarHeight()
local e=self._titleBar
if not e or not e.enabled then
return 0
end
local a,a,a,a,a,t=T(self)
if t<=0 then
return 0
end
local e=math.max(1,math.floor(e.height or 1))
if e>t then
e=t
end
return e
end
function r:setTitleBar(e)
self._titleBar=Q(e,nil)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function r:getTitleBar()
return o(self._titleBar)
end
function r:setDraggable(e)
self.draggable=not not e
end
function r:isDraggable()
return not not self.draggable
end
function r:setResizable(e)
self.resizable=not not e
self:_invalidateTitleLayout()
end
function r:isResizable()
return not not self.resizable
end
function r:setClosable(e)
self.closable=not not e
self:_invalidateTitleLayout()
end
function r:isClosable()
return not not self.closable
end
function r:setMaximizable(e)
self.maximizable=not not e
self:_invalidateTitleLayout()
end
function r:isMaximizable()
return not not self.maximizable
end
function r:setTitle(e)
p.setTitle(self,e)
self:_invalidateTitleLayout()
end
function r:getContentOffset()
local e,t,a=T(self)
local t=self:_getVisibleTitleBarHeight()
return e,a+t
end
function r:setSize(t,e)
p.setSize(self,t,e)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function r:setBorder(e)
i.setBorder(self,e)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function r:bringToFront()
local e=self.parent
if not e then
return
end
e._orderCounter=(e._orderCounter or 0)+1
self._orderIndex=e._orderCounter
end
function r:_pointInTitleBar(a,t)
local e=self:_computeTitleLayout()
if not e then
return false
end
if self._titleButtonRects then
for o,e in pairs(self._titleButtonRects)do
if a>=e.x1 and a<=e.x2 and t>=e.y1 and t<=e.y2 then
return false
end
end
end
local o=e.barX
local i=e.barY
local n=o+math.max(0,e.barWidth-1)
local e=i+math.max(0,e.barHeight-1)
return a>=o and a<=n and t>=i and t<=e
end
function r:_beginDrag(e,t,a,o)
self:_restoreFromMaximize()
local n,i=R(self)
self._dragging=true
self._dragSource=e
self._dragIdentifier=t
self._dragOffsetX=a-n
self._dragOffsetY=o-i
self:bringToFront()
if self.app then
self.app:setFocus(nil)
end
end
function r:_updateDragPosition(i,o)
if not self._dragging then
return
end
local t=self.parent
local a=self._dragOffsetX or 0
local e=self._dragOffsetY or 0
local a=i-a
local e=o-e
if t then
local i,o=R(t)
local n=i
local s=o
local h=i+math.max(0,t.width-self.width)
local t=o+math.max(0,t.height-self.height)
a=K(a,n,h)
e=K(e,s,t)
local t=a-i+1
local e=e-o+1
self:setPosition(t,e)
else
self:setPosition(a,e)
end
end
function r:_endDrag()
self._dragging=false
self._dragSource=nil
self._dragIdentifier=nil
self._dragOffsetX=0
self._dragOffsetY=0
end
function r:draw(i,l)
if not self.visible then
return
end
local d,r,u,c=self:getAbsoluteRect()
local o,s,n,s,a,t=T(self)
local o=d+o
local s=r+n
local n=self.bg or self.app.background
if a>0 and t>0 then
h(i,o,s,a,t,n,n)
else
h(i,d,r,u,c,n,n)
end
z(i,d,r,u,c)
local s=self._titleBar
local t=nil
local o=nil
if s then
t=self:_computeTitleLayout()
if t then
o=s.bg or n
local r=s.fg or self.fg or e.white
if t.textWidth>0 then
h(i,t.textX,t.textBaseline,t.textWidth,t.barHeight,o,o)
end
local n=t.titleWidth or 0
local a=self.title or""
if n>0 and a~=""then
if#a>n then
a=a:sub(1,n)
end
local e=n-#a
local s=s.align or"left"
local n=a
if e>0 then
if s=="center"then
local t=math.floor(e/2)
local e=e-t
n=string.rep(" ",t)..a..string.rep(" ",e)
elseif s=="right"then
n=string.rep(" ",e)..a
else
n=a..string.rep(" ",e)
end
end
i.text(t.titleStart,t.textBaseline,n,r,o)
end
local a=s.fg or self.fg or e.white
if self.maximizable then
local e=t.buttonRects.maximize
if e then
local t=t.maximizeState=="restore"and"[-]"or"[+]"
i.text(e.x1,e.y1,t,a,o)
end
end
if self.closable then
local e=t.buttonRects.close
if e then
i.text(e.x1,e.y1,"[X]",a,o)
end
end
end
end
if self.border then
y(l,d,r,u,c,self.border,n)
if t and o then
self:_fillTitleBarPixels(l,t,o)
end
end
local e=D(self._children)
C(e)
for t=1,#e do
e[t]:draw(i,l)
end
end
function r:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local o,t,e=...
local a=self:_hitTestTitleButton(t,e)
if a=="close"and self.closable then
self:close()
return true
elseif a=="maximize"and self.maximizable then
self:toggleMaximize()
return true
end
local a=self:_hitTestResize(t,e)
if a then
self:_beginResize("mouse",o,t,e,a)
return true
end
if self.draggable and self:_pointInTitleBar(t,e)then
self:_beginDrag("mouse",o,t,e)
return true
end
elseif e=="mouse_drag"then
local e,t,a=...
if self._resizing and self._resizeSource=="mouse"and e==self._resizeIdentifier then
self:_updateResize(t,a)
return true
end
if self._dragging and self._dragSource=="mouse"and e==self._dragIdentifier then
self:_updateDragPosition(t,a)
return true
end
elseif e=="mouse_up"then
local e=...
if self._resizing and self._resizeSource=="mouse"and e==self._resizeIdentifier then
self:_endResize()
return true
end
if self._dragging and self._dragSource=="mouse"and e==self._dragIdentifier then
self:_endDrag()
return true
end
elseif e=="monitor_touch"then
local a,t,e=...
local o=self:_hitTestTitleButton(t,e)
if o=="close"and self.closable then
self:close()
return true
elseif o=="maximize"and self.maximizable then
self:toggleMaximize()
return true
end
local o=self:_hitTestResize(t,e)
if o then
self:_beginResize("monitor",a,t,e,o)
return true
end
if self.draggable and self:_pointInTitleBar(t,e)then
self:_beginDrag("monitor",a,t,e)
return true
end
elseif e=="monitor_drag"then
local e,t,a=...
if self._resizing and self._resizeSource=="monitor"and e==self._resizeIdentifier then
self:_updateResize(t,a)
return true
end
if self._dragging and self._dragSource=="monitor"and e==self._dragIdentifier then
self:_updateDragPosition(t,a)
return true
end
elseif e=="monitor_up"then
local e=...
if self._resizing and self._resizeSource=="monitor"and e==self._resizeIdentifier then
self:_endResize()
return true
end
if self._dragging and self._dragSource=="monitor"and e==self._dragIdentifier then
self:_endDrag()
return true
end
end
return p.handleEvent(self,e,...)
end
function A:new(a,e)
local t=setmetatable({},A)
t:_init_base(a,e)
t.label=(e and e.label)or"Button"
t.onPress=e and e.onPress or nil
t.onRelease=e and e.onRelease or nil
t.onClick=e and e.onClick or nil
if e and e.clickEffect~=nil then
t.clickEffect=not not e.clickEffect
else
t.clickEffect=true
end
t._pressed=false
t.focusable=false
return t
end
function A:setLabel(e)
t(1,e,"string")
self.label=e
end
function A:setOnClick(e)
if e~=nil then
t(1,e,"function")
end
self.onClick=e
end
function A:draw(s,c)
if not self.visible then
return
end
local n,i,t,a=self:getAbsoluteRect()
local r=self.bg or e.gray
local o=self.fg or e.white
local e=r
local d=o
if self.clickEffect and self._pressed then
e,d=d,e
end
local u,l=n+1,i+1
local o=math.max(0,t-2)
local r=math.max(0,a-2)
if o>0 and r>0 then
h(s,u,l,o,r,e,e)
else
h(s,n,i,t,a,e,e)
end
z(s,n,i,t,a)
if self.border then
y(c,n,i,t,a,self.border,e)
end
local a=self.label or""
local t=o>0 and o or t
if#a>t then
a=a:sub(1,t)
end
local h=0
if t>#a then
h=math.floor((t-#a)/2)
end
local a=string.rep(" ",h)..a
if#a<t then
a=a..string.rep(" ",t-#a)
end
local o=o>0 and u or n
local t
if r>0 then
t=l+math.floor((r-1)/2)
else
t=i
end
s.text(o,t,a,d,e)
end
function A:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(nil)
self._pressed=true
if self.onPress then
self.onPress(self,a,t,e)
end
return true
end
elseif e=="mouse_drag"then
local a,t,e=...
if self._pressed then
if not self:containsPoint(t,e)then
self._pressed=false
if self.onRelease then
self.onRelease(self,a,t,e)
end
return false
end
return true
end
elseif e=="mouse_up"then
local a,t,e=...
if self._pressed then
self._pressed=false
if self:containsPoint(t,e)then
self.app:setFocus(nil)
if self.onRelease then
self.onRelease(self,a,t,e)
end
if self.onClick then
self.onClick(self,a,t,e)
end
return true
end
end
elseif e=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(nil)
if self.onPress then
self.onPress(self,1,e,t)
end
if self.onRelease then
self.onRelease(self,1,e,t)
end
if self.onClick then
self.onClick(self,1,e,t)
end
return true
end
end
return false
end
function j:new(i,e)
e=e or{}
local a=o(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},j)
t:_init_base(i,a)
t.focusable=false
local a=e and e.text
if a==nil then
a=""
end
t.text=tostring(a)
t.wrap=not not(e and e.wrap)
local a=(e and e.align)and tostring(e.align):lower()or"left"
if a~="left"and a~="center"and a~="right"then
a="left"
end
t.align=a
local e=(e and e.verticalAlign)and tostring(e.verticalAlign):lower()or"top"
if e=="center"then
e="middle"
end
if e~="top"and e~="middle"and e~="bottom"then
e="top"
end
t.verticalAlign=e
t._lines={""}
t._lastInnerWidth=nil
t._lastText=nil
t._lastWrap=nil
t:_updateLines(true)
return t
end
function j:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-a-o)
local i=math.max(0,self.height-t-e)
return a,o,t,e,n,i
end
function j:_wrapLine(e,a,t)
if a<=0 then
t[#t+1]=""
return
end
e=e:gsub("\r","")
if e==""then
t[#t+1]=""
return
end
local e=e
while#e>a do
local n=e:sub(1,a)
local o
for e=a,1,-1 do
local t=n:sub(e,e)
if t:match("%s")then
o=e-1
break
end
end
if o and o>=1 then
local i=e:sub(1,o)
i=i:gsub("%s+$","")
if i==""then
i=e:sub(1,a)
o=a
end
t[#t+1]=i
e=e:sub(o+1)
else
t[#t+1]=n
e=e:sub(a+1)
end
e=e:gsub("^%s+","")
if e==""then
break
end
end
if e~=""then
t[#t+1]=e
elseif#t==0 then
t[#t+1]=""
end
end
function j:_updateLines(e)
local t=tostring(self.text or"")
local i=not not self.wrap
local o,o,o,o,a=self:_getInnerMetrics()
if not e and self._lastText==t and self._lastWrap==i and self._lastInnerWidth==a then
return
end
local e={}
if t==""then
e[1]=""
else
local o=1
while true do
local n=t:find("\n",o,true)
if not n then
local t=t:sub(o)
t=t:gsub("\r","")
if i then
self:_wrapLine(t,a,e)
else
e[#e+1]=t
end
break
end
local t=t:sub(o,n-1)
t=t:gsub("\r","")
if i then
self:_wrapLine(t,a,e)
else
e[#e+1]=t
end
o=n+1
end
end
if#e==0 then
e[1]=""
end
self._lines=e
self._lastText=t
self._lastWrap=i
self._lastInnerWidth=a
end
function j:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function j:getText()
return self.text
end
function j:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function j:isWrapping()
return self.wrap
end
function j:setHorizontalAlign(e)
if e==nil then
e="left"
else
t(1,e,"string")
end
local t=e:lower()
if t~="left"and t~="center"and t~="right"then
error("Invalid horizontal alignment '"..e.."'",2)
end
if self.align~=t then
self.align=t
end
end
function j:setVerticalAlign(a)
if a==nil then
a="top"
else
t(1,a,"string")
end
local e=a:lower()
if e=="center"then
e="middle"
end
if e~="top"and e~="middle"and e~="bottom"then
error("Invalid vertical alignment '"..a.."'",2)
end
if self.verticalAlign~=e then
self.verticalAlign=e
end
end
function j:setSize(e,t)
i.setSize(self,e,t)
self:_updateLines(true)
end
function j:setBorder(e)
i.setBorder(self,e)
self:_updateLines(true)
end
function j:draw(l,m)
if not self.visible then
return
end
local n,s,d,u=self:getAbsoluteRect()
local r=self.bg or self.app.background or e.black
local f=self.fg or e.white
h(l,n,s,d,u,r,r)
z(l,n,s,d,u)
local t,o,e,o,a,i=self:_getInnerMetrics()
local o=n+t
local c=s+e
self:_updateLines(false)
local h=self._lines or{""}
local t=#h
if t==0 then
h={""}
t=1
end
if a>0 and i>0 then
local e=math.min(t,i)
local n=1
if t>e then
if self.verticalAlign=="bottom"then
n=t-e+1
elseif self.verticalAlign=="middle"then
n=math.floor((t-e)/2)+1
end
end
local t=0
if i>e then
if self.verticalAlign=="bottom"then
t=i-e
elseif self.verticalAlign=="middle"then
t=math.floor((i-e)/2)
end
end
local i=c+t
for e=0,e-1 do
local e=h[n+e]or""
if#e>a then
e=e:sub(1,a)
end
local t=o
if self.align=="center"then
t=o+math.floor((a-#e)/2)
elseif self.align=="right"then
t=o+a-#e
end
if t<o then
t=o
end
if t+#e>o+a then
t=o+a-#e
end
if#e>0 then
l.text(t,i,e,f,r)
end
i=i+1
end
end
if self.border then
y(m,n,s,d,u,self.border,r)
end
end
function q:new(n,t)
t=t or{}
local o=o(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},q)
a:_init_base(n,o)
a.focusable=true
a.label=i
a.allowIndeterminate=not not(t and t.allowIndeterminate)
a.indeterminate=not not(t and t.indeterminate)
if not a.allowIndeterminate then
a.indeterminate=false
end
a.checked=not a.indeterminate and not not(t and t.checked)
a.onChange=t and t.onChange or nil
a.focusBg=t and t.focusBg or e.lightGray
a.focusFg=t and t.focusFg or e.black
return a
end
function q:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function q:_setState(t,e,o)
t=not not t
e=not not e
if e then
t=false
end
if not self.allowIndeterminate then
e=false
end
local a=(self.checked~=t)or(self.indeterminate~=e)
if not a then
return false
end
self.checked=t
self.indeterminate=e
if not o then
self:_notifyChange()
end
return true
end
function q:setLabel(e)
t(1,e,"string")
self.label=e
end
function q:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function q:setAllowIndeterminate(e)
e=not not e
if self.allowIndeterminate==e then
return
end
self.allowIndeterminate=e
if not e and self.indeterminate then
self:_setState(self.checked,false,true)
self:_notifyChange()
end
end
function q:setChecked(e)
t(1,e,"boolean")
self:_setState(e,false,false)
end
function q:isChecked()
return self.checked
end
function q:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
t(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function q:isIndeterminate()
return self.indeterminate
end
function q:toggle()
self:_activate()
end
function q:_activate()
if self.allowIndeterminate then
if self.indeterminate then
self:_setState(false,false,false)
elseif self.checked then
self:_setState(false,true,false)
else
self:_setState(true,false,false)
end
else
if self.indeterminate then
self:_setState(true,false,false)
else
self:_setState(not self.checked,false,false)
end
end
end
function q:draw(d,l)
if not self.visible then
return
end
local s,n,t,i=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local o=a
local r=e
if self:isFocused()then
o=self.focusBg or o
r=self.focusFg or r
end
h(d,s,n,t,i,o,o)
z(d,s,n,t,i)
if self.border then
y(l,s,n,t,i,self.border,o)
end
if t<=0 or i<=0 then
return
end
local e=" "
if self.indeterminate then
e="-"
elseif self.checked then
e="x"
end
local a="["..e.."]"
local e={}
e[#e+1]=a
local a=#a
if t>a then
e[#e+1]=" "
a=a+1
end
if t>a then
local o=self.label or""
local t=t-a
if#o>t then
o=o:sub(1,t)
end
e[#e+1]=o
a=a+#o
end
local e=table.concat(e)
if#e<t then
e=e..string.rep(" ",t-#e)
elseif#e>t then
e=e:sub(1,t)
end
local t=n+math.floor((i-1)/2)
d.text(s,t,e,r,o)
end
function q:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_activate()
return true
end
elseif e=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_activate()
return true
end
elseif e=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.space or e==a.enter then
self:_activate()
return true
end
end
return false
end
function x:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},x)
a:_init_base(i,o)
a.focusable=true
local o=t.value
if o==nil then
o=t.on
end
a.value=not not o
a.labelOn=(t and t.labelOn)or"On"
a.labelOff=(t and t.labelOff)or"Off"
a.trackColorOn=(t and t.trackColorOn)or e.lightBlue
a.trackColorOff=(t and t.trackColorOff)or e.gray
a.thumbColor=(t and t.thumbColor)or e.white
a.onLabelColor=t and t.onLabelColor or nil
a.offLabelColor=t and t.offLabelColor or nil
a.focusBg=t and t.focusBg or e.lightGray
a.focusFg=t and t.focusFg or e.black
a.showLabel=not(t and t.showLabel==false)
a.disabled=not not(t and t.disabled)
a.onChange=t and t.onChange or nil
return a
end
function x:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function x:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function x:setValue(e,t)
e=not not e
if self.value==e then
return
end
self.value=e
if not t then
self:_emitChange()
end
end
function x:isOn()
return self.value
end
function x:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function x:setLabels(e,a)
if e~=nil then
t(1,e,"string")
self.labelOn=e
end
if a~=nil then
t(2,a,"string")
self.labelOff=a
end
end
function x:setShowLabel(e)
self.showLabel=not not e
end
function x:setDisabled(e)
e=not not e
if self.disabled==e then
return
end
self.disabled=e
end
function x:isDisabled()
return self.disabled
end
function x:setColors(n,i,e,a,o)
if n~=nil then
t(1,n,"number")
self.trackColorOn=n
end
if i~=nil then
t(2,i,"number")
self.trackColorOff=i
end
if e~=nil then
t(3,e,"number")
self.thumbColor=e
end
if a~=nil then
t(4,a,"number")
self.onLabelColor=a
end
if o~=nil then
t(5,o,"number")
self.offLabelColor=o
end
end
function x:draw(d,r)
if not self.visible then
return
end
local i,o,a,n=self:getAbsoluteRect()
local t=self.bg or e.black
local u=self.fg or e.white
h(d,i,o,a,n,t,t)
z(d,i,o,a,n)
if self.border then
y(r,i,o,a,n,self.border,t)
end
local t=self.border
local s=(t and t.left)and t.thickness or 0
local c=(t and t.right)and t.thickness or 0
local l=(t and t.top)and t.thickness or 0
local m=(t and t.bottom)and t.thickness or 0
local i=i+s
local f=o+l
local t=math.max(0,a-s-c)
local o=math.max(0,n-l-m)
if t<=0 or o<=0 then
return
end
local a=i
local n=f
local t=t
local i=o
local s=self.trackColorOff or e.gray
local o=self.trackColorOn or e.lightBlue
local c=self.value and o or s
h(d,a,n,t,i,c,c)
local o=math.max(1,math.floor(t/2))
if t>=4 then
o=math.max(2,o)
end
if o>t then
o=t
end
local s
if self.value then
s=a+t-o
else
s=a
end
if s<a then
s=a
end
if s+o>a+t then
s=a+t-o
end
local l=self.thumbColor or e.white
if self:isFocused()then
l=self.focusBg or l
end
h(d,s,n,o,i,l,l)
local o=""
if self.showLabel then
if self.value then
o=self.labelOn or"On"
else
o=self.labelOff or"Off"
end
end
if o~=""and i>0 then
local e=math.max(0,t-2)
if e>0 and#o>e then
o=o:sub(1,e)
end
local s=u
if self.value then
s=self.onLabelColor or u
else
s=self.offLabelColor or u
end
local i=n+math.floor((i-1)/2)
local e=a+math.floor((t-#o)/2)
if e<a then
e=a
end
if e+#o-1>a+t-1 then
e=a+t-#o
end
if#o>0 then
d.text(e,i,o,s,c)
end
end
if self:isFocused()then
local e=self.focusFg or e.white
if t>1 then
for t=0,t-1 do
r.pixel(a+t,n,e)
if i>1 then
r.pixel(a+t,n+i-1,e)
end
end
end
if i>1 then
for o=0,i-1 do
r.pixel(a,n+o,e)
if t>1 then
r.pixel(a+t-1,n+o,e)
end
end
end
end
if self.disabled then
for t=0,t-1,2 do
local t=a+t
r.pixel(t,n,e.gray)
if i>1 then
r.pixel(t,n+i-1,e.gray)
end
end
end
end
function x:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"or e=="monitor_touch"then
local a,t,e=...
if self:containsPoint(t,e)then
if self.disabled then
return true
end
self.app:setFocus(self)
self:toggle()
return true
end
elseif e=="key"then
if not self:isFocused()or self.disabled then
return false
end
local e=...
if e==a.space or e==a.enter then
self:toggle()
return true
end
elseif e=="char"then
if not self:isFocused()or self.disabled then
return false
end
local e=...
if e==" "then
self:toggle()
return true
end
end
return false
end
function b:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},b)
t:_init_base(n,o)
t.focusable=true
t.label=i
if a and a.value~=nil then
t.value=a.value
else
t.value=i
end
if a and a.group~=nil then
if type(a.group)~="string"then
error("RadioButton group must be a string",2)
end
t.group=a.group
else
t.group=nil
end
t.selected=not not(a and a.selected)
t.onChange=a and a.onChange or nil
t.focusBg=a and a.focusBg or e.lightGray
t.focusFg=a and a.focusFg or e.black
t._registeredGroup=nil
t._dotChar=X
if t.group and t.app then
t:_registerWithGroup()
if t.selected then
t.app:_selectRadioInGroup(t.group,t,true)
else
local e=t.app._radioGroups
if e then
local e=e[t.group]
if e and e.selected and e.selected~=t then
t.selected=false
end
end
end
end
t:_applySelection(t.selected,true)
return t
end
function b:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function b:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function b:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function b:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function b:setLabel(e)
t(1,e,"string")
self.label=e
end
function b:setValue(e)
self.value=e
end
function b:getValue()
return self.value
end
function b:setGroup(e)
t(1,e,"string","nil")
if self.group==e then
return
end
self:_unregisterFromGroup()
self.group=e
if self.group then
self:_registerWithGroup()
end
end
function b:getGroup()
return self.group
end
function b:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function b:setSelected(e)
e=not not e
if self.group and self.app then
if e then
self.app:_selectRadioInGroup(self.group,self,false)
else
local e=self.app._radioGroups
local e=e and e[self.group]
if e and e.selected==self then
self.app:_selectRadioInGroup(self.group,nil,false)
else
self:_applySelection(false,false)
end
end
return
end
if self.selected==e then
return
end
self:_applySelection(e,false)
end
function b:isSelected()
return self.selected
end
function b:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function b:draw(r,d)
if not self.visible then
return
end
local o,n,t,i=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local s=e
if self:isFocused()then
a=self.focusBg or a
s=self.focusFg or s
end
h(r,o,n,t,i,a,a)
z(r,o,n,t,i)
if self.border then
y(d,o,n,t,i,self.border,a)
end
local n=n+math.floor((i-1)/2)
local e=self.selected and(self._dotChar or"*")or" "
local e="("..e..")"
local i=self.label or""
local e=e
if#i>0 then
e=e.." "..i
end
if#e>t then
e=e:sub(1,t)
elseif#e<t then
e=e..string.rep(" ",t-#e)
end
if t>0 then
r.text(o,n,e,s,a)
end
end
function b:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_activate()
return true
end
elseif e=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_activate()
return true
end
elseif e=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.space or e==a.enter then
self:_activate()
return true
end
end
return false
end
function v:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},v)
t:_init_base(i,o)
t.focusable=false
t.min=type(a.min)=="number"and a.min or 0
t.max=type(a.max)=="number"and a.max or 1
if t.max<=t.min then
t.max=t.min+1
end
local o=a.value
if type(o)~="number"then
o=t.min
end
t.value=t:_clampValue(o)
t.trackColor=(a.trackColor)or e.gray
t.fillColor=(a.fillColor)or e.lightBlue
t.textColor=(a.textColor)or t.fg or e.white
t.label=a.label or nil
t.showPercent=not not a.showPercent
t.indeterminate=not not a.indeterminate
t.indeterminateSpeed=math.max(.1,a.indeterminateSpeed or 1.2)
t._indeterminateProgress=0
t._animationHandle=nil
if not t.border then
t.border=I(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
end
return t
end
function v:_clampValue(e)
if type(e)~="number"then
e=self.min
end
if e<self.min then
return self.min
end
if e>self.max then
return self.max
end
return e
end
function v:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function v:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=L.linear,
update=function(t,e)
self._indeterminateProgress=e or 0
end,
onComplete=function()
self._animationHandle=nil
if self.indeterminate then
self:_startIndeterminateAnimation()
else
self._indeterminateProgress=0
end
end,
onCancel=function()
self._animationHandle=nil
end
})
end
function v:setRange(a,e)
t(1,a,"number")
t(2,e,"number")
if e<=a then
error("ProgressBar max must be greater than min",2)
end
self.min=a
self.max=e
self.value=self:_clampValue(self.value)
end
function v:getRange()
return self.min,self.max
end
function v:setValue(e)
if self.indeterminate then
return
end
t(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function v:getValue()
return self.value
end
function v:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function v:setIndeterminate(e)
e=not not e
if self.indeterminate==e then
return
end
self.indeterminate=e
if e then
self:_startIndeterminateAnimation()
else
self:_stopIndeterminateAnimation()
end
end
function v:isIndeterminate()
return self.indeterminate
end
function v:setLabel(e)
if e~=nil then
t(1,e,"string")
end
self.label=e
end
function v:setShowPercent(e)
self.showPercent=not not e
end
function v:setColors(e,a,o)
if e~=nil then
t(1,e,"number")
self.trackColor=e
end
if a~=nil then
t(2,a,"number")
self.fillColor=a
end
if o~=nil then
t(3,o,"number")
self.textColor=o
end
end
function v:draw(s,a)
if not self.visible then
return
end
local t,i,d,o=self:getAbsoluteRect()
local n=self.trackColor or(self.bg or e.gray)
local r=self.fillColor or e.lightBlue
local f=self.textColor or(self.fg or e.white)
h(s,t,i,d,o,n,n)
z(s,t,i,d,o)
if self.border then
y(a,t,i,d,o,self.border,n)
end
local e=self.border
local l=(e and e.left)and 1 or 0
local m=(e and e.right)and 1 or 0
local c=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=t+l
local u=i+c
local t=math.max(0,d-l-m)
local o=math.max(0,o-c-e)
if t<=0 or o<=0 then
return
end
h(s,a,u,t,o,n,n)
local l=0
local d=0
local i=0
if self.indeterminate then
i=math.max(1,math.floor(t/3))
if i>t then
i=t
end
local t=t-i
local e=self._indeterminateProgress or 0
if e<0 then e=0 end
if e>1 then e=1 end
d=math.floor(t*e+.5)
h(s,a+d,u,i,o,r,r)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
h(s,a,u,l,o,r,r)
end
end
local e=self.label or""
if self.showPercent and not self.indeterminate then
local t=math.floor(self:getPercent()*100+.5)
local t=tostring(t).."%"
if e~=""then
e=e.." "..t
else
e=t
end
end
if e~=""and o>0 then
if#e>t then
e=e:sub(1,t)
end
local h=u+math.floor((o-1)/2)
local o=a+math.floor((t-#e)/2)
if o<a then
o=a
end
for t=1,#e do
local u=e:sub(t,t)
local a=(o-a)+(t-1)
local e=n
if self.indeterminate then
if a>=d and a<d+i then
e=r
end
else
if a<l then
e=r
end
end
s.text(o+t-1,h,u,f,e)
end
end
end
function v:handleEvent(e,...)
return false
end
function O:new(i,t)
t=t or{}
local e=o(t)or{}
e.focusable=false
e.width=math.max(1,math.floor(e.width or 10))
e.height=math.max(1,math.floor(e.height or 4))
local a=setmetatable({},O)
a:_init_base(i,e)
a.onDraw=t.onDraw
a.clear=t.clear~=false
return a
end
function O:setOnDraw(e)
if e~=nil and type(e)~="function"then
error("FreeDraw:setOnDraw expects a function or nil",2)
end
self.onDraw=e
end
function O:setClear(e)
self.clear=not not e
end
function O:draw(r,d)
if not self.visible then
return
end
local i,n,a,o=self:getAbsoluteRect()
if a<=0 or o<=0 then
return
end
if self.clear then
local e=self.bg or self.app.background or e.black
h(r,i,n,a,o,e,e)
end
if self.onDraw then
local t=self._ctx or{}
t.app=self.app
t.box=self.app.box
t.textLayer=r
t.pixelLayer=d
t.x=i
t.y=n
t.width=a
t.height=o
local l=self.bg or self.app.background or e.black
local u=self.fg or e.white
t.fill=function(e)
local e=e or l
h(r,i,n,a,o,e,e)
end
t.write=function(s,h,e,c,d)
local s=math.floor(s or 1)
local h=math.floor(h or 1)
if type(e)~="string"then
e=tostring(e or"")
end
if h<1 or h>o then
return
end
if s>a then
return
end
local e=e
local o=0
if s<1 then
o=1-s
if o>=#e then
return
end
e=e:sub(o+1)
s=1
end
local a=a-s+1
if a<=0 then
return
end
if#e>a then
e=e:sub(1,a)
end
r.text(i+s-1,n+h-1,e,c or u,d or l)
end
t.pixel=function(e,t,s)
local e=math.floor(e or 1)
local t=math.floor(t or 1)
if e<1 or e>a or t<1 or t>o then
return
end
d.pixel(i+e-1,n+t-1,s or u)
end
self._ctx=t
self.onDraw(self,t)
end
if self.border then
y(d,i,n,a,o,self.border,self.bg or self.app.background or e.black)
end
end
function l:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=o.width or 12
if o.height==nil then
o.height=a.showValue and 2 or 1
end
local t=setmetatable({},l)
t:_init_base(i,o)
t.focusable=true
t.min=type(a.min)=="number"and a.min or 0
t.max=type(a.max)=="number"and a.max or 1
if t.max<=t.min then
t.max=t.min+1
end
if a.step~=nil then
if type(a.step)~="number"then
error("Slider step must be a number",2)
end
t.step=a.step>0 and a.step or 0
else
t.step=0
end
t.range=not not a.range
t.showValue=not not a.showValue
t.trackColor=a.trackColor or e.gray
t.fillColor=a.fillColor or e.lightBlue
t.handleColor=a.handleColor or e.white
if a.formatValue~=nil then
if type(a.formatValue)~="function"then
error("Slider formatValue must be a function",2)
end
t.formatValue=a.formatValue
else
t.formatValue=nil
end
t.onChange=a.onChange
t._activeHandle=nil
t._focusedHandle=t.range and"lower"or"single"
t._dragging=false
if t.range then
local o
local e
if type(a.value)=="table"then
o=a.value[1]
e=a.value[2]
end
if type(a.startValue)=="number"then
o=a.startValue
end
if type(a.endValue)=="number"then
e=a.endValue
end
if type(o)~="number"then
o=t.min
end
if type(e)~="number"then
e=t.max
end
if o>e then
o,e=e,o
end
t.lowerValue=t:_applyStep(o)
t.upperValue=t:_applyStep(e)
if t.lowerValue>t.upperValue then
t.lowerValue,t.upperValue=t.upperValue,t.lowerValue
end
else
local e=a.value
if type(e)~="number"then
e=t.min
end
t.value=t:_applyStep(e)
end
if not t.border then
t.border=I(true)
end
return t
end
function l:_clampValue(e)
if type(e)~="number"then
e=self.min
end
if e<self.min then
return self.min
end
if e>self.max then
return self.max
end
return e
end
function l:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function l:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,i=self:getAbsoluteRect()
local s=math.max(0,self.width-a-n)
local n=math.max(0,self.height-t-e)
local o=o+a
local i=i+t
return o,i,s,n,a,t,e
end
function l:_valueToPosition(o,a)
if a<=1 then
return 0
end
local t=self.max-self.min
local e=0
if t>0 then
e=(o-self.min)/t
end
if e<0 then
e=0
elseif e>1 then
e=1
end
return math.floor(e*(a-1)+.5)
end
function l:_positionToValue(e,t)
if t<=1 then
return self.min
end
if e<0 then
e=0
elseif e>t-1 then
e=t-1
end
local e=e/(t-1)
local e=self.min+(self.max-self.min)*e
return self:_applyStep(e)
end
function l:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function l:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function l:_setSingleValue(e,t)
e=self:_applyStep(e)
if self.value~=e then
self.value=e
if not t then
self:_notifyChange()
end
return true
end
return false
end
function l:setValue(e)
if self.range then
return
end
t(1,e,"number")
self:_setSingleValue(e,false)
end
function l:getValue()
return self.value
end
function l:_setLowerValue(e,t)
e=self:_applyStep(e)
if e<self.min then
e=self.min
end
if e>self.upperValue then
e=self.upperValue
end
if self.lowerValue~=e then
self.lowerValue=e
if not t then
self:_notifyChange()
end
return true
end
return false
end
function l:_setUpperValue(e,t)
e=self:_applyStep(e)
if e>self.max then
e=self.max
end
if e<self.lowerValue then
e=self.lowerValue
end
if self.upperValue~=e then
self.upperValue=e
if not t then
self:_notifyChange()
end
return true
end
return false
end
function l:setRangeValues(e,a,o)
if not self.range then
return
end
if e==nil then
e=self.lowerValue or self.min
end
if a==nil then
a=self.upperValue or self.max
end
t(1,e,"number")
t(2,a,"number")
if e>a then
e,a=a,e
end
local t=false
t=self:_setLowerValue(e,true)or t
t=self:_setUpperValue(a,true)or t
if t and not o then
self:_notifyChange()
end
end
function l:getRangeValues()
return self.lowerValue,self.upperValue
end
function l:setRangeLimits(e,a)
t(1,e,"number")
t(2,a,"number")
if a<=e then
error("Slider max must be greater than min",2)
end
self.min=e
self.max=a
if self.range then
local e=false
e=self:_setLowerValue(self.lowerValue,true)or e
e=self:_setUpperValue(self.upperValue,true)or e
if e then
self:_notifyChange()
end
else
if self:_setSingleValue(self.value,true)then
self:_notifyChange()
end
end
end
function l:setStep(e)
if e==nil then
e=0
else
t(1,e,"number")
end
if e<=0 then
self.step=0
else
self.step=e
end
if self.range then
local e=false
e=self:_setLowerValue(self.lowerValue,true)or e
e=self:_setUpperValue(self.upperValue,true)or e
if e then
self:_notifyChange()
end
else
if self:_setSingleValue(self.value,true)then
self:_notifyChange()
end
end
end
function l:setShowValue(e)
self.showValue=not not e
end
function l:setColors(o,e,a)
if o~=nil then
t(1,o,"number")
self.trackColor=o
end
if e~=nil then
t(2,e,"number")
self.fillColor=e
end
if a~=nil then
t(3,a,"number")
self.handleColor=a
end
end
function l:_formatNumber(o)
local a=self.step or 0
local e
if a>0 then
local t=0
local a=a
while a<1 and t<4 do
a=a*10
t=t+1
end
local t="%0."..tostring(t).."f"
e=t:format(o)
else
e=string.format("%0.2f",o)
end
if e:find(".",1,true)then
e=e:gsub("0+$","")
e=e:gsub("%.$","")
end
return e
end
function l:_formatDisplayValue()
if self.formatValue then
local t,e
if self.range then
t,e=pcall(self.formatValue,self,self.lowerValue,self.upperValue)
else
t,e=pcall(self.formatValue,self,self.value)
end
if t and type(e)=="string"then
return e
end
end
if self.range then
return self:_formatNumber(self.lowerValue).." - "..self:_formatNumber(self.upperValue)
end
return self:_formatNumber(self.value)
end
function l:_getStepForNudge(t)
local e=self.step or 0
if e<=0 then
e=(self.max-self.min)/math.max(1,(self.range and 20 or 40))
end
if e<=0 then
e=1
end
if t and t>1 then
e=e*t
end
return e
end
function l:_positionFromPoint(e)
local a,o,t=self:_getInnerMetrics()
if t<=0 then
return nil,t
end
local e=math.floor(e-a)
if e<0 then
e=0
elseif e>t-1 then
e=t-1
end
return e,t
end
function l:_beginInteraction(e)
local e,a=self:_positionFromPoint(e)
if not e then
return false
end
if self.range then
local n=self:_valueToPosition(self.lowerValue,a)
local o=self:_valueToPosition(self.upperValue,a)
local t=self._focusedHandle or"lower"
local s=math.abs(e-n)
local i=math.abs(e-o)
if s==i then
if e>o then
t="upper"
elseif e<n then
t="lower"
end
elseif s<i then
t="lower"
else
t="upper"
end
self._activeHandle=t
self._focusedHandle=t
local e=self:_positionToValue(e,a)
if t=="lower"then
self:_setLowerValue(e)
else
self:_setUpperValue(e)
end
else
self._activeHandle="single"
self._focusedHandle="single"
local e=self:_positionToValue(e,a)
self:_setSingleValue(e)
end
return true
end
function l:_updateInteraction(e)
if not self._activeHandle then
return false
end
local e,t=self:_positionFromPoint(e)
if not e then
return false
end
local e=self:_positionToValue(e,t)
if self._activeHandle=="lower"then
self:_setLowerValue(e)
elseif self._activeHandle=="upper"then
self:_setUpperValue(e)
else
self:_setSingleValue(e)
end
return true
end
function l:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function l:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function l:_nudgeValue(e)
if e==0 then
return
end
local t=e>=0 and 1 or-1
local e=math.abs(e)
local e=self:_getStepForNudge(e)
e=e*t
if self.range then
local t=self._focusedHandle or"lower"
if t=="upper"then
self:_setUpperValue(self.upperValue+e)
else
self:_setLowerValue(self.lowerValue+e)
end
else
self:_setSingleValue(self.value+e)
end
end
function l:onFocusChanged(e)
if e then
if self.range then
if self._focusedHandle~="lower"and self._focusedHandle~="upper"then
self._focusedHandle="lower"
end
else
self._focusedHandle="single"
end
end
end
function l:draw(i,f)
if not self.visible then
return
end
local l,d,s,r=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
h(i,l,d,s,r,n,n)
z(i,l,d,s,r)
local o,c,t,u=self:_getInnerMetrics()
if t<=0 or u<=0 then
if self.border then
y(f,l,d,s,r,self.border,n)
end
return
end
local a
local m=nil
if self.showValue and u>=2 then
m=c
a=c+u-1
else
a=c+math.floor((u-1)/2)
end
h(i,o,a,t,1,self.trackColor,self.trackColor)
local c
if self:isFocused()then
c=self._activeHandle or self._focusedHandle
end
local function u(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if c and s==c then
t=self.fg or e.white
end
i.text(o+n,a," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local n=t-e+1
if n>0 then
h(i,o+e,a,n,1,self.fillColor,self.fillColor)
end
u(e,"lower")
u(t,"upper")
else
local t=self:_valueToPosition(self.value,t)
local e=t+1
if e>0 then
h(i,o,a,e,1,self.fillColor,self.fillColor)
end
u(t,"single")
end
if self.showValue and m then
local a=self:_formatDisplayValue()
if a and a~=""then
if#a>t then
a=a:sub(1,t)
end
local t=o+math.floor((t-#a)/2)
if t<o then
t=o
end
i.text(t,m,a,self.fg or e.white,n)
end
end
if self.border then
y(f,l,d,s,r,self.border,n)
end
end
function l:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self._dragging=true
return self:_beginInteraction(e)
end
elseif t=="mouse_drag"then
local a,e,t=...
if self._activeHandle then
return self:_updateInteraction(e)
elseif self._dragging and self:containsPoint(e,t)then
return self:_beginInteraction(e)
end
elseif t=="mouse_up"then
local e,t=...
local e=false
if self._activeHandle then
e=self:_updateInteraction(t)
end
if self._dragging then
e=true
end
self:_endInteraction()
return e
elseif t=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_beginInteraction(e)
self:_endInteraction()
return true
end
elseif t=="mouse_scroll"then
local e,t,a=...
if self:containsPoint(t,a)then
self.app:setFocus(self)
if e>0 then
self:_nudgeValue(1)
elseif e<0 then
self:_nudgeValue(-1)
end
return true
end
elseif t=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.left or e==a.down then
self:_nudgeValue(-1)
return true
elseif e==a.right or e==a.up then
self:_nudgeValue(1)
return true
elseif e==a.home then
if self.range then
self:setRangeValues(self.min,self.upperValue)
self._focusedHandle="lower"
else
self:setValue(self.min)
end
return true
elseif e==a["end"]then
if self.range then
self:setRangeValues(self.lowerValue,self.max)
self._focusedHandle="upper"
else
self:setValue(self.max)
end
return true
elseif e==a.tab then
if self.range then
self:_switchFocusedHandle()
return true
end
elseif e==a.pageUp then
self:_nudgeValue(-5)
return true
elseif e==a.pageDown then
self:_nudgeValue(5)
return true
end
elseif t=="key_up"then
if self._activeHandle then
self:_endInteraction()
end
end
return false
end
function d:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},d)
t:_init_base(i,o)
t.focusable=true
t.headerBg=a.headerBg or t.bg or e.gray
t.headerFg=a.headerFg or t.fg or e.white
t.rowBg=a.rowBg or t.bg or e.black
t.rowFg=a.rowFg or t.fg or e.white
t.highlightBg=a.highlightBg or e.lightBlue
t.highlightFg=a.highlightFg or e.black
t.zebra=not not a.zebra
t.zebraBg=a.zebraBg or e.gray
t.placeholder=a.placeholder or"No rows"
t.allowRowSelection=a.selectable~=false
t.sortColumn=a.sortColumn
t.sortDirection=(a.sortDirection=="desc")and"desc"or"asc"
t.onSelect=a.onSelect or nil
t.onSort=a.onSort or nil
t.columns={}
t.data={}
t._rows={}
t._columnMetrics={}
t._totalColumnWidth=0
t.scrollOffset=1
t.selectedIndex=0
t.typeSearchTimeout=a.typeSearchTimeout or .75
t._typeSearch={buffer="",lastTime=0}
t.columns=t:_normalizeColumns(a.columns or{})
t:_recomputeColumnMetrics()
t:setData(a.data or{})
if a.selectedIndex then
t:setSelectedIndex(a.selectedIndex,true)
end
if t.sortColumn then
t:setSort(t.sortColumn,t.sortDirection,true)
end
if not t.border then
t.border=I(true)
end
t.scrollbar=N(a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_ensureSelectionVisible()
return t
end
function d:_normalizeColumns(e)
local a={}
if type(e)=="table"then
for t=1,#e do
local e=e[t]
if type(e)~="table"then
error("Table column configuration must be a table",3)
end
local t=e.id or e.key or e.title
if type(t)~="string"or t==""then
error("Table column is missing an id",3)
end
local e={
id=t,
title=e.title or t,
key=e.key or t,
accessor=e.accessor,
format=e.format,
comparator=e.comparator,
color=e.color,
align=e.align or"left",
sortable=e.sortable~=false,
width=math.max(3,math.floor(e.width or 10))
}
a[#a+1]=e
end
end
return a
end
function d:_recomputeColumnMetrics()
self._columnMetrics={}
local t=0
for a=1,#self.columns do
local e=self.columns[a]
e.width=math.max(3,math.floor(e.width or 10))
self._columnMetrics[a]={
offset=t,
width=e.width
}
t=t+e.width
end
self._totalColumnWidth=t
end
function d:_ensureColumnsForData()
if#self.columns>0 then
return
end
local e=self.data[1]
if type(e)=="table"then
local t={}
for e,a in pairs(e)do
if type(e)=="string"then
t[#t+1]={
id=e,
title=e,
key=e,
align="left",
sortable=true,
width=math.max(3,math.min(20,tostring(a or""):len()+2))
}
end
end
table.sort(t,function(t,e)
return t.id<e.id
end)
if#t==0 then
t[1]={
id="value",
title="Value",
key="value",
align="left",
sortable=true,
accessor=function(t)
if type(t)=="table"then
local e={}
local a=0
for t,o in pairs(t)do
a=a+1
if a>4 then
e[#e+1]="..."
break
end
e[#e+1]=tostring(t).."="..tostring(o)
end
table.sort(e,function(e,t)
return e<t
end)
return"{"..table.concat(e,", ").."}"
end
return tostring(t)
end,
width=math.max(6,self.width-2)
}
end
self.columns=t
else
self.columns={
{
id="value",
title="Value",
align="left",
sortable=true,
accessor=function(e)
return e
end,
width=math.max(6,self.width-2)
}
}
end
self:_recomputeColumnMetrics()
end
function d:setColumns(e)
if e~=nil then
t(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function d:getColumns()
local t={}
for e=1,#self.columns do
t[e]=o(self.columns[e])
end
return t
end
function d:setData(e)
t(1,e,"table")
local a={}
for t=1,#e do
a[t]=e[t]
end
self.data=a
self:_ensureColumnsForData()
self:_refreshRows()
end
function d:getData()
local e={}
for t=1,#self.data do
e[t]=self.data[t]
end
return e
end
function d:_refreshRows()
self._rows={}
for e=1,#self.data do
self._rows[e]=e
end
if self.sortColumn then
self:_applySort(self.sortColumn,self.sortDirection or"asc",true)
end
if self.allowRowSelection then
if#self._rows==0 then
self.selectedIndex=0
elseif self.selectedIndex<1 or self.selectedIndex>#self._rows then
self.selectedIndex=1
end
else
self.selectedIndex=0
end
self:_clampScroll()
self:_ensureSelectionVisible()
end
function d:_getColumnById(t)
if not t then
return nil
end
for e=1,#self.columns do
if self.columns[e].id==t then
return self.columns[e]
end
end
return nil
end
function d:_applySort(e,a,u)
local t=self:_getColumnById(e)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=a=="desc"and"desc"or"asc"
local l=self.sortDirection=="desc"
local i=t.comparator
table.sort(self._rows,function(n,s)
local h=self.data[n]
local r=self.data[s]
local a=d._resolveColumnValue(t,h)
local o=d._resolveColumnValue(t,r)
local e=0
if i then
local a,t=pcall(i,a,o,h,r,t)
if a and type(t)=="number"then
e=t
end
end
if e==0 then
if type(a)=="number"and type(o)=="number"then
if a<o then
e=-1
elseif a>o then
e=1
else
e=0
end
else
local a=tostring(a or""):lower()
local t=tostring(o or""):lower()
if a<t then
e=-1
elseif a>t then
e=1
else
e=0
end
end
end
if e==0 then
return n<s
end
if l then
return e>0
end
return e<0
end)
if not u and self.onSort then
self.onSort(self,self.sortColumn,self.sortDirection)
end
self:_ensureSelectionVisible()
end
function d:setSort(e,a,t)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,a or self.sortDirection,t)
end
function d:getSort()
return self.sortColumn,self.sortDirection
end
function d:setOnSort(e)
if e~=nil then
t(1,e,"function")
end
self.onSort=e
end
function d:setScrollbar(t)
self.scrollbar=N(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function d:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function d:getSelectedIndex()
return self.selectedIndex
end
function d:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function d:setSelectedIndex(e,a)
if not self.allowRowSelection then
self.selectedIndex=0
return
end
if#self._rows==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
t(1,e,"number")
e=math.floor(e)
if e<1 then
e=1
elseif e>#self._rows then
e=#self._rows
end
local t=e~=self.selectedIndex
self.selectedIndex=e
self:_ensureSelectionVisible()
if t and not a then
self:_notifySelect()
end
end
function d:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function d:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local i=(e and e.bottom)and 1 or 0
local n,e=self:getAbsoluteRect()
local o=math.max(0,self.width-a-o)
local i=math.max(0,self.height-t-i)
local a=n+a
local e=e+t
return a,e,o,i
end
function d:_computeLayoutMetrics()
local i,r,t,a=self:_getInnerMetrics()
if t<=0 or a<=0 then
return{
innerX=i,
innerY=r,
innerWidth=t,
innerHeight=a,
headerHeight=0,
rowsHeight=0,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=i
}
end
local s=a>=1 and 1 or 0
local h=math.max(0,a-s)
local e,n=U(self.scrollbar,#self._rows,h,t)
if e>0 and t-e<1 then
e=math.max(0,t-1)
if e<=0 then
e=0
n=nil
end
end
local o=t-e
if o<1 then
o=t
e=0
n=nil
end
return{
innerX=i,
innerY=r,
innerWidth=t,
innerHeight=a,
headerHeight=s,
rowsHeight=h,
contentWidth=o,
scrollbarWidth=e,
scrollbarStyle=n,
scrollbarX=i+o
}
end
function d:_getRowsVisible()
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return 0
end
local e=e.rowsHeight
if e<0 then
e=0
end
return e
end
function d:_clampScroll()
local e=self:_getRowsVisible()
if#self._rows==0 or e<=0 then
self.scrollOffset=1
return
end
local e=math.max(1,#self._rows-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function d:_ensureSelectionVisible()
self:_clampScroll()
if not self.allowRowSelection or self.selectedIndex<1 or self.selectedIndex>#self._rows then
return
end
local e=self:_getRowsVisible()
if e<=0 then
return
end
if self.selectedIndex<self.scrollOffset then
self.scrollOffset=self.selectedIndex
elseif self.selectedIndex>self.scrollOffset+e-1 then
self.scrollOffset=self.selectedIndex-e+1
end
self:_clampScroll()
end
function d:_rowFromPoint(o,t)
if not self:containsPoint(o,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
local a=e.innerY+e.headerHeight
if t<a or t>=a+e.rowsHeight then
return nil
end
if o<e.innerX or o>=e.innerX+e.contentWidth then
return nil
end
local t=t-a
if t<0 or t>=e.rowsHeight then
return nil
end
local e=self.scrollOffset+t
if e<1 or e>#self._rows then
return nil
end
return e
end
function d:_columnFromPoint(a,t)
if not self:containsPoint(a,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
if e.headerHeight<=0 or t~=e.innerY then
return nil
end
if a<e.innerX or a>=e.innerX+e.contentWidth then
return nil
end
local n=e.contentWidth
local t=e.innerX
for o=1,#self.columns do
local i=math.max(1,math.min(self.columns[o].width,n))
if o==#self.columns then
i=e.innerX+e.contentWidth-t
end
if i<=0 then
break
end
if a>=t and a<t+i then
return self.columns[o],o
end
t=t+i
n=e.contentWidth-(t-e.innerX)
if n<=0 then
break
end
end
return nil
end
function d._resolveColumnValue(e,t)
if e.accessor then
local e,t=pcall(e.accessor,t,e)
if e then
return t
end
end
if type(t)=="table"then
local e=e.key or e.id
return t[e]
end
return t
end
function d:_formatCell(t,a,e)
if t.format then
local a,t=pcall(t.format,e,a,t)
if a and t~=nil then
e=t
end
end
if e==nil then
e=""
end
return tostring(e)
end
function d:draw(o,b)
if not self.visible then
return
end
local c,u,m,f=self:getAbsoluteRect()
local s=self.bg or e.black
local g=self.fg or e.white
h(o,c,u,m,f,s,s)
z(o,c,u,m,f)
local t=self:_computeLayoutMetrics()
local i=t.innerWidth
local k=t.innerHeight
local a=t.contentWidth
if i<=0 or k<=0 or a<=0 then
if self.border then
y(b,c,u,m,f,self.border,s)
end
return
end
local n=t.innerX
local w=t.innerY
local p=t.headerHeight
local j=t.rowsHeight
local v=t.scrollbarWidth
local l=t.scrollbarStyle
local r=self.headerBg or s
local q=self.headerFg or g
if p>0 then
o.text(n,w,string.rep(" ",a),r,r)
local s=n
local h=a
for e=1,#self.columns do
local i=self.columns[e]
local t=math.max(1,math.min(i.width,h))
if e==#self.columns then
t=math.max(1,h)
end
if t<=0 then
break
end
local e=i.title or i.id
local d=""
if self.sortColumn==i.id then
d=self.sortDirection=="desc"and"v"or"^"
end
if d~=""and t>=2 then
if#e>=t then
e=e:sub(1,t-1)
end
e=e..d
elseif t>#e then
e=e..string.rep(" ",t-#e)
else
e=e:sub(1,t)
end
o.text(s,w,e,q,r)
s=s+t
h=a-(s-n)
if h<=0 then
break
end
end
end
local p=w+p
local r=j
local i=self.rowBg or s
local g=self.rowFg or g
if r<=0 then
if v>0 then
local e=(l and l.background)or s
h(o,t.scrollbarX,w,v,k,e,e)
end
if self.border then
y(b,c,u,m,f,self.border,s)
end
return
end
if#self._rows==0 then
for e=0,r-1 do
local e=p+e
o.text(n,e,string.rep(" ",a),g,i)
end
if self.placeholder and self.placeholder~=""then
local t=self.placeholder
if#t>a then
t=t:sub(1,a)
end
local s=r>0 and math.min(r-1,math.floor(r/2))or 0
local s=p+s
local a=n+math.floor((a-#t)/2)
if a<n then
a=n
end
o.text(a,s,t,e.lightGray,i)
end
else
for s=0,r-1 do
local t=self.scrollOffset+s
local m=p+s
if t>#self._rows then
o.text(n,m,string.rep(" ",a),g,i)
else
local s=self._rows[t]
local l=self.data[s]
local c=self.allowRowSelection and t==self.selectedIndex
local h=i
local u=g
if c then
h=self.highlightBg or e.lightGray
u=self.highlightFg or e.black
elseif self.zebra and(t%2==0)then
h=self.zebraBg or h
end
local s=n
local r=a
for e=1,#self.columns do
local t=self.columns[e]
local i=math.max(1,math.min(t.width,r))
if e==#self.columns then
i=math.max(1,r)
end
if i<=0 then
break
end
local e=d._resolveColumnValue(t,l)
e=self:_formatCell(t,l,e)
if#e>i then
e=e:sub(1,i)
end
if t.align=="right"then
if#e<i then
e=string.rep(" ",i-#e)..e
end
elseif t.align=="center"then
local t=i-#e
local a=math.floor(t/2)
local t=t-a
e=string.rep(" ",a)..e..string.rep(" ",t)
else
if#e<i then
e=e..string.rep(" ",i-#e)
end
end
local d=u
if t.color then
if type(t.color)=="number"then
d=t.color
elseif type(t.color)=="function"then
local t,e=pcall(t.color,e,l,t,c)
if t and type(e)=="number"then
d=e
end
end
end
o.text(s,m,e,d,h)
s=s+i
r=a-(s-n)
if r<=0 then
break
end
end
end
end
end
if v>0 then
local e=(l and l.background)or s
h(o,t.scrollbarX,w,v,k,e,e)
if l and r>0 then
local e=math.max(0,self.scrollOffset-1)
H(o,t.scrollbarX,p,r,#self._rows,r,e,l)
end
end
if self.border then
y(b,c,u,m,f,self.border,s)
end
end
function d:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=_.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=(e.buffer or"")..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function d:_searchForPrefix(e)
if not e or e==""then
return
end
if#self._rows==0 then
return
end
local a=self.selectedIndex>=1 and self.selectedIndex or 0
for t=1,#self._rows do
local t=((a+t-1)%#self._rows)+1
local a=self.data[self._rows[t]]
local o=self.columns[1]
local a=d._resolveColumnValue(o,a)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function d:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function d:handleEvent(o,...)
if not self.visible then
return false
end
local function i(a,t)
if not self:containsPoint(a,t)then
return false
end
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 and e.rowsHeight>0 then
local i=e.scrollbarX
local o=e.innerY+e.headerHeight
if a>=i and a<i+e.scrollbarWidth and t>=o and t<o+e.rowsHeight then
local a=t-o
local t=math.max(0,self.scrollOffset-1)
local e=S(a,e.rowsHeight,#self._rows,e.rowsHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_clampScroll()
end
return true
end
end
local e=self:_columnFromPoint(a,t)
if e then
local t=self.sortDirection
if self.sortColumn==e.id then
t=t=="asc"and"desc"or"asc"
else
t="asc"
end
if e.sortable~=false then
self:setSort(e.id,t)
end
return true
end
local e=self:_rowFromPoint(a,t)
if e then
self:setSelectedIndex(e)
return true
end
return false
end
if o=="mouse_click"then
local a,e,t=...
return i(e,t)
elseif o=="monitor_touch"then
local a,e,t=...
return i(e,t)
elseif o=="mouse_scroll"then
local t,a,e=...
if self:containsPoint(a,e)then
self.scrollOffset=self.scrollOffset+t
self:_clampScroll()
return true
end
elseif o=="char"then
if self:isFocused()and self.allowRowSelection then
local e=...
self:_handleTypeSearch(e)
return true
end
elseif o=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.up then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(math.max(1,(self.selectedIndex>0)and(self.selectedIndex-1)or 1))
end
return true
elseif e==a.down then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(math.min(#self._rows,(self.selectedIndex>0 and self.selectedIndex or 0)+1))
end
return true
elseif e==a.home then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(1)
else
self.scrollOffset=1
end
return true
elseif e==a["end"]then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(#self._rows)
else
self.scrollOffset=math.max(1,#self._rows-self:_getRowsVisible()+1)
self:_clampScroll()
end
return true
elseif e==a.pageUp then
local e=math.max(1,self:_getRowsVisible()-1)
self.scrollOffset=self.scrollOffset-e
self:_clampScroll()
if self.allowRowSelection and self.selectedIndex>0 then
self:setSelectedIndex(math.max(1,self.selectedIndex-e),true)
self:_notifySelect()
end
return true
elseif e==a.pageDown then
local e=math.max(1,self:_getRowsVisible()-1)
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
if self.allowRowSelection and self.selectedIndex>0 then
self:setSelectedIndex(math.min(#self._rows,self.selectedIndex+e),true)
self:_notifySelect()
end
return true
elseif e==a.enter then
if self.allowRowSelection then
self:_notifySelect()
end
return true
elseif e==a.space then
if self.allowRowSelection then
self:_notifySelect()
end
return true
end
end
return false
end
function u:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local t=setmetatable({},u)
t:_init_base(i,o)
t.focusable=true
t.highlightBg=(a and a.highlightBg)or e.lightGray
t.highlightFg=(a and a.highlightFg)or e.black
t.placeholder=(a and a.placeholder)or nil
t.indentWidth=math.max(1,math.floor((a and a.indentWidth)or 2))
local o=(a and a.toggleSymbols)or{}
t.toggleSymbols={
expanded=tostring(o.expanded or"-"),
collapsed=tostring(o.collapsed or"+"),
leaf=tostring(o.leaf or" ")
}
t.onSelect=a and a.onSelect or nil
t.onToggle=a and a.onToggle or nil
t.nodes={}
t._flatNodes={}
t.scrollOffset=1
t.selectedNode=nil
t._selectedIndex=0
t.typeSearchTimeout=(a and a.typeSearchTimeout)or .75
t._typeSearch={buffer="",lastTime=0}
if not t.border then
t.border=I(true)
end
t.scrollbar=N(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:setNodes((a and a.nodes)or{})
return t
end
function u:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function u:setOnToggle(e)
if e~=nil then
t(1,e,"function")
end
self.onToggle=e
end
function u:setScrollbar(t)
self.scrollbar=N(t,self.bg or e.black,self.fg or e.white)
self:_ensureSelectionVisible()
end
function u:_copyNodes(e,i)
local a={}
if type(e)~="table"then
return a
end
for o=1,#e do
local e=e[o]
if e~=nil then
local t
if type(e)=="string"then
t={
label=e,
data=nil,
expanded=false
}
elseif type(e)=="table"then
t={
label=e.label and tostring(e.label)or string.format("Node %d",o),
data=e.data,
expanded=not not e.expanded
}
else
t={
label=tostring(e),
data=nil,
expanded=false
}
end
t.parent=i
if e and type(e.children)=="table"and#e.children>0 then
t.children=self:_copyNodes(e.children,t)
if t.expanded==nil then
t.expanded=false
end
else
t.children={}
t.expanded=false
end
a[#a+1]=t
end
end
return a
end
function u:setNodes(e)
e=e or{}
t(1,e,"table")
local a=self.selectedNode
local t=self._selectedIndex
self.nodes=self:_copyNodes(e,nil)
self.scrollOffset=1
self.selectedNode=nil
self._selectedIndex=0
self:_rebuildFlatNodes()
local e=self.selectedNode
if a~=e or self._selectedIndex~=t then
self:_notifySelect()
end
end
function u:getSelectedNode()
return self.selectedNode
end
function u:setSelectedNode(e)
if e==nil then
if self.selectedNode~=nil then
self.selectedNode=nil
self._selectedIndex=0
self:_notifySelect()
end
return
end
self:_selectNode(e,false)
end
function u:expandNode(e)
self:_toggleNode(e,true)
end
function u:collapseNode(e)
self:_toggleNode(e,false)
end
function u:toggleNode(e)
self:_toggleNode(e,nil)
end
function u:_rebuildFlatNodes()
local e={}
local function o(t,a)
for i=1,#t do
local t=t[i]
e[#e+1]={node=t,depth=a}
if t.expanded and t.children and#t.children>0 then
o(t.children,a+1)
end
end
end
o(self.nodes,0)
self._flatNodes=e
local t=self:_findVisibleIndex(self.selectedNode)
if t then
self._selectedIndex=t
elseif#e>0 then
self._selectedIndex=1
self.selectedNode=e[1].node
else
self._selectedIndex=0
self.selectedNode=nil
end
self:_ensureSelectionVisible()
end
function u:_findVisibleIndex(e)
if e==nil then
return nil
end
local a=self._flatNodes
for t=1,#a do
if a[t].node==e then
return t
end
end
return nil
end
function u:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-t)
local i=math.max(0,self.height-a-e)
return o,t,a,e,n,i
end
function u:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function u:_computeLayoutMetrics()
local i,n=self:getAbsoluteRect()
local a,s,e,s,t,o=self:_getInnerMetrics()
local a=i+a
local s=n+e
if t<=0 or o<=0 then
return{
innerX=a,
innerY=s,
innerWidth=t,
innerHeight=o,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=a
}
end
local e,n=U(self.scrollbar,#self._flatNodes,o,t)
if e>0 and t-e<1 then
e=math.max(0,t-1)
if e<=0 then
e=0
n=nil
end
end
local i=t-e
if i<1 then
i=t
e=0
n=nil
end
return{
innerX=a,
innerY=s,
innerWidth=t,
innerHeight=o,
contentWidth=i,
scrollbarWidth=e,
scrollbarStyle=n,
scrollbarX=a+i
}
end
function u:_ensureSelectionVisible()
local e=#self._flatNodes
local t=self:_getInnerHeight()
if e==0 then
self.scrollOffset=1
return
end
if self._selectedIndex<1 then
self._selectedIndex=1
elseif self._selectedIndex>e then
self._selectedIndex=e
end
if self.scrollOffset<1 then
self.scrollOffset=1
end
local e=math.max(1,e-t+1)
if self.scrollOffset>e then
self.scrollOffset=e
end
if self._selectedIndex<self.scrollOffset then
self.scrollOffset=self._selectedIndex
elseif self._selectedIndex>self.scrollOffset+t-1 then
self.scrollOffset=self._selectedIndex-t+1
if self.scrollOffset>e then
self.scrollOffset=e
end
end
end
function u:_setSelectedIndex(e,a)
local t=#self._flatNodes
if t==0 then
self.selectedNode=nil
self._selectedIndex=0
self.scrollOffset=1
if not a then
self:_notifySelect()
end
return
end
if e<1 then
e=1
elseif e>t then
e=t
end
self._selectedIndex=e
self.selectedNode=self._flatNodes[e].node
self:_ensureSelectionVisible()
if not a then
self:_notifySelect()
end
end
function u:_selectNode(t,a)
if not t then
return
end
local e=t.parent
while e do
if not e.expanded then
e.expanded=true
end
e=e.parent
end
self:_rebuildFlatNodes()
local e=self:_findVisibleIndex(t)
if e then
self:_setSelectedIndex(e,a)
end
end
function u:_moveSelection(a)
if a==0 then
return
end
local t=#self._flatNodes
if t==0 then
return
end
local e=self._selectedIndex
if e<1 then
e=1
end
e=e+a
if e<1 then
e=1
elseif e>t then
e=t
end
self:_setSelectedIndex(e,false)
end
function u:_scrollBy(t)
if t==0 then
return
end
local e=#self._flatNodes
if e==0 then
self.scrollOffset=1
return
end
local a=self:_getInnerHeight()
local e=math.max(1,e-a+1)
self.scrollOffset=math.min(e,math.max(1,self.scrollOffset+t))
end
function u:_rowFromPoint(i,t)
if not self:containsPoint(i,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
local o=e.innerX
local a=e.innerY
if i<o or i>=o+e.contentWidth then
return nil
end
if t<a or t>=a+e.innerHeight then
return nil
end
local t=t-a
local t=self.scrollOffset+t
if t<1 or t>#self._flatNodes then
return nil
end
return t,o,e.contentWidth
end
function u:_toggleNode(e,a)
if not e or not e.children or#e.children==0 then
return false
end
local t
if a==nil then
t=not e.expanded
else
t=not not a
end
if e.expanded==t then
return false
end
e.expanded=t
self:_rebuildFlatNodes()
if self.onToggle then
self.onToggle(self,e,t)
end
return true
end
function u:_notifySelect()
if self.onSelect then
self.onSelect(self,self.selectedNode,self._selectedIndex)
end
end
function u:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function u:_searchForPrefix(e)
if not e or e==""then
return
end
local a=self._flatNodes
local t=#a
if t==0 then
return
end
local i=self._selectedIndex>=1 and self._selectedIndex or 0
for o=1,t do
local t=((i+o-1)%t)+1
local a=a[t].node
local a=a and a.label or""
if a:lower():sub(1,#e)==e then
self:_setSelectedIndex(t,false)
return
end
end
end
function u:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=_.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function u:draw(n,r)
if not self.visible then
return
end
local o,a,t,i=self:getAbsoluteRect()
local s=self.bg or e.black
local m=self.fg or e.white
h(n,o,a,t,i,s,s)
z(n,o,a,t,i)
if self.border then
y(r,o,a,t,i,self.border,s)
end
local o=self:_computeLayoutMetrics()
local t=o.innerWidth
local r=o.innerHeight
local i=o.contentWidth
local c=o.scrollbarWidth
local d=o.scrollbarStyle
if t<=0 or r<=0 or i<=0 then
return
end
local u=o.innerX
local l=o.innerY
local f=self._flatNodes
local w=#f
if w==0 then
for e=0,r-1 do
n.text(u,l+e,string.rep(" ",i),m,s)
end
local t=self.placeholder
if type(t)=="string"and#t>0 then
local t=t
if#t>i then
t=t:sub(1,i)
end
local a=u+math.floor((i-#t)/2)
if a<u then
a=u
end
n.text(a,l,t,e.lightGray,s)
end
if c>0 then
local e=(d and d.background)or s
h(n,o.scrollbarX,l,c,r,e,e)
if d then
H(n,o.scrollbarX,l,r,0,r,0,d)
end
end
return
end
for t=0,r-1 do
local d=l+t
local r=self.scrollOffset+t
if r>w then
n.text(u,d,string.rep(" ",i),m,s)
else
local t=f[r]
local o=t.node
local t=t.depth or 0
local t=t*self.indentWidth
if t>i-1 then
t=i-1
end
if t<0 then
t=0
end
local a=t>0 and string.rep(" ",t)or""
local h
if o and o.children and#o.children>0 then
h=o.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
else
h=self.toggleSymbols.leaf
end
h=tostring(h or" ")
local t=i-t
local a=a
if t>0 then
local e=h:sub(1,1)
a=a..e
t=t-1
end
if t>0 then
a=a.." "
t=t-1
end
if t>0 then
local e=(o and o.label)or""
if#e>t then
e=e:sub(1,t)
end
a=a..e
t=t-#e
end
if t>0 then
a=a..string.rep(" ",t)
elseif#a>i then
a=a:sub(1,i)
end
local o=s
local t=m
if r==self._selectedIndex then
o=self.highlightBg or e.lightGray
t=self.highlightFg or e.black
end
n.text(u,d,a,t,o)
end
end
if c>0 then
local e=(d and d.background)or s
h(n,o.scrollbarX,l,c,r,e,e)
if d then
H(n,o.scrollbarX,l,r,#self._flatNodes,r,math.max(0,self.scrollOffset-1),d)
end
end
end
function u:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local e,a,t=...
local i,n,o=self:_rowFromPoint(a,t)
if i then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.innerHeight then
local a=t-e.innerY
local t=math.max(0,self.scrollOffset-1)
local e=S(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_ensureSelectionVisible()
end
return true
end
end
local t=self._flatNodes[i]
if t then
local e=t.depth*self.indentWidth
if e<0 then
e=0
end
if e>o-1 then
e=o-1
end
local i=n+e
if t.node and t.node.children and#t.node.children>0 and e<o then
local e=#tostring(self.toggleSymbols.collapsed or"+")
if e<1 then
e=1
end
if a>=i and a<i+e then
self:_toggleNode(t.node,nil)
return true
end
end
end
self:_setSelectedIndex(i,false)
return true
end
elseif t=="monitor_touch"then
local e,a,t=...
local o,n,i=self:_rowFromPoint(a,t)
if o then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.innerHeight then
local a=t-e.innerY
local t=math.max(0,self.scrollOffset-1)
local e=S(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_ensureSelectionVisible()
end
return true
end
end
local e=self._flatNodes[o]
if e then
local t=e.depth*self.indentWidth
if t<0 then
t=0
end
if t>i-1 then
t=i-1
end
local o=n+t
if e.node and e.node.children and#e.node.children>0 and t<i then
local t=#tostring(self.toggleSymbols.collapsed or"+")
if t<1 then
t=1
end
if a>=o and a<o+t then
self:_toggleNode(e.node,nil)
return true
end
end
end
self:_setSelectedIndex(o,false)
return true
end
elseif t=="mouse_scroll"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
if e>0 then
self:_scrollBy(1)
elseif e<0 then
self:_scrollBy(-1)
end
return true
end
elseif t=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.up then
self:_moveSelection(-1)
return true
elseif e==a.down then
self:_moveSelection(1)
return true
elseif e==a.pageUp then
self:_moveSelection(-self:_getInnerHeight())
return true
elseif e==a.pageDown then
self:_moveSelection(self:_getInnerHeight())
return true
elseif e==a.home then
self:_setSelectedIndex(1,false)
return true
elseif e==a["end"]then
self:_setSelectedIndex(#self._flatNodes,false)
return true
elseif e==a.left then
local e=self.selectedNode
if e then
if e.children and#e.children>0 and e.expanded then
self:_toggleNode(e,false)
return true
elseif e.parent then
self:_selectNode(e.parent,false)
return true
end
end
elseif e==a.right then
local e=self.selectedNode
if e and e.children and#e.children>0 then
if not e.expanded then
self:_toggleNode(e,true)
else
local e=e.children[1]
if e then
self:_selectNode(e,false)
end
end
return true
end
elseif e==a.enter or e==a.space then
local e=self.selectedNode
if e and e.children and#e.children>0 then
self:_toggleNode(e,nil)
else
self:_notifySelect()
end
return true
end
elseif t=="char"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
elseif t=="paste"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
end
return false
end
local function T(e,a,t)
if e<a then
return a
end
if e>t then
return t
end
return e
end
local function R(r,a,t,i,o,n)
if not r then
return
end
n=n or e.white
local h=math.abs(i-a)
local d=a<i and 1 or-1
local s=-math.abs(o-t)
local l=t<o and 1 or-1
local e=h+s
while true do
r.pixel(a,t,n)
if a==i and t==o then
break
end
local o=2*e
if o>=s then
e=e+s
a=a+d
end
if o<=h then
e=e+h
t=t+l
end
end
end
function m:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 8))
o.width=math.max(6,math.floor(o.width or 18))
local a=setmetatable({},m)
a:_init_base(i,o)
a.focusable=true
a.data={}
a.labels={}
a.chartType="bar"
a.showAxis=not(t and t.showAxis==false)
a.showLabels=not(t and t.showLabels==false)
a.placeholder=(t and t.placeholder)or"No data"
a.barColor=(t and t.barColor)or e.lightBlue
a.highlightColor=(t and t.highlightColor)or e.orange
a.axisColor=(t and t.axisColor)or(a.fg or e.white)
a.lineColor=(t and t.lineColor)or(a.fg or e.white)
if t and type(t.rangePadding)=="number"then
a.rangePadding=math.max(0,t.rangePadding)
else
a.rangePadding=.05
end
if t and type(t.minValue)=="number"then
a.minValue=t.minValue
else
a.minValue=nil
end
if t and type(t.maxValue)=="number"then
a.maxValue=t.maxValue
else
a.maxValue=nil
end
a.onSelect=t and t.onSelect or nil
a.selectedIndex=nil
a._lastLayout=nil
if t and t.chartType then
a:setChartType(t.chartType)
end
if t and t.labels then
a:setLabels(t.labels)
end
if t and t.data then
a:setData(t.data)
end
if t and t.selectedIndex then
a:setSelectedIndex(t.selectedIndex,true)
else
a:_clampSelection(true)
end
return a
end
function m:_emitSelect()
if self.onSelect then
local e=self.selectedIndex
local t=e and self.data[e]or nil
self.onSelect(self,e,t)
end
end
function m:_clampSelection(a)
local t=#self.data
if t==0 then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not a then
self:_emitSelect()
end
end
return
end
local e=self.selectedIndex
if type(e)~="number"then
e=1
else
e=math.floor(e)
if e<1 then
e=1
elseif e>t then
e=t
end
end
if self.selectedIndex~=e then
self.selectedIndex=e
if not a then
self:_emitSelect()
end
end
end
function m:setData(e)
t(1,e,"table")
local t={}
for a=1,#e do
local e=e[a]
if type(e)~="number"then
e=tonumber(e)or 0
end
t[a]=e
end
self.data=t
self:_clampSelection(false)
end
function m:getData()
return self.data
end
function m:setLabels(e)
if e==nil then
self.labels={}
return
end
t(1,e,"table")
local t={}
for a=1,#e do
local e=e[a]
if e~=nil then
t[a]=tostring(e)
end
end
self.labels=t
end
function m:getLabels()
return self.labels
end
function m:getLabel(e)
if type(e)~="number"then
return nil
end
if not self.labels then
return nil
end
return self.labels[math.floor(e)]
end
function m:setChartType(e)
if e==nil then
return
end
t(1,e,"string")
local e=e:lower()
if e~="bar"and e~="line"then
error("Chart type must be 'bar' or 'line'",2)
end
self.chartType=e
end
function m:setShowAxis(e)
self.showAxis=not not e
end
function m:setShowLabels(e)
self.showLabels=not not e
end
function m:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e or""
end
function m:setRange(a,e)
if a~=nil then
t(1,a,"number")
end
if e~=nil then
t(2,e,"number")
end
self.minValue=a
self.maxValue=e
end
function m:setRangePadding(e)
t(1,e,"number")
if e<0 then
e=0
end
self.rangePadding=e
end
function m:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function m:setSelectedIndex(e,a)
if e==nil then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not a then
self:_emitSelect()
end
end
return false
end
t(1,e,"number")
local t=#self.data
if t==0 then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not a then
self:_emitSelect()
end
end
return false
end
local e=math.floor(e)
if e<1 then
e=1
elseif e>t then
e=t
end
if self.selectedIndex==e then
return false
end
self.selectedIndex=e
if not a then
self:_emitSelect()
end
return true
end
function m:getSelectedIndex()
return self.selectedIndex
end
function m:getSelectedValue()
local e=self.selectedIndex
if not e then
return nil
end
return self.data[e]
end
function m:onFocusChanged(e)
if e then
self:_clampSelection(true)
end
end
function m:_indexFromPoint(t)
local e=self._lastLayout
if not e or not e.bars then
return nil
end
local a=e.bars
for e=1,#a do
local a=a[e]
if t>=a.left and t<=a.right then
return e
end
end
if t<e.innerX or t>=e.innerX+e.innerWidth then
return nil
end
if e.innerWidth<=0 then
return nil
end
local t=t-e.innerX
local t=math.floor(t*e.dataCount/e.innerWidth)+1
if t<1 or t>e.dataCount then
return nil
end
return t
end
function m:_moveSelection(a)
if a==0 then
return false
end
local t=#self.data
if t==0 then
return false
end
local e=self.selectedIndex or(a>0 and 0 or t+1)
e=e+a
if e<1 then
e=1
elseif e>t then
e=t
end
return self:setSelectedIndex(e,false)
end
function m:draw(r,p)
if not self.visible then
return
end
local n,s,o,d=self:getAbsoluteRect()
local i=self.bg or e.black
local f=self.fg or e.white
h(r,n,s,o,d,i,i)
z(r,n,s,o,d)
if self.border then
y(p,n,s,o,d,self.border,i)
end
local t=self.border
local a=(t and t.thickness)or 0
local u=(t and t.left)and a or 0
local c=(t and t.right)and a or 0
local l=(t and t.top)and a or 0
local t=(t and t.bottom)and a or 0
local n=n+u
local s=s+l
local a=math.max(0,o-u-c)
local t=math.max(0,d-l-t)
self._lastLayout=nil
if a<=0 or t<=0 then
return
end
local d=#self.data
if d==0 then
local o=self.placeholder or""
if o~=""then
local o=o
if#o>a then
o=o:sub(1,a)
end
local a=n+math.floor((a-#o)/2)
if a<n then
a=n
end
local t=s+math.floor((t-1)/2)
r.text(a,t,o,e.lightGray,i)
end
return
end
local o=(self.showLabels and t>=2)and 1 or 0
local c=(self.showAxis and(t-o)>=2)and 1 or 0
local l=t-c-o
if l<1 then
l=t
c=0
o=0
end
local m=s
local u=m+l-1
local w=c>0 and(u+1)or nil
local c
if o>0 then
if w then
c=w+1
else
c=u+1
end
if c>s+t-1 then
c=s+t-1
end
end
local t=math.huge
local o=-math.huge
for e=1,d do
local e=self.data[e]or 0
if e<t then
t=e
end
if e>o then
o=e
end
end
if t==math.huge then
t=0
end
if o==-math.huge then
o=0
end
local t=type(self.minValue)=="number"and self.minValue or t
local s=type(self.maxValue)=="number"and self.maxValue or o
if s==t then
s=s+1
t=t-1
end
local o=s-t
if o<=0 then
o=1
s=t+o
end
local y=self.rangePadding or 0
if y>0 then
local e=s-t
local e=e*y
if e==0 then
e=y
end
t=t-e
s=s+e
o=s-t
if o<=0 then
o=1
s=t+o
end
end
local s={}
for o=1,d do
local t=n+math.floor((o-1)*a/d)
local e=n+math.floor(o*a/d)-1
if e<t then
e=t
end
if e>n+a-1 then
e=n+a-1
end
local a=e-t+1
if a<1 then
a=1
end
s[o]={
left=t,
right=e,
width=a,
center=t+math.floor((a-1)/2)
}
end
if self.chartType=="bar"then
for a=1,d do
local i=self.data[a]or 0
local e=0
if o>0 then
e=(i-t)/o
end
e=T(e,0,1)
local e=math.floor(e*l+.5)
if l>0 and e<=0 and i>t then
e=1
end
if e>l then
e=l
end
if e<1 then
e=1
end
local o=u-e+1
if o<m then
o=m
e=u-m+1
end
local t=self.barColor or f
if self.selectedIndex==a then
t=self.highlightColor or t
end
h(r,s[a].left,o,s[a].width,e,t,t)
end
else
local a={}
for i=1,d do
local n=self.data[i]or 0
local e=0
if o>0 then
e=(n-t)/o
end
e=T(e,0,1)
local t=math.max(l-1,0)
local e=u-math.floor(e*t+.5)
if e<m then
e=m
end
if e>u then
e=u
end
a[i]={x=s[i].center,y=e}
end
for e=2,#a do
local t=a[e-1]
local e=a[e]
R(p,t.x,t.y,e.x,e.y,self.lineColor or f)
end
for o=1,#a do
local a=a[o]
local t=self.lineColor or f
local n="o"
if self.selectedIndex==o then
t=self.highlightColor or e.orange
n="O"
end
r.text(a.x,a.y,n,t,i)
end
end
if w then
h(r,n,w,a,1,i,i)
local e=string.rep("-",a)
r.text(n,w,e,self.axisColor or f,i)
end
if c then
h(r,n,c,a,1,i,i)
local t=self.labels or{}
for n=1,d do
local t=t[n]
if t and t~=""then
t=tostring(t)
local a=s[n]
local o=a.width
if o>0 and#t>o then
t=t:sub(1,o)
end
local o=a.left+math.floor((a.width-#t)/2)
if o<a.left then
o=a.left
end
if o+#t-1>a.right then
o=a.right-#t+1
end
local e=(self.selectedIndex==n)and(self.highlightColor or e.orange)or(self.axisColor or f)
r.text(o,c,t,e,i)
end
end
end
self._lastLayout={
innerX=n,
innerWidth=a,
dataCount=d,
bars=s
}
end
function m:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"or e=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
local e=self:_indexFromPoint(e)
if e then
self:setSelectedIndex(e,false)
end
return true
end
elseif e=="mouse_scroll"then
local e,t,a=...
if self:containsPoint(t,a)then
self.app:setFocus(self)
if e>0 then
self:_moveSelection(1)
elseif e<0 then
self:_moveSelection(-1)
end
return true
end
elseif e=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.left then
self:_moveSelection(-1)
return true
elseif e==a.right then
self:_moveSelection(1)
return true
elseif e==a.home then
self:setSelectedIndex(1,false)
return true
elseif e==a["end"]then
local e=#self.data
if e>0 then
self:setSelectedIndex(e,false)
end
return true
elseif e==a.enter or e==a.space then
self:_emitSelect()
return true
end
end
return false
end
function c:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local t=setmetatable({},c)
t:_init_base(i,o)
t.focusable=true
t.items={}
if a and type(a.items)=="table"then
for e=1,#a.items do
local e=a.items[e]
if e~=nil then
t.items[#t.items+1]=tostring(e)
end
end
end
if type(a.selectedIndex)=="number"then
t.selectedIndex=math.floor(a.selectedIndex)
elseif#t.items>0 then
t.selectedIndex=1
else
t.selectedIndex=0
end
t.highlightBg=(a and a.highlightBg)or e.lightGray
t.highlightFg=(a and a.highlightFg)or e.black
t.placeholder=(a and a.placeholder)or nil
t.onSelect=a and a.onSelect or nil
t.scrollOffset=1
t.typeSearchTimeout=(a and a.typeSearchTimeout)or .75
t._typeSearch={buffer="",lastTime=0}
if not t.border then
t.border=I(true)
end
t.scrollbar=N(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_normalizeSelection(true)
return t
end
function c:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-o-a)
local n=math.max(0,self.height-t-e)
return o,a,t,e,i,n
end
function c:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function c:_computeLayoutMetrics()
local t,o=self:getAbsoluteRect()
local a,s,n,s,e,i=self:_getInnerMetrics()
local a=t+a
local s=o+n
if e<=0 or i<=0 then
return{
innerX=a,
innerY=s,
innerWidth=e,
innerHeight=i,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=a
}
end
local t,n=U(self.scrollbar,#self.items,i,e)
if t>0 and e-t<1 then
t=math.max(0,e-1)
if t<=0 then
t=0
n=nil
end
end
local o=e-t
if o<1 then
o=e
t=0
n=nil
end
return{
innerX=a,
innerY=s,
innerWidth=e,
innerHeight=i,
contentWidth=o,
scrollbarWidth=t,
scrollbarStyle=n,
scrollbarX=a+o
}
end
function c:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function c:_ensureSelectionVisible()
if self.selectedIndex<1 or self.selectedIndex>#self.items then
self:_clampScroll()
return
end
local e=self:_getInnerHeight()
if self.selectedIndex<self.scrollOffset then
self.scrollOffset=self.selectedIndex
elseif self.selectedIndex>self.scrollOffset+e-1 then
self.scrollOffset=self.selectedIndex-e+1
end
self:_clampScroll()
end
function c:_normalizeSelection(t)
local e=#self.items
if e==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
if self.selectedIndex<1 then
self.selectedIndex=1
elseif self.selectedIndex>e then
self.selectedIndex=e
end
self:_ensureSelectionVisible()
if not t then
self:_notifySelect()
end
end
function c:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function c:setItems(a)
t(1,a,"table")
local e={}
for t=1,#a do
local t=a[t]
if t~=nil then
e[#e+1]=tostring(t)
end
end
local t=self:getSelectedItem()
local a=self.selectedIndex
self.items=e
if#e==0 then
self.selectedIndex=0
self.scrollOffset=1
if(a~=0 or t~=nil)and self.onSelect then
self.onSelect(self,nil,0)
end
return
end
self:_normalizeSelection(true)
local e=self:getSelectedItem()
if(a~=self.selectedIndex)or(t~=e)then
self:_notifySelect()
end
end
function c:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function c:setSelectedIndex(e,a)
if#self.items==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
t(1,e,"number")
e=math.floor(e)
if e<1 then
e=1
elseif e>#self.items then
e=#self.items
end
if self.selectedIndex~=e then
self.selectedIndex=e
self:_ensureSelectionVisible()
if not a then
self:_notifySelect()
end
else
self:_ensureSelectionVisible()
end
end
function c:getSelectedIndex()
return self.selectedIndex
end
function c:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function c:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e
end
function c:setHighlightColors(e,a)
if e~=nil then
t(1,e,"number")
self.highlightBg=e
end
if a~=nil then
t(2,a,"number")
self.highlightFg=a
end
end
function c:setScrollbar(t)
self.scrollbar=N(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function c:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function c:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function c:_itemIndexFromPoint(a,t)
if not self:containsPoint(a,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
local i=e.innerX
local o=e.innerY
if a<i or a>=i+e.contentWidth then
return nil
end
if t<o or t>=o+e.innerHeight then
return nil
end
local e=t-o
local e=self.scrollOffset+e
if e<1 or e>#self.items then
return nil
end
return e
end
function c:_moveSelection(t)
if#self.items==0 then
return
end
local e=self.selectedIndex
if e<1 then
e=1
end
e=e+t
if e<1 then
e=1
elseif e>#self.items then
e=#self.items
end
self:setSelectedIndex(e)
end
function c:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
end
function c:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=_.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function c:_searchForPrefix(e)
if not e or e==""then
return
end
local t=#self.items
if t==0 then
return
end
local a=self.selectedIndex>=1 and self.selectedIndex or 0
for o=1,t do
local t=((a+o-1)%t)+1
local a=self.items[t]
if a and a:lower():sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function c:draw(a,s)
if not self.visible then
return
end
local i,n,o,t=self:getAbsoluteRect()
local d=self.bg or e.black
local u=self.fg or e.white
h(a,i,n,o,t,d,d)
z(a,i,n,o,t)
if self.border then
y(s,i,n,o,t,self.border,d)
end
local t=self:_computeLayoutMetrics()
local n=t.innerWidth
local i=t.innerHeight
local o=t.contentWidth
if n<=0 or i<=0 or o<=0 then
return
end
local r=t.innerX
local s=t.innerY
local l=t.scrollbarWidth
local n=t.scrollbarStyle
local c=#self.items
local d=d
local f=self.highlightBg or e.lightGray
local m=self.highlightFg or e.black
if c==0 then
for e=0,i-1 do
a.text(r,s+e,string.rep(" ",o),u,d)
end
if l>0 then
local e=(n and n.background)or d
h(a,t.scrollbarX,s,l,i,e,e)
end
local h=self.placeholder
if type(h)=="string"and#h>0 then
local t=h
if#t>o then
t=t:sub(1,o)
end
local o=r+math.floor((o-#t)/2)
if o<r then
o=r
end
a.text(o,s,t,e.lightGray,d)
end
if n then
H(a,t.scrollbarX,s,i,0,i,0,n)
end
return
end
for e=0,i-1 do
local i=s+e
local t=self.scrollOffset+e
if t>c then
a.text(r,i,string.rep(" ",o),u,d)
else
local e=self.items[t]or""
if#e>o then
e=e:sub(1,o)
end
local e=e
if#e<o then
e=e..string.rep(" ",o-#e)
end
local o=d
local n=u
if t==self.selectedIndex then
o=f
n=m
end
a.text(r,i,e,n,o)
end
end
if l>0 then
local e=(n and n.background)or d
h(a,t.scrollbarX,s,l,i,e,e)
if n then
H(a,t.scrollbarX,s,i,#self.items,i,math.max(0,self.scrollOffset-1),n)
end
end
end
function c:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.innerHeight then
local a=t-e.innerY
local t=math.max(0,self.scrollOffset-1)
local e=S(a,e.innerHeight,#self.items,e.innerHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_clampScroll()
end
return true
end
end
local e=self:_itemIndexFromPoint(a,t)
if e then
self:setSelectedIndex(e)
end
return true
end
elseif t=="monitor_touch"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.innerHeight then
local a=t-e.innerY
local t=math.max(0,self.scrollOffset-1)
local e=S(a,e.innerHeight,#self.items,e.innerHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_clampScroll()
end
return true
end
end
local e=self:_itemIndexFromPoint(a,t)
if e then
self:setSelectedIndex(e)
end
return true
end
elseif t=="mouse_scroll"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
if e>0 then
self:_scrollBy(1)
elseif e<0 then
self:_scrollBy(-1)
end
return true
end
elseif t=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.up then
self:_moveSelection(-1)
return true
elseif e==a.down then
self:_moveSelection(1)
return true
elseif e==a.pageUp then
self:_moveSelection(-self:_getInnerHeight())
return true
elseif e==a.pageDown then
self:_moveSelection(self:_getInnerHeight())
return true
elseif e==a.home then
if#self.items>0 then
self:setSelectedIndex(1)
end
return true
elseif e==a["end"]then
if#self.items>0 then
self:setSelectedIndex(#self.items)
end
return true
elseif e==a.enter or e==a.space then
self:_notifySelect()
return true
end
elseif t=="char"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
elseif t=="paste"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
end
return false
end
function g:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},g)
a:_init_base(i,o)
a.focusable=true
a.items={}
if t and type(t.items)=="table"then
for e=1,#t.items do
local e=t.items[e]
if e~=nil then
a.items[#a.items+1]=tostring(e)
end
end
end
a.dropdownBg=(t and t.dropdownBg)or e.black
a.dropdownFg=(t and t.dropdownFg)or e.white
a.highlightBg=(t and t.highlightBg)or e.lightBlue
a.highlightFg=(t and t.highlightFg)or e.black
a.placeholder=(t and t.placeholder)or"Select..."
a.onChange=t and t.onChange or nil
if t and type(t.selectedIndex)=="number"then
a.selectedIndex=math.floor(t.selectedIndex)
elseif#a.items>0 then
a.selectedIndex=1
else
a.selectedIndex=0
end
a:_normalizeSelection()
if not a.border then
a.border=I(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function g:_normalizeSelection()
if#self.items==0 then
self.selectedIndex=0
return
end
if self.selectedIndex<1 then
self.selectedIndex=1
elseif self.selectedIndex>#self.items then
self.selectedIndex=#self.items
end
end
function g:setItems(a)
t(1,a,"table")
local e={}
for t=1,#a do
local t=a[t]
if t~=nil then
e[#e+1]=tostring(t)
end
end
local a=self:getSelectedItem()
local t=self.selectedIndex
self.items=e
if#e==0 then
self.selectedIndex=0
if t~=0 or a~=nil then
self:_notifyChange()
end
self:_setOpen(false)
return
end
self:_normalizeSelection()
local e=self:getSelectedItem()
if t~=self.selectedIndex or a~=e then
self:_notifyChange()
end
if self._open then
self._hoverIndex=self.selectedIndex
end
end
function g:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function g:setSelectedIndex(e,a)
if e==nil then
return
end
t(1,e,"number")
if#self.items==0 then
self.selectedIndex=0
return
end
e=math.floor(e)
if e<1 then
e=1
elseif e>#self.items then
e=#self.items
end
if self.selectedIndex~=e then
self.selectedIndex=e
if not a then
self:_notifyChange()
end
end
if self._open then
self._hoverIndex=self.selectedIndex
end
end
function g:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function g:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function g:_setOpen(e)
e=not not e
if e and#self.items==0 then
e=false
end
if self._open==e then
return
end
self._open=e
if e then
if self.app then
self.app:_registerPopup(self)
end
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
self._hoverIndex=self.selectedIndex
elseif#self.items>0 then
self._hoverIndex=1
else
self._hoverIndex=nil
end
else
if self.app then
self.app:_unregisterPopup(self)
end
self._hoverIndex=nil
end
end
function g:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function g:_isPointInDropdown(o,t)
if not self._open or#self.items==0 then
return false
end
local a,n,i,e=self:getAbsoluteRect()
local e=n+e
return o>=a and o<a+i and t>=e and t<e+#self.items
end
function g:_indexFromPoint(t,e)
if not self:_isPointInDropdown(t,e)then
return nil
end
local o,a,o,t=self:getAbsoluteRect()
local e=e-(a+t)+1
if e<1 or e>#self.items then
return nil
end
return e
end
function g:_handlePress(e,t)
local i,i,a,o=self:getAbsoluteRect()
if a<=0 or o<=0 then
return false
end
if self:containsPoint(e,t)then
self.app:setFocus(self)
if self._open then
self:_setOpen(false)
else
self:_setOpen(true)
end
return true
end
if self:_isPointInDropdown(e,t)then
local e=self:_indexFromPoint(e,t)
if e then
self:setSelectedIndex(e)
end
self.app:setFocus(self)
self:_setOpen(false)
return true
end
if self._open then
self:_setOpen(false)
end
return false
end
function g:draw(i,d)
if not self.visible then
return
end
local o,a,n,s=self:getAbsoluteRect()
local t=self.bg or e.black
local r=self.fg or e.white
h(i,o,a,n,s,t,t)
z(i,o,a,n,s)
if self.border then
y(d,o,a,n,s,self.border,t)
end
local e=self.border
local h=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local l=o+h
local h=math.max(0,n-h-u)
local u=a+d
local e=math.max(0,s-d-e)
local s=h>0 and 1 or 0
local o=math.max(0,h-s)
local n
if e>0 then
n=u+math.floor((e-1)/2)
else
n=a
end
local e=self:getSelectedItem()
if not e or e==""then
e=self.placeholder or""
end
if o>0 then
if#e>o then
e=e:sub(1,o)
end
local a=math.max(0,o-#e)
local e=e..string.rep(" ",a)
i.text(l,n,e,r,t)
end
if s>0 then
local a=self._open and string.char(30)or string.char(31)
local e=l+h-1
i.text(e,n,a,r,t)
end
end
function g:_drawDropdown(r,c)
if not self._open or#self.items==0 or self.visible==false then
return
end
local t,i,a,e=self:getAbsoluteRect()
local i=i+e
local d=#self.items
local e=self.border
local n=(e and e.left)and 1 or 0
local s=(e and e.right)and 1 or 0
local u=t+n
local n=math.max(0,a-n-s)
local l=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local s=d+e
h(r,t,i,a,s,self.dropdownBg,self.dropdownBg)
z(r,t,i,a,s)
for e=1,d do
local a=i+e-1
local t=self.items[e]or""
local e=l~=nil and l==e
local o=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local i=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if n>0 then
local e=t
if#e>n then
e=e:sub(1,n)
end
local t=math.max(0,n-#e)
local e=e..string.rep(" ",t)
r.text(u,a,e,i,o)
end
end
if self.border then
local e=o(self.border)
if e then
e.top=false
y(c,t,i,a,s,e,self.dropdownBg)
end
end
end
function g:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,t,e=...
return self:_handlePress(t,e)
elseif t=="monitor_touch"then
local a,t,e=...
return self:_handlePress(t,e)
elseif t=="mouse_scroll"then
local t,e,a=...
if self:containsPoint(e,a)or self:_isPointInDropdown(e,a)then
self.app:setFocus(self)
if t>0 then
self:setSelectedIndex(self.selectedIndex+1)
elseif t<0 then
self:setSelectedIndex(self.selectedIndex-1)
end
return true
end
elseif t=="mouse_move"then
local e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
end
elseif t=="mouse_drag"then
local a,t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
end
elseif t=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.down then
self:setSelectedIndex(self.selectedIndex+1)
return true
elseif e==a.up then
self:setSelectedIndex(self.selectedIndex-1)
return true
elseif e==a.home then
self:setSelectedIndex(1)
return true
elseif e==a["end"]then
self:setSelectedIndex(#self.items)
return true
elseif e==a.enter or e==a.space then
if self._open then
self:_setOpen(false)
else
self:_setOpen(true)
end
return true
elseif e==a.escape then
if self._open then
self:_setOpen(false)
return true
end
end
elseif t=="char"then
if not self:isFocused()or#self.items==0 then
return false
end
local e=...
if e and#e>0 then
local a=e:sub(1,1):lower()
local t=self.selectedIndex>=1 and self.selectedIndex or 0
for e=1,#self.items do
local t=((t+e-1)%#self.items)+1
local e=self.items[t]
if e and e:sub(1,1):lower()==a then
self:setSelectedIndex(t)
return true
end
end
end
end
return false
end
local o={}
o.__index=o
setmetatable(o,{__index=i})
local M={
["and"]=true,
["break"]=true,
["do"]=true,
["else"]=true,
["elseif"]=true,
["end"]=true,
["false"]=true,
["for"]=true,
["function"]=true,
["goto"]=true,
["if"]=true,
["in"]=true,
["local"]=true,
["nil"]=true,
["not"]=true,
["or"]=true,
["repeat"]=true,
["return"]=true,
["then"]=true,
["true"]=true,
["until"]=true,
["while"]=true
}
local C={
print=true,
ipairs=true,
pairs=true,
next=true,
math=true,
table=true,
string=true,
coroutine=true,
os=true,
tonumber=true,
tostring=true,
type=true,
pcall=true,
xpcall=true,
select=true
}
local function D(a)
if a==nil or a==""then
return{""}
end
local e={}
local t=1
local i=#a
while t<=i do
local o=a:find("\n",t,true)
if not o then
e[#e+1]=a:sub(t)
break
end
e[#e+1]=a:sub(t,o-1)
t=o+1
if t>i then
e[#e+1]=""
break
end
end
if#e==0 then
e[1]=""
end
return e
end
local function B(e)
return table.concat(e,"\n")
end
local function T(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function R(e,t,o,a)
if e<o then
return-1
end
if e>o then
return 1
end
if t<a then
return-1
end
if t>a then
return 1
end
return 0
end
local function V(e,t,a,i,o,n)
if R(e,t,a,i)<0 then
return false
end
if R(e,t,o,n)>=0 then
return false
end
return true
end
local function G(a)
if a==nil then
return nil
end
if a==true then
a="lua"
end
if type(a)=="string"then
if a=="lua"then
return{
language="lua",
keywords=M,
builtins=C,
keywordColor=e.orange,
commentColor=e.lightGray,
stringColor=e.yellow,
numberColor=e.cyan,
builtinColor=e.lightBlue
}
end
return nil
end
if type(a)=="table"then
local t={}
for e,a in pairs(a)do
t[e]=a
end
if t.language=="lua"then
t.keywords=t.keywords or M
t.builtins=t.builtins or C
if t.keywordColor==nil then
t.keywordColor=e.orange
end
if t.commentColor==nil then
t.commentColor=e.lightGray
end
if t.stringColor==nil then
t.stringColor=e.yellow
end
if t.numberColor==nil then
t.numberColor=e.cyan
end
if t.builtinColor==nil then
t.builtinColor=e.lightBlue
end
end
return t
end
return nil
end
function o:new(n,a)
a=a or{}
local i={}
for t,e in pairs(a)do
i[t]=e
end
i.focusable=true
i.width=math.max(4,math.floor(i.width or 16))
i.height=math.max(1,math.floor(i.height or(a.multiline~=false and 5 or 1)))
local t=setmetatable({},o)
t:_init_base(n,i)
t.focusable=true
t.placeholder=a.placeholder or""
t.onChange=a.onChange or nil
t.onCursorMove=a.onCursorMove or nil
t.maxLength=a.maxLength or nil
t.multiline=a.multiline~=false
t.tabWidth=math.max(1,math.floor(a.tabWidth or 4))
t.selectionBg=a.selectionBg or e.lightGray
t.selectionFg=a.selectionFg or e.black
t.overlayBg=a.overlayBg or e.gray
t.overlayFg=a.overlayFg or e.white
t.overlayActiveBg=a.overlayActiveBg or e.orange
t.overlayActiveFg=a.overlayActiveFg or e.black
t.autocomplete=a.autocomplete
t.autocompleteAuto=not not a.autocompleteAuto
t.autocompleteMaxItems=math.max(1,math.floor(a.autocompleteMaxItems or 5))
t.autocompleteBg=a.autocompleteBg or e.gray
t.autocompleteFg=a.autocompleteFg or e.white
t.autocompleteGhostColor=a.autocompleteGhostColor or e.lightGray
t.syntax=G(a.syntax)
t._lines={""}
t.text=""
t._cursorLine=1
t._cursorCol=1
t._preferredCol=1
t._selectionAnchor=nil
t._scrollX=0
t._scrollY=0
t._shiftDown=false
t._ctrlDown=false
t._dragging=false
t._dragButton=nil
t._dragAnchor=nil
t._find={
visible=false,
activeField="find",
findText="",
replaceText="",
matchCase=false,
matches={},
index=0
}
t._autocompleteState={
visible=false,
items={},
selectedIndex=1,
anchorLine=1,
anchorCol=1,
prefix="",
ghost="",
trigger="auto"
}
if not t.border then
t.border=I(true)
end
t.scrollbar=N(a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_setTextInternal(a.text or"",true,true)
if a.cursorPos then
t:_moveCursorToIndex(a.cursorPos)
end
t:_ensureCursorVisible()
return t
end
function o:setOnCursorMove(e)
if e~=nil then
t(1,e,"function")
end
self.onCursorMove=e
end
function o:setScrollbar(t)
self.scrollbar=N(t,self.bg or e.black,self.fg or e.white)
end
function o:onFocusChanged(e)
self:_ensureCursorVisible()
end
function o:_applyMaxLength(e)
if not self.maxLength then
return e
end
if#e<=self.maxLength then
return e
end
return e:sub(1,self.maxLength)
end
function o:_syncTextFromLines()
self.text=B(self._lines)
end
function o:_setTextInternal(e,a,t)
e=tostring(e or"")
e=self:_applyMaxLength(e)
self._lines=D(e)
self:_syncTextFromLines()
if a then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=T(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=T(self._cursorCol,1,#e+1)
end
self._preferredCol=self._cursorCol
self._selectionAnchor=nil
self:_ensureCursorVisible()
if not t then
self:_notifyChange()
self:_notifyCursorChange()
end
end
function o:_indexToPosition(e)
e=T(e or 1,1,#self.text+1)
local e=e-1
for a=1,#self._lines do
local t=self._lines[a]
local t=#t
if e<=t then
return a,e+1
end
e=e-(t+1)
end
local e=#self._lines
local t=#self._lines[e]
return e,t+1
end
function o:_moveCursorToIndex(e)
local e,t=self:_indexToPosition(e)
self:_setCursorPosition(e,t)
end
function o:getCursorPosition()
return self._cursorLine,self._cursorCol
end
function o:getLineCount()
return#self._lines
end
function o:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i,n=self:getAbsoluteRect()
local i=i+a
local n=n+t
local s=math.max(0,self.width-a-o)
local o=math.max(0,self.height-t-e)
return i,n,s,o,a,t,e
end
function o:_getOverlayHeight(e)
if not self._find.visible then
return 0
end
return math.min(2,e)
end
function o:_computeLayoutMetrics()
local n,i,a,e=self:getAbsoluteRect()
local s,h,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
s=n
h=i
t=math.max(1,a)
o=math.max(1,e)
end
local r=self:_getOverlayHeight(o)
local n=math.max(1,o-r)
local e,a=U(self.scrollbar,#self._lines,n,t)
if e>0 and t-e<1 then
if a and(a.alwaysVisible or#self._lines>n)then
e=math.max(0,t-1)
else
e=0
a=nil
end
end
if e<=0 then
e=0
a=nil
end
local i=t-e
if i<1 then
i=t
e=0
a=nil
end
return{
innerX=s,
innerY=h,
innerWidth=t,
innerHeight=o,
contentWidth=i,
contentHeight=n,
overlayHeight=r,
scrollbarWidth=e,
scrollbarStyle=a,
scrollbarX=s+i
}
end
function o:_getContentSize()
local e=self:_computeLayoutMetrics()
return math.max(1,e.contentWidth),math.max(1,e.contentHeight)
end
function o:_ensureCursorVisible()
local t,e=self:_getContentSize()
local o=self._scrollY+1
local a=self._scrollY+e
if self._cursorLine<o then
self._scrollY=self._cursorLine-1
elseif self._cursorLine>a then
self._scrollY=self._cursorLine-e
end
if self._scrollY<0 then
self._scrollY=0
end
local e=math.max(0,#self._lines-e)
if self._scrollY>e then
self._scrollY=e
end
local a=self._scrollX+1
local e=self._scrollX+t
if self._cursorCol<a then
self._scrollX=self._cursorCol-1
elseif self._cursorCol>e then
self._scrollX=self._cursorCol-t
end
if self._scrollX<0 then
self._scrollX=0
end
local e=self._lines[self._cursorLine]or""
local e=math.max(0,#e+1-t)
if self._scrollX>e then
self._scrollX=e
end
end
function o:_notifyChange()
if self.onChange then
self.onChange(self,self.text)
end
end
function o:_notifyCursorChange()
if self.onCursorMove then
self.onCursorMove(self,self._cursorLine,self._cursorCol,self:getSelectionLength())
end
end
function o:_hasSelection()
if not self._selectionAnchor then
return false
end
if self._selectionAnchor.line~=self._cursorLine then
return true
end
return self._selectionAnchor.col~=self._cursorCol
end
function o:getSelectionLength()
if not self:_hasSelection()then
return 0
end
local t,e,a,o=self:_getSelectionRange()
local e=self:_collectRange(t,e,a,o)
return#e
end
function o:getSelectionText()
if not self:_hasSelection()then
return""
end
local e,t,o,a=self:_getSelectionRange()
return self:_collectRange(e,t,o,a)
end
function o:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local e,a=e.line,e.col
local t,o=self._cursorLine,self._cursorCol
if R(e,a,t,o)<=0 then
return e,a,t,o
else
return t,o,e,a
end
end
function o:_collectRange(t,i,a,o)
if t==a then
return(self._lines[t]or""):sub(i,o-1)
end
local e={}
e[#e+1]=(self._lines[t]or""):sub(i)
for t=t+1,a-1 do
e[#e+1]=self._lines[t]or""
end
e[#e+1]=(self._lines[a]or""):sub(1,o-1)
return table.concat(e,"\n")
end
function o:_clearSelection()
self._selectionAnchor=nil
end
function o:_removeRange(e,a,t,o)
if e==t then
local t=self._lines[e]
self._lines[e]=t:sub(1,a-1)..t:sub(o)
else
local i=self._lines[e]:sub(1,a-1)
local a=self._lines[t]:sub(o)
for e=t,e+1,-1 do
table.remove(self._lines,e)
end
self._lines[e]=i..a
end
if#self._lines==0 then
self._lines[1]=""
end
end
function o:_insertAt(e,t,a)
if a==nil or a==""then
return e,t
end
local a=D(a)
local o=self._lines[e]
local i=o:sub(1,t-1)
local t=o:sub(t)
self._lines[e]=i..a[1]
local e=e
for t=2,#a do
e=e+1
table.insert(self._lines,e,a[t])
end
self._lines[e]=self._lines[e]..t
local t=(#self._lines[e]-#t)+1
return e,t
end
function o:_deleteSelection(n)
local e,t,o,a=self:_getSelectionRange()
if not e then
return 0
end
local i=self:_collectRange(e,t,o,a)
self:_removeRange(e,t,o,a)
self._cursorLine=e
self._cursorCol=t
self._preferredCol=self._cursorCol
self:_clearSelection()
self:_syncTextFromLines()
self:_ensureCursorVisible()
if not n then
self:_notifyChange()
end
self:_notifyCursorChange()
return#i
end
function o:_replaceSelection(e,a)
local t=0
if self:_hasSelection()then
t=self:_deleteSelection(true)
end
local t=#self.text
if self.maxLength then
local t=self.maxLength-t
if#e>t then
e=e:sub(1,t)
end
end
local e,t=self:_insertAt(self._cursorLine,self._cursorCol,e)
self._cursorLine=e
self._cursorCol=t
self._preferredCol=self._cursorCol
self:_clearSelection()
self:_syncTextFromLines()
self:_ensureCursorVisible()
if not a then
self:_notifyChange()
end
self:_notifyCursorChange()
return true
end
function o:_insertTextAtCursor(e)
if not e or e==""then
return false
end
return self:_replaceSelection(e,false)
end
function o:_insertCharacter(e)
if not e or e==""then
return false
end
return self:_insertTextAtCursor(e)
end
function o:_insertNewline()
if not self.multiline then
return false
end
return self:_insertTextAtCursor("\n")
end
function o:_insertTab()
local e=string.rep(" ",self.tabWidth)
return self:_insertTextAtCursor(e)
end
function o:_deleteBackward()
if self:_hasSelection()then
return self:_deleteSelection(false)>0
end
if self._cursorLine==1 and self._cursorCol==1 then
return false
end
if self._cursorCol>1 then
local e=self._lines[self._cursorLine]
self._lines[self._cursorLine]=e:sub(1,self._cursorCol-2)..e:sub(self._cursorCol)
self._cursorCol=self._cursorCol-1
else
local e=self._lines[self._cursorLine-1]
local a=self._lines[self._cursorLine]
local t=#e
self._lines[self._cursorLine-1]=e..a
table.remove(self._lines,self._cursorLine)
self._cursorLine=self._cursorLine-1
self._cursorCol=t+1
end
self._preferredCol=self._cursorCol
self:_syncTextFromLines()
self:_ensureCursorVisible()
self:_notifyChange()
self:_notifyCursorChange()
return true
end
function o:_deleteForward()
if self:_hasSelection()then
return self:_deleteSelection(false)>0
end
local e=self._lines[self._cursorLine]
if self._cursorCol<=#e then
self._lines[self._cursorLine]=e:sub(1,self._cursorCol-1)..e:sub(self._cursorCol+1)
else
if self._cursorLine>=#self._lines then
return false
end
local t=table.remove(self._lines,self._cursorLine+1)
self._lines[self._cursorLine]=e..t
end
self:_syncTextFromLines()
self:_ensureCursorVisible()
self:_notifyChange()
self:_notifyCursorChange()
return true
end
function o:_setCursorPosition(a,t,e)
e=e or{}
a=T(a,1,#self._lines)
local o=self._lines[a]or""
t=T(t,1,#o+1)
if e.extendSelection then
if not self._selectionAnchor then
self._selectionAnchor={line=self._cursorLine,col=self._cursorCol}
end
else
self:_clearSelection()
end
self._cursorLine=a
self._cursorCol=t
if not e.preservePreferred then
self._preferredCol=t
end
if self._selectionAnchor and self._selectionAnchor.line==self._cursorLine and self._selectionAnchor.col==self._cursorCol then
self:_clearSelection()
end
self:_ensureCursorVisible()
self:_notifyCursorChange()
if not e.keepAutocomplete then
self:_hideAutocomplete()
end
end
function o:_moveCursorLeft(e)
if self:_hasSelection()and not e then
local t,e=self:_getSelectionRange()
self:_setCursorPosition(t,e)
return
end
if self._cursorCol>1 then
self:_setCursorPosition(self._cursorLine,self._cursorCol-1,{extendSelection=e})
elseif self._cursorLine>1 then
local t=self._cursorLine-1
local a=(#self._lines[t]or 0)+1
self:_setCursorPosition(t,a,{extendSelection=e})
end
end
function o:_moveCursorRight(e)
if self:_hasSelection()and not e then
local a,a,e,t=self:_getSelectionRange()
self:_setCursorPosition(e,t)
return
end
local t=self._lines[self._cursorLine]
if self._cursorCol<=#t then
self:_setCursorPosition(self._cursorLine,self._cursorCol+1,{extendSelection=e})
elseif self._cursorLine<#self._lines then
self:_setCursorPosition(self._cursorLine+1,1,{extendSelection=e})
end
end
function o:_moveCursorVertical(e,a)
local e=T(self._cursorLine+e,1,#self._lines)
local t=self._lines[e]or""
local t=T(self._preferredCol,1,#t+1)
self:_setCursorPosition(e,t,{extendSelection=a,preservePreferred=true})
end
function o:_moveCursorUp(e)
self:_moveCursorVertical(-1,e)
end
function o:_moveCursorDown(e)
self:_moveCursorVertical(1,e)
end
function o:_moveCursorLineStart(e)
self:_setCursorPosition(self._cursorLine,1,{extendSelection=e})
end
function o:_moveCursorLineEnd(t)
local e=self._lines[self._cursorLine]
self:_setCursorPosition(self._cursorLine,#e+1,{extendSelection=t})
end
function o:_moveCursorDocumentStart(e)
self:_setCursorPosition(1,1,{extendSelection=e})
end
function o:_moveCursorDocumentEnd(t)
local e=#self._lines
local a=#self._lines[e]
self:_setCursorPosition(e,a+1,{extendSelection=t})
end
function o:_selectAll()
self._selectionAnchor={line=1,col=1}
self:_setCursorPosition(#self._lines,(#self._lines[#self._lines]or 0)+1,{extendSelection=true,keepAutocomplete=true})
end
function o:_scrollLines(e)
if e==0 then
return
end
local a,t=self:_getContentSize()
local t=math.max(0,#self._lines-t)
self._scrollY=T(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local a=select(1,self:_getContentSize())
local t=self._lines[self._cursorLine]or""
local t=math.max(0,#t-a)
self._scrollX=T(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(i,n)
local e=self:_computeLayoutMetrics()
local a=e.innerX
local o=e.innerY
local t=math.max(1,e.contentWidth)
local e=math.max(1,e.contentHeight)
local a=T(i-a,0,t-1)
local e=T(n-o,0,e-1)
local e=T(self._scrollY+e+1,1,#self._lines)
local t=self._lines[e]or""
local t=T(self._scrollX+a+1,1,#t+1)
return e,t
end
function o:_computeSyntaxColors(o)
local t=self.syntax
if not t then
return nil
end
local a={}
local i=t.defaultColor or self.fg or e.white
for e=1,#o do
a[e]=i
end
local e=1
while e<=#o do
local i=o:sub(e,e)
if i=='"'or i=="'"then
local i=i
a[e]=t.stringColor or a[e]
e=e+1
while e<=#o do
a[e]=t.stringColor or a[e]
local t=o:sub(e,e)
if t==i and o:sub(e-1,e-1)~="\\"then
e=e+1
break
end
e=e+1
end
else
e=e+1
end
end
for e,n,o in o:gmatch("()(%d+%.?%d*)()")do
if t.numberColor then
for e=e,o-1 do
if a[e]==i then
a[e]=t.numberColor
end
end
end
end
for s,n,o in o:gmatch("()([%a_][%w_]*)()")do
local e=n:lower()
if t.keywords and t.keywords[e]then
if t.keywordColor then
for e=s,o-1 do
if a[e]==i then
a[e]=t.keywordColor
end
end
end
elseif t.builtins and t.builtins[n]then
if t.builtinColor then
for e=s,o-1 do
if a[e]==i then
a[e]=t.builtinColor
end
end
end
end
end
local e=o:find("--",1,true)
if e then
local t=t.commentColor or i
for e=e,#o do
a[e]=t
end
end
return a
end
local function T(t,a,o,i)
if a==""then
return
end
local e=t[#t]
if e and e.fg==o and e.bg==i then
e.text=e.text..a
else
t[#t+1]={text=a,fg=o,bg=i}
end
end
function o:_buildLineSegments(n,i,r,h,e)
local a=self._lines[n]or""
local o=self:_computeSyntaxColors(a)
local t=self._scrollX+1
local s={}
for i=0,i-1 do
local t=t+i
local i
if t<=#a then
i=a:sub(t,t)
else
i=" "
end
local o=o and o[t]or r
local a=h
if e and V(n,t,e.startLine,e.startCol,e.endLine,e.endCol)then
a=self.selectionBg
o=self.selectionFg
end
T(s,i,o,a)
end
return s,a,o
end
function o:_drawSegments(o,t,i,e)
local t=t
for a=1,#e do
local e=e[a]
if e.text~=""then
o.text(t,i,e.text,e.fg,e.bg)
t=t+#e.text
end
end
end
function o:_drawFindOverlay(s,a,n,t,i)
if not self._find.visible then
return
end
local o=self:_getOverlayHeight(i)
if o<=0 then
return
end
local d=self.overlayBg or self.bg or e.gray
local r=self.overlayFg or self.fg or e.white
local c=self.overlayActiveBg or e.orange
local u=self.overlayActiveFg or e.black
local i=n+i-o
for e=0,o-1 do
s.text(a,i+e,string.rep(" ",t),r,d)
end
local e=self._find
local n=#e.matches
local n=n>0 and string.format("%d/%d",math.max(1,e.index),n)or"0/0"
local h=e.matchCase and"CASE"or"case"
local n=string.format("Find: %s  %s  %s",e.findText,n,h)
local h="Replace: "..e.replaceText
local n=n
if#n>t then
n=n:sub(1,t)
end
local h=h
if#h>t then
h=h:sub(1,t)
end
s.text(a,i,n..string.rep(" ",math.max(0,t-#n)),r,d)
s.text(a,i+math.max(o-1,0),h..string.rep(" ",math.max(0,t-#h)),r,d)
local n,h,l
if e.activeField=="find"then
n=a+6
h=i
l=e.findText
else
n=a+9
h=i+math.max(o-1,0)
l=e.replaceText
end
local e=l
if#e>t-(n-a)then
e=e:sub(1,t-(n-a))
end
s.text(n,h,e..string.rep(" ",math.max(0,t-(n-a)-#e)),u,c)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
s.text(a,i+o-1,e..string.rep(" ",math.max(0,t-#e)),r,d)
end
end
function o:_hideAutocomplete()
local e=self._autocompleteState
e.visible=false
e.items={}
e.ghost=""
e.prefix=""
e.trigger="auto"
e.selectedIndex=1
e.anchorLine=self._cursorLine
e.anchorCol=self._cursorCol
end
function o:_updateAutocomplete(n)
if not self.autocomplete then
return
end
local a=self._lines[self._cursorLine]or""
local e=self._cursorCol-1
local t=e
while t>=1 do
local e=a:sub(t,t)
if not e:match("[%w_]")then
break
end
t=t-1
end
t=t+1
local o=a:sub(t,e)
if o==""and n~="manual"then
self:_hideAutocomplete()
return
end
local e={}
if type(self.autocomplete)=="function"then
local a,t=pcall(self.autocomplete,self,o)
if a and type(t)=="table"then
e=t
end
elseif type(self.autocomplete)=="table"then
e=self.autocomplete
end
local a={}
local i=o:lower()
for t=1,#e do
local e=e[t]
if type(e)=="string"then
local t=e:lower()
if o==""or t:sub(1,#i)==i then
a[#a+1]={label=e,insert=e}
end
elseif type(e)=="table"and e.label then
local t=e.label
local n=t:lower()
if o==""or n:sub(1,#i)==i then
a[#a+1]={label=t,insert=e.insert or t}
end
end
end
if#a==0 then
self:_hideAutocomplete()
return
end
local e=self._autocompleteState
e.trigger=n or"auto"
e.visible=true
e.items={}
for t=1,math.min(self.autocompleteMaxItems,#a)do
e.items[t]=a[t]
end
e.selectedIndex=1
e.anchorLine=self._cursorLine
e.anchorCol=t
e.prefix=o
e.ghost=self:_computeAutocompleteGhost(e.items[e.selectedIndex],e.prefix,e.trigger)
end
function o:_computeAutocompleteGhost(t,e,a)
if not t then
return""
end
local t=t.insert or t.label or""
if t==""then
return""
end
if e==""then
if a=="manual"then
return t
end
return""
end
local a=t:lower()
local o=e:lower()
if a:sub(1,#e)~=o then
return""
end
return t:sub(#e+1)
end
function o:_acceptAutocomplete()
local e=self._autocompleteState
if not e.visible or#e.items==0 then
return false
end
local t=e.items[e.selectedIndex]
if not t then
return false
end
local a,o=self._cursorLine,self._cursorCol
self._selectionAnchor={line=e.anchorLine,col=e.anchorCol}
self._cursorLine=a
self._cursorCol=o
self:_replaceSelection(t.insert or t.label or"",false)
self:_hideAutocomplete()
return true
end
function o:_moveAutocompleteSelection(a)
local e=self._autocompleteState
if not e.visible then
return
end
local t=#e.items
if t==0 then
return
end
e.selectedIndex=((e.selectedIndex-1+a)%t)+1
e.ghost=self:_computeAutocompleteGhost(e.items[e.selectedIndex],e.prefix,e.trigger)
end
function o:_toggleFindOverlay(e)
local t=self._find
if t.visible and(not e or t.activeField==e)then
self:_closeFindOverlay()
return
end
t.visible=true
if e then
t.activeField=e
end
if self:_hasSelection()and e=="find"then
t.findText=self:getSelectionText()
end
self:_updateFindMatches(true)
end
function o:_closeFindOverlay()
local e=self._find
if e.visible then
e.visible=false
e.matches={}
e.index=0
end
end
function o:_toggleFindField()
local e=self._find
if not e.visible then
return
end
if e.activeField=="find"then
e.activeField="replace"
else
e.activeField="find"
end
end
function o:_editFindFieldText(t)
local e=self._find
if not e.visible then
return
end
t=tostring(t or"")
t=t:gsub("[\r\n]"," ")
if e.activeField=="find"then
e.findText=e.findText..t
self:_updateFindMatches(true)
elseif e.activeField=="replace"then
e.replaceText=e.replaceText..t
end
end
function o:_handleOverlayBackspace()
local e=self._find
if not e.visible then
return false
end
if e.activeField=="find"then
if#e.findText==0 then
return false
end
e.findText=e.findText:sub(1,-2)
self:_updateFindMatches(true)
else
if#e.replaceText==0 then
return false
end
e.replaceText=e.replaceText:sub(1,-2)
end
return true
end
function o:_updateFindMatches(t)
local e=self._find
e.matches={}
e.index=t and 0 or e.index
if not e.visible or e.findText==""then
return
end
local i=e.findText
local t=e.matchCase
for a=1,#self._lines do
local o=self._lines[a]
local n=t and o or o:lower()
local t=t and i or i:lower()
local o=1
while true do
local t,i=n:find(t,o,true)
if not t then
break
end
e.matches[#e.matches+1]={
line=a,
col=t,
length=i-t+1
}
o=t+1
end
end
end
function o:_selectMatch(e)
if not e then
return
end
self._selectionAnchor={line=e.line,col=e.col}
self:_setCursorPosition(e.line,e.col+e.length,{extendSelection=true,keepAutocomplete=true})
self:_ensureCursorVisible()
self:_notifyCursorChange()
end
function o:_gotoMatch(o)
local e=self._find
if not e.visible then
return false
end
self:_updateFindMatches(false)
if#e.matches==0 then
return false
end
if e.index<1 then
local t=1
for a=1,#e.matches do
local e=e.matches[a]
if R(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
t=a
break
end
end
e.index=t
else
e.index=((e.index-1+o)%#e.matches)+1
end
self:_selectMatch(e.matches[e.index])
return true
end
function o:_gotoNextMatch()
return self:_gotoMatch(1)
end
function o:_gotoPreviousMatch()
return self:_gotoMatch(-1)
end
function o:_replaceCurrentMatch()
local e=self._find
if not e.visible or#e.matches==0 then
return false
end
if e.index<1 or e.index>#e.matches then
e.index=1
end
local t=e.matches[e.index]
self._selectionAnchor={line=t.line,col=t.col}
self:_setCursorPosition(t.line,t.col+t.length,{extendSelection=true,keepAutocomplete=true})
self:_replaceSelection(e.replaceText or"",false)
self:_updateFindMatches(true)
return true
end
function o:_replaceAll()
local e=self._find
if not e.visible or e.findText==""then
return false
end
self:_updateFindMatches(true)
if#e.matches==0 then
return false
end
for t=#e.matches,1,-1 do
local t=e.matches[t]
local i=t.line
local a=t.col
local o=self._lines[i]
self._lines[i]=o:sub(1,a-1)..(e.replaceText or"")..o:sub(a+t.length)
end
self:_syncTextFromLines()
self:_ensureCursorVisible()
self:_notifyChange()
self:_notifyCursorChange()
self:_updateFindMatches(true)
return true
end
function o:_handleEscape()
if self._find.visible then
self:_closeFindOverlay()
return true
end
if self:_hasSelection()then
self:_clearSelection()
self:_notifyCursorChange()
return true
end
if self._autocompleteState.visible then
self:_hideAutocomplete()
return true
end
return false
end
function o:_handleKey(e,t)
if self._find.visible then
if e==a.tab then
self:_toggleFindField()
return true
elseif e==a.backspace then
return self:_handleOverlayBackspace()
elseif e==a.enter then
if self._find.activeField=="find"then
self:_gotoNextMatch()
else
self:_replaceCurrentMatch()
end
return true
elseif e==a.delete then
local e=self._find
if e.activeField=="find"then
e.findText=""
self:_updateFindMatches(true)
else
e.replaceText=""
end
return true
end
end
if self._ctrlDown then
if e==a.a then
self:_selectAll()
return true
elseif e==a.f then
self:_toggleFindOverlay("find")
return true
elseif e==a.h then
self:_toggleFindOverlay("replace")
return true
elseif e==a.g then
if self._shiftDown then
self:_gotoPreviousMatch()
else
self:_gotoNextMatch()
end
return true
elseif e==a.space then
self:_updateAutocomplete("manual")
return true
elseif e==a.r and self._shiftDown then
self:_replaceAll()
return true
elseif e==a.f and self._shiftDown then
local e=self._find
e.matchCase=not e.matchCase
self:_updateFindMatches(true)
return true
end
end
if self._autocompleteState.visible then
if e==a.enter or e==a.tab then
return self:_acceptAutocomplete()
elseif e==a.up then
self:_moveAutocompleteSelection(-1)
return true
elseif e==a.down then
self:_moveAutocompleteSelection(1)
return true
elseif e==a.escape then
self:_hideAutocomplete()
return true
end
end
if e==a.left then
self:_moveCursorLeft(self._shiftDown)
return true
elseif e==a.right then
self:_moveCursorRight(self._shiftDown)
return true
elseif e==a.up then
self:_moveCursorUp(self._shiftDown)
return true
elseif e==a.down then
self:_moveCursorDown(self._shiftDown)
return true
elseif e==a.home then
if self._ctrlDown then
self:_moveCursorDocumentStart(self._shiftDown)
else
self:_moveCursorLineStart(self._shiftDown)
end
return true
elseif e==a["end"]then
if self._ctrlDown then
self:_moveCursorDocumentEnd(self._shiftDown)
else
self:_moveCursorLineEnd(self._shiftDown)
end
return true
elseif e==a.backspace then
return self:_deleteBackward()
elseif e==a.delete then
return self:_deleteForward()
elseif e==a.enter then
return self:_insertNewline()
elseif e==a.tab then
return self:_insertTab()
elseif e==a.pageUp then
self:_scrollLines(-math.max(1,select(2,self:_getContentSize())-1))
return true
elseif e==a.pageDown then
self:_scrollLines(math.max(1,select(2,self:_getContentSize())-1))
return true
elseif e==a.escape then
return self:_handleEscape()
end
return false
end
function o:draw(a,q)
if not self.visible then
return
end
local m,c,f,w=self:getAbsoluteRect()
local s=self.bg or e.black
local p=self.fg or e.white
h(a,m,c,f,w,s,s)
z(a,m,c,f,w)
local o=self:_computeLayoutMetrics()
local r=o.innerX
local n=o.innerY
local t=o.innerWidth
local j=o.innerHeight
local i=o.contentWidth
local d=o.contentHeight
local b=o.overlayHeight
local u=o.scrollbarWidth
local v=o.scrollbarStyle
local g
local k=false
if self:_hasSelection()then
local o,e,t,a=self:_getSelectionRange()
g={
startLine=o,
startCol=e,
endLine=t,
endCol=a
}
k=true
end
local t=self._autocompleteState
local l=s
for s=0,d-1 do
local o=self._scrollY+s+1
local n=n+s
if o>#self._lines then
a.text(r,n,string.rep(" ",i),p,l)
else
local s,h,d=self:_buildLineSegments(o,i,p,l,g)
self:_drawSegments(a,r,n,s)
if self:isFocused()and o==self._cursorLine then
local t=self._cursorCol-self._scrollX-1
if t>=0 and t<i then
local e
if self._cursorCol<=#h then
e=h:sub(self._cursorCol,self._cursorCol)
else
e=" "
end
local i=l
local o=p
a.text(r+t,n,e,i,o)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not k and o==t.anchorLine then
local s=t.anchorCol+#t.prefix
local o=s-self._scrollX-1
if o<i then
local t=t.ghost
local h=#h
if s<=h then
local e=h-s+1
if e>=#t then
t=""
else
t=t:sub(e+1)
o=o+e
end
end
if t~=""then
if o<0 then
local e=-o
if e>=#t then
t=""
else
t=t:sub(e+1)
o=0
end
end
if t~=""and o<i then
local i=i-o
if i>0 then
if#t>i then
t=t:sub(1,i)
end
if t~=""then
a.text(r+o,n,t,self.autocompleteGhostColor or e.lightGray,l)
end
end
end
end
end
end
end
end
if self.text==""and not self:isFocused()and self.placeholder~=""then
local t=self.placeholder
if#t>i then
t=t:sub(1,i)
end
a.text(r,n,t..string.rep(" ",math.max(0,i-#t)),e.lightGray,l)
end
self:_drawFindOverlay(a,r,n,i,j)
if v then
local t=o.scrollbarX
local e=v.background or s
h(a,t,n,u,d,e,e)
H(a,t,n,d,#self._lines,d,self._scrollY,v)
if b>0 then
h(a,t,n+d,u,b,e,e)
end
elseif u>0 then
h(a,o.scrollbarX,n,u,d+b,s,s)
end
if self.border then
y(q,m,c,f,w,self.border,s)
end
end
function o:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local o,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.contentHeight then
local t=t-e.innerY
local e=S(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
if e~=self._scrollY then
self._scrollY=e
end
return true
end
end
local t,e=self:_cursorFromPoint(a,t)
if o==1 then
self:_setCursorPosition(t,e)
self._dragging=true
self._dragButton=o
self._dragAnchor={line=t,col=e}
elseif o==2 then
self:_setCursorPosition(t,e)
end
return true
end
elseif t=="mouse_drag"then
local e,t,a=...
if self._dragging and e==self._dragButton then
local t,e=self:_cursorFromPoint(t,a)
if not self._selectionAnchor and self._dragAnchor then
self._selectionAnchor={line=self._dragAnchor.line,col=self._dragAnchor.col}
end
self:_setCursorPosition(t,e,{extendSelection=true,keepAutocomplete=true})
return true
end
elseif t=="mouse_up"then
local e=...
if self._dragging and e==self._dragButton then
self._dragging=false
self._dragButton=nil
self._dragAnchor=nil
return true
end
elseif t=="monitor_touch"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.contentHeight then
local t=t-e.innerY
local e=S(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
if e~=self._scrollY then
self._scrollY=e
end
return true
end
end
local t,e=self:_cursorFromPoint(a,t)
self:_setCursorPosition(t,e)
return true
end
elseif t=="mouse_scroll"then
local t,e,a=...
if self:containsPoint(e,a)then
self:_scrollLines(t)
return true
end
elseif t=="char"then
local e=...
if self:isFocused()then
if self._find.visible then
self:_editFindFieldText(e)
return true
end
local e=self:_insertCharacter(e)
if e and self.autocompleteAuto then
self:_updateAutocomplete("auto")
end
return e
end
elseif t=="paste"then
local e=...
if self:isFocused()then
if self._find.visible then
self:_editFindFieldText(e)
return true
end
local e=self:_insertTextAtCursor(e)
if e and self.autocompleteAuto then
self:_updateAutocomplete("auto")
end
return e
end
elseif t=="key"then
local e,t=...
if e==a.leftShift or e==a.rightShift then
self._shiftDown=true
return true
elseif e==a.leftCtrl or e==a.rightCtrl then
self._ctrlDown=true
return true
end
if self:isFocused()then
return self:_handleKey(e,t)
end
elseif t=="key_up"then
local e=...
if e==a.leftShift or e==a.rightShift then
self._shiftDown=false
if not self:_hasSelection()then
self:_clearSelection()
end
return true
elseif e==a.leftCtrl or e==a.rightCtrl then
self._ctrlDown=false
return true
elseif e==a.escape then
if self:_handleEscape()then
return true
end
end
end
return false
end
function o:setText(e,a)
t(1,e,"string")
self:_setTextInternal(e,true,a)
end
function o:getText()
return self.text
end
function o:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function w.create(a)
if a~=nil then
t(1,a,"table")
end
a=a or{}
local h=false
local i
local t=a.window
if t==nil then
i=F.current()
local a,e=i.getSize()
t=ee.create(i,1,1,a,e,true)
t.setVisible(true)
h=true
end
local o=P.new(t)
o.profiler.start_frame()
o.profiler.start_region("user")
local u=o.add_pixel_layer(5,"pixelui_pixels")
local c=o.add_text_layer(10,"pixelui_ui")
local l,d=t.getSize()
local n=a.background or e.black
o.fill(n)
local r=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=t,
box=o,
layer=c,
pixelLayer=u,
background=n,
running=false,
_autoWindow=h,
_parentTerminal=i,
_focusWidget=nil,
_popupWidgets={},
_popupLookup={},
_animations={},
_animationTimer=nil,
_animationInterval=r,
_radioGroups={},
_threads={},
_threadTimers={},
_threadTicker=nil,
_threadIdCounter=0
},s)
t.root=p:new(t,{
x=1,
y=1,
width=l,
height=d,
bg=n,
fg=e.white,
border=a.rootBorder,
z=-math.huge
})
return t
end
function s:getRoot()
return self.root
end
function s:setBackground(e)
t(1,e,"number")
self.background=e
self.box.fill(e)
end
function s:getLayer()
return self.layer
end
function s:getPixelLayer()
return self.pixelLayer
end
function s:createFrame(e)
return p:new(self,e)
end
function s:createWindow(e)
return r:new(self,e)
end
function s:createButton(e)
return A:new(self,e)
end
function s:createLabel(e)
return j:new(self,e)
end
function s:createCheckBox(e)
return q:new(self,e)
end
function s:createToggle(e)
return x:new(self,e)
end
function s:createTextBox(e)
return o:new(self,e)
end
function s:createComboBox(e)
return g:new(self,e)
end
function s:createList(e)
return c:new(self,e)
end
function s:createTable(e)
return d:new(self,e)
end
function s:createTreeView(e)
return u:new(self,e)
end
function s:createChart(e)
return m:new(self,e)
end
function s:createRadioButton(e)
return b:new(self,e)
end
function s:createProgressBar(e)
return v:new(self,e)
end
function s:createNotificationToast(e)
return n:new(self,e)
end
function s:createLoadingRing(e)
return f:new(self,e)
end
function s:createFreeDraw(e)
return O:new(self,e)
end
function s:createSlider(e)
return l:new(self,e)
end
function s:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=_.startTimer(self._animationInterval)
end
end
function s:_updateAnimations()
local a=self._animations
if not a or#a==0 then
return
end
local o=_.clock()
local t=1
while t<=#a do
local e=a[t]
if e._cancelled then
if e.onCancel then
e.onCancel(e.handle)
end
e._finished=true
table.remove(a,t)
else
if not e.startTime then
e.startTime=o
end
local i=o-e.startTime
local o
if e.duration<=0 then
o=1
else
o=math.min(1,i/e.duration)
end
local i=e.easing(o)
if e.update then
e.update(i,o,e.handle)
end
if o>=1 then
e._finished=true
if e.onComplete then
e.onComplete(e.handle)
end
table.remove(a,t)
else
t=t+1
end
end
end
end
function s:_clearAnimations(t)
local e=self._animations
if not e or#e==0 then
self._animations={}
self._animationTimer=nil
return
end
if t then
for t=1,#e do
local e=e[t]
if e and not e._finished then
if e.onCancel then
e.onCancel(e.handle)
end
e._finished=true
end
end
end
self._animations={}
self._animationTimer=nil
end
function s:animate(e)
t(1,e,"table")
local a=e.update
if a~=nil and type(a)~="function"then
error("options.update must be a function",2)
end
local i=e.onComplete
if i~=nil and type(i)~="function"then
error("options.onComplete must be a function",2)
end
local o=e.onCancel
if o~=nil and type(o)~="function"then
error("options.onCancel must be a function",2)
end
local t=e.easing
if t==nil then
t=L.linear
elseif type(t)=="string"then
t=L[t]
if not t then
error("Unknown easing '"..e.easing.."'",2)
end
elseif type(t)~="function"then
error("options.easing must be a function or easing name",2)
end
if e.duration~=nil and type(e.duration)~="number"then
error("options.duration must be a number",2)
end
local e=math.max(.01,e.duration or .3)
local e={
update=a,
onComplete=i,
onCancel=o,
easing=t,
duration=e,
startTime=_.clock()
}
local t={}
function t:cancel()
if e._finished or e._cancelled then
return
end
e._cancelled=true
end
e.handle=t
self._animations[#self._animations+1]=e
if a then
a(0,0,t)
end
self:_ensureAnimationTimer()
return t
end
local a="running"
local y="completed"
local z="error"
local h="cancelled"
local I={}
local function T(e,a,...)
if not e then
return
end
for t=1,#e do
local e=e[t]
local t,e=pcall(e,...)
if not t then
print(a..tostring(e))
end
end
end
function k:getId()
return self.id
end
function k:getName()
return self.name
end
function k:setName(e)
t(1,e,"string")
self.name=e
end
function k:getStatus()
return self.status
end
function k:isRunning()
return self.status==a
end
function k:isFinished()
local e=self.status
return e==y or e==z or e==h
end
function k:isCancelled()
return self._cancelRequested or self.status==h
end
function k:cancel()
if self.status~=a then
return false
end
self._cancelRequested=true
if self.waiting=="timer"and self.timerId then
local e=self.app._threadTimers
if e then
e[self.timerId]=nil
end
self.timerId=nil
end
self.waiting=nil
self._ready=true
self.app:_ensureThreadPump()
return true
end
function k:getResult()
if not self.result then
return nil
end
return Y(self.result,1,self.result.n or#self.result)
end
function k:getResults()
if not self.result then
return nil
end
local e={n=self.result.n}
local t=self.result.n or#self.result
for t=1,t do
e[t]=self.result[t]
end
return e
end
function k:getError()
return self.error
end
function k:setMetadata(e,a)
t(1,e,"string")
local t=self.metadata[e]
if t==a then
return
end
self.metadata[e]=a
self:_emitMetadata(e,a)
end
function k:getMetadata(e)
t(1,e,"string")
return self.metadata[e]
end
function k:getAllMetadata()
local e={}
for t,a in pairs(self.metadata)do
e[t]=a
end
return e
end
function k:onStatusChange(e)
if e==nil then
return
end
t(1,e,"function")
local t=self._statusListeners
t[#t+1]=e
local t,e=pcall(e,self,self.status)
if not t then
print("Thread status listener error: "..tostring(e))
end
end
function k:onMetadataChange(e)
if e==nil then
return
end
t(1,e,"function")
local t=self._metadataListeners
t[#t+1]=e
for t,a in pairs(self.metadata)do
local t,e=pcall(e,self,t,a)
if not t then
print("Thread metadata listener error: "..tostring(e))
end
end
end
function k:_emitMetadata(e,t)
T(self._metadataListeners,"Thread metadata listener error: ",self,e,t)
end
function k:_setStatus(e)
if self.status==e then
return
end
self.status=e
T(self._statusListeners,"Thread status listener error: ",self,e)
end
local function T(e)
return setmetatable({_handle=e},E)
end
function E:checkCancelled()
if self._handle._cancelRequested then
error(I,0)
end
end
function E:isCancelled()
return self._handle._cancelRequested==true
end
function E:sleep(a)
if a~=nil then
t(1,a,"number")
else
a=0
end
if a<0 then
a=0
end
self:checkCancelled()
local e=self._handle
if e.timerId then
local t=e.app._threadTimers
if t then
t[e.timerId]=nil
end
e.timerId=nil
end
e.waiting="timer"
local a=_.startTimer(a)
e.timerId=a
local t=e.app._threadTimers
if not t then
t={}
e.app._threadTimers=t
end
t[a]=e
e._ready=false
return coroutine.yield("sleep")
end
function E:yield()
self:checkCancelled()
self._handle.waiting="yield"
return coroutine.yield("yield")
end
function E:setMetadata(e,t)
self._handle:setMetadata(e,t)
end
function E:setStatus(e)
self._handle:setMetadata("status",e)
end
function E:setDetail(e)
self._handle:setMetadata("detail",e)
end
function E:setProgress(e)
if e~=nil then
t(1,e,"number")
end
self._handle:setMetadata("progress",e)
end
function E:getHandle()
return self._handle
end
function s:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
self._threadTicker=_.startTimer(0)
return
end
end
end
function s:_cleanupThread(e)
if e.timerId and self._threadTimers then
self._threadTimers[e.timerId]=nil
e.timerId=nil
end
e.waiting=nil
e._ready=false
e._resumeValue=nil
end
function s:_resumeThread(e)
if e.status~=a then
return
end
if e._cancelRequested then
e:_setStatus(h)
self:_cleanupThread(e)
return
end
local t=e._resumeValue
e._resumeValue=nil
local t=W(coroutine.resume(e.co,t))
local a=t[1]
if not a then
local t=t[2]
if t==I then
e:_setStatus(h)
else
if type(t)=="string"and debug and debug.traceback then
t=debug.traceback(e.co,t)
end
e.error=t
print("PixelUI thread error: "..tostring(t))
e:_setStatus(z)
end
self:_cleanupThread(e)
return
end
if coroutine.status(e.co)=="dead"then
local o={n=t.n-1}
for a=2,t.n do
o[a-1]=t[a]
end
e.result=o
e:_setStatus(y)
self:_cleanupThread(e)
return
end
local t=t[2]
e.waiting=nil
if t=="sleep"then
return
elseif t=="yield"then
e._ready=true
else
e._ready=true
end
self:_ensureThreadPump()
end
function s:_serviceThreads()
if not self._threads or#self._threads==0 then
return
end
local t={}
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
e._ready=false
t[#t+1]=e
end
end
for e=1,#t do
self:_resumeThread(t[e])
end
self:_ensureThreadPump()
end
function s:_shutdownThreads()
if not self._threads then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a then
e._cancelRequested=true
e:_setStatus(h)
self:_cleanupThread(e)
end
end
self._threadTimers={}
self._threadTicker=nil
end
function s:spawnThread(o,e)
t(1,o,"function")
if e~=nil then
t(2,e,"table")
else
e={}
end
if not self._threads then
self._threads={}
end
if not self._threadTimers then
self._threadTimers={}
end
self._threadIdCounter=(self._threadIdCounter or 0)+1
local t=self._threadIdCounter
local i=e.name or("Thread "..tostring(t))
local t=setmetatable({
app=self,
id=t,
name=i,
status=a,
co=nil,
waiting=nil,
timerId=nil,
_ready=true,
_cancelRequested=false,
_resumeValue=nil,
metadata={},
result=nil,
error=nil,
_statusListeners={},
_metadataListeners={}
},k)
local a=coroutine.create(function()
local e=T(t)
t._context=e
local e=W(o(e,self))
return Y(e,1,e.n)
end)
t.co=a
self._threads[#self._threads+1]=t
if e.onStatus then
t:onStatusChange(e.onStatus)
end
if e.onMetadata then
t:onMetadataChange(e.onMetadata)
end
self:_ensureThreadPump()
return t
end
function s:getThreads()
local e={}
if not self._threads then
return e
end
for t=1,#self._threads do
e[t]=self._threads[t]
end
return e
end
function s:_registerPopup(e)
if not e then
return
end
local t=self._popupLookup
if not t[e]then
t[e]=true
table.insert(self._popupWidgets,e)
end
end
function s:_unregisterPopup(e)
if not e then
return
end
local t=self._popupLookup
if not t[e]then
return
end
t[e]=nil
local t=self._popupWidgets
for a=#t,1,-1 do
if t[a]==e then
table.remove(t,a)
break
end
end
end
function s:_drawPopups()
local t=self._popupWidgets
if not t or#t==0 then
return
end
local o=self.layer
local i=self.pixelLayer
local a=1
while a<=#t do
local e=t[a]
if e and e._open and e.visible~=false then
e:_drawDropdown(o,i)
a=a+1
else
if e then
self._popupLookup[e]=nil
end
table.remove(t,a)
end
end
end
function s:_registerRadioButton(e)
if not e or not e.group then
return
end
local a=e.group
local o=self._radioGroups
local t=o[a]
if not t then
t={buttons={},lookup={},selected=nil}
o[a]=t
end
if not t.lookup[e]then
t.lookup[e]=true
t.buttons[#t.buttons+1]=e
end
e._registeredGroup=a
if t.selected then
if t.selected==e then
e:_applySelection(true,true)
else
e:_applySelection(false,true)
end
elseif e.selected then
self:_selectRadioInGroup(a,e,true)
end
end
function s:_unregisterRadioButton(t)
if not t then
return
end
local a=t._registeredGroup
if not a then
return
end
local e=self._radioGroups[a]
if not e then
t._registeredGroup=nil
return
end
e.lookup[t]=nil
for a=#e.buttons,1,-1 do
if e.buttons[a]==t then
table.remove(e.buttons,a)
break
end
end
if e.selected==t then
e.selected=nil
for t=1,#e.buttons do
local e=e.buttons[t]
if e then
e:_applySelection(false,true)
end
end
end
t._registeredGroup=nil
if not next(e.lookup)then
self._radioGroups[a]=nil
end
end
function s:_selectRadioInGroup(o,t,a)
if not o then
return
end
a=not not a
local i=self._radioGroups
local e=i[o]
if not e then
e={buttons={},lookup={},selected=nil}
i[o]=e
end
if t then
if not e.lookup[t]then
e.lookup[t]=true
e.buttons[#e.buttons+1]=t
end
t._registeredGroup=o
end
e.selected=t
for o=1,#e.buttons do
local e=e.buttons[o]
if e then
if e==t then
e:_applySelection(true,a)
else
e:_applySelection(false,a)
end
end
end
end
function s:setFocus(e)
if e~=nil then
t(1,e,"table")
if e.app~=self then
error("Cannot focus widget from a different PixelUI app",2)
end
if not e.focusable then
e=nil
end
end
if self._focusWidget==e then
return
end
if self._focusWidget then
local e=self._focusWidget
e:setFocused(false)
end
self._focusWidget=e
if e then
e:setFocused(true)
end
end
function s:getFocus()
return self._focusWidget
end
function s:render()
self.box.fill(self.background)
self.pixelLayer.clear()
self.layer.clear()
self.root:draw(self.layer,self.pixelLayer)
self:_drawPopups()
self.box.render()
end
function s:step(e,...)
if not e then
return
end
local t=false
if e=="timer"then
local o=...
if self._threadTicker and o==self._threadTicker then
self._threadTicker=nil
self:_serviceThreads()
t=true
end
local i=self._threadTimers
if i then
local e=i[o]
if e then
i[o]=nil
if e.status==a and e.timerId==o then
e.timerId=nil
e.waiting=nil
e._ready=true
e._resumeValue=true
end
t=true
end
end
if self._animationTimer and o==self._animationTimer then
self:_updateAnimations()
if self._animations and#self._animations>0 then
self._animationTimer=_.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or F.current()
local t,e=e.getSize()
if self.window.reposition then
self.window.reposition(1,1,t,e)
end
end
local t,e=self.window.getSize()
self.root:setSize(t,e)
end
if not t and(e=="char"or e=="paste"or e=="key"or e=="key_up")then
local a=self._focusWidget
if a and a.visible~=false then
t=a:handleEvent(e,...)
end
end
if not t then
t=self.root:handleEvent(e,...)
end
if not t and(e=="mouse_click"or e=="monitor_touch")then
self:setFocus(nil)
end
self:_serviceThreads()
self:render()
end
function s:run()
self.running=true
self:render()
while self.running do
local e={Z()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
self:_shutdownThreads()
end
function s:stop()
self.running=false
self:_clearAnimations(true)
self:_shutdownThreads()
end
w.widgets={
Frame=function(e,t)
return p:new(e,t)
end,
Window=function(t,e)
return r:new(t,e)
end,
Button=function(e,t)
return A:new(e,t)
end,
Label=function(t,e)
return j:new(t,e)
end,
CheckBox=function(e,t)
return q:new(e,t)
end,
Toggle=function(t,e)
return x:new(t,e)
end,
TextBox=function(t,e)
return o:new(t,e)
end,
ComboBox=function(e,t)
return g:new(e,t)
end,
List=function(e,t)
return c:new(e,t)
end,
Table=function(t,e)
return d:new(t,e)
end,
TreeView=function(e,t)
return u:new(e,t)
end,
Chart=function(e,t)
return m:new(e,t)
end,
RadioButton=function(e,t)
return b:new(e,t)
end,
ProgressBar=function(t,e)
return v:new(t,e)
end,
Slider=function(t,e)
return l:new(t,e)
end,
LoadingRing=function(t,e)
return f:new(t,e)
end,
FreeDraw=function(e,t)
return O:new(e,t)
end,
NotificationToast=function(e,t)
return n:new(e,t)
end
}
w.Widget=i
w.Frame=p
w.Window=r
w.Button=A
w.Label=j
w.CheckBox=q
w.Toggle=x
w.TextBox=o
w.ComboBox=g
w.List=c
w.Table=d
w.TreeView=u
w.Chart=m
w.RadioButton=b
w.ProgressBar=v
w.Slider=l
w.LoadingRing=f
w.FreeDraw=O
w.NotificationToast=n
w.easings=L
w.ThreadHandle=k
w.ThreadContext=E
w.threadStatus={
running=a,
completed=y,
error=z,
cancelled=h
}
return w
