local M=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local z=assert(rawget(_G,"os"),"os API unavailable")
local G=assert(z.pullEvent,"os.pullEvent unavailable")
local B=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local V=table.pack or function(...)
return{n=select("#",...),...}
end
local Y=assert(table.unpack,"table.unpack unavailable")
local t=require("cc.expect").expect
local P=require("shrekbox")
local f={
version="0.1.0"
}
local R={
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
local n={}
n.__index=n
local x={}
x.__index=x
setmetatable(x,{__index=n})
local T={}
T.__index=T
setmetatable(T,{__index=n})
local k={}
k.__index=k
setmetatable(k,{__index=n})
local g={}
g.__index=g
setmetatable(g,{__index=n})
local q={}
q.__index=q
setmetatable(q,{__index=n})
local w={}
w.__index=w
setmetatable(w,{__index=n})
local d={}
d.__index=d
setmetatable(d,{__index=n})
local p={}
p.__index=p
local _={}
_.__index=_
local u={}
u.__index=u
setmetatable(u,{__index=n})
local h={}
h.__index=h
setmetatable(h,{__index=n})
local l={}
l.__index=l
setmetatable(l,{__index=n})
local c={}
c.__index=c
setmetatable(c,{__index=n})
local y={}
y.__index=y
setmetatable(y,{__index=n})
local v={}
v.__index=v
setmetatable(v,{__index=n})
local i={}
i.__index=i
setmetatable(i,{__index=n})
local m={}
m.__index=m
setmetatable(m,{__index=n})
local A={}
A.__index=A
setmetatable(A,{__index=n})
local s={}
s.__index=s
local r={"top","right","bottom","left"}
local Q=string.char(7)
local D={
info={bg=e.blue,fg=e.white,accent=e.lightBlue,icon="i"},
success={bg=e.green,fg=e.black,accent=e.lime,icon="+"},
warning={bg=e.orange,fg=e.black,accent=e.yellow,icon="!"},
error={bg=e.red,fg=e.white,accent=e.white,icon="x"}
}
local function C(e)
if e==nil then
return"info"
end
local e=tostring(e):lower()
if D[e]then
return e
end
return"info"
end
local function U(e)
if e==nil then
return 1,1,1,1
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
return e,e,e,e
end
local i,o,n,s=1,1,1,1
if type(e)=="table"then
local t=e.horizontal or e.x
local a=e.vertical or e.y
if t~=nil then
t=math.max(0,math.floor(t))
i=t
o=t
end
if a~=nil then
a=math.max(0,math.floor(a))
n=a
s=a
end
if e.left~=nil then
i=math.max(0,math.floor(e.left))
end
if e.right~=nil then
o=math.max(0,math.floor(e.right))
end
if e.top~=nil then
n=math.max(0,math.floor(e.top))
end
if e.bottom~=nil then
s=math.max(0,math.floor(e.bottom))
end
end
return i,o,n,s
end
local function b(t,a,e)
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
local function F(e)
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
local function L(e)
local a,o,i,t=1,1,1,1
if e==nil then
return{top=a,right=o,bottom=i,left=t}
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
a,o,i,t=e,e,e,e
elseif type(e)=="table"then
if e.all~=nil then
local e=math.max(0,math.floor(e.all))
a,o,i,t=e,e,e,e
end
if e.vertical~=nil then
local e=math.max(0,math.floor(e.vertical))
a,i=e,e
end
if e.horizontal~=nil then
local e=math.max(0,math.floor(e.horizontal))
o,t=e,e
end
if e.top~=nil then
a=math.max(0,math.floor(e.top))
end
if e.right~=nil then
o=math.max(0,math.floor(e.right))
end
if e.bottom~=nil then
i=math.max(0,math.floor(e.bottom))
end
if e.left~=nil then
t=math.max(0,math.floor(e.left))
end
end
return{top=a,right=o,bottom=i,left=t}
end
local function K(t,o)
local e={}
if o<=0 then
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
local i=t:find("\n",a,true)
if not i then
b(t:sub(a),o,e)
break
end
b(t:sub(a,i-1),o,e)
a=i+1
end
if#e==0 then
e[1]=""
end
return e
end
local function o(t)
if not t then
return nil
end
local e={}
for a,t in pairs(t)do
e[a]=t
end
return e
end
local function E(a,e)
t(nil,a,"string")
t(nil,e,"number")
if e<1 or e~=math.floor(e)then
error(('%s must be a positive integer, got "%s"'):format(a,tostring(e)),3)
end
end
local function O(a)
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
for e=1,#r do
o(r[e],a[r[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local b="^(%a[%w_]*)%.([%a_][%w_]*)$"
local function r(e)
if type(e)~="string"then
return nil,nil
end
local e,t=e:match(b)
return e,t
end
local function j(e,t)
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
local function b(e,t)
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
local e,a=r(e)
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
local a,o=r(a)
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
local o=j(e.percent,t..".percent")
local a=e.of or("parent."..t)
local a,i=r(a)
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
return b(e.match,t)
end
if e.value~=nil then
return b(e.value,t)
end
error("constraints."..t.." table must include percent, reference/of, match, or value fields",3)
end
return nil
end
local function I(e,t)
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
local e,a=r(e)
if not e then
error("constraints.center"..(t=="x"and"X"or"Y").." string references must look like 'parent.<property>'",3)
end
if e~="parent"then
error("constraints.center"..(t=="x"and"X"or"Y").." currently only supports the parent",3)
end
return{kind="center",target=e,property=a,offset=0}
end
if a=="table"then
local o=e.reference or e.of or e.target or e.align
local a=e.offset and math.floor(e.offset)or 0
if o then
local e,o=r(o)
if not e then
error("constraints.center"..(t=="x"and"X"or"Y").." reference tables must use 'parent.<property>'",3)
end
if e~="parent"then
error("constraints.center"..(t=="x"and"X"or"Y").." currently only supports the parent",3)
end
return{kind="center",target=e,property=o,offset=a}
end
return{
kind="center",
target="parent",
property=t=="x"and"centerX"or"centerY",
offset=a
}
end
return nil
end
local function W(e)
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
t.width=b(e.width,"width")
end
if e.height~=nil then
t.height=b(e.height,"height")
end
if e.widthPercent~=nil then
t.widthPercent=j(e.widthPercent,"widthPercent")
end
if e.heightPercent~=nil then
t.heightPercent=j(e.heightPercent,"heightPercent")
end
if e.centerX~=nil then
t.centerX=I(e.centerX,"x")
end
if e.centerY~=nil then
t.centerY=I(e.centerY,"y")
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
local N=string.char(30)
local j=string.char(31)
local function I(o,n,i)
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
local o=a.trackColor or e.gray
local s=a.thumbColor or e.lightGray
local i=a.arrowColor or i or e.white
local n=a.background or n or e.black
local e=math.max(1,math.floor(a.width or 1))
local t=math.max(1,math.floor(a.minThumbSize or 1))
return{
enabled=true,
alwaysVisible=not not a.alwaysVisible,
width=e,
trackColor=o,
thumbColor=s,
arrowColor=i,
background=n,
minThumbSize=t
}
end
local function b(e)
if e<0 then
return 0
end
if e>1 then
return 1
end
return e
end
local function H(t,o,e,a)
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
local function S(s,n,a,t,d,r,m,e)
if not e or t<=0 then
return
end
local h=math.max(1,math.floor(e.width or 1))
local o=e.trackColor
local i=e.arrowColor
local l=e.thumbColor
local c=math.max(1,math.floor(e.minThumbSize or 1))
local e=math.max(0,h-1)
local u=N..string.rep(" ",e)
s.text(n,a,u,i,o)
if t>=2 then
local e=j..string.rep(" ",e)
s.text(n,a+t-1,e,i,o)
end
local a=a+1
local t=math.max(0,t-2)
local i=string.rep(" ",h)
for e=0,t-1 do
s.text(n,a+e,i,o,o)
end
local i=math.max(0,(d or 0)-(r or 0))
if i<=0 or t<=0 then
return
end
local u=math.max(0,math.min(i,math.floor((m or 0)+.5)))
local e=r/d
local e=math.max(c,math.floor(t*e+.5))
if e>t then
e=t
end
if e<1 then
e=1
end
local o=t-e
local t=a
if o>0 then
local e=b(i==0 and 0 or(u/i))
t=a+math.floor(e*o+.5)
if t>a+o then
t=a+o
end
end
local a=string.rep(" ",h)
for e=0,e-1 do
s.text(n,t+e,a,l,l)
end
end
local function N(o,a,i,e,t)
if a<=0 then
return t or 0
end
local e=math.max(0,(i or 0)-(e or 0))
if e<=0 then
return 0
end
local t=math.max(0,math.min(e,math.floor((t or 0)+.5)))
if o<=0 then
return math.max(0,t-1)
elseif o>=a-1 then
return math.min(e,t+1)
end
local a=a-2
if a<=0 then
return t
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
local function r(a,o,n,t,e,i,s,h)
if t<=0 or e<=0 then
return
end
local h=h or" "
local t=h:rep(t)
for e=0,e-1 do
a.text(o,n+e,t,i,s)
end
end
local function j(e,i,n,a,t)
if a<=0 or t<=0 then
return
end
local o=P.transparent
for a=0,a-1 do
e.pixel(i+a,n,o)
if t>1 then
e.pixel(i+a,n+t-1,o)
end
end
for t=1,math.max(0,t-2)do
e.pixel(i,n+t,o)
if a>1 then
e.pixel(i+a-1,n+t,o)
end
end
end
local function b(h,a,t,o,i,e,s)
if o<=0 or i<=0 then
return
end
local n=e.color
local r=s or n
local a=(a-1)*2+1
local t=(t-1)*3+1
local o=o*2
local i=i*3
local l=3
local u=2
local d=math.min(e.thickness,i)
local s=math.min(e.thickness,o)
local l=math.min(i,math.max(d,l))
local u=math.min(o,math.max(s,u))
local function w(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
h.pixel(a+t,e,n)
end
end
end
local function m(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
h.pixel(a+t,e,n)
end
end
end
local function f(e,n,s)
for n=0,n-1 do
local e=e+n
if e<a or e>=a+o then break end
for a=0,i-1 do
h.pixel(e,t+a,s)
end
end
end
local function c(e,s,n)
for s=0,s-1 do
local e=e+s
if e<a or e>=a+o then break end
for a=0,i-1 do
h.pixel(e,t+a,n)
end
end
end
if e.left then
f(a,u,r)
end
if e.right then
f(a+o-u,u,r)
end
if e.top then
w(t,l,r)
end
if e.bottom then
w(t+i-l,l,r)
end
if e.top then
m(t,d,n)
end
if e.bottom then
m(t+i-d,d,n)
end
if e.left then
c(a,s,n)
end
if e.right then
c(a+o-s,s,n)
end
end
function i:new(n,a)
a=a or{}
t(1,n,"table")
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
local e=setmetatable({},i)
e:_init_base(n,t)
e.focusable=false
local i=a.anchor~=nil
local t=F(a.anchor)
if not t and not i then
if a.x~=nil or a.y~=nil then
t=nil
else
t="top_right"
end
end
e.anchor=t
e.anchorMargins=L(a.anchorMargin)
e.anchorAnimationDuration=math.max(.05,tonumber(a.anchorAnimationDuration)or .2)
e.anchorEasing=a.anchorEasing or"easeOutCubic"
e._anchorDirty=true
e._anchorAnimationHandle=nil
e.title=a.title~=nil and tostring(a.title)or nil
e.message=a.message~=nil and tostring(a.message)or""
e.icon=a.icon~=nil and tostring(a.icon)or nil
e.severity=C(a.severity)
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
e.paddingLeft,e.paddingRight,e.paddingTop,e.paddingBottom=U(a.padding)
e._hideTimer=nil
e._wrappedLines={""}
e._lastWrapWidth=nil
e._lastMessage=nil
e:_refreshWrap(true)
return e
end
function i:_applyPadding(e,i)
local e,a,t,o=U(e)
if i or e~=self.paddingLeft or a~=self.paddingRight or t~=self.paddingTop or o~=self.paddingBottom then
self.paddingLeft=e
self.paddingRight=a
self.paddingTop=t
self.paddingBottom=o
self:_refreshWrap(true)
self._anchorDirty=true
end
end
function i:setPadding(e)
self:_applyPadding(e,false)
end
function i:getAnchor()
return self.anchor
end
function i:getAnchorMargins()
return o(self.anchorMargins)
end
function i:refreshAnchor(e)
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
function i:setAnchor(t)
local e=F(t)
if e==nil and t~=nil then
self.anchor=nil
else
self.anchor=e
end
self:refreshAnchor(false)
end
function i:setAnchorMargin(e)
self.anchorMargins=L(e)
self:refreshAnchor(false)
end
function i:_computeAnchorPosition()
local o=self.anchor
if not o then
return nil,nil
end
local e=self.parent
if not e then
return nil,nil
end
local i=e.width
local n=e.height
if type(i)~="number"or type(n)~="number"then
return nil,nil
end
local s=self.width
local h=self.height
local a=self.anchorMargins or L(nil)
local t
local e
if o=="top_right"then
t=i-s-(a.right or 0)+1
e=(a.top or 0)+1
elseif o=="top_left"then
t=(a.left or 0)+1
e=(a.top or 0)+1
elseif o=="bottom_right"then
t=i-s-(a.right or 0)+1
e=n-h-(a.bottom or 0)+1
elseif o=="bottom_left"then
t=(a.left or 0)+1
e=n-h-(a.bottom or 0)+1
else
return nil,nil
end
if t<1 then
t=1
end
if e<1 then
e=1
end
if t+s-1>i then
t=math.max(1,i-s+1)
end
if e+h-1>n then
e=math.max(1,n-h+1)
end
return t,e
end
function i:getAnchorTargetPosition()
return self:_computeAnchorPosition()
end
function i:_applyAnchorPosition(a)
if not self.anchor then
self._anchorDirty=false
return
end
local e,t=self:_computeAnchorPosition()
if not e or not t then
return
end
if self._anchorAnimationHandle then
self._anchorAnimationHandle:cancel()
self._anchorAnimationHandle=nil
end
if a and self.app and self.app.animate then
local i=math.max(2,math.floor(self.width/6))
local s=math.max(1,math.floor(self.height/3))
local o=e
local a=t
if self.anchor=="top_right"then
o=e+i
a=math.max(1,t-s)
elseif self.anchor=="top_left"then
o=e-i
a=math.max(1,t-s)
elseif self.anchor=="bottom_right"then
o=e+i
a=t+s
elseif self.anchor=="bottom_left"then
o=e-i
a=t+s
end
n.setPosition(self,o,a)
local i=self.anchorAnimationDuration or .2
local s=self.anchorEasing or"easeOutCubic"
local o=o
local a=a
local h=e-o
local r=t-a
self._anchorAnimationHandle=self.app:animate({
duration=i,
easing=s,
update=function(e)
local t=math.floor(o+h*e+.5)
local e=math.floor(a+r*e+.5)
n.setPosition(self,t,e)
end,
onComplete=function()
n.setPosition(self,e,t)
self._anchorAnimationHandle=nil
end,
onCancel=function()
n.setPosition(self,e,t)
self._anchorAnimationHandle=nil
end
})
self._anchorDirty=false
return
end
if self.x~=e or self.y~=t then
n.setPosition(self,e,t)
end
self._anchorDirty=false
end
function i:_getActiveBorder()
if self.border then
return self.border
end
return nil
end
function i:_refreshWrap(o,t)
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
self._wrappedLines=K(self.message,e)
self._lastWrapWidth=e
self._lastMessage=self.message
end
function i:_getStyle()
local a=self.severity
local e=D.info
if a~=nil then
local t=D[a]
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
for a,e in pairs(a)do
t[a]=e
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
function i:_cancelTimer()
if self._hideTimer then
if z.cancelTimer then
pcall(z.cancelTimer,self._hideTimer)
end
self._hideTimer=nil
end
end
function i:_scheduleHide(e)
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
self._hideTimer=z.startTimer(e)
end
function i:setTitle(e)
if e==nil then
self.title=nil
else
self.title=tostring(e)
end
end
function i:getTitle()
return self.title
end
function i:setMessage(e)
if e==nil then
e=""
end
local e=tostring(e)
if self.message~=e then
self.message=e
self:_refreshWrap(true)
end
end
function i:getMessage()
return self.message
end
function i:setSeverity(e)
local e=C(e)
if self.severity~=e then
self.severity=e
end
end
function i:getSeverity()
return self.severity
end
function i:setIcon(e)
if e==nil or e==""then
self.icon=nil
return
end
self.icon=tostring(e)
end
function i:getIcon()
return self.icon
end
function i:setAutoHide(e)
e=not not e
if self.autoHide~=e then
self.autoHide=e
if not e then
self:_cancelTimer()
end
end
end
function i:isAutoHide()
return self.autoHide
end
function i:setDuration(e)
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
function i:getDuration()
return self.duration
end
function i:setDismissOnClick(e)
self.dismissOnClick=not not e
end
function i:isDismissOnClick()
return self.dismissOnClick
end
function i:setOnDismiss(e)
if e~=nil and type(e)~="function"then
error("onDismiss handler must be a function",2)
end
self.onDismiss=e
end
function i:setVariants(e)
if e~=nil and type(e)~="table"then
error("variants must be a table",2)
end
self.variantOverrides=e and o(e)or nil
end
function i:setStyle(e)
if e~=nil and type(e)~="table"then
error("style must be a table",2)
end
self.styleOverride=e and o(e)or nil
end
function i:present(e)
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
function i:show(t)
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
function i:hide(e)
local t=self.visible
self.visible=false
self:_cancelTimer()
if self._anchorAnimationHandle then
self._anchorAnimationHandle:cancel()
self._anchorAnimationHandle=nil
end
if e~=false and t and self.onDismiss then
self.onDismiss(self)
end
end
function i:setSize(e,t)
n.setSize(self,e,t)
self:_refreshWrap(true)
self._anchorDirty=true
if self.anchor then
self:_applyAnchorPosition(false)
end
end
function i:setBorder(e)
n.setBorder(self,e)
self:_refreshWrap(true)
self._anchorDirty=true
end
function i:_renderLine(s,n,i,t,e,o,a)
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
s.text(n,i,e,o,a)
end
function i:draw(n,c)
if not self.visible then
return
end
if self._anchorDirty and not self._anchorAnimationHandle then
self:_applyAnchorPosition(false)
end
local s,h,o,a=self:getAbsoluteRect()
if o<=0 or a<=0 then
return
end
local i=self:_getStyle()or D.info
local t=i.bg or self.bg or e.gray
local d=i.fg or self.fg or e.white
local l=i.accent or d
local m=i.titleColor or d
local u=i.iconColor or l
r(n,s,h,o,a,t,t)
j(n,s,h,o,a)
local e=self.border
if e then
b(c,s,h,o,a,e,t)
else
b(c,s,h,o,a,{
color=l,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
},t)
end
local e=e
local r=(e and e.left)and e.thickness or 0
local c=(e and e.right)and e.thickness or 0
local l=(e and e.top)and e.thickness or 0
local e=(e and e.bottom)and e.thickness or 0
local s=s+r
local h=h+l
local o=math.max(0,o-r-c)
local a=math.max(0,a-l-e)
local s=s+(self.paddingLeft or 0)
local e=h+(self.paddingTop or 0)
local h=math.max(0,o-(self.paddingLeft or 0)-(self.paddingRight or 0))
local o=math.max(0,a-(self.paddingTop or 0)-(self.paddingBottom or 0))
if h<=0 or o<=0 then
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
n.text(s,e,a,u,t)
if h>=3 then
n.text(s+1,e," ",u,t)
i=2
else
i=1
end
r=s+i
end
local a=math.max(0,h-i)
self:_refreshWrap(false,a)
if self.title and self.title~=""and o>0 and a>0 then
self:_renderLine(n,r,e,a,self.title,m,t)
e=e+1
o=o-1
end
if o>0 and a>0 then
local i=self._wrappedLines or{""}
local o=math.min(o,#i)
for o=1,o do
self:_renderLine(n,r,e,a,i[o],d,t)
e=e+1
end
end
end
function i:handleEvent(e,...)
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
local a,e,t=...
if self.dismissOnClick and self:containsPoint(e,t)then
self:hide(true)
return true
end
end
return false
end
function i:onFocusChanged()
end
function m:new(n,a)
a=a or{}
t(1,n,"table")
if a~=nil then
t(2,a,"table")
end
local i=o(a)or{}
i.focusable=false
i.width=math.max(3,math.floor(i.width or 8))
i.height=math.max(3,math.floor(i.height or 5))
local t=setmetatable({},m)
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
function m:_cancelTick()
if self._tickTimer then
if z.cancelTimer then
pcall(z.cancelTimer,self._tickTimer)
end
self._tickTimer=nil
end
end
function m:_scheduleTick()
self:_cancelTick()
if self._paused then
return
end
if not self.speed or self.speed<=0 then
return
end
self._tickTimer=z.startTimer(self.speed)
end
function m:start()
if not self._paused then
return
end
self._paused=false
self:_scheduleTick()
end
function m:stop()
if self._paused then
return
end
self._paused=true
self:_cancelTick()
end
function m:setSpeed(e)
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
function m:setDirection(e)
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
function m:setSegments(e)
if e==nil then
return
end
local e=math.max(3,math.floor(e))
if e~=self.segmentCount then
self.segmentCount=e
self._phase=self._phase%e
end
end
function m:setThickness(e)
if e==nil then
return
end
local e=math.max(1,math.floor(e))
self.thickness=e
end
function m:setRadius(e)
if e==nil then
self.radiusPixels=nil
return
end
local e=math.max(2,math.floor(e))
self.radiusPixels=e
end
function m:setColor(e)
if e==nil then
return
end
t(1,e,"number")
self.color=e
end
function m:setSecondaryColor(e)
if e==nil then
self.secondaryColor=nil
return
end
t(1,e,"number")
self.secondaryColor=e
end
function m:setTertiaryColor(e)
if e==nil then
self.tertiaryColor=nil
return
end
t(1,e,"number")
self.tertiaryColor=e
end
function m:setTrailColor(e)
if e==nil then
self.trailColor=nil
return
end
t(1,e,"number")
self.trailColor=e
end
function m:setTrailPalette(e)
if e~=nil then
t(1,e,"table")
end
self.trailPalette=e and o(e)or nil
end
function m:setFadeSteps(e)
if e==nil then
return
end
local e=math.max(0,math.floor(e))
self.fadeSteps=e
end
function m:_computeTrailColors()
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
function m:draw(n,d)
if not self.visible then
return
end
local i,o,a,t=self:getAbsoluteRect()
if a<=0 or t<=0 then
return
end
local e=self.bg or self.app.background
r(n,i,o,a,t,e,e)
j(n,i,o,a,t)
if self.border then
b(d,i,o,a,t,self.border,e)
end
local l=(self.border and self.border.left)and 1 or 0
local u=(self.border and self.border.right)and 1 or 0
local h=(self.border and self.border.top)and 1 or 0
local c=(self.border and self.border.bottom)and 1 or 0
local s=i+l
local i=o+h
local o=math.max(0,a-l-u)
local a=math.max(0,t-h-c)
if o<=0 or a<=0 then
return
end
r(n,s,i,o,a,e,e)
local w=s+(o-1)/2
local l=i+(a-1)/2
local n=math.floor(math.min(o,a)/2)
local t=self.radiusPixels and math.floor(self.radiusPixels)or n
if t>n then
t=n
end
if t<1 then
t=1
end
local h=math.max(1,math.min(math.floor(self.thickness or 1),t))
local n=t+.35
local t=math.max(0,t-h+.35)
local u=n*n
local c=t*t
local t=math.max(3,math.floor(self.segmentCount or 12))
local n=self._phase%t
local f=self.direction>=0 and 1 or-1
local h=math.pi*2
local m=self:_computeTrailColors()
for a=0,a-1 do
local r=i+a
local i=r-l
for a=0,o-1 do
local l=s+a
local a=l-w
local s=a*a+i*i
local o=e
if s<=u and s>=c then
local a=math.atan(i,a)
if a<0 then
a=a+h
end
local i=math.floor(a/h*t)%t
local a
if f>=0 then
a=(n-i)%t
else
a=(i-n)%t
end
if a==0 then
o=self.color or e
else
local t=math.floor(a+1e-4)
if t<1 then
t=1
end
o=m[t]or e
end
end
d.pixel(l,r,o)
end
end
end
function m:handleEvent(a,...)
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
return n.handleEvent(self,a,...)
end
local function L(e)
local t,a=e.x,e.y
local e=e.parent
while e do
t=t+e.x-1
a=a+e.y-1
e=e.parent
end
return t,a
end
function n:_init_base(o,a)
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
self.border=O(a.border)
self.focusable=a.focusable==true
self._focused=false
self.constraints=nil
E("width",self.width)
E("height",self.height)
if a.constraints~=nil then
self.constraints=W(a.constraints)
local t,e=self:_applySizeConstraints(self.width,self.height)
self.width=t
self.height=e
end
end
function n:setSize(e,t)
E("width",e)
E("height",t)
local e,t=self:_applySizeConstraints(e,t)
self.width=e
self.height=t
end
function n:_applyConstraintLayout()
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
local n=e and e.width or nil
local i=e and e.height or nil
if not a and t.widthPercent and n then
a=math.max(1,math.floor(n*t.widthPercent+.5))
end
if not o and t.heightPercent and i then
o=math.max(1,math.floor(i*t.heightPercent+.5))
end
local a=a or self.width
local o=o or self.height
local a,o=self:_applySizeConstraints(a,o)
if a~=self.width or o~=self.height then
self:setSize(a,o)
end
n=e and e.width or nil
i=e and e.height or nil
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
local a=self.x
local e=self.y
local o=h(t.centerX,"x",n,self.width,o)
if o then
a=o
end
local t=h(t.centerY,"y",i,self.height,s)
if t then
e=t
end
if a~=self.x or e~=self.y then
self:setPosition(a,e)
end
end
function n:_applySizeConstraints(t,e)
local t=math.floor(t)
local a=math.floor(e)
if t<1 then
t=1
end
if a<1 then
a=1
end
local e=self.constraints
if e then
if e.minWidth and t<e.minWidth then
t=e.minWidth
end
if e.maxWidth and t>e.maxWidth then
t=e.maxWidth
end
if e.minHeight and a<e.minHeight then
a=e.minHeight
end
if e.maxHeight and a>e.maxHeight then
a=e.maxHeight
end
end
return t,a
end
function n:setConstraints(e)
if e==nil or e==false then
self.constraints=nil
else
self.constraints=W(e)
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
local function E(e)
if not e then
return nil
end
local t=string.format("%s.%s",e.target or"parent",e.property or"center")
if e.offset and e.offset~=0 then
return{reference=t,offset=e.offset}
end
return t
end
function n:getConstraints()
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
local a=E(e.centerX)
if a~=nil then
t.centerX=a
end
local a=E(e.centerY)
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
function n:setPosition(e,a)
t(1,e,"number")
t(2,a,"number")
self.x=math.floor(e)
self.y=math.floor(a)
end
function n:setZ(e)
t(1,e,"number")
self.z=e
end
function n:setBorder(e)
if e==nil then
self.border=nil
return
end
if e==false then
self.border=nil
return
end
if e==true then
self.border=O(true)
return
end
t(1,e,"table","boolean")
self.border=O(e)
end
function n:isFocused()
return self._focused
end
function n:setFocused(e)
e=not not e
if self._focused==e then
return
end
self._focused=e
self:onFocusChanged(e)
end
function n:onFocusChanged(e)
end
function n:getAbsoluteRect()
local t,e=L(self)
return t,e,self.width,self.height
end
function n:containsPoint(e,t)
local a,o,n,i=self:getAbsoluteRect()
return e>=a and e<a+n and t>=o and t<o+i
end
function n:draw(e,e)
error("draw needs implementation for widget",2)
end
function n:handleEvent(e,...)
return false
end
function x:new(a,t)
local e=setmetatable({},x)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function x:addChild(e)
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
function x:_applyConstraintsToChildren()
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
function x:setSize(t,e)
n.setSize(self,t,e)
self:_applyConstraintsToChildren()
end
function x:removeChild(e)
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
local function E(t)
local a={}
for e=1,#t do
a[e]=t[e]
end
return a
end
local function D(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function x:getChildren()
return E(self._children)
end
function x:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function x:draw(n,l)
if not self.visible then
return
end
local s,i,o,a=self:getAbsoluteRect()
local t=self.bg or self.app.background
local d,u=s+1,i+1
local e=math.max(0,o-2)
local h=math.max(0,a-2)
if e>0 and h>0 then
r(n,d,u,e,h,t,t)
elseif o>0 and a>0 then
r(n,s,i,o,a,t,t)
end
j(n,s,i,o,a)
local h=self.title
if type(h)=="string"and#h>0 then
local o=e>0 and e or o
local s=e>0 and d or s
local a=(a>2)and(i+1)or i
if o>0 then
local e=h
if#e>o then
e=e:sub(1,o)
end
if#e<o then
e=e..string.rep(" ",o-#e)
end
n.text(s,a,e,self.fg,t)
end
end
if self.border then
b(l,s,i,o,a,self.border,t)
end
local e=E(self._children)
D(e)
for t=1,#e do
e[t]:draw(n,l)
end
end
function x:handleEvent(t,...)
if not self.visible then
return false
end
if n.handleEvent(self,t,...)then
return true
end
local e=E(self._children)
D(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function T:new(a,e)
local t=setmetatable({},T)
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
function T:setLabel(e)
t(1,e,"string")
self.label=e
end
function T:setOnClick(e)
if e~=nil then
t(1,e,"function")
end
self.onClick=e
end
function T:draw(s,c)
if not self.visible then
return
end
local n,o,a,t=self:getAbsoluteRect()
local i=self.bg or e.gray
local h=self.fg or e.white
local e=i
local d=h
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=n+1,o+1
local i=math.max(0,a-2)
local h=math.max(0,t-2)
if i>0 and h>0 then
r(s,l,u,i,h,e,e)
else
r(s,n,o,a,t,e,e)
end
j(s,n,o,a,t)
if self.border then
b(c,n,o,a,t,self.border,e)
end
local t=self.label or""
local a=i>0 and i or a
if#t>a then
t=t:sub(1,a)
end
local r=0
if a>#t then
r=math.floor((a-#t)/2)
end
local t=string.rep(" ",r)..t
if#t<a then
t=t..string.rep(" ",a-#t)
end
local i=i>0 and l or n
local a
if h>0 then
a=u+math.floor((h-1)/2)
else
a=o
end
s.text(i,a,t,d,e)
end
function T:handleEvent(e,...)
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
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(nil)
if self.onPress then
self.onPress(self,1,t,e)
end
if self.onRelease then
self.onRelease(self,1,t,e)
end
if self.onClick then
self.onClick(self,1,t,e)
end
return true
end
end
return false
end
function k:new(i,e)
e=e or{}
local a=o(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},k)
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
function k:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-a-t)
local n=math.max(0,self.height-o-e)
return a,t,o,e,i,n
end
function k:_wrapLine(e,a,t)
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
function k:_updateLines(e)
local t=tostring(self.text or"")
local i=not not self.wrap
local a,a,a,a,o=self:_getInnerMetrics()
if not e and self._lastText==t and self._lastWrap==i and self._lastInnerWidth==o then
return
end
local e={}
if t==""then
e[1]=""
else
local a=1
while true do
local n=t:find("\n",a,true)
if not n then
local t=t:sub(a)
t=t:gsub("\r","")
if i then
self:_wrapLine(t,o,e)
else
e[#e+1]=t
end
break
end
local t=t:sub(a,n-1)
t=t:gsub("\r","")
if i then
self:_wrapLine(t,o,e)
else
e[#e+1]=t
end
a=n+1
end
end
if#e==0 then
e[1]=""
end
self._lines=e
self._lastText=t
self._lastWrap=i
self._lastInnerWidth=o
end
function k:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function k:getText()
return self.text
end
function k:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function k:isWrapping()
return self.wrap
end
function k:setHorizontalAlign(a)
if a==nil then
a="left"
else
t(1,a,"string")
end
local e=a:lower()
if e~="left"and e~="center"and e~="right"then
error("Invalid horizontal alignment '"..a.."'",2)
end
if self.align~=e then
self.align=e
end
end
function k:setVerticalAlign(a)
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
function k:setSize(t,e)
n.setSize(self,t,e)
self:_updateLines(true)
end
function k:setBorder(e)
n.setBorder(self,e)
self:_updateLines(true)
end
function k:draw(u,m)
if not self.visible then
return
end
local s,h,d,l=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
local f=self.fg or e.white
r(u,s,h,d,l,n,n)
j(u,s,h,d,l)
local a,o,e,o,t,i=self:_getInnerMetrics()
local a=s+a
local c=h+e
self:_updateLines(false)
local r=self._lines or{""}
local o=#r
if o==0 then
r={""}
o=1
end
if t>0 and i>0 then
local e=math.min(o,i)
local s=1
if o>e then
if self.verticalAlign=="bottom"then
s=o-e+1
elseif self.verticalAlign=="middle"then
s=math.floor((o-e)/2)+1
end
end
local o=0
if i>e then
if self.verticalAlign=="bottom"then
o=i-e
elseif self.verticalAlign=="middle"then
o=math.floor((i-e)/2)
end
end
local i=c+o
for e=0,e-1 do
local e=r[s+e]or""
if#e>t then
e=e:sub(1,t)
end
local o=a
if self.align=="center"then
o=a+math.floor((t-#e)/2)
elseif self.align=="right"then
o=a+t-#e
end
if o<a then
o=a
end
if o+#e>a+t then
o=a+t-#e
end
if#e>0 then
u.text(o,i,e,f,n)
end
i=i+1
end
end
if self.border then
b(m,s,h,d,l,self.border,n)
end
end
function g:new(n,t)
t=t or{}
local o=o(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},g)
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
function g:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function g:_setState(t,e,a)
t=not not t
e=not not e
if e then
t=false
end
if not self.allowIndeterminate then
e=false
end
local o=(self.checked~=t)or(self.indeterminate~=e)
if not o then
return false
end
self.checked=t
self.indeterminate=e
if not a then
self:_notifyChange()
end
return true
end
function g:setLabel(e)
t(1,e,"string")
self.label=e
end
function g:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function g:setAllowIndeterminate(e)
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
function g:setChecked(e)
t(1,e,"boolean")
self:_setState(e,false,false)
end
function g:isChecked()
return self.checked
end
function g:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
t(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function g:isIndeterminate()
return self.indeterminate
end
function g:toggle()
self:_activate()
end
function g:_activate()
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
function g:draw(h,l)
if not self.visible then
return
end
local n,s,t,i=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local o=a
local d=e
if self:isFocused()then
o=self.focusBg or o
d=self.focusFg or d
end
r(h,n,s,t,i,o,o)
j(h,n,s,t,i)
if self.border then
b(l,n,s,t,i,self.border,o)
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
local e="["..e.."]"
local a={}
a[#a+1]=e
local e=#e
if t>e then
a[#a+1]=" "
e=e+1
end
if t>e then
local o=self.label or""
local t=t-e
if#o>t then
o=o:sub(1,t)
end
a[#a+1]=o
e=e+#o
end
local e=table.concat(a)
if#e<t then
e=e..string.rep(" ",t-#e)
elseif#e>t then
e=e:sub(1,t)
end
local t=s+math.floor((i-1)/2)
h.text(n,t,e,d,o)
end
function g:handleEvent(e,...)
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
function q:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},q)
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
function q:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function q:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function q:setValue(e,t)
e=not not e
if self.value==e then
return
end
self.value=e
if not t then
self:_emitChange()
end
end
function q:isOn()
return self.value
end
function q:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function q:setLabels(e,a)
if e~=nil then
t(1,e,"string")
self.labelOn=e
end
if a~=nil then
t(2,a,"string")
self.labelOff=a
end
end
function q:setShowLabel(e)
self.showLabel=not not e
end
function q:setDisabled(e)
e=not not e
if self.disabled==e then
return
end
self.disabled=e
end
function q:isDisabled()
return self.disabled
end
function q:setColors(e,o,i,a,n)
if e~=nil then
t(1,e,"number")
self.trackColorOn=e
end
if o~=nil then
t(2,o,"number")
self.trackColorOff=o
end
if i~=nil then
t(3,i,"number")
self.thumbColor=i
end
if a~=nil then
t(4,a,"number")
self.onLabelColor=a
end
if n~=nil then
t(5,n,"number")
self.offLabelColor=n
end
end
function q:draw(d,s)
if not self.visible then
return
end
local a,n,i,o=self:getAbsoluteRect()
local t=self.bg or e.black
local u=self.fg or e.white
r(d,a,n,i,o,t,t)
j(d,a,n,i,o)
if self.border then
b(s,a,n,i,o,self.border,t)
end
local t=self.border
local h=(t and t.left)and t.thickness or 0
local c=(t and t.right)and t.thickness or 0
local l=(t and t.top)and t.thickness or 0
local t=(t and t.bottom)and t.thickness or 0
local m=a+h
local n=n+l
local a=math.max(0,i-h-c)
local o=math.max(0,o-l-t)
if a<=0 or o<=0 then
return
end
local t=m
local n=n
local a=a
local i=o
local h=self.trackColorOff or e.gray
local o=self.trackColorOn or e.lightBlue
local c=self.value and o or h
r(d,t,n,a,i,c,c)
local o=math.max(1,math.floor(a/2))
if a>=4 then
o=math.max(2,o)
end
if o>a then
o=a
end
local h
if self.value then
h=t+a-o
else
h=t
end
if h<t then
h=t
end
if h+o>t+a then
h=t+a-o
end
local l=self.thumbColor or e.white
if self:isFocused()then
l=self.focusBg or l
end
r(d,h,n,o,i,l,l)
local o=""
if self.showLabel then
if self.value then
o=self.labelOn or"On"
else
o=self.labelOff or"Off"
end
end
if o~=""and i>0 then
local e=math.max(0,a-2)
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
local e=t+math.floor((a-#o)/2)
if e<t then
e=t
end
if e+#o-1>t+a-1 then
e=t+a-#o
end
if#o>0 then
d.text(e,i,o,s,c)
end
end
if self:isFocused()then
local e=self.focusFg or e.white
if a>1 then
for a=0,a-1 do
s.pixel(t+a,n,e)
if i>1 then
s.pixel(t+a,n+i-1,e)
end
end
end
if i>1 then
for o=0,i-1 do
s.pixel(t,n+o,e)
if a>1 then
s.pixel(t+a-1,n+o,e)
end
end
end
end
if self.disabled then
for a=0,a-1,2 do
local t=t+a
s.pixel(t,n,e.gray)
if i>1 then
s.pixel(t,n+i-1,e.gray)
end
end
end
end
function q:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"or e=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
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
function y:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},y)
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
t._dotChar=Q
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
function y:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function y:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function y:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function y:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function y:setLabel(e)
t(1,e,"string")
self.label=e
end
function y:setValue(e)
self.value=e
end
function y:getValue()
return self.value
end
function y:setGroup(e)
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
function y:getGroup()
return self.group
end
function y:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function y:setSelected(e)
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
function y:isSelected()
return self.selected
end
function y:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function y:draw(h,d)
if not self.visible then
return
end
local i,n,t,o=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local s=e
if self:isFocused()then
a=self.focusBg or a
s=self.focusFg or s
end
r(h,i,n,t,o,a,a)
j(h,i,n,t,o)
if self.border then
b(d,i,n,t,o,self.border,a)
end
local n=n+math.floor((o-1)/2)
local e=self.selected and(self._dotChar or"*")or" "
local e="("..e..")"
local o=self.label or""
local e=e
if#o>0 then
e=e.." "..o
end
if#e>t then
e=e:sub(1,t)
elseif#e<t then
e=e..string.rep(" ",t-#e)
end
if t>0 then
h.text(i,n,e,s,a)
end
end
function y:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,t,e=...
if self:containsPoint(t,e)then
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
function w:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},w)
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
t.border=O(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
end
return t
end
function w:_clampValue(e)
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
function w:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function w:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=R.linear,
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
function w:setRange(a,e)
t(1,a,"number")
t(2,e,"number")
if e<=a then
error("ProgressBar max must be greater than min",2)
end
self.min=a
self.max=e
self.value=self:_clampValue(self.value)
end
function w:getRange()
return self.min,self.max
end
function w:setValue(e)
if self.indeterminate then
return
end
t(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function w:getValue()
return self.value
end
function w:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function w:setIndeterminate(e)
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
function w:isIndeterminate()
return self.indeterminate
end
function w:setLabel(e)
if e~=nil then
t(1,e,"string")
end
self.label=e
end
function w:setShowPercent(e)
self.showPercent=not not e
end
function w:setColors(o,a,e)
if o~=nil then
t(1,o,"number")
self.trackColor=o
end
if a~=nil then
t(2,a,"number")
self.fillColor=a
end
if e~=nil then
t(3,e,"number")
self.textColor=e
end
end
function w:draw(h,d)
if not self.visible then
return
end
local a,i,t,o=self:getAbsoluteRect()
local s=self.trackColor or(self.bg or e.gray)
local n=self.fillColor or e.lightBlue
local c=self.textColor or(self.fg or e.white)
r(h,a,i,t,o,s,s)
j(h,a,i,t,o)
if self.border then
b(d,a,i,t,o,self.border,s)
end
local e=self.border
local u=(e and e.left)and 1 or 0
local m=(e and e.right)and 1 or 0
local l=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+u
local d=i+l
local t=math.max(0,t-u-m)
local i=math.max(0,o-l-e)
if t<=0 or i<=0 then
return
end
r(h,a,d,t,i,s,s)
local l=0
local u=0
local o=0
if self.indeterminate then
o=math.max(1,math.floor(t/3))
if o>t then
o=t
end
local t=t-o
local e=self._indeterminateProgress or 0
if e<0 then e=0 end
if e>1 then e=1 end
u=math.floor(t*e+.5)
r(h,a+u,d,o,i,n,n)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
r(h,a,d,l,i,n,n)
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
if e~=""and i>0 then
if#e>t then
e=e:sub(1,t)
end
local r=d+math.floor((i-1)/2)
local i=a+math.floor((t-#e)/2)
if i<a then
i=a
end
for t=1,#e do
local d=e:sub(t,t)
local a=(i-a)+(t-1)
local e=s
if self.indeterminate then
if a>=u and a<u+o then
e=n
end
else
if a<l then
e=n
end
end
h.text(i+t-1,r,d,c,e)
end
end
end
function w:handleEvent(e,...)
return false
end
function A:new(i,t)
t=t or{}
local e=o(t)or{}
e.focusable=false
e.width=math.max(1,math.floor(e.width or 10))
e.height=math.max(1,math.floor(e.height or 4))
local a=setmetatable({},A)
a:_init_base(i,e)
a.onDraw=t.onDraw
a.clear=t.clear~=false
return a
end
function A:setOnDraw(e)
if e~=nil and type(e)~="function"then
error("FreeDraw:setOnDraw expects a function or nil",2)
end
self.onDraw=e
end
function A:setClear(e)
self.clear=not not e
end
function A:draw(h,d)
if not self.visible then
return
end
local s,n,a,o=self:getAbsoluteRect()
if a<=0 or o<=0 then
return
end
if self.clear then
local e=self.bg or self.app.background or e.black
r(h,s,n,a,o,e,e)
end
if self.onDraw then
local t=self._ctx or{}
t.app=self.app
t.box=self.app.box
t.textLayer=h
t.pixelLayer=d
t.x=s
t.y=n
t.width=a
t.height=o
local l=self.bg or self.app.background or e.black
local u=self.fg or e.white
t.fill=function(e)
local e=e or l
r(h,s,n,a,o,e,e)
end
t.write=function(i,r,e,c,d)
local i=math.floor(i or 1)
local r=math.floor(r or 1)
if type(e)~="string"then
e=tostring(e or"")
end
if r<1 or r>o then
return
end
if i>a then
return
end
local e=e
local o=0
if i<1 then
o=1-i
if o>=#e then
return
end
e=e:sub(o+1)
i=1
end
local a=a-i+1
if a<=0 then
return
end
if#e>a then
e=e:sub(1,a)
end
h.text(s+i-1,n+r-1,e,c or u,d or l)
end
t.pixel=function(t,e,i)
local t=math.floor(t or 1)
local e=math.floor(e or 1)
if t<1 or t>a or e<1 or e>o then
return
end
d.pixel(s+t-1,n+e-1,i or u)
end
self._ctx=t
self.onDraw(self,t)
end
if self.border then
b(d,s,n,a,o,self.border,self.bg or self.app.background or e.black)
end
end
function d:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=o.width or 12
if o.height==nil then
o.height=a.showValue and 2 or 1
end
local t=setmetatable({},d)
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
t.border=O(true)
end
return t
end
function d:_clampValue(e)
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
function d:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function d:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local i=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,n=self:getAbsoluteRect()
local i=math.max(0,self.width-t-i)
local s=math.max(0,self.height-a-e)
local h=o+t
local o=n+a
return h,o,i,s,t,a,e
end
function d:_valueToPosition(o,t)
if t<=1 then
return 0
end
local a=self.max-self.min
local e=0
if a>0 then
e=(o-self.min)/a
end
if e<0 then
e=0
elseif e>1 then
e=1
end
return math.floor(e*(t-1)+.5)
end
function d:_positionToValue(e,t)
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
function d:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function d:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function d:_setSingleValue(e,t)
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
function d:setValue(e)
if self.range then
return
end
t(1,e,"number")
self:_setSingleValue(e,false)
end
function d:getValue()
return self.value
end
function d:_setLowerValue(e,t)
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
function d:_setUpperValue(e,t)
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
function d:setRangeValues(a,e,o)
if not self.range then
return
end
if a==nil then
a=self.lowerValue or self.min
end
if e==nil then
e=self.upperValue or self.max
end
t(1,a,"number")
t(2,e,"number")
if a>e then
a,e=e,a
end
local t=false
t=self:_setLowerValue(a,true)or t
t=self:_setUpperValue(e,true)or t
if t and not o then
self:_notifyChange()
end
end
function d:getRangeValues()
return self.lowerValue,self.upperValue
end
function d:setRangeLimits(e,a)
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
function d:setStep(e)
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
function d:setShowValue(e)
self.showValue=not not e
end
function d:setColors(a,e,o)
if a~=nil then
t(1,a,"number")
self.trackColor=a
end
if e~=nil then
t(2,e,"number")
self.fillColor=e
end
if o~=nil then
t(3,o,"number")
self.handleColor=o
end
end
function d:_formatNumber(o)
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
function d:_formatDisplayValue()
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
function d:_getStepForNudge(t)
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
function d:_positionFromPoint(t)
local a,o,e=self:_getInnerMetrics()
if e<=0 then
return nil,e
end
local t=math.floor(t-a)
if t<0 then
t=0
elseif t>e-1 then
t=e-1
end
return t,e
end
function d:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local o=self:_valueToPosition(self.lowerValue,a)
local i=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local s=math.abs(t-o)
local n=math.abs(t-i)
if s==n then
if t>i then
e="upper"
elseif t<o then
e="lower"
end
elseif s<n then
e="lower"
else
e="upper"
end
self._activeHandle=e
self._focusedHandle=e
local t=self:_positionToValue(t,a)
if e=="lower"then
self:_setLowerValue(t)
else
self:_setUpperValue(t)
end
else
self._activeHandle="single"
self._focusedHandle="single"
local e=self:_positionToValue(t,a)
self:_setSingleValue(e)
end
return true
end
function d:_updateInteraction(e)
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
function d:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function d:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function d:_nudgeValue(e)
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
function d:onFocusChanged(e)
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
function d:draw(o,f)
if not self.visible then
return
end
local s,d,h,u=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
r(o,s,d,h,u,n,n)
j(o,s,d,h,u)
local a,m,t,l=self:_getInnerMetrics()
if t<=0 or l<=0 then
if self.border then
b(f,s,d,h,u,self.border,n)
end
return
end
local i
local c=nil
if self.showValue and l>=2 then
c=m
i=m+l-1
else
i=m+math.floor((l-1)/2)
end
r(o,a,i,t,1,self.trackColor,self.trackColor)
local m
if self:isFocused()then
m=self._activeHandle or self._focusedHandle
end
local function l(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if m and s==m then
t=self.fg or e.white
end
o.text(a+n,i," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local n=t-e+1
if n>0 then
r(o,a+e,i,n,1,self.fillColor,self.fillColor)
end
l(e,"lower")
l(t,"upper")
else
local t=self:_valueToPosition(self.value,t)
local e=t+1
if e>0 then
r(o,a,i,e,1,self.fillColor,self.fillColor)
end
l(t,"single")
end
if self.showValue and c then
local i=self:_formatDisplayValue()
if i and i~=""then
if#i>t then
i=i:sub(1,t)
end
local t=a+math.floor((t-#i)/2)
if t<a then
t=a
end
o.text(t,c,i,self.fg or e.white,n)
end
end
if self.border then
b(f,s,d,h,u,self.border,n)
end
end
function d:handleEvent(t,...)
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
local e,a,t=...
if self:containsPoint(a,t)then
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
function h:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},h)
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
t.border=O(true)
end
t.scrollbar=I(a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_ensureSelectionVisible()
return t
end
function h:_normalizeColumns(e)
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
function h:_recomputeColumnMetrics()
self._columnMetrics={}
local e=0
for a=1,#self.columns do
local t=self.columns[a]
t.width=math.max(3,math.floor(t.width or 10))
self._columnMetrics[a]={
offset=e,
width=t.width
}
e=e+t.width
end
self._totalColumnWidth=e
end
function h:_ensureColumnsForData()
if#self.columns>0 then
return
end
local t=self.data[1]
if type(t)=="table"then
local e={}
for t,a in pairs(t)do
if type(t)=="string"then
e[#e+1]={
id=t,
title=t,
key=t,
align="left",
sortable=true,
width=math.max(3,math.min(20,tostring(a or""):len()+2))
}
end
end
table.sort(e,function(t,e)
return t.id<e.id
end)
if#e==0 then
e[1]={
id="value",
title="Value",
key="value",
align="left",
sortable=true,
accessor=function(a)
if type(a)=="table"then
local e={}
local t=0
for o,a in pairs(a)do
t=t+1
if t>4 then
e[#e+1]="..."
break
end
e[#e+1]=tostring(o).."="..tostring(a)
end
table.sort(e,function(t,e)
return t<e
end)
return"{"..table.concat(e,", ").."}"
end
return tostring(a)
end,
width=math.max(6,self.width-2)
}
end
self.columns=e
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
function h:setColumns(e)
if e~=nil then
t(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function h:getColumns()
local e={}
for t=1,#self.columns do
e[t]=o(self.columns[t])
end
return e
end
function h:setData(e)
t(1,e,"table")
local a={}
for t=1,#e do
a[t]=e[t]
end
self.data=a
self:_ensureColumnsForData()
self:_refreshRows()
end
function h:getData()
local e={}
for t=1,#self.data do
e[t]=self.data[t]
end
return e
end
function h:_refreshRows()
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
function h:_getColumnById(e)
if not e then
return nil
end
for t=1,#self.columns do
if self.columns[t].id==e then
return self.columns[t]
end
end
return nil
end
function h:_applySort(e,a,u)
local t=self:_getColumnById(e)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=a=="desc"and"desc"or"asc"
local l=self.sortDirection=="desc"
local i=t.comparator
table.sort(self._rows,function(n,s)
local r=self.data[n]
local d=self.data[s]
local a=h._resolveColumnValue(t,r)
local o=h._resolveColumnValue(t,d)
local e=0
if i then
local a,t=pcall(i,a,o,r,d,t)
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
function h:setSort(e,a,t)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,a or self.sortDirection,t)
end
function h:getSort()
return self.sortColumn,self.sortDirection
end
function h:setOnSort(e)
if e~=nil then
t(1,e,"function")
end
self.onSort=e
end
function h:setScrollbar(t)
self.scrollbar=I(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function h:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function h:getSelectedIndex()
return self.selectedIndex
end
function h:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function h:setSelectedIndex(e,a)
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
function h:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function h:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local i=(e and e.bottom)and 1 or 0
local n,e=self:getAbsoluteRect()
local o=math.max(0,self.width-t-o)
local i=math.max(0,self.height-a-i)
local t=n+t
local e=e+a
return t,e,o,i
end
function h:_computeLayoutMetrics()
local o,s,e,a=self:_getInnerMetrics()
if e<=0 or a<=0 then
return{
innerX=o,
innerY=s,
innerWidth=e,
innerHeight=a,
headerHeight=0,
rowsHeight=0,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=o
}
end
local h=a>=1 and 1 or 0
local r=math.max(0,a-h)
local t,n=H(self.scrollbar,#self._rows,r,e)
if t>0 and e-t<1 then
t=math.max(0,e-1)
if t<=0 then
t=0
n=nil
end
end
local i=e-t
if i<1 then
i=e
t=0
n=nil
end
return{
innerX=o,
innerY=s,
innerWidth=e,
innerHeight=a,
headerHeight=h,
rowsHeight=r,
contentWidth=i,
scrollbarWidth=t,
scrollbarStyle=n,
scrollbarX=o+i
}
end
function h:_getRowsVisible()
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
function h:_clampScroll()
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
function h:_ensureSelectionVisible()
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
function h:_rowFromPoint(o,t)
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
function h:_columnFromPoint(a,t)
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
function h._resolveColumnValue(e,t)
if e.accessor then
local t,e=pcall(e.accessor,t,e)
if t then
return e
end
end
if type(t)=="table"then
local e=e.key or e.id
return t[e]
end
return t
end
function h:_formatCell(t,a,e)
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
function h:draw(a,g)
if not self.visible then
return
end
local m,c,u,f=self:getAbsoluteRect()
local s=self.bg or e.black
local v=self.fg or e.white
r(a,m,c,u,f,s,s)
j(a,m,c,u,f)
local t=self:_computeLayoutMetrics()
local i=t.innerWidth
local k=t.innerHeight
local o=t.contentWidth
if i<=0 or k<=0 or o<=0 then
if self.border then
b(g,m,c,u,f,self.border,s)
end
return
end
local n=t.innerX
local w=t.innerY
local y=t.headerHeight
local j=t.rowsHeight
local p=t.scrollbarWidth
local l=t.scrollbarStyle
local d=self.headerBg or s
local q=self.headerFg or v
if y>0 then
a.text(n,w,string.rep(" ",o),d,d)
local h=n
local i=o
for e=1,#self.columns do
local s=self.columns[e]
local t=math.max(1,math.min(s.width,i))
if e==#self.columns then
t=math.max(1,i)
end
if t<=0 then
break
end
local e=s.title or s.id
local r=""
if self.sortColumn==s.id then
r=self.sortDirection=="desc"and"v"or"^"
end
if r~=""and t>=2 then
if#e>=t then
e=e:sub(1,t-1)
end
e=e..r
elseif t>#e then
e=e..string.rep(" ",t-#e)
else
e=e:sub(1,t)
end
a.text(h,w,e,q,d)
h=h+t
i=o-(h-n)
if i<=0 then
break
end
end
end
local y=w+y
local d=j
local i=self.rowBg or s
local v=self.rowFg or v
if d<=0 then
if p>0 then
local e=(l and l.background)or s
r(a,t.scrollbarX,w,p,k,e,e)
end
if self.border then
b(g,m,c,u,f,self.border,s)
end
return
end
if#self._rows==0 then
for e=0,d-1 do
local e=y+e
a.text(n,e,string.rep(" ",o),v,i)
end
if self.placeholder and self.placeholder~=""then
local t=self.placeholder
if#t>o then
t=t:sub(1,o)
end
local s=d>0 and math.min(d-1,math.floor(d/2))or 0
local s=y+s
local o=n+math.floor((o-#t)/2)
if o<n then
o=n
end
a.text(o,s,t,e.lightGray,i)
end
else
for s=0,d-1 do
local t=self.scrollOffset+s
local m=y+s
if t>#self._rows then
a.text(n,m,string.rep(" ",o),v,i)
else
local s=self._rows[t]
local l=self.data[s]
local c=self.allowRowSelection and t==self.selectedIndex
local s=i
local u=v
if c then
s=self.highlightBg or e.lightGray
u=self.highlightFg or e.black
elseif self.zebra and(t%2==0)then
s=self.zebraBg or s
end
local r=n
local d=o
for e=1,#self.columns do
local t=self.columns[e]
local i=math.max(1,math.min(t.width,d))
if e==#self.columns then
i=math.max(1,d)
end
if i<=0 then
break
end
local e=h._resolveColumnValue(t,l)
e=self:_formatCell(t,l,e)
if#e>i then
e=e:sub(1,i)
end
if t.align=="right"then
if#e<i then
e=string.rep(" ",i-#e)..e
end
elseif t.align=="center"then
local a=i-#e
local t=math.floor(a/2)
local a=a-t
e=string.rep(" ",t)..e..string.rep(" ",a)
else
if#e<i then
e=e..string.rep(" ",i-#e)
end
end
local h=u
if t.color then
if type(t.color)=="number"then
h=t.color
elseif type(t.color)=="function"then
local t,e=pcall(t.color,e,l,t,c)
if t and type(e)=="number"then
h=e
end
end
end
a.text(r,m,e,h,s)
r=r+i
d=o-(r-n)
if d<=0 then
break
end
end
end
end
end
if p>0 then
local e=(l and l.background)or s
r(a,t.scrollbarX,w,p,k,e,e)
if l and d>0 then
local e=math.max(0,self.scrollOffset-1)
S(a,t.scrollbarX,y,d,#self._rows,d,e,l)
end
end
if self.border then
b(g,m,c,u,f,self.border,s)
end
end
function h:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=z.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=(e.buffer or"")..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function h:_searchForPrefix(e)
if not e or e==""then
return
end
if#self._rows==0 then
return
end
local a=self.selectedIndex>=1 and self.selectedIndex or 0
for t=1,#self._rows do
local t=((a+t-1)%#self._rows)+1
local o=self.data[self._rows[t]]
local a=self.columns[1]
local a=h._resolveColumnValue(a,o)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function h:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function h:handleEvent(o,...)
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
local e=N(a,e.rowsHeight,#self._rows,e.rowsHeight,t)
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
local a,t,e=...
return i(t,e)
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
function l:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local t=setmetatable({},l)
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
t.border=O(true)
end
t.scrollbar=I(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:setNodes((a and a.nodes)or{})
return t
end
function l:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function l:setOnToggle(e)
if e~=nil then
t(1,e,"function")
end
self.onToggle=e
end
function l:setScrollbar(t)
self.scrollbar=I(t,self.bg or e.black,self.fg or e.white)
self:_ensureSelectionVisible()
end
function l:_copyNodes(e,i)
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
function l:setNodes(e)
e=e or{}
t(1,e,"table")
local t=self.selectedNode
local a=self._selectedIndex
self.nodes=self:_copyNodes(e,nil)
self.scrollOffset=1
self.selectedNode=nil
self._selectedIndex=0
self:_rebuildFlatNodes()
local e=self.selectedNode
if t~=e or self._selectedIndex~=a then
self:_notifySelect()
end
end
function l:getSelectedNode()
return self.selectedNode
end
function l:setSelectedNode(e)
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
function l:expandNode(e)
self:_toggleNode(e,true)
end
function l:collapseNode(e)
self:_toggleNode(e,false)
end
function l:toggleNode(e)
self:_toggleNode(e,nil)
end
function l:_rebuildFlatNodes()
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
function l:_findVisibleIndex(e)
if e==nil then
return nil
end
local t=self._flatNodes
for a=1,#t do
if t[a].node==e then
return a
end
end
return nil
end
function l:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-a)
local i=math.max(0,self.height-t-e)
return o,a,t,e,n,i
end
function l:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function l:_computeLayoutMetrics()
local a,t=self:getAbsoluteRect()
local o,s,n,s,e,i=self:_getInnerMetrics()
local o=a+o
local s=t+n
if e<=0 or i<=0 then
return{
innerX=o,
innerY=s,
innerWidth=e,
innerHeight=i,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=o
}
end
local t,n=H(self.scrollbar,#self._flatNodes,i,e)
if t>0 and e-t<1 then
t=math.max(0,e-1)
if t<=0 then
t=0
n=nil
end
end
local a=e-t
if a<1 then
a=e
t=0
n=nil
end
return{
innerX=o,
innerY=s,
innerWidth=e,
innerHeight=i,
contentWidth=a,
scrollbarWidth=t,
scrollbarStyle=n,
scrollbarX=o+a
}
end
function l:_ensureSelectionVisible()
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
function l:_setSelectedIndex(e,a)
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
function l:_selectNode(t,a)
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
function l:_moveSelection(a)
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
function l:_scrollBy(t)
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
function l:_rowFromPoint(a,t)
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
local t=t-o
local t=self.scrollOffset+t
if t<1 or t>#self._flatNodes then
return nil
end
return t,i,e.contentWidth
end
function l:_toggleNode(e,a)
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
function l:_notifySelect()
if self.onSelect then
self.onSelect(self,self.selectedNode,self._selectedIndex)
end
end
function l:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function l:_searchForPrefix(e)
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
function l:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=z.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function l:draw(n,h)
if not self.visible then
return
end
local o,t,i,a=self:getAbsoluteRect()
local s=self.bg or e.black
local m=self.fg or e.white
r(n,o,t,i,a,s,s)
j(n,o,t,i,a)
if self.border then
b(h,o,t,i,a,self.border,s)
end
local o=self:_computeLayoutMetrics()
local t=o.innerWidth
local h=o.innerHeight
local i=o.contentWidth
local c=o.scrollbarWidth
local d=o.scrollbarStyle
if t<=0 or h<=0 or i<=0 then
return
end
local u=o.innerX
local l=o.innerY
local f=self._flatNodes
local w=#f
if w==0 then
for e=0,h-1 do
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
r(n,o.scrollbarX,l,c,h,e,e)
if d then
S(n,o.scrollbarX,l,h,0,h,0,d)
end
end
return
end
for t=0,h-1 do
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
local t=s
local o=m
if r==self._selectedIndex then
t=self.highlightBg or e.lightGray
o=self.highlightFg or e.black
end
n.text(u,d,a,o,t)
end
end
if c>0 then
local e=(d and d.background)or s
r(n,o.scrollbarX,l,c,h,e,e)
if d then
S(n,o.scrollbarX,l,h,#self._flatNodes,h,math.max(0,self.scrollOffset-1),d)
end
end
end
function l:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
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
local e=N(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_ensureSelectionVisible()
end
return true
end
end
local t=self._flatNodes[o]
if t then
local e=t.depth*self.indentWidth
if e<0 then
e=0
end
if e>i-1 then
e=i-1
end
local o=n+e
if t.node and t.node.children and#t.node.children>0 and e<i then
local e=#tostring(self.toggleSymbols.collapsed or"+")
if e<1 then
e=1
end
if a>=o and a<o+e then
self:_toggleNode(t.node,nil)
return true
end
end
end
self:_setSelectedIndex(o,false)
return true
end
elseif t=="monitor_touch"then
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
local e=N(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
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
elseif t=="mouse_scroll"then
local e,t,a=...
if self:containsPoint(t,a)then
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
local function E(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function D(r,t,a,h,s,i)
if not r then
return
end
i=i or e.white
local n=math.abs(h-t)
local l=t<h and 1 or-1
local o=-math.abs(s-a)
local d=a<s and 1 or-1
local e=n+o
while true do
r.pixel(t,a,i)
if t==h and a==s then
break
end
local i=2*e
if i>=o then
e=e+o
t=t+l
end
if i<=n then
e=e+n
a=a+d
end
end
end
function c:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 8))
o.width=math.max(6,math.floor(o.width or 18))
local a=setmetatable({},c)
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
function c:_emitSelect()
if self.onSelect then
local e=self.selectedIndex
local t=e and self.data[e]or nil
self.onSelect(self,e,t)
end
end
function c:_clampSelection(a)
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
function c:setData(e)
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
function c:getData()
return self.data
end
function c:setLabels(e)
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
function c:getLabels()
return self.labels
end
function c:getLabel(e)
if type(e)~="number"then
return nil
end
if not self.labels then
return nil
end
return self.labels[math.floor(e)]
end
function c:setChartType(e)
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
function c:setShowAxis(e)
self.showAxis=not not e
end
function c:setShowLabels(e)
self.showLabels=not not e
end
function c:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e or""
end
function c:setRange(e,a)
if e~=nil then
t(1,e,"number")
end
if a~=nil then
t(2,a,"number")
end
self.minValue=e
self.maxValue=a
end
function c:setRangePadding(e)
t(1,e,"number")
if e<0 then
e=0
end
self.rangePadding=e
end
function c:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function c:setSelectedIndex(e,a)
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
function c:getSelectedIndex()
return self.selectedIndex
end
function c:getSelectedValue()
local e=self.selectedIndex
if not e then
return nil
end
return self.data[e]
end
function c:onFocusChanged(e)
if e then
self:_clampSelection(true)
end
end
function c:_indexFromPoint(t)
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
function c:_moveSelection(a)
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
function c:draw(h,p)
if not self.visible then
return
end
local o,a,l,d=self:getAbsoluteRect()
local n=self.bg or e.black
local w=self.fg or e.white
r(h,o,a,l,d,n,n)
j(h,o,a,l,d)
if self.border then
b(p,o,a,l,d,self.border,n)
end
local t=self.border
local i=(t and t.thickness)or 0
local c=(t and t.left)and i or 0
local m=(t and t.right)and i or 0
local u=(t and t.top)and i or 0
local t=(t and t.bottom)and i or 0
local i=o+c
local s=a+u
local a=math.max(0,l-c-m)
local t=math.max(0,d-u-t)
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
local a=i+math.floor((a-#o)/2)
if a<i then
a=i
end
local t=s+math.floor((t-1)/2)
h.text(a,t,o,e.lightGray,n)
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
local f=c>0 and(u+1)or nil
local c
if o>0 then
if f then
c=f+1
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
local t=i+math.floor((o-1)*a/d)
local e=i+math.floor(o*a/d)-1
if e<t then
e=t
end
if e>i+a-1 then
e=i+a-1
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
e=E(e,0,1)
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
local t=self.barColor or w
if self.selectedIndex==a then
t=self.highlightColor or t
end
r(h,s[a].left,o,s[a].width,e,t,t)
end
else
local a={}
for i=1,d do
local n=self.data[i]or 0
local e=0
if o>0 then
e=(n-t)/o
end
e=E(e,0,1)
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
for t=2,#a do
local e=a[t-1]
local t=a[t]
D(p,e.x,e.y,t.x,t.y,self.lineColor or w)
end
for i=1,#a do
local a=a[i]
local o=self.lineColor or w
local t="o"
if self.selectedIndex==i then
o=self.highlightColor or e.orange
t="O"
end
h.text(a.x,a.y,t,o,n)
end
end
if f then
r(h,i,f,a,1,n,n)
local e=string.rep("-",a)
h.text(i,f,e,self.axisColor or w,n)
end
if c then
r(h,i,c,a,1,n,n)
local t=self.labels or{}
for i=1,d do
local t=t[i]
if t and t~=""then
t=tostring(t)
local a=s[i]
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
local e=(self.selectedIndex==i)and(self.highlightColor or e.orange)or(self.axisColor or w)
h.text(o,c,t,e,n)
end
end
end
self._lastLayout={
innerX=i,
innerWidth=a,
dataCount=d,
bars=s
}
end
function c:handleEvent(e,...)
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
function u:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local t=setmetatable({},u)
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
t.border=O(true)
end
t.scrollbar=I(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_normalizeSelection(true)
return t
end
function u:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-a-o)
local i=math.max(0,self.height-t-e)
return a,o,t,e,n,i
end
function u:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function u:_computeLayoutMetrics()
local t,a=self:getAbsoluteRect()
local i,s,n,s,e,o=self:_getInnerMetrics()
local i=t+i
local s=a+n
if e<=0 or o<=0 then
return{
innerX=i,
innerY=s,
innerWidth=e,
innerHeight=o,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=i
}
end
local t,n=H(self.scrollbar,#self.items,o,e)
if t>0 and e-t<1 then
t=math.max(0,e-1)
if t<=0 then
t=0
n=nil
end
end
local a=e-t
if a<1 then
a=e
t=0
n=nil
end
return{
innerX=i,
innerY=s,
innerWidth=e,
innerHeight=o,
contentWidth=a,
scrollbarWidth=t,
scrollbarStyle=n,
scrollbarX=i+a
}
end
function u:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function u:_ensureSelectionVisible()
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
function u:_normalizeSelection(t)
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
function u:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function u:setItems(a)
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
function u:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function u:setSelectedIndex(e,a)
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
function u:getSelectedIndex()
return self.selectedIndex
end
function u:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function u:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e
end
function u:setHighlightColors(a,e)
if a~=nil then
t(1,a,"number")
self.highlightBg=a
end
if e~=nil then
t(2,e,"number")
self.highlightFg=e
end
end
function u:setScrollbar(t)
self.scrollbar=I(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function u:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function u:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function u:_itemIndexFromPoint(a,t)
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
function u:_moveSelection(t)
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
function u:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
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
local a=z.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function u:_searchForPrefix(e)
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
function u:draw(o,s)
if not self.visible then
return
end
local a,i,n,t=self:getAbsoluteRect()
local d=self.bg or e.black
local u=self.fg or e.white
r(o,a,i,n,t,d,d)
j(o,a,i,n,t)
if self.border then
b(s,a,i,n,t,self.border,d)
end
local t=self:_computeLayoutMetrics()
local n=t.innerWidth
local i=t.innerHeight
local a=t.contentWidth
if n<=0 or i<=0 or a<=0 then
return
end
local h=t.innerX
local s=t.innerY
local l=t.scrollbarWidth
local n=t.scrollbarStyle
local c=#self.items
local d=d
local m=self.highlightBg or e.lightGray
local f=self.highlightFg or e.black
if c==0 then
for e=0,i-1 do
o.text(h,s+e,string.rep(" ",a),u,d)
end
if l>0 then
local e=(n and n.background)or d
r(o,t.scrollbarX,s,l,i,e,e)
end
local r=self.placeholder
if type(r)=="string"and#r>0 then
local t=r
if#t>a then
t=t:sub(1,a)
end
local a=h+math.floor((a-#t)/2)
if a<h then
a=h
end
o.text(a,s,t,e.lightGray,d)
end
if n then
S(o,t.scrollbarX,s,i,0,i,0,n)
end
return
end
for e=0,i-1 do
local i=s+e
local t=self.scrollOffset+e
if t>c then
o.text(h,i,string.rep(" ",a),u,d)
else
local e=self.items[t]or""
if#e>a then
e=e:sub(1,a)
end
local e=e
if#e<a then
e=e..string.rep(" ",a-#e)
end
local n=d
local a=u
if t==self.selectedIndex then
n=m
a=f
end
o.text(h,i,e,a,n)
end
end
if l>0 then
local e=(n and n.background)or d
r(o,t.scrollbarX,s,l,i,e,e)
if n then
S(o,t.scrollbarX,s,i,#self.items,i,math.max(0,self.scrollOffset-1),n)
end
end
end
function u:handleEvent(t,...)
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
local e=N(a,e.innerHeight,#self.items,e.innerHeight,t)
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
local e=N(a,e.innerHeight,#self.items,e.innerHeight,t)
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
local e,t,a=...
if self:containsPoint(t,a)then
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
function v:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},v)
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
a.border=O(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function v:_normalizeSelection()
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
function v:setItems(a)
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
if a~=0 or t~=nil then
self:_notifyChange()
end
self:_setOpen(false)
return
end
self:_normalizeSelection()
local e=self:getSelectedItem()
if a~=self.selectedIndex or t~=e then
self:_notifyChange()
end
if self._open then
self._hoverIndex=self.selectedIndex
end
end
function v:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function v:setSelectedIndex(e,a)
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
function v:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function v:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function v:_setOpen(e)
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
function v:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function v:_isPointInDropdown(o,a)
if not self._open or#self.items==0 then
return false
end
local e,t,i,n=self:getAbsoluteRect()
local t=t+n
return o>=e and o<e+i and a>=t and a<t+#self.items
end
function v:_indexFromPoint(t,e)
if not self:_isPointInDropdown(t,e)then
return nil
end
local o,t,o,a=self:getAbsoluteRect()
local e=e-(t+a)+1
if e<1 or e>#self.items then
return nil
end
return e
end
function v:_handlePress(t,e)
local i,i,a,o=self:getAbsoluteRect()
if a<=0 or o<=0 then
return false
end
if self:containsPoint(t,e)then
self.app:setFocus(self)
if self._open then
self:_setOpen(false)
else
self:_setOpen(true)
end
return true
end
if self:_isPointInDropdown(t,e)then
local e=self:_indexFromPoint(t,e)
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
function v:draw(o,d)
if not self.visible then
return
end
local s,t,n,i=self:getAbsoluteRect()
local a=self.bg or e.black
local h=self.fg or e.white
r(o,s,t,n,i,a,a)
j(o,s,t,n,i)
if self.border then
b(d,s,t,n,i,self.border,a)
end
local e=self.border
local r=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local l=s+r
local s=math.max(0,n-r-u)
local u=t+d
local e=math.max(0,i-d-e)
local r=s>0 and 1 or 0
local i=math.max(0,s-r)
local n
if e>0 then
n=u+math.floor((e-1)/2)
else
n=t
end
local e=self:getSelectedItem()
if not e or e==""then
e=self.placeholder or""
end
if i>0 then
if#e>i then
e=e:sub(1,i)
end
local t=math.max(0,i-#e)
local e=e..string.rep(" ",t)
o.text(l,n,e,h,a)
end
if r>0 then
local t=self._open and string.char(30)or string.char(31)
local e=l+s-1
o.text(e,n,t,h,a)
end
end
function v:_drawDropdown(h,u)
if not self._open or#self.items==0 or self.visible==false then
return
end
local n,e,i,t=self:getAbsoluteRect()
local t=e+t
local d=#self.items
local e=self.border
local a=(e and e.left)and 1 or 0
local s=(e and e.right)and 1 or 0
local c=n+a
local a=math.max(0,i-a-s)
local l=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local s=d+e
r(h,n,t,i,s,self.dropdownBg,self.dropdownBg)
j(h,n,t,i,s)
for e=1,d do
local n=t+e-1
local t=self.items[e]or""
local e=l~=nil and l==e
local i=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local o=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if a>0 then
local e=t
if#e>a then
e=e:sub(1,a)
end
local t=math.max(0,a-#e)
local e=e..string.rep(" ",t)
h.text(c,n,e,o,i)
end
end
if self.border then
local e=o(self.border)
if e then
e.top=false
b(u,n,t,i,s,e,self.dropdownBg)
end
end
end
function v:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,t,e=...
return self:_handlePress(t,e)
elseif e=="monitor_touch"then
local a,t,e=...
return self:_handlePress(t,e)
elseif e=="mouse_scroll"then
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
elseif e=="mouse_move"then
local t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
end
elseif e=="mouse_drag"then
local a,t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
end
elseif e=="key"then
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
elseif e=="char"then
if not self:isFocused()or#self.items==0 then
return false
end
local e=...
if e and#e>0 then
local a=e:sub(1,1):lower()
local e=self.selectedIndex>=1 and self.selectedIndex or 0
for t=1,#self.items do
local e=((e+t-1)%#self.items)+1
local t=self.items[e]
if t and t:sub(1,1):lower()==a then
self:setSelectedIndex(e)
return true
end
end
end
end
return false
end
local o={}
o.__index=o
setmetatable(o,{__index=n})
local L={
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
local function U(t)
if t==nil or t==""then
return{""}
end
local e={}
local a=1
local i=#t
while a<=i do
local o=t:find("\n",a,true)
if not o then
e[#e+1]=t:sub(a)
break
end
e[#e+1]=t:sub(a,o-1)
a=o+1
if a>i then
e[#e+1]=""
break
end
end
if#e==0 then
e[1]=""
end
return e
end
local function F(e)
return table.concat(e,"\n")
end
local function E(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function D(t,a,o,e)
if t<o then
return-1
end
if t>o then
return 1
end
if a<e then
return-1
end
if a>e then
return 1
end
return 0
end
local function W(t,e,a,o,n,i)
if D(t,e,a,o)<0 then
return false
end
if D(t,e,n,i)>=0 then
return false
end
return true
end
local function K(a)
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
keywords=L,
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
t.keywords=t.keywords or L
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
for e,t in pairs(a)do
i[e]=t
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
t.syntax=K(a.syntax)
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
t.border=O(true)
end
t.scrollbar=I(a.scrollbar,t.bg or e.black,t.fg or e.white)
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
self.scrollbar=I(t,self.bg or e.black,self.fg or e.white)
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
self.text=F(self._lines)
end
function o:_setTextInternal(e,a,t)
e=tostring(e or"")
e=self:_applyMaxLength(e)
self._lines=U(e)
self:_syncTextFromLines()
if a then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=E(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=E(self._cursorCol,1,#e+1)
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
e=E(e or 1,1,#self.text+1)
local e=e-1
for t=1,#self._lines do
local a=self._lines[t]
local a=#a
if e<=a then
return t,e+1
end
e=e-(a+1)
end
local e=#self._lines
local t=#self._lines[e]
return e,t+1
end
function o:_moveCursorToIndex(e)
local t,e=self:_indexToPosition(e)
self:_setCursorPosition(t,e)
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
local s=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,i=self:getAbsoluteRect()
local o=o+a
local n=i+t
local i=math.max(0,self.width-a-s)
local s=math.max(0,self.height-t-e)
return o,n,i,s,a,t,e
end
function o:_getOverlayHeight(e)
if not self._find.visible then
return 0
end
return math.min(2,e)
end
function o:_computeLayoutMetrics()
local i,n,a,e=self:getAbsoluteRect()
local s,r,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
s=i
r=n
t=math.max(1,a)
o=math.max(1,e)
end
local h=self:_getOverlayHeight(o)
local n=math.max(1,o-h)
local e,a=H(self.scrollbar,#self._lines,n,t)
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
innerY=r,
innerWidth=t,
innerHeight=o,
contentWidth=i,
contentHeight=n,
overlayHeight=h,
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
local o,t,e,a=self:_getSelectionRange()
local e=self:_collectRange(o,t,e,a)
return#e
end
function o:getSelectionText()
if not self:_hasSelection()then
return""
end
local t,e,a,o=self:_getSelectionRange()
return self:_collectRange(t,e,a,o)
end
function o:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local o,a=e.line,e.col
local t,e=self._cursorLine,self._cursorCol
if D(o,a,t,e)<=0 then
return o,a,t,e
else
return t,e,o,a
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
local a=self._lines[e]:sub(1,a-1)
local o=self._lines[t]:sub(o)
for e=t,e+1,-1 do
table.remove(self._lines,e)
end
self._lines[e]=a..o
end
if#self._lines==0 then
self._lines[1]=""
end
end
function o:_insertAt(e,t,a)
if a==nil or a==""then
return e,t
end
local a=U(a)
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
function o:_deleteSelection(i)
local e,t,a,o=self:_getSelectionRange()
if not e then
return 0
end
local n=self:_collectRange(e,t,a,o)
self:_removeRange(e,t,a,o)
self._cursorLine=e
self._cursorCol=t
self._preferredCol=self._cursorCol
self:_clearSelection()
self:_syncTextFromLines()
self:_ensureCursorVisible()
if not i then
self:_notifyChange()
end
self:_notifyCursorChange()
return#n
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
local t,e=self:_insertAt(self._cursorLine,self._cursorCol,e)
self._cursorLine=t
self._cursorCol=e
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
local t=self._lines[self._cursorLine]
local a=#e
self._lines[self._cursorLine-1]=e..t
table.remove(self._lines,self._cursorLine)
self._cursorLine=self._cursorLine-1
self._cursorCol=a+1
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
a=E(a,1,#self._lines)
local o=self._lines[a]or""
t=E(t,1,#o+1)
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
local a,a,t,e=self:_getSelectionRange()
self:_setCursorPosition(t,e)
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
local e=E(self._cursorLine+e,1,#self._lines)
local t=self._lines[e]or""
local t=E(self._preferredCol,1,#t+1)
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
function o:_moveCursorDocumentEnd(a)
local e=#self._lines
local t=#self._lines[e]
self:_setCursorPosition(e,t+1,{extendSelection=a})
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
self._scrollY=E(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local a=select(1,self:_getContentSize())
local t=self._lines[self._cursorLine]or""
local t=math.max(0,#t-a)
self._scrollX=E(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(t,n)
local e=self:_computeLayoutMetrics()
local a=e.innerX
local o=e.innerY
local i=math.max(1,e.contentWidth)
local e=math.max(1,e.contentHeight)
local t=E(t-a,0,i-1)
local e=E(n-o,0,e-1)
local e=E(self._scrollY+e+1,1,#self._lines)
local a=self._lines[e]or""
local t=E(self._scrollX+t+1,1,#a+1)
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
for o,n,e in o:gmatch("()(%d+%.?%d*)()")do
if t.numberColor then
for e=o,e-1 do
if a[e]==i then
a[e]=t.numberColor
end
end
end
end
for o,e,n in o:gmatch("()([%a_][%w_]*)()")do
local s=e:lower()
if t.keywords and t.keywords[s]then
if t.keywordColor then
for e=o,n-1 do
if a[e]==i then
a[e]=t.keywordColor
end
end
end
elseif t.builtins and t.builtins[e]then
if t.builtinColor then
for e=o,n-1 do
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
local function E(t,a,i,o)
if a==""then
return
end
local e=t[#t]
if e and e.fg==i and e.bg==o then
e.text=e.text..a
else
t[#t+1]={text=a,fg=i,bg=o}
end
end
function o:_buildLineSegments(n,t,r,h,e)
local a=self._lines[n]or""
local i=self:_computeSyntaxColors(a)
local o=self._scrollX+1
local s={}
for t=0,t-1 do
local t=o+t
local o
if t<=#a then
o=a:sub(t,t)
else
o=" "
end
local i=i and i[t]or r
local a=h
if e and W(n,t,e.startLine,e.startCol,e.endLine,e.endCol)then
a=self.selectionBg
i=self.selectionFg
end
E(s,o,i,a)
end
return s,a,i
end
function o:_drawSegments(i,t,a,e)
local t=t
for o=1,#e do
local e=e[o]
if e.text~=""then
i.text(t,a,e.text,e.fg,e.bg)
t=t+#e.text
end
end
end
function o:_drawFindOverlay(h,a,n,t,i)
if not self._find.visible then
return
end
local o=self:_getOverlayHeight(i)
if o<=0 then
return
end
local d=self.overlayBg or self.bg or e.gray
local r=self.overlayFg or self.fg or e.white
local u=self.overlayActiveBg or e.orange
local c=self.overlayActiveFg or e.black
local n=n+i-o
for e=0,o-1 do
h.text(a,n+e,string.rep(" ",t),r,d)
end
local e=self._find
local i=#e.matches
local i=i>0 and string.format("%d/%d",math.max(1,e.index),i)or"0/0"
local s=e.matchCase and"CASE"or"case"
local i=string.format("Find: %s  %s  %s",e.findText,i,s)
local s="Replace: "..e.replaceText
local i=i
if#i>t then
i=i:sub(1,t)
end
local s=s
if#s>t then
s=s:sub(1,t)
end
h.text(a,n,i..string.rep(" ",math.max(0,t-#i)),r,d)
h.text(a,n+math.max(o-1,0),s..string.rep(" ",math.max(0,t-#s)),r,d)
local i,s,l
if e.activeField=="find"then
i=a+6
s=n
l=e.findText
else
i=a+9
s=n+math.max(o-1,0)
l=e.replaceText
end
local e=l
if#e>t-(i-a)then
e=e:sub(1,t-(i-a))
end
h.text(i,s,e..string.rep(" ",math.max(0,t-(i-a)-#e)),c,u)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
h.text(a,n+o-1,e..string.rep(" ",math.max(0,t-#e)),r,d)
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
function o:_computeAutocompleteGhost(e,t,a)
if not e then
return""
end
local e=e.insert or e.label or""
if e==""then
return""
end
if t==""then
if a=="manual"then
return e
end
return""
end
local a=e:lower()
local o=t:lower()
if a:sub(1,#t)~=o then
return""
end
return e:sub(#t+1)
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
function o:_toggleFindOverlay(t)
local e=self._find
if e.visible and(not t or e.activeField==t)then
self:_closeFindOverlay()
return
end
e.visible=true
if t then
e.activeField=t
end
if self:_hasSelection()and t=="find"then
e.findText=self:getSelectionText()
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
local t=e.findText
local a=e.matchCase
for o=1,#self._lines do
local i=self._lines[o]
local i=a and i or i:lower()
local t=a and t or t:lower()
local a=1
while true do
local t,i=i:find(t,a,true)
if not t then
break
end
e.matches[#e.matches+1]={
line=o,
col=t,
length=i-t+1
}
a=t+1
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
local a=1
for t=1,#e.matches do
local e=e.matches[t]
if D(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
a=t
break
end
end
e.index=a
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
local a=t.line
local o=t.col
local i=self._lines[a]
self._lines[a]=i:sub(1,o-1)..(e.replaceText or"")..i:sub(o+t.length)
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
function o:draw(a,x)
if not self.visible then
return
end
local v,p,y,w=self:getAbsoluteRect()
local s=self.bg or e.black
local f=self.fg or e.white
r(a,v,p,y,w,s,s)
j(a,v,p,y,w)
local o=self:_computeLayoutMetrics()
local h=o.innerX
local n=o.innerY
local t=o.innerWidth
local q=o.innerHeight
local i=o.contentWidth
local d=o.contentHeight
local m=o.overlayHeight
local u=o.scrollbarWidth
local c=o.scrollbarStyle
local k
local g=false
if self:_hasSelection()then
local a,e,t,o=self:_getSelectionRange()
k={
startLine=a,
startCol=e,
endLine=t,
endCol=o
}
g=true
end
local t=self._autocompleteState
local l=s
for s=0,d-1 do
local o=self._scrollY+s+1
local n=n+s
if o>#self._lines then
a.text(h,n,string.rep(" ",i),f,l)
else
local r,s,d=self:_buildLineSegments(o,i,f,l,k)
self:_drawSegments(a,h,n,r)
if self:isFocused()and o==self._cursorLine then
local t=self._cursorCol-self._scrollX-1
if t>=0 and t<i then
local e
if self._cursorCol<=#s then
e=s:sub(self._cursorCol,self._cursorCol)
else
e=" "
end
local o=l
local i=f
a.text(h+t,n,e,o,i)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not g and o==t.anchorLine then
local r=t.anchorCol+#t.prefix
local o=r-self._scrollX-1
if o<i then
local t=t.ghost
local s=#s
if r<=s then
local e=s-r+1
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
a.text(h+o,n,t,self.autocompleteGhostColor or e.lightGray,l)
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
a.text(h,n,t..string.rep(" ",math.max(0,i-#t)),e.lightGray,l)
end
self:_drawFindOverlay(a,h,n,i,q)
if c then
local t=o.scrollbarX
local e=c.background or s
r(a,t,n,u,d,e,e)
S(a,t,n,d,#self._lines,d,self._scrollY,c)
if m>0 then
r(a,t,n+d,u,m,e,e)
end
elseif u>0 then
r(a,o.scrollbarX,n,u,d+m,s,s)
end
if self.border then
b(x,v,p,y,w,self.border,s)
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
local e=N(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
if e~=self._scrollY then
self._scrollY=e
end
return true
end
end
local e,t=self:_cursorFromPoint(a,t)
if o==1 then
self:_setCursorPosition(e,t)
self._dragging=true
self._dragButton=o
self._dragAnchor={line=e,col=t}
elseif o==2 then
self:_setCursorPosition(e,t)
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
local e=N(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
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
local e,t,a=...
if self:containsPoint(t,a)then
self:_scrollLines(e)
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
function f.create(a)
if a~=nil then
t(1,a,"table")
end
a=a or{}
local h=false
local i
local t=a.window
if t==nil then
i=M.current()
local a,e=i.getSize()
t=B.create(i,1,1,a,e,true)
t.setVisible(true)
h=true
end
local o=P.new(t)
o.profiler.start_frame()
o.profiler.start_region("user")
local r=o.add_pixel_layer(5,"pixelui_pixels")
local d=o.add_text_layer(10,"pixelui_ui")
local l,c=t.getSize()
local n=a.background or e.black
o.fill(n)
local u=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=t,
box=o,
layer=d,
pixelLayer=r,
background=n,
running=false,
_autoWindow=h,
_parentTerminal=i,
_focusWidget=nil,
_popupWidgets={},
_popupLookup={},
_animations={},
_animationTimer=nil,
_animationInterval=u,
_radioGroups={},
_threads={},
_threadTimers={},
_threadTicker=nil,
_threadIdCounter=0
},s)
t.root=x:new(t,{
x=1,
y=1,
width=l,
height=c,
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
return x:new(self,e)
end
function s:createButton(e)
return T:new(self,e)
end
function s:createLabel(e)
return k:new(self,e)
end
function s:createCheckBox(e)
return g:new(self,e)
end
function s:createToggle(e)
return q:new(self,e)
end
function s:createTextBox(e)
return o:new(self,e)
end
function s:createComboBox(e)
return v:new(self,e)
end
function s:createList(e)
return u:new(self,e)
end
function s:createTable(e)
return h:new(self,e)
end
function s:createTreeView(e)
return l:new(self,e)
end
function s:createChart(e)
return c:new(self,e)
end
function s:createRadioButton(e)
return y:new(self,e)
end
function s:createProgressBar(e)
return w:new(self,e)
end
function s:createNotificationToast(e)
return i:new(self,e)
end
function s:createLoadingRing(e)
return m:new(self,e)
end
function s:createFreeDraw(e)
return A:new(self,e)
end
function s:createSlider(e)
return d:new(self,e)
end
function s:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=z.startTimer(self._animationInterval)
end
end
function s:_updateAnimations()
local a=self._animations
if not a or#a==0 then
return
end
local o=z.clock()
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
t=R.linear
elseif type(t)=="string"then
t=R[t]
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
startTime=z.clock()
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
local b="completed"
local j="error"
local r="cancelled"
local E={}
local function O(e,a,...)
if not e then
return
end
for t=1,#e do
local e=e[t]
local e,t=pcall(e,...)
if not e then
print(a..tostring(t))
end
end
end
function p:getId()
return self.id
end
function p:getName()
return self.name
end
function p:setName(e)
t(1,e,"string")
self.name=e
end
function p:getStatus()
return self.status
end
function p:isRunning()
return self.status==a
end
function p:isFinished()
local e=self.status
return e==b or e==j or e==r
end
function p:isCancelled()
return self._cancelRequested or self.status==r
end
function p:cancel()
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
function p:getResult()
if not self.result then
return nil
end
return Y(self.result,1,self.result.n or#self.result)
end
function p:getResults()
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
function p:getError()
return self.error
end
function p:setMetadata(e,a)
t(1,e,"string")
local t=self.metadata[e]
if t==a then
return
end
self.metadata[e]=a
self:_emitMetadata(e,a)
end
function p:getMetadata(e)
t(1,e,"string")
return self.metadata[e]
end
function p:getAllMetadata()
local e={}
for a,t in pairs(self.metadata)do
e[a]=t
end
return e
end
function p:onStatusChange(e)
if e==nil then
return
end
t(1,e,"function")
local t=self._statusListeners
t[#t+1]=e
local e,t=pcall(e,self,self.status)
if not e then
print("Thread status listener error: "..tostring(t))
end
end
function p:onMetadataChange(e)
if e==nil then
return
end
t(1,e,"function")
local t=self._metadataListeners
t[#t+1]=e
for a,t in pairs(self.metadata)do
local t,e=pcall(e,self,a,t)
if not t then
print("Thread metadata listener error: "..tostring(e))
end
end
end
function p:_emitMetadata(t,e)
O(self._metadataListeners,"Thread metadata listener error: ",self,t,e)
end
function p:_setStatus(e)
if self.status==e then
return
end
self.status=e
O(self._statusListeners,"Thread status listener error: ",self,e)
end
local function O(e)
return setmetatable({_handle=e},_)
end
function _:checkCancelled()
if self._handle._cancelRequested then
error(E,0)
end
end
function _:isCancelled()
return self._handle._cancelRequested==true
end
function _:sleep(a)
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
local a=z.startTimer(a)
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
function _:yield()
self:checkCancelled()
self._handle.waiting="yield"
return coroutine.yield("yield")
end
function _:setMetadata(t,e)
self._handle:setMetadata(t,e)
end
function _:setStatus(e)
self._handle:setMetadata("status",e)
end
function _:setDetail(e)
self._handle:setMetadata("detail",e)
end
function _:setProgress(e)
if e~=nil then
t(1,e,"number")
end
self._handle:setMetadata("progress",e)
end
function _:getHandle()
return self._handle
end
function s:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
self._threadTicker=z.startTimer(0)
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
e:_setStatus(r)
self:_cleanupThread(e)
return
end
local t=e._resumeValue
e._resumeValue=nil
local t=V(coroutine.resume(e.co,t))
local a=t[1]
if not a then
local t=t[2]
if t==E then
e:_setStatus(r)
else
if type(t)=="string"and debug and debug.traceback then
t=debug.traceback(e.co,t)
end
e.error=t
print("PixelUI thread error: "..tostring(t))
e:_setStatus(j)
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
e:_setStatus(b)
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
e:_setStatus(r)
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
},p)
local a=coroutine.create(function()
local e=O(t)
t._context=e
local e=V(o(e,self))
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
local a=self._popupWidgets
if not a or#a==0 then
return
end
local i=self.layer
local o=self.pixelLayer
local t=1
while t<=#a do
local e=a[t]
if e and e._open and e.visible~=false then
e:_drawDropdown(i,o)
t=t+1
else
if e then
self._popupLookup[e]=nil
end
table.remove(a,t)
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
self._animationTimer=z.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or M.current()
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
local e={G()}
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
f.widgets={
Frame=function(e,t)
return x:new(e,t)
end,
Button=function(e,t)
return T:new(e,t)
end,
Label=function(t,e)
return k:new(t,e)
end,
CheckBox=function(t,e)
return g:new(t,e)
end,
Toggle=function(e,t)
return q:new(e,t)
end,
TextBox=function(e,t)
return o:new(e,t)
end,
ComboBox=function(e,t)
return v:new(e,t)
end,
List=function(t,e)
return u:new(t,e)
end,
Table=function(e,t)
return h:new(e,t)
end,
TreeView=function(e,t)
return l:new(e,t)
end,
Chart=function(t,e)
return c:new(t,e)
end,
RadioButton=function(t,e)
return y:new(t,e)
end,
ProgressBar=function(e,t)
return w:new(e,t)
end,
Slider=function(t,e)
return d:new(t,e)
end,
LoadingRing=function(t,e)
return m:new(t,e)
end,
FreeDraw=function(t,e)
return A:new(t,e)
end,
NotificationToast=function(t,e)
return i:new(t,e)
end
}
f.Widget=n
f.Frame=x
f.Button=T
f.Label=k
f.CheckBox=g
f.Toggle=q
f.TextBox=o
f.ComboBox=v
f.List=u
f.Table=h
f.TreeView=l
f.Chart=c
f.RadioButton=y
f.ProgressBar=w
f.Slider=d
f.LoadingRing=m
f.FreeDraw=A
f.NotificationToast=i
f.easings=R
f.ThreadHandle=p
f.ThreadContext=_
f.threadStatus={
running=a,
completed=b,
error=j,
cancelled=r
}
return f
