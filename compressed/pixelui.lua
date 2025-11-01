local Y=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local T=assert(rawget(_G,"os"),"os API unavailable")
local te=assert(T.pullEvent,"os.pullEvent unavailable")
local ee=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local B=table.pack or function(...)
return{n=select("#",...),...}
end
local K=assert(table.unpack,"table.unpack unavailable")
local t=require("cc.expect").expect
local Q=require("shrekbox")
local y={
version="0.1.0"
}
local H={
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
local q={}
q.__index=q
setmetatable(q,{__index=n})
local d={}
d.__index=d
setmetatable(d,{__index=q})
local N={}
N.__index=N
setmetatable(N,{__index=n})
local E={}
E.__index=E
setmetatable(E,{__index=n})
local z={}
z.__index=z
setmetatable(z,{__index=n})
local b={}
b.__index=b
setmetatable(b,{__index=n})
local k={}
k.__index=k
setmetatable(k,{__index=n})
local l={}
l.__index=l
setmetatable(l,{__index=n})
local x={}
x.__index=x
local O={}
O.__index=O
local f={}
f.__index=f
setmetatable(f,{__index=n})
local r={}
r.__index=r
setmetatable(r,{__index=n})
local u={}
u.__index=u
setmetatable(u,{__index=n})
local w={}
w.__index=w
setmetatable(w,{__index=n})
local g={}
g.__index=g
setmetatable(g,{__index=n})
local j={}
j.__index=j
setmetatable(j,{__index=n})
local c={}
c.__index=c
setmetatable(c,{__index=n})
local m={}
m.__index=m
setmetatable(m,{__index=n})
local h={}
h.__index=h
setmetatable(h,{__index=n})
local v={}
v.__index=v
setmetatable(v,{__index=n})
local S={}
S.__index=S
setmetatable(S,{__index=n})
local s={}
s.__index=s
local p={"top","right","bottom","left"}
local ae=string.char(7)
local U={
info={bg=e.blue,fg=e.white,accent=e.lightBlue,icon="i"},
success={bg=e.green,fg=e.black,accent=e.lime,icon="+"},
warning={bg=e.orange,fg=e.black,accent=e.yellow,icon="!"},
error={bg=e.red,fg=e.white,accent=e.white,icon="x"}
}
local function G(e)
if e==nil then
return"info"
end
local e=tostring(e):lower()
if U[e]then
return e
end
return"info"
end
local function V(e)
if e==nil then
return 1,1,1,1
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
return e,e,e,e
end
local i,s,n,o=1,1,1,1
if type(e)=="table"then
local a=e.horizontal or e.x
local t=e.vertical or e.y
if a~=nil then
a=math.max(0,math.floor(a))
i=a
s=a
end
if t~=nil then
t=math.max(0,math.floor(t))
n=t
o=t
end
if e.left~=nil then
i=math.max(0,math.floor(e.left))
end
if e.right~=nil then
s=math.max(0,math.floor(e.right))
end
if e.top~=nil then
n=math.max(0,math.floor(e.top))
end
if e.bottom~=nil then
o=math.max(0,math.floor(e.bottom))
end
end
return i,s,n,o
end
local function _(t,a,e)
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
local function J(e)
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
local function F(e)
local i,a,o,t=1,1,1,1
if e==nil then
return{top=i,right=a,bottom=o,left=t}
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
i,a,o,t=e,e,e,e
elseif type(e)=="table"then
if e.all~=nil then
local e=math.max(0,math.floor(e.all))
i,a,o,t=e,e,e,e
end
if e.vertical~=nil then
local e=math.max(0,math.floor(e.vertical))
i,o=e,e
end
if e.horizontal~=nil then
local e=math.max(0,math.floor(e.horizontal))
a,t=e,e
end
if e.top~=nil then
i=math.max(0,math.floor(e.top))
end
if e.right~=nil then
a=math.max(0,math.floor(e.right))
end
if e.bottom~=nil then
o=math.max(0,math.floor(e.bottom))
end
if e.left~=nil then
t=math.max(0,math.floor(e.left))
end
end
return{top=i,right=a,bottom=o,left=t}
end
local function W(t,i)
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
_(t:sub(a),i,e)
break
end
_(t:sub(a,o-1),i,e)
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
for a,e in pairs(e)do
t[a]=e
end
return t
end
local function C(a,e)
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
for e=1,#p do
o(p[e],a[p[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function A(a)
local e=a.border
local t=e and math.max(1,math.floor(e.thickness or 1))or 0
local o=(e and e.left)and t or 0
local i=(e and e.right)and t or 0
local n=(e and e.top)and t or 0
local e=(e and e.bottom)and t or 0
local s=math.max(0,a.width-o-i)
local t=math.max(0,a.height-n-e)
return o,i,n,e,s,t
end
local function X(e,a)
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
local function Z(a,e,t)
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
local p="^(%a[%w_]*)%.([%a_][%w_]*)$"
local function i(e)
if type(e)~="string"then
return nil,nil
end
local e,t=e:match(p)
return e,t
end
local function _(e,t)
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
local function p(e,t)
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
local e,a=i(e)
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
local a,o=i(a)
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
local o=_(e.percent,t..".percent")
local a=e.of or("parent."..t)
local a,i=i(a)
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
return p(e.match,t)
end
if e.value~=nil then
return p(e.value,t)
end
error("constraints."..t.." table must include percent, reference/of, match, or value fields",3)
end
return nil
end
local function R(e,t)
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
local e,a=i(e)
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
local e,a=i(a)
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
local function P(e)
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
t.width=p(e.width,"width")
end
if e.height~=nil then
t.height=p(e.height,"height")
end
if e.widthPercent~=nil then
t.widthPercent=_(e.widthPercent,"widthPercent")
end
if e.heightPercent~=nil then
t.heightPercent=_(e.heightPercent,"heightPercent")
end
if e.centerX~=nil then
t.centerX=R(e.centerX,"x")
end
if e.centerY~=nil then
t.centerY=R(e.centerY,"y")
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
local _=string.char(30)
local D=string.char(31)
local function R(o,h,i)
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
local s=a.trackColor or e.gray
local n=a.thumbColor or e.lightGray
local i=a.arrowColor or i or e.white
local o=a.background or h or e.black
local t=math.max(1,math.floor(a.width or 1))
local e=math.max(1,math.floor(a.minThumbSize or 1))
return{
enabled=true,
alwaysVisible=not not a.alwaysVisible,
width=t,
trackColor=s,
thumbColor=n,
arrowColor=i,
background=o,
minThumbSize=e
}
end
local function p(e)
if e<0 then
return 0
end
if e>1 then
return 1
end
return e
end
local function M(t,o,e,a)
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
local function L(o,i,a,t,l,d,u,e)
if not e or t<=0 then
return
end
local h=math.max(1,math.floor(e.width or 1))
local n=e.trackColor
local s=e.arrowColor
local r=e.thumbColor
local m=math.max(1,math.floor(e.minThumbSize or 1))
local e=math.max(0,h-1)
local c=_..string.rep(" ",e)
o.text(i,a,c,s,n)
if t>=2 then
local e=D..string.rep(" ",e)
o.text(i,a+t-1,e,s,n)
end
local a=a+1
local e=math.max(0,t-2)
local t=string.rep(" ",h)
for e=0,e-1 do
o.text(i,a+e,t,n,n)
end
local s=math.max(0,(l or 0)-(d or 0))
if s<=0 or e<=0 then
return
end
local u=math.max(0,math.min(s,math.floor((u or 0)+.5)))
local t=d/l
local t=math.max(m,math.floor(e*t+.5))
if t>e then
t=e
end
if t<1 then
t=1
end
local e=e-t
local n=a
if e>0 then
local t=p(s==0 and 0 or(u/s))
n=a+math.floor(t*e+.5)
if n>a+e then
n=a+e
end
end
local a=string.rep(" ",h)
for e=0,t-1 do
o.text(i,n+e,a,r,r)
end
end
local function D(o,a,e,i,t)
if a<=0 then
return t or 0
end
local e=math.max(0,(e or 0)-(i or 0))
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
local function i(o,n,i,e,t,h,s,a)
if e<=0 or t<=0 then
return
end
local a=a or" "
local a=a:rep(e)
for e=0,t-1 do
o.text(n,i+e,a,h,s)
end
end
local function _(e,i,n,o,t)
if o<=0 or t<=0 then
return
end
local a=Q.transparent
for o=0,o-1 do
e.pixel(i+o,n,a)
if t>1 then
e.pixel(i+o,n+t-1,a)
end
end
for t=1,math.max(0,t-2)do
e.pixel(i,n+t,a)
if o>1 then
e.pixel(i+o-1,n+t,a)
end
end
end
local function p(d,s,a,o,i,e,t)
if o<=0 or i<=0 then
return
end
local n=e.color
local r=t or n
local t=(s-1)*2+1
local a=(a-1)*3+1
local o=o*2
local i=i*3
local l=3
local u=2
local s=math.min(e.thickness,i)
local h=math.min(e.thickness,o)
local l=math.min(i,math.max(s,l))
local u=math.min(o,math.max(h,u))
local function m(n,e,s)
for e=0,e-1 do
local e=n+e
if e<a or e>=a+i then break end
for a=0,o-1 do
d.pixel(t+a,e,s)
end
end
end
local function c(e,s,n)
for s=0,s-1 do
local e=e+s
if e<a or e>=a+i then break end
for a=0,o-1 do
d.pixel(t+a,e,n)
end
end
end
local function f(e,n,s)
for n=0,n-1 do
local e=e+n
if e<t or e>=t+o then break end
for t=0,i-1 do
d.pixel(e,a+t,s)
end
end
end
local function w(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+o then break end
for t=0,i-1 do
d.pixel(e,a+t,n)
end
end
end
if e.left then
f(t,u,r)
end
if e.right then
f(t+o-u,u,r)
end
if e.top then
m(a,l,r)
end
if e.bottom then
m(a+i-l,l,r)
end
if e.top then
c(a,s,n)
end
if e.bottom then
c(a+i-s,s,n)
end
if e.left then
w(t,h,n)
end
if e.right then
w(t+o-h,h,n)
end
end
function h:new(i,a)
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
local e=setmetatable({},h)
e:_init_base(i,t)
e.focusable=false
local i=a.anchor~=nil
local t=J(a.anchor)
if not t and not i then
if a.x~=nil or a.y~=nil then
t=nil
else
t="top_right"
end
end
e.anchor=t
e.anchorMargins=F(a.anchorMargin)
e.anchorAnimationDuration=math.max(.05,tonumber(a.anchorAnimationDuration)or .2)
e.anchorEasing=a.anchorEasing or"easeOutCubic"
e._anchorDirty=true
e._anchorAnimationHandle=nil
e.title=a.title~=nil and tostring(a.title)or nil
e.message=a.message~=nil and tostring(a.message)or""
e.icon=a.icon~=nil and tostring(a.icon)or nil
e.severity=G(a.severity)
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
e.paddingLeft,e.paddingRight,e.paddingTop,e.paddingBottom=V(a.padding)
e._hideTimer=nil
e._wrappedLines={""}
e._lastWrapWidth=nil
e._lastMessage=nil
e:_refreshWrap(true)
return e
end
function h:_applyPadding(e,i)
local a,e,t,o=V(e)
if i or a~=self.paddingLeft or e~=self.paddingRight or t~=self.paddingTop or o~=self.paddingBottom then
self.paddingLeft=a
self.paddingRight=e
self.paddingTop=t
self.paddingBottom=o
self:_refreshWrap(true)
self._anchorDirty=true
end
end
function h:setPadding(e)
self:_applyPadding(e,false)
end
function h:getAnchor()
return self.anchor
end
function h:getAnchorMargins()
return o(self.anchorMargins)
end
function h:refreshAnchor(e)
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
function h:setAnchor(e)
local t=J(e)
if t==nil and e~=nil then
self.anchor=nil
else
self.anchor=t
end
self:refreshAnchor(false)
end
function h:setAnchorMargin(e)
self.anchorMargins=F(e)
self:refreshAnchor(false)
end
function h:_computeAnchorPosition()
local n=self.anchor
if not n then
return nil,nil
end
local e=self.parent
if not e then
return nil,nil
end
local i=e.width
local o=e.height
if type(i)~="number"or type(o)~="number"then
return nil,nil
end
local h=self.width
local s=self.height
local a=self.anchorMargins or F(nil)
local t
local e
if n=="top_right"then
t=i-h-(a.right or 0)+1
e=(a.top or 0)+1
elseif n=="top_left"then
t=(a.left or 0)+1
e=(a.top or 0)+1
elseif n=="bottom_right"then
t=i-h-(a.right or 0)+1
e=o-s-(a.bottom or 0)+1
elseif n=="bottom_left"then
t=(a.left or 0)+1
e=o-s-(a.bottom or 0)+1
else
return nil,nil
end
if t<1 then
t=1
end
if e<1 then
e=1
end
if t+h-1>i then
t=math.max(1,i-h+1)
end
if e+s-1>o then
e=math.max(1,o-s+1)
end
return t,e
end
function h:getAnchorTargetPosition()
return self:_computeAnchorPosition()
end
function h:_applyAnchorPosition(a)
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
local s=math.max(2,math.floor(self.width/6))
local i=math.max(1,math.floor(self.height/3))
local o=e
local a=t
if self.anchor=="top_right"then
o=e+s
a=math.max(1,t-i)
elseif self.anchor=="top_left"then
o=e-s
a=math.max(1,t-i)
elseif self.anchor=="bottom_right"then
o=e+s
a=t+i
elseif self.anchor=="bottom_left"then
o=e-s
a=t+i
end
n.setPosition(self,o,a)
local s=self.anchorAnimationDuration or .2
local i=self.anchorEasing or"easeOutCubic"
local o=o
local a=a
local r=e-o
local h=t-a
self._anchorAnimationHandle=self.app:animate({
duration=s,
easing=i,
update=function(e)
local t=math.floor(o+r*e+.5)
local e=math.floor(a+h*e+.5)
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
function h:_getActiveBorder()
if self.border then
return self.border
end
return nil
end
function h:_refreshWrap(o,t)
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
self._wrappedLines=W(self.message,e)
self._lastWrapWidth=e
self._lastMessage=self.message
end
function h:_getStyle()
local a=self.severity
local e=U.info
if a~=nil then
local t=U[a]
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
function h:_cancelTimer()
if self._hideTimer then
if T.cancelTimer then
pcall(T.cancelTimer,self._hideTimer)
end
self._hideTimer=nil
end
end
function h:_scheduleHide(e)
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
self._hideTimer=T.startTimer(e)
end
function h:setTitle(e)
if e==nil then
self.title=nil
else
self.title=tostring(e)
end
end
function h:getTitle()
return self.title
end
function h:setMessage(e)
if e==nil then
e=""
end
local e=tostring(e)
if self.message~=e then
self.message=e
self:_refreshWrap(true)
end
end
function h:getMessage()
return self.message
end
function h:setSeverity(e)
local e=G(e)
if self.severity~=e then
self.severity=e
end
end
function h:getSeverity()
return self.severity
end
function h:setIcon(e)
if e==nil or e==""then
self.icon=nil
return
end
self.icon=tostring(e)
end
function h:getIcon()
return self.icon
end
function h:setAutoHide(e)
e=not not e
if self.autoHide~=e then
self.autoHide=e
if not e then
self:_cancelTimer()
end
end
end
function h:isAutoHide()
return self.autoHide
end
function h:setDuration(e)
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
function h:getDuration()
return self.duration
end
function h:setDismissOnClick(e)
self.dismissOnClick=not not e
end
function h:isDismissOnClick()
return self.dismissOnClick
end
function h:setOnDismiss(e)
if e~=nil and type(e)~="function"then
error("onDismiss handler must be a function",2)
end
self.onDismiss=e
end
function h:setVariants(e)
if e~=nil and type(e)~="table"then
error("variants must be a table",2)
end
self.variantOverrides=e and o(e)or nil
end
function h:setStyle(e)
if e~=nil and type(e)~="table"then
error("style must be a table",2)
end
self.styleOverride=e and o(e)or nil
end
function h:present(e)
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
function h:show(t)
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
function h:hide(t)
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
function h:setSize(e,t)
n.setSize(self,e,t)
self:_refreshWrap(true)
self._anchorDirty=true
if self.anchor then
self:_applyAnchorPosition(false)
end
end
function h:setBorder(e)
n.setBorder(self,e)
self:_refreshWrap(true)
self._anchorDirty=true
end
function h:_renderLine(s,n,i,t,e,o,a)
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
function h:draw(o,u)
if not self.visible then
return
end
if self._anchorDirty and not self._anchorAnimationHandle then
self:_applyAnchorPosition(false)
end
local h,r,a,n=self:getAbsoluteRect()
if a<=0 or n<=0 then
return
end
local s=self:_getStyle()or U.info
local t=s.bg or self.bg or e.gray
local d=s.fg or self.fg or e.white
local l=s.accent or d
local m=s.titleColor or d
local c=s.iconColor or l
i(o,h,r,a,n,t,t)
_(o,h,r,a,n)
local e=self.border
if e then
p(u,h,r,a,n,e,t)
else
p(u,h,r,a,n,{
color=l,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
},t)
end
local e=e
local i=(e and e.left)and e.thickness or 0
local u=(e and e.right)and e.thickness or 0
local l=(e and e.top)and e.thickness or 0
local e=(e and e.bottom)and e.thickness or 0
local h=h+i
local f=r+l
local a=math.max(0,a-i-u)
local e=math.max(0,n-l-e)
local r=h+(self.paddingLeft or 0)
local l=f+(self.paddingTop or 0)
local h=math.max(0,a-(self.paddingLeft or 0)-(self.paddingRight or 0))
local i=math.max(0,e-(self.paddingTop or 0)-(self.paddingBottom or 0))
if h<=0 or i<=0 then
return
end
local a=self.icon
if not a or a==""then
a=s.icon or""
end
a=tostring(a or"")
local n=0
local s=r
local e=l
if a~=""and h>0 then
local a=a:sub(1,1)
o.text(r,e,a,c,t)
if h>=3 then
o.text(r+1,e," ",c,t)
n=2
else
n=1
end
s=r+n
end
local a=math.max(0,h-n)
self:_refreshWrap(false,a)
if self.title and self.title~=""and i>0 and a>0 then
self:_renderLine(o,s,e,a,self.title,m,t)
e=e+1
i=i-1
end
if i>0 and a>0 then
local n=self._wrappedLines or{""}
local i=math.min(i,#n)
for i=1,i do
self:_renderLine(o,s,e,a,n[i],d,t)
e=e+1
end
end
end
function h:handleEvent(e,...)
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
local a,t,e=...
if self.dismissOnClick and self:containsPoint(t,e)then
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
function h:onFocusChanged()
end
function v:new(n,a)
a=a or{}
t(1,n,"table")
if a~=nil then
t(2,a,"table")
end
local i=o(a)or{}
i.focusable=false
i.width=math.max(3,math.floor(i.width or 8))
i.height=math.max(3,math.floor(i.height or 5))
local t=setmetatable({},v)
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
function v:_cancelTick()
if self._tickTimer then
if T.cancelTimer then
pcall(T.cancelTimer,self._tickTimer)
end
self._tickTimer=nil
end
end
function v:_scheduleTick()
self:_cancelTick()
if self._paused then
return
end
if not self.speed or self.speed<=0 then
return
end
self._tickTimer=T.startTimer(self.speed)
end
function v:start()
if not self._paused then
return
end
self._paused=false
self:_scheduleTick()
end
function v:stop()
if self._paused then
return
end
self._paused=true
self:_cancelTick()
end
function v:setSpeed(e)
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
function v:setDirection(e)
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
function v:setSegments(e)
if e==nil then
return
end
local e=math.max(3,math.floor(e))
if e~=self.segmentCount then
self.segmentCount=e
self._phase=self._phase%e
end
end
function v:setThickness(e)
if e==nil then
return
end
local e=math.max(1,math.floor(e))
self.thickness=e
end
function v:setRadius(e)
if e==nil then
self.radiusPixels=nil
return
end
local e=math.max(2,math.floor(e))
self.radiusPixels=e
end
function v:setColor(e)
if e==nil then
return
end
t(1,e,"number")
self.color=e
end
function v:setSecondaryColor(e)
if e==nil then
self.secondaryColor=nil
return
end
t(1,e,"number")
self.secondaryColor=e
end
function v:setTertiaryColor(e)
if e==nil then
self.tertiaryColor=nil
return
end
t(1,e,"number")
self.tertiaryColor=e
end
function v:setTrailColor(e)
if e==nil then
self.trailColor=nil
return
end
t(1,e,"number")
self.trailColor=e
end
function v:setTrailPalette(e)
if e~=nil then
t(1,e,"table")
end
self.trailPalette=e and o(e)or nil
end
function v:setFadeSteps(e)
if e==nil then
return
end
local e=math.max(0,math.floor(e))
self.fadeSteps=e
end
function v:_computeTrailColors()
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
function v:draw(h,d)
if not self.visible then
return
end
local n,o,a,t=self:getAbsoluteRect()
if a<=0 or t<=0 then
return
end
local e=self.bg or self.app.background
i(h,n,o,a,t,e,e)
_(h,n,o,a,t)
if self.border then
p(d,n,o,a,t,self.border,e)
end
local r=(self.border and self.border.left)and 1 or 0
local c=(self.border and self.border.right)and 1 or 0
local l=(self.border and self.border.top)and 1 or 0
local u=(self.border and self.border.bottom)and 1 or 0
local n=n+r
local s=o+l
local o=math.max(0,a-r-c)
local a=math.max(0,t-l-u)
if o<=0 or a<=0 then
return
end
i(h,n,s,o,a,e,e)
local c=n+(o-1)/2
local u=s+(a-1)/2
local i=math.floor(math.min(o,a)/2)
local t=self.radiusPixels and math.floor(self.radiusPixels)or i
if t>i then
t=i
end
if t<1 then
t=1
end
local h=math.max(1,math.min(math.floor(self.thickness or 1),t))
local i=t+.35
local t=math.max(0,t-h+.35)
local m=i*i
local w=t*t
local t=math.max(3,math.floor(self.segmentCount or 12))
local h=self._phase%t
local f=self.direction>=0 and 1 or-1
local r=math.pi*2
local y=self:_computeTrailColors()
for a=0,a-1 do
local l=s+a
local a=l-u
for o=0,o-1 do
local n=n+o
local i=n-c
local s=i*i+a*a
local o=e
if s<=m and s>=w then
local a=math.atan(a,i)
if a<0 then
a=a+r
end
local i=math.floor(a/r*t)%t
local a
if f>=0 then
a=(h-i)%t
else
a=(i-h)%t
end
if a==0 then
o=self.color or e
else
local t=math.floor(a+1e-4)
if t<1 then
t=1
end
o=y[t]or e
end
end
d.pixel(n,l,o)
end
end
end
function v:handleEvent(a,...)
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
local function U(e)
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
self.border=I(a.border)
self.focusable=a.focusable==true
self._focused=false
self.constraints=nil
C("width",self.width)
C("height",self.height)
if a.constraints~=nil then
self.constraints=P(a.constraints)
local e,t=self:_applySizeConstraints(self.width,self.height)
self.width=e
self.height=t
end
end
function n:setSize(t,e)
C("width",t)
C("height",e)
local t,e=self:_applySizeConstraints(t,e)
self.width=t
self.height=e
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
local function a(e,t)
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
local o=a(t.width,"width")
local a=a(t.height,"height")
local i=e and e.width or nil
local n=e and e.height or nil
if not o and t.widthPercent and i then
o=math.max(1,math.floor(i*t.widthPercent+.5))
end
if not a and t.heightPercent and n then
a=math.max(1,math.floor(n*t.heightPercent+.5))
end
local o=o or self.width
local a=a or self.height
local o,a=self:_applySizeConstraints(o,a)
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
local a=self.x
local e=self.y
local o=h(t.centerX,"x",i,self.width,o)
if o then
a=o
end
local t=h(t.centerY,"y",n,self.height,s)
if t then
e=t
end
if a~=self.x or e~=self.y then
self:setPosition(a,e)
end
end
function n:_applySizeConstraints(e,t)
local a=math.floor(e)
local t=math.floor(t)
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
function n:setConstraints(e)
if e==nil or e==false then
self.constraints=nil
else
self.constraints=P(e)
end
local e,t=self:_applySizeConstraints(self.width,self.height)
if e~=self.width or t~=self.height then
self:setSize(e,t)
end
self:_applyConstraintLayout()
end
local function F(e)
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
local a=F(e.width)
if a~=nil then
t.width=a
end
local a=F(e.height)
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
function n:setPosition(a,e)
t(1,a,"number")
t(2,e,"number")
self.x=math.floor(a)
self.y=math.floor(e)
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
self.border=I(true)
return
end
t(1,e,"table","boolean")
self.border=I(e)
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
local t,e=U(self)
return t,e,self.width,self.height
end
function n:containsPoint(o,a)
local t,e,n,i=self:getAbsoluteRect()
return o>=t and o<t+n and a>=e and a<e+i
end
function n:draw(e,e)
error("draw needs implementation for widget",2)
end
function n:handleEvent(e,...)
return false
end
function q:new(a,t)
local e=setmetatable({},q)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function q:addChild(e)
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
function q:_applyConstraintsToChildren()
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
function q:setSize(e,t)
n.setSize(self,e,t)
self:_applyConstraintsToChildren()
end
function q:removeChild(e)
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
local function C(a)
local t={}
for e=1,#a do
t[e]=a[e]
end
return t
end
local function F(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function q:getChildren()
return C(self._children)
end
function q:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function q:draw(h,l)
if not self.visible then
return
end
local s,t,a,o=self:getAbsoluteRect()
local n=self.bg or self.app.background
local d,u=s+1,t+1
local e=math.max(0,a-2)
local r=math.max(0,o-2)
if e>0 and r>0 then
i(h,d,u,e,r,n,n)
elseif a>0 and o>0 then
i(h,s,t,a,o,n,n)
end
_(h,s,t,a,o)
local i=self.title
if type(i)=="string"and#i>0 then
local a=e>0 and e or a
local s=e>0 and d or s
local t=(o>2)and(t+1)or t
if a>0 then
local e=i
if#e>a then
e=e:sub(1,a)
end
if#e<a then
e=e..string.rep(" ",a-#e)
end
h.text(s,t,e,self.fg,n)
end
end
if self.border then
p(l,s,t,a,o,self.border,n)
end
local e=C(self._children)
F(e)
for t=1,#e do
e[t]:draw(h,l)
end
end
function q:handleEvent(t,...)
if not self.visible then
return false
end
if n.handleEvent(self,t,...)then
return true
end
local e=C(self._children)
F(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function d:new(e,t)
t=t or{}
local e=q.new(q,e,t)
setmetatable(e,d)
e.draggable=t.draggable~=false
e.resizable=t.resizable~=false
e.closable=t.closable~=false
e.maximizable=t.maximizable~=false
e._titleBar=X(t.titleBar,nil)
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
function d:_refreshTitleBarState()
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
function d:_invalidateTitleLayout()
self._titleLayoutCache=nil
self._titleButtonRects=nil
end
function d:_computeTitleLayout()
local i=self:_getVisibleTitleBarHeight()
local e=self._titleBar
if i<=0 or not e or not e.enabled then
self:_invalidateTitleLayout()
return nil
end
local e,o=U(self)
local a,n=A(self)
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
local i=3
local s=1
local a=t+a-1
local function n(n)
if a-i+1<t then
return nil
end
local t=a
local i=t-i+1
local t={x1=i,y1=o,x2=t,y2=o}
e.buttonRects[n]=t
e.buttonOrder[#e.buttonOrder+1]=n
a=i-s
return t
end
if self.closable then
n("close")
end
if self.maximizable then
n("maximize")
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
function d:_hitTestTitleButton(a,t)
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
function d:_fillTitleBarPixels(t,e,o)
if not t or not e then
return
end
local a=(e.barX-1)*2+1
local n=(e.barY-1)*3+1
local i=e.barWidth*2
local e=math.min(e.barHeight*3,self.height*3)
for e=0,e-1 do
for i=0,i-1 do
t.pixel(a+i,n+e,o)
end
end
end
function d:_hitTestResize(t,s)
if not self.resizable then
return nil
end
local o,e=U(self)
local n=o+math.max(0,self.width-1)
local i=e+math.max(0,self.height-1)
local a=1
if self.border and self.border.thickness then
a=math.max(1,math.floor(self.border.thickness))
end
local e={}
local n=t>=n-a+1 and t<=n
local t=t>=o and t<=o+a-1
if n then
e.right=true
elseif t then
e.left=true
end
if s>=i-a+1 and s<=i then
e.bottom=true
end
if not e.right and not e.left and not e.bottom then
return nil
end
return e
end
function d:_beginResize(t,a,i,o,e)
if not e then
return
end
self:_restoreFromMaximize()
self._resizing=true
self._resizeSource=t
self._resizeIdentifier=a
self._resizeEdges=e
local e=self.constraints or{}
self._resizeStart={
pointerX=i,
pointerY=o,
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
function d:_updateResize(a,t)
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
function d:_endResize()
self._resizing=false
self._resizeSource=nil
self._resizeIdentifier=nil
self._resizeEdges=nil
self._resizeStart=nil
end
function d:_restoreFromMaximize()
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
function d:_computeMaximizedGeometry()
local e=self.parent
if e then
local t,i,a,o=A(e)
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
function d:maximize()
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
function d:restore()
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
function d:toggleMaximize()
if self._isMaximized then
self:restore()
else
self:maximize()
end
end
function d:close()
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
function d:_getVisibleTitleBarHeight()
local t=self._titleBar
if not t or not t.enabled then
return 0
end
local a,a,a,a,a,e=A(self)
if e<=0 then
return 0
end
local t=math.max(1,math.floor(t.height or 1))
if t>e then
t=e
end
return t
end
function d:setTitleBar(e)
self._titleBar=X(e,nil)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function d:getTitleBar()
return o(self._titleBar)
end
function d:setDraggable(e)
self.draggable=not not e
end
function d:isDraggable()
return not not self.draggable
end
function d:setResizable(e)
self.resizable=not not e
self:_invalidateTitleLayout()
end
function d:isResizable()
return not not self.resizable
end
function d:setClosable(e)
self.closable=not not e
self:_invalidateTitleLayout()
end
function d:isClosable()
return not not self.closable
end
function d:setMaximizable(e)
self.maximizable=not not e
self:_invalidateTitleLayout()
end
function d:isMaximizable()
return not not self.maximizable
end
function d:setTitle(e)
q.setTitle(self,e)
self:_invalidateTitleLayout()
end
function d:getContentOffset()
local e,a,t=A(self)
local a=self:_getVisibleTitleBarHeight()
return e,t+a
end
function d:setSize(e,t)
q.setSize(self,e,t)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function d:setBorder(e)
n.setBorder(self,e)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function d:bringToFront()
local e=self.parent
if not e then
return
end
e._orderCounter=(e._orderCounter or 0)+1
self._orderIndex=e._orderCounter
end
function d:_pointInTitleBar(t,a)
local e=self:_computeTitleLayout()
if not e then
return false
end
if self._titleButtonRects then
for o,e in pairs(self._titleButtonRects)do
if t>=e.x1 and t<=e.x2 and a>=e.y1 and a<=e.y2 then
return false
end
end
end
local i=e.barX
local o=e.barY
local n=i+math.max(0,e.barWidth-1)
local e=o+math.max(0,e.barHeight-1)
return t>=i and t<=n and a>=o and a<=e
end
function d:_beginDrag(n,i,o,a)
self:_restoreFromMaximize()
local e,t=U(self)
self._dragging=true
self._dragSource=n
self._dragIdentifier=i
self._dragOffsetX=o-e
self._dragOffsetY=a-t
self:bringToFront()
if self.app then
self.app:setFocus(nil)
end
end
function d:_updateDragPosition(e,o)
if not self._dragging then
return
end
local t=self.parent
local a=self._dragOffsetX or 0
local i=self._dragOffsetY or 0
local e=e-a
local a=o-i
if t then
local o,i=U(t)
local n=o
local s=i
local h=o+math.max(0,t.width-self.width)
local t=i+math.max(0,t.height-self.height)
e=Z(e,n,h)
a=Z(a,s,t)
local e=e-o+1
local t=a-i+1
self:setPosition(e,t)
else
self:setPosition(e,a)
end
end
function d:_endDrag()
self._dragging=false
self._dragSource=nil
self._dragIdentifier=nil
self._dragOffsetX=0
self._dragOffsetY=0
end
function d:draw(n,u)
if not self.visible then
return
end
local d,r,l,c=self:getAbsoluteRect()
local s,h,o,h,a,t=A(self)
local h=d+s
local o=r+o
local s=self.bg or self.app.background
if a>0 and t>0 then
i(n,h,o,a,t,s,s)
else
i(n,d,r,l,c,s,s)
end
_(n,d,r,l,c)
local h=self._titleBar
local t=nil
local o=nil
if h then
t=self:_computeTitleLayout()
if t then
o=h.bg or s
local r=h.fg or self.fg or e.white
if t.textWidth>0 then
i(n,t.textX,t.textBaseline,t.textWidth,t.barHeight,o,o)
end
local i=t.titleWidth or 0
local a=self.title or""
if i>0 and a~=""then
if#a>i then
a=a:sub(1,i)
end
local e=i-#a
local s=h.align or"left"
local i=a
if e>0 then
if s=="center"then
local t=math.floor(e/2)
local e=e-t
i=string.rep(" ",t)..a..string.rep(" ",e)
elseif s=="right"then
i=string.rep(" ",e)..a
else
i=a..string.rep(" ",e)
end
end
n.text(t.titleStart,t.textBaseline,i,r,o)
end
local a=h.fg or self.fg or e.white
if self.maximizable then
local e=t.buttonRects.maximize
if e then
local t=t.maximizeState=="restore"and"[-]"or"[+]"
n.text(e.x1,e.y1,t,a,o)
end
end
if self.closable then
local e=t.buttonRects.close
if e then
n.text(e.x1,e.y1,"[X]",a,o)
end
end
end
end
if self.border then
p(u,d,r,l,c,self.border,s)
if t and o then
self:_fillTitleBarPixels(u,t,o)
end
end
local e=C(self._children)
F(e)
for t=1,#e do
e[t]:draw(n,u)
end
end
function d:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
local o=self:_hitTestTitleButton(e,t)
if o=="close"and self.closable then
self:close()
return true
elseif o=="maximize"and self.maximizable then
self:toggleMaximize()
return true
end
local o=self:_hitTestResize(e,t)
if o then
self:_beginResize("mouse",a,e,t,o)
return true
end
if self.draggable and self:_pointInTitleBar(e,t)then
self:_beginDrag("mouse",a,e,t)
return true
end
elseif e=="mouse_drag"then
local a,t,e=...
if self._resizing and self._resizeSource=="mouse"and a==self._resizeIdentifier then
self:_updateResize(t,e)
return true
end
if self._dragging and self._dragSource=="mouse"and a==self._dragIdentifier then
self:_updateDragPosition(t,e)
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
self:_beginResize("monitor",o,t,e,a)
return true
end
if self.draggable and self:_pointInTitleBar(t,e)then
self:_beginDrag("monitor",o,t,e)
return true
end
elseif e=="monitor_drag"then
local t,e,a=...
if self._resizing and self._resizeSource=="monitor"and t==self._resizeIdentifier then
self:_updateResize(e,a)
return true
end
if self._dragging and self._dragSource=="monitor"and t==self._dragIdentifier then
self:_updateDragPosition(e,a)
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
return q.handleEvent(self,e,...)
end
function N:new(a,e)
local t=setmetatable({},N)
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
function N:setLabel(e)
t(1,e,"string")
self.label=e
end
function N:setOnClick(e)
if e~=nil then
t(1,e,"function")
end
self.onClick=e
end
function N:draw(h,c)
if not self.visible then
return
end
local n,o,a,t=self:getAbsoluteRect()
local r=self.bg or e.gray
local s=self.fg or e.white
local e=r
local d=s
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=n+1,o+1
local s=math.max(0,a-2)
local r=math.max(0,t-2)
if s>0 and r>0 then
i(h,l,u,s,r,e,e)
else
i(h,n,o,a,t,e,e)
end
_(h,n,o,a,t)
if self.border then
p(c,n,o,a,t,self.border,e)
end
local t=self.label or""
local a=s>0 and s or a
if#t>a then
t=t:sub(1,a)
end
local i=0
if a>#t then
i=math.floor((a-#t)/2)
end
local t=string.rep(" ",i)..t
if#t<a then
t=t..string.rep(" ",a-#t)
end
local i=s>0 and l or n
local a
if r>0 then
a=u+math.floor((r-1)/2)
else
a=o
end
h.text(i,a,t,d,e)
end
function N:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(nil)
self._pressed=true
if self.onPress then
self.onPress(self,a,e,t)
end
return true
end
elseif e=="mouse_drag"then
local a,e,t=...
if self._pressed then
if not self:containsPoint(e,t)then
self._pressed=false
if self.onRelease then
self.onRelease(self,a,e,t)
end
return false
end
return true
end
elseif e=="mouse_up"then
local a,e,t=...
if self._pressed then
self._pressed=false
if self:containsPoint(e,t)then
self.app:setFocus(nil)
if self.onRelease then
self.onRelease(self,a,e,t)
end
if self.onClick then
self.onClick(self,a,e,t)
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
function E:new(i,e)
e=e or{}
local a=o(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},E)
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
function E:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-a)
local i=math.max(0,self.height-t-e)
return o,a,t,e,n,i
end
function E:_wrapLine(t,a,e)
if a<=0 then
e[#e+1]=""
return
end
t=t:gsub("\r","")
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
function E:_updateLines(e)
local t=tostring(self.text or"")
local a=not not self.wrap
local i,i,i,i,o=self:_getInnerMetrics()
if not e and self._lastText==t and self._lastWrap==a and self._lastInnerWidth==o then
return
end
local e={}
if t==""then
e[1]=""
else
local i=1
while true do
local n=t:find("\n",i,true)
if not n then
local t=t:sub(i)
t=t:gsub("\r","")
if a then
self:_wrapLine(t,o,e)
else
e[#e+1]=t
end
break
end
local t=t:sub(i,n-1)
t=t:gsub("\r","")
if a then
self:_wrapLine(t,o,e)
else
e[#e+1]=t
end
i=n+1
end
end
if#e==0 then
e[1]=""
end
self._lines=e
self._lastText=t
self._lastWrap=a
self._lastInnerWidth=o
end
function E:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function E:getText()
return self.text
end
function E:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function E:isWrapping()
return self.wrap
end
function E:setHorizontalAlign(e)
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
function E:setVerticalAlign(a)
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
function E:setSize(t,e)
n.setSize(self,t,e)
self:_updateLines(true)
end
function E:setBorder(e)
n.setBorder(self,e)
self:_updateLines(true)
end
function E:draw(d,c)
if not self.visible then
return
end
local s,n,l,r=self:getAbsoluteRect()
local h=self.bg or self.app.background or e.black
local m=self.fg or e.white
i(d,s,n,l,r,h,h)
_(d,s,n,l,r)
local e,a,t,a,o,i=self:_getInnerMetrics()
local a=s+e
local f=n+t
self:_updateLines(false)
local u=self._lines or{""}
local t=#u
if t==0 then
u={""}
t=1
end
if o>0 and i>0 then
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
local i=f+t
for e=0,e-1 do
local e=u[n+e]or""
if#e>o then
e=e:sub(1,o)
end
local t=a
if self.align=="center"then
t=a+math.floor((o-#e)/2)
elseif self.align=="right"then
t=a+o-#e
end
if t<a then
t=a
end
if t+#e>a+o then
t=a+o-#e
end
if#e>0 then
d.text(t,i,e,m,h)
end
i=i+1
end
end
if self.border then
p(c,s,n,l,r,self.border,h)
end
end
function z:new(n,t)
t=t or{}
local o=o(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},z)
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
function z:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function z:_setState(t,e,o)
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
function z:setLabel(e)
t(1,e,"string")
self.label=e
end
function z:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function z:setAllowIndeterminate(e)
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
function z:setChecked(e)
t(1,e,"boolean")
self:_setState(e,false,false)
end
function z:isChecked()
return self.checked
end
function z:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
t(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function z:isIndeterminate()
return self.indeterminate
end
function z:toggle()
self:_activate()
end
function z:_activate()
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
function z:draw(d,a)
if not self.visible then
return
end
local h,s,t,n=self:getAbsoluteRect()
local o=self.bg or e.black
local e=self.fg or e.white
local o=o
local r=e
if self:isFocused()then
o=self.focusBg or o
r=self.focusFg or r
end
i(d,h,s,t,n,o,o)
_(d,h,s,t,n)
if self.border then
p(a,h,s,t,n,self.border,o)
end
if t<=0 or n<=0 then
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
local t=s+math.floor((n-1)/2)
d.text(h,t,e,r,o)
end
function z:handleEvent(e,...)
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
function b:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},b)
a:_init_base(i,o)
a.focusable=true
local o=t.value
if o==nil then
o=t.on
end
a.value=not not o
a.labelOn=(t and t.labelOn)or"On"
a.labelOff=(t and t.labelOff)or"Off"
a.trackColorOn=(t and t.trackColorOn)or(t and t.onColor)or e.green
a.trackColorOff=(t and t.trackColorOff)or(t and t.offColor)or e.red
a.trackColorDisabled=(t and t.trackColorDisabled)or e.lightGray
a.thumbColor=(t and t.thumbColor)or e.white
a.knobColorDisabled=(t and t.knobColorDisabled)or e.lightGray
a.onLabelColor=t and t.onLabelColor or nil
a.offLabelColor=t and t.offLabelColor or nil
a.focusBg=t and t.focusBg or e.lightGray
a.focusFg=t and t.focusFg or e.black
a.focusOutline=t and t.focusOutline or a.focusFg or e.white
a.showLabel=not(t and t.showLabel==false)
a.disabled=not not(t and t.disabled)
a.onChange=t and t.onChange or nil
a.knobMargin=math.max(0,math.floor(t.knobMargin or 0))
if t.knobWidth~=nil then
if type(t.knobWidth)~="number"then
error("Toggle knobWidth must be a number",3)
end
a.knobWidth=math.max(1,math.floor(t.knobWidth))
else
a.knobWidth=nil
end
if t.transitionDuration~=nil then
if type(t.transitionDuration)~="number"then
error("Toggle transitionDuration must be a number",3)
end
a.transitionDuration=math.max(0,t.transitionDuration)
else
a.transitionDuration=.2
end
local e=t.transitionEasing
if type(e)=="string"then
e=H[e]or H.easeInOutQuad
elseif type(e)~="function"then
e=H.easeInOutQuad
end
a.transitionEasing=e
a._thumbProgress=a.value and 1 or 0
a._animationHandle=nil
return a
end
function b:_cancelAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
end
function b:_setThumbProgress(e)
if e==nil then
e=self.value and 1 or 0
end
if e<0 then
e=0
elseif e>1 then
e=1
end
self._thumbProgress=e
end
function b:_animateThumb(e)
e=math.max(0,math.min(1,e or(self.value and 1 or 0)))
if self.disabled then
self:_cancelAnimation()
self:_setThumbProgress(e)
return
end
if not self.app or self.transitionDuration<=0 then
self:_cancelAnimation()
self:_setThumbProgress(e)
return
end
local t=self._thumbProgress
if t==nil then
t=self.value and 1 or 0
end
if math.abs(t-e)<1e-4 then
self:_cancelAnimation()
self:_setThumbProgress(e)
return
end
self:_cancelAnimation()
local a=e-t
local o=self.transitionEasing or H.easeInOutQuad
self._animationHandle=self.app:animate({
duration=self.transitionDuration,
easing=o,
update=function(e)
local e=t+a*e
if e<0 then
e=0
elseif e>1 then
e=1
end
self._thumbProgress=e
end,
onComplete=function()
self._thumbProgress=e
self._animationHandle=nil
end,
onCancel=function()
self._animationHandle=nil
end
})
end
function b:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function b:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function b:setValue(e,t)
e=not not e
if self.value==e then
self:_animateThumb(e and 1 or 0)
return
end
self.value=e
self:_animateThumb(e and 1 or 0)
if not t then
self:_emitChange()
end
end
function b:isOn()
return self.value
end
function b:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function b:setLabels(e,a)
if e~=nil then
t(1,e,"string")
self.labelOn=e
end
if a~=nil then
t(2,a,"string")
self.labelOff=a
end
end
function b:setShowLabel(e)
self.showLabel=not not e
end
function b:setDisabled(e)
e=not not e
if self.disabled==e then
return
end
self.disabled=e
if e then
self:_cancelAnimation()
self:_setThumbProgress(self.value and 1 or 0)
else
self:_animateThumb(self.value and 1 or 0)
end
end
function b:isDisabled()
return self.disabled
end
function b:setColors(s,h,n,i,o,e,a)
if s~=nil then
t(1,s,"number")
self.trackColorOn=s
end
if h~=nil then
t(2,h,"number")
self.trackColorOff=h
end
if n~=nil then
t(3,n,"number")
self.thumbColor=n
end
if i~=nil then
t(4,i,"number")
self.onLabelColor=i
end
if o~=nil then
t(5,o,"number")
self.offLabelColor=o
end
if e~=nil then
t(6,e,"number")
self.trackColorDisabled=e
end
if a~=nil then
t(7,a,"number")
self.knobColorDisabled=a
end
end
function b:setTransition(a,e)
if a~=nil then
t(1,a,"number")
self.transitionDuration=math.max(0,a)
end
if e~=nil then
if type(e)=="string"then
local t=H[e]
if not t then
error("Unknown easing '"..e.."'",2)
end
self.transitionEasing=t
elseif type(e)=="function"then
self.transitionEasing=e
else
error("Toggle transition easing must be a function or easing name",2)
end
end
end
function b:setKnobStyle(a,e)
if a~=nil then
t(1,a,"number")
self.knobWidth=math.max(1,math.floor(a))
end
if e~=nil then
t(2,e,"number")
self.knobMargin=math.max(0,math.floor(e))
end
end
function b:draw(l,d)
if not self.visible then
return
end
local t,o,s,n=self:getAbsoluteRect()
local a=self.bg or e.black
local y=self.fg or e.white
i(l,t,o,s,n,a,a)
_(l,t,o,s,n)
if self.border then
p(d,t,o,s,n,self.border,a)
end
local a,r,n,r,h,s=A(self)
if h<=0 or s<=0 then
return
end
local a=t+a
local n=o+n
local t=h
local o=s
local s=self._thumbProgress
if s==nil then
s=self.value and 1 or 0
end
if s<0 then
s=0
elseif s>1 then
s=1
end
local w=self.trackColorOn or e.green
local f=self.trackColorOff or e.red
local c=self.trackColorDisabled or f
local h=self.disabled and c or f
i(l,a,n,t,o,h,h)
local h=math.floor(t*s+.5)
if h>0 then
if h>t then
h=t
end
local e=self.disabled and c or w
i(l,a,n,h,o,e,e)
end
local r=self.knobMargin or 0
if r<0 then
r=0
end
if r*2>=t then
r=math.max(0,math.floor((t-1)/2))
end
local u=math.max(1,t-r*2)
local h=self.knobWidth and math.max(1,math.min(math.floor(self.knobWidth),u))
if not h then
h=math.max(1,math.floor(u/2))
if u>=4 then
h=math.max(2,h)
end
end
local m=math.max(0,u-h)
local u=math.floor(m*s+.5)
if u>m then
u=m
end
local u=a+r+u
if u+h-1>a+t-1 then
u=a+t-h
elseif u<a+r then
u=a+r
end
local r=self.thumbColor or e.white
if self.disabled then
r=self.knobColorDisabled or r
end
i(l,u,n,h,o,r,r)
local i=""
if self.showLabel then
i=self.value and(self.labelOn or"On")or(self.labelOff or"Off")
end
if i~=""and o>0 then
local e=math.max(0,t-2)
if e>0 and#i>e then
i=i:sub(1,e)
end
local r=self.value and(self.onLabelColor or y)or(self.offLabelColor or y)
local h
if s>=.5 then
h=self.disabled and c or w
else
h=self.disabled and c or f
end
local o=n+math.floor((o-1)/2)
local e=a+math.floor((t-#i)/2)
if e<a then
e=a
end
if e+#i-1>a+t-1 then
e=a+t-#i
end
if#i>0 then
l.text(e,o,i,r,h)
end
end
if self:isFocused()then
local e=self.focusOutline or self.focusFg or e.white
if t>0 then
for t=0,t-1 do
d.pixel(a+t,n,e)
if o>1 then
d.pixel(a+t,n+o-1,e)
end
end
end
if o>0 then
for o=0,o-1 do
d.pixel(a,n+o,e)
if t>1 then
d.pixel(a+t-1,n+o,e)
end
end
end
end
if self.disabled then
local i=self.knobColorDisabled or e.lightGray
for e=0,t-1,2 do
local e=a+e
d.pixel(e,n,i)
if o>1 then
d.pixel(e,n+o-1,i)
end
end
end
end
function b:handleEvent(e,...)
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
function g:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},g)
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
t._dotChar=ae
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
function g:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function g:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function g:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function g:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function g:setLabel(e)
t(1,e,"string")
self.label=e
end
function g:setValue(e)
self.value=e
end
function g:getValue()
return self.value
end
function g:setGroup(e)
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
function g:getGroup()
return self.group
end
function g:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function g:setSelected(e)
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
function g:isSelected()
return self.selected
end
function g:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function g:draw(h,d)
if not self.visible then
return
end
local s,n,t,o=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local r=e
if self:isFocused()then
a=self.focusBg or a
r=self.focusFg or r
end
i(h,s,n,t,o,a,a)
_(h,s,n,t,o)
if self.border then
p(d,s,n,t,o,self.border,a)
end
local i=n+math.floor((o-1)/2)
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
h.text(s,i,e,r,a)
end
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
local a,t,e=...
if self:containsPoint(t,e)then
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
function k:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},k)
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
function k:_clampValue(e)
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
function k:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function k:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=H.linear,
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
function k:setRange(e,a)
t(1,e,"number")
t(2,a,"number")
if a<=e then
error("ProgressBar max must be greater than min",2)
end
self.min=e
self.max=a
self.value=self:_clampValue(self.value)
end
function k:getRange()
return self.min,self.max
end
function k:setValue(e)
if self.indeterminate then
return
end
t(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function k:getValue()
return self.value
end
function k:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function k:setIndeterminate(e)
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
function k:isIndeterminate()
return self.indeterminate
end
function k:setLabel(e)
if e~=nil then
t(1,e,"string")
end
self.label=e
end
function k:setShowPercent(e)
self.showPercent=not not e
end
function k:setColors(e,a,o)
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
function k:draw(o,d)
if not self.visible then
return
end
local a,t,s,r=self:getAbsoluteRect()
local h=self.trackColor or(self.bg or e.gray)
local n=self.fillColor or e.lightBlue
local c=self.textColor or(self.fg or e.white)
i(o,a,t,s,r,h,h)
_(o,a,t,s,r)
if self.border then
p(d,a,t,s,r,self.border,h)
end
local e=self.border
local u=(e and e.left)and 1 or 0
local m=(e and e.right)and 1 or 0
local l=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+u
local d=t+l
local t=math.max(0,s-u-m)
local s=math.max(0,r-l-e)
if t<=0 or s<=0 then
return
end
i(o,a,d,t,s,h,h)
local l=0
local u=0
local r=0
if self.indeterminate then
r=math.max(1,math.floor(t/3))
if r>t then
r=t
end
local t=t-r
local e=self._indeterminateProgress or 0
if e<0 then e=0 end
if e>1 then e=1 end
u=math.floor(t*e+.5)
i(o,a+u,d,r,s,n,n)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
i(o,a,d,l,s,n,n)
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
if e~=""and s>0 then
if#e>t then
e=e:sub(1,t)
end
local d=d+math.floor((s-1)/2)
local i=a+math.floor((t-#e)/2)
if i<a then
i=a
end
for t=1,#e do
local s=e:sub(t,t)
local a=(i-a)+(t-1)
local e=h
if self.indeterminate then
if a>=u and a<u+r then
e=n
end
else
if a<l then
e=n
end
end
o.text(i+t-1,d,s,c,e)
end
end
end
function k:handleEvent(e,...)
return false
end
function S:new(i,t)
t=t or{}
local e=o(t)or{}
e.focusable=false
e.width=math.max(1,math.floor(e.width or 10))
e.height=math.max(1,math.floor(e.height or 4))
local a=setmetatable({},S)
a:_init_base(i,e)
a.onDraw=t.onDraw
a.clear=t.clear~=false
return a
end
function S:setOnDraw(e)
if e~=nil and type(e)~="function"then
error("FreeDraw:setOnDraw expects a function or nil",2)
end
self.onDraw=e
end
function S:setClear(e)
self.clear=not not e
end
function S:draw(h,r)
if not self.visible then
return
end
local n,s,a,o=self:getAbsoluteRect()
if a<=0 or o<=0 then
return
end
if self.clear then
local e=self.bg or self.app.background or e.black
i(h,n,s,a,o,e,e)
end
if self.onDraw then
local t=self._ctx or{}
t.app=self.app
t.box=self.app.box
t.textLayer=h
t.pixelLayer=r
t.x=n
t.y=s
t.width=a
t.height=o
local d=self.bg or self.app.background or e.black
local l=self.fg or e.white
t.fill=function(e)
local e=e or d
i(h,n,s,a,o,e,e)
end
t.write=function(i,r,e,c,u)
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
h.text(n+i-1,s+r-1,e,c or l,u or d)
end
t.pixel=function(e,t,i)
local e=math.floor(e or 1)
local t=math.floor(t or 1)
if e<1 or e>a or t<1 or t>o then
return
end
r.pixel(n+e-1,s+t-1,i or l)
end
self._ctx=t
self.onDraw(self,t)
end
if self.border then
p(r,n,s,a,o,self.border,self.bg or self.app.background or e.black)
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
local i=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,n=self:getAbsoluteRect()
local i=math.max(0,self.width-a-i)
local s=math.max(0,self.height-t-e)
local o=o+a
local n=n+t
return o,n,i,s,a,t,e
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
function l:setColors(a,o,e)
if a~=nil then
t(1,a,"number")
self.trackColor=a
end
if o~=nil then
t(2,o,"number")
self.fillColor=o
end
if e~=nil then
t(3,e,"number")
self.handleColor=e
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
function l:_positionFromPoint(a)
local t,o,e=self:_getInnerMetrics()
if e<=0 then
return nil,e
end
local t=math.floor(a-t)
if t<0 then
t=0
elseif t>e-1 then
t=e-1
end
return t,e
end
function l:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local s=self:_valueToPosition(self.lowerValue,a)
local n=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local i=math.abs(t-s)
local o=math.abs(t-n)
if i==o then
if t>n then
e="upper"
elseif t<s then
e="lower"
end
elseif i<o then
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
function l:draw(n,f)
if not self.visible then
return
end
local l,d,u,h=self:getAbsoluteRect()
local s=self.bg or self.app.background or e.black
i(n,l,d,u,h,s,s)
_(n,l,d,u,h)
local a,c,t,r=self:_getInnerMetrics()
if t<=0 or r<=0 then
if self.border then
p(f,l,d,u,h,self.border,s)
end
return
end
local o
local m=nil
if self.showValue and r>=2 then
m=c
o=c+r-1
else
o=c+math.floor((r-1)/2)
end
i(n,a,o,t,1,self.trackColor,self.trackColor)
local c
if self:isFocused()then
c=self._activeHandle or self._focusedHandle
end
local function r(i,s)
if i<0 or i>=t then
return
end
local t=self.handleColor or e.white
if c and s==c then
t=self.fg or e.white
end
n.text(a+i,o," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local s=t-e+1
if s>0 then
i(n,a+e,o,s,1,self.fillColor,self.fillColor)
end
r(e,"lower")
r(t,"upper")
else
local t=self:_valueToPosition(self.value,t)
local e=t+1
if e>0 then
i(n,a,o,e,1,self.fillColor,self.fillColor)
end
r(t,"single")
end
if self.showValue and m then
local o=self:_formatDisplayValue()
if o and o~=""then
if#o>t then
o=o:sub(1,t)
end
local t=a+math.floor((t-#o)/2)
if t<a then
t=a
end
n.text(t,m,o,self.fg or e.white,s)
end
end
if self.border then
p(f,l,d,u,h,self.border,s)
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
function r:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},r)
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
t.scrollbar=R(a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_ensureSelectionVisible()
return t
end
function r:_normalizeColumns(e)
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
function r:_recomputeColumnMetrics()
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
function r:_ensureColumnsForData()
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
accessor=function(t)
if type(t)=="table"then
local e={}
local a=0
for o,t in pairs(t)do
a=a+1
if a>4 then
e[#e+1]="..."
break
end
e[#e+1]=tostring(o).."="..tostring(t)
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
function r:setColumns(e)
if e~=nil then
t(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function r:getColumns()
local t={}
for e=1,#self.columns do
t[e]=o(self.columns[e])
end
return t
end
function r:setData(e)
t(1,e,"table")
local a={}
for t=1,#e do
a[t]=e[t]
end
self.data=a
self:_ensureColumnsForData()
self:_refreshRows()
end
function r:getData()
local e={}
for t=1,#self.data do
e[t]=self.data[t]
end
return e
end
function r:_refreshRows()
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
function r:_getColumnById(e)
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
function r:_applySort(t,e,l)
local t=self:_getColumnById(t)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=e=="desc"and"desc"or"asc"
local u=self.sortDirection=="desc"
local s=t.comparator
table.sort(self._rows,function(d,n)
local h=self.data[d]
local i=self.data[n]
local a=r._resolveColumnValue(t,h)
local o=r._resolveColumnValue(t,i)
local e=0
if s then
local a,t=pcall(s,a,o,h,i,t)
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
return d<n
end
if u then
return e>0
end
return e<0
end)
if not l and self.onSort then
self.onSort(self,self.sortColumn,self.sortDirection)
end
self:_ensureSelectionVisible()
end
function r:setSort(e,a,t)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,a or self.sortDirection,t)
end
function r:getSort()
return self.sortColumn,self.sortDirection
end
function r:setOnSort(e)
if e~=nil then
t(1,e,"function")
end
self.onSort=e
end
function r:setScrollbar(t)
self.scrollbar=R(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function r:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function r:getSelectedIndex()
return self.selectedIndex
end
function r:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function r:setSelectedIndex(e,a)
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
function r:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function r:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local i=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local o=(e and e.bottom)and 1 or 0
local n,e=self:getAbsoluteRect()
local i=math.max(0,self.width-a-i)
local o=math.max(0,self.height-t-o)
local a=n+a
local e=e+t
return a,e,i,o
end
function r:_computeLayoutMetrics()
local i,s,e,a=self:_getInnerMetrics()
if e<=0 or a<=0 then
return{
innerX=i,
innerY=s,
innerWidth=e,
innerHeight=a,
headerHeight=0,
rowsHeight=0,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=i
}
end
local h=a>=1 and 1 or 0
local r=math.max(0,a-h)
local t,n=M(self.scrollbar,#self._rows,r,e)
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
innerX=i,
innerY=s,
innerWidth=e,
innerHeight=a,
headerHeight=h,
rowsHeight=r,
contentWidth=o,
scrollbarWidth=t,
scrollbarStyle=n,
scrollbarX=i+o
}
end
function r:_getRowsVisible()
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
function r:_clampScroll()
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
function r:_ensureSelectionVisible()
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
function r:_rowFromPoint(a,t)
if not self:containsPoint(a,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
local o=e.innerY+e.headerHeight
if t<o or t>=o+e.rowsHeight then
return nil
end
if a<e.innerX or a>=e.innerX+e.contentWidth then
return nil
end
local t=t-o
if t<0 or t>=e.rowsHeight then
return nil
end
local e=self.scrollOffset+t
if e<1 or e>#self._rows then
return nil
end
return e
end
function r:_columnFromPoint(a,t)
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
for i=1,#self.columns do
local o=math.max(1,math.min(self.columns[i].width,n))
if i==#self.columns then
o=e.innerX+e.contentWidth-t
end
if o<=0 then
break
end
if a>=t and a<t+o then
return self.columns[i],i
end
t=t+o
n=e.contentWidth-(t-e.innerX)
if n<=0 then
break
end
end
return nil
end
function r._resolveColumnValue(e,t)
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
function r:_formatCell(t,a,e)
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
function r:draw(a,g)
if not self.visible then
return
end
local c,u,m,f=self:getAbsoluteRect()
local s=self.bg or e.black
local b=self.fg or e.white
i(a,c,u,m,f,s,s)
_(a,c,u,m,f)
local t=self:_computeLayoutMetrics()
local n=t.innerWidth
local k=t.innerHeight
local o=t.contentWidth
if n<=0 or k<=0 or o<=0 then
if self.border then
p(g,c,u,m,f,self.border,s)
end
return
end
local n=t.innerX
local l=t.innerY
local y=t.headerHeight
local j=t.rowsHeight
local v=t.scrollbarWidth
local d=t.scrollbarStyle
local w=self.headerBg or s
local q=self.headerFg or b
if y>0 then
a.text(n,l,string.rep(" ",o),w,w)
local h=n
local s=o
for e=1,#self.columns do
local i=self.columns[e]
local t=math.max(1,math.min(i.width,s))
if e==#self.columns then
t=math.max(1,s)
end
if t<=0 then
break
end
local e=i.title or i.id
local r=""
if self.sortColumn==i.id then
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
a.text(h,l,e,q,w)
h=h+t
s=o-(h-n)
if s<=0 then
break
end
end
end
local y=l+y
local h=j
local w=self.rowBg or s
local b=self.rowFg or b
if h<=0 then
if v>0 then
local e=(d and d.background)or s
i(a,t.scrollbarX,l,v,k,e,e)
end
if self.border then
p(g,c,u,m,f,self.border,s)
end
return
end
if#self._rows==0 then
for e=0,h-1 do
local e=y+e
a.text(n,e,string.rep(" ",o),b,w)
end
if self.placeholder and self.placeholder~=""then
local t=self.placeholder
if#t>o then
t=t:sub(1,o)
end
local i=h>0 and math.min(h-1,math.floor(h/2))or 0
local i=y+i
local o=n+math.floor((o-#t)/2)
if o<n then
o=n
end
a.text(o,i,t,e.lightGray,w)
end
else
for i=0,h-1 do
local t=self.scrollOffset+i
local m=y+i
if t>#self._rows then
a.text(n,m,string.rep(" ",o),b,w)
else
local i=self._rows[t]
local l=self.data[i]
local u=self.allowRowSelection and t==self.selectedIndex
local s=w
local c=b
if u then
s=self.highlightBg or e.lightGray
c=self.highlightFg or e.black
elseif self.zebra and(t%2==0)then
s=self.zebraBg or s
end
local h=n
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
local e=r._resolveColumnValue(t,l)
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
local r=c
if t.color then
if type(t.color)=="number"then
r=t.color
elseif type(t.color)=="function"then
local t,e=pcall(t.color,e,l,t,u)
if t and type(e)=="number"then
r=e
end
end
end
a.text(h,m,e,r,s)
h=h+i
d=o-(h-n)
if d<=0 then
break
end
end
end
end
end
if v>0 then
local e=(d and d.background)or s
i(a,t.scrollbarX,l,v,k,e,e)
if d and h>0 then
local e=math.max(0,self.scrollOffset-1)
L(a,t.scrollbarX,y,h,#self._rows,h,e,d)
end
end
if self.border then
p(g,c,u,m,f,self.border,s)
end
end
function r:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=T.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=(e.buffer or"")..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function r:_searchForPrefix(e)
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
local a=r._resolveColumnValue(a,o)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function r:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function r:handleEvent(o,...)
if not self.visible then
return false
end
local function n(a,t)
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
local e=D(a,e.rowsHeight,#self._rows,e.rowsHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_clampScroll()
end
return true
end
end
local o=self:_columnFromPoint(a,t)
if o then
local e=self.sortDirection
if self.sortColumn==o.id then
e=e=="asc"and"desc"or"asc"
else
e="asc"
end
if o.sortable~=false then
self:setSort(o.id,e)
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
return n(e,t)
elseif o=="monitor_touch"then
local a,e,t=...
return n(e,t)
elseif o=="mouse_scroll"then
local e,a,t=...
if self:containsPoint(a,t)then
self.scrollOffset=self.scrollOffset+e
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
function u:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local a=setmetatable({},u)
a:_init_base(i,o)
a.focusable=true
a.highlightBg=(t and t.highlightBg)or e.lightGray
a.highlightFg=(t and t.highlightFg)or e.black
a.placeholder=(t and t.placeholder)or nil
a.indentWidth=math.max(1,math.floor((t and t.indentWidth)or 2))
local o=(t and t.toggleSymbols)or{}
a.toggleSymbols={
expanded=tostring(o.expanded or"-"),
collapsed=tostring(o.collapsed or"+"),
leaf=tostring(o.leaf or" ")
}
a.onSelect=t and t.onSelect or nil
a.onToggle=t and t.onToggle or nil
a.nodes={}
a._flatNodes={}
a.scrollOffset=1
a.selectedNode=nil
a._selectedIndex=0
a.typeSearchTimeout=(t and t.typeSearchTimeout)or .75
a._typeSearch={buffer="",lastTime=0}
if not a.border then
a.border=I(true)
end
a.scrollbar=R(t and t.scrollbar,a.bg or e.black,a.fg or e.white)
a:setNodes((t and t.nodes)or{})
return a
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
self.scrollbar=R(t,self.bg or e.black,self.fg or e.white)
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
local t={}
local function o(e,a)
for i=1,#e do
local e=e[i]
t[#t+1]={node=e,depth=a}
if e.expanded and e.children and#e.children>0 then
o(e.children,a+1)
end
end
end
o(self.nodes,0)
self._flatNodes=t
local e=self:_findVisibleIndex(self.selectedNode)
if e then
self._selectedIndex=e
elseif#t>0 then
self._selectedIndex=1
self.selectedNode=t[1].node
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
local t=self._flatNodes
for a=1,#t do
if t[a].node==e then
return a
end
end
return nil
end
function u:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-a)
local i=math.max(0,self.height-t-e)
return o,a,t,e,n,i
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
local i=i+a
local s=n+e
if t<=0 or o<=0 then
return{
innerX=i,
innerY=s,
innerWidth=t,
innerHeight=o,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=i
}
end
local e,n=M(self.scrollbar,#self._flatNodes,o,t)
if e>0 and t-e<1 then
e=math.max(0,t-1)
if e<=0 then
e=0
n=nil
end
end
local a=t-e
if a<1 then
a=t
e=0
n=nil
end
return{
innerX=i,
innerY=s,
innerWidth=t,
innerHeight=o,
contentWidth=a,
scrollbarWidth=e,
scrollbarStyle=n,
scrollbarX=i+a
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
function u:_rowFromPoint(a,t)
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
local a=T.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function u:draw(s,h)
if not self.visible then
return
end
local n,o,a,t=self:getAbsoluteRect()
local r=self.bg or e.black
local m=self.fg or e.white
i(s,n,o,a,t,r,r)
_(s,n,o,a,t)
if self.border then
p(h,n,o,a,t,self.border,r)
end
local o=self:_computeLayoutMetrics()
local t=o.innerWidth
local h=o.innerHeight
local n=o.contentWidth
local c=o.scrollbarWidth
local d=o.scrollbarStyle
if t<=0 or h<=0 or n<=0 then
return
end
local u=o.innerX
local l=o.innerY
local f=self._flatNodes
local w=#f
if w==0 then
for e=0,h-1 do
s.text(u,l+e,string.rep(" ",n),m,r)
end
local t=self.placeholder
if type(t)=="string"and#t>0 then
local t=t
if#t>n then
t=t:sub(1,n)
end
local a=u+math.floor((n-#t)/2)
if a<u then
a=u
end
s.text(a,l,t,e.lightGray,r)
end
if c>0 then
local e=(d and d.background)or r
i(s,o.scrollbarX,l,c,h,e,e)
if d then
L(s,o.scrollbarX,l,h,0,h,0,d)
end
end
return
end
for t=0,h-1 do
local d=l+t
local h=self.scrollOffset+t
if h>w then
s.text(u,d,string.rep(" ",n),m,r)
else
local t=f[h]
local o=t.node
local t=t.depth or 0
local t=t*self.indentWidth
if t>n-1 then
t=n-1
end
if t<0 then
t=0
end
local a=t>0 and string.rep(" ",t)or""
local i
if o and o.children and#o.children>0 then
i=o.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
else
i=self.toggleSymbols.leaf
end
i=tostring(i or" ")
local t=n-t
local a=a
if t>0 then
local e=i:sub(1,1)
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
elseif#a>n then
a=a:sub(1,n)
end
local o=r
local t=m
if h==self._selectedIndex then
o=self.highlightBg or e.lightGray
t=self.highlightFg or e.black
end
s.text(u,d,a,t,o)
end
end
if c>0 then
local e=(d and d.background)or r
i(s,o.scrollbarX,l,c,h,e,e)
if d then
L(s,o.scrollbarX,l,h,#self._flatNodes,h,math.max(0,self.scrollOffset-1),d)
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
local e=D(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
if e~=t then
self.scrollOffset=e+1
self:_ensureSelectionVisible()
end
return true
end
end
local e=self._flatNodes[i]
if e then
local t=e.depth*self.indentWidth
if t<0 then
t=0
end
if t>o-1 then
t=o-1
end
local i=n+t
if e.node and e.node.children and#e.node.children>0 and t<o then
local t=#tostring(self.toggleSymbols.collapsed or"+")
if t<1 then
t=1
end
if a>=i and a<i+t then
self:_toggleNode(e.node,nil)
return true
end
end
end
self:_setSelectedIndex(i,false)
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
local e=D(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
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
local function A(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function U(r,a,t,o,i,n)
if not r then
return
end
n=n or e.white
local h=math.abs(o-a)
local d=a<o and 1 or-1
local s=-math.abs(i-t)
local l=t<i and 1 or-1
local e=h+s
while true do
r.pixel(a,t,n)
if a==o and t==i then
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
function w:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 8))
o.width=math.max(6,math.floor(o.width or 18))
local a=setmetatable({},w)
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
function w:_emitSelect()
if self.onSelect then
local e=self.selectedIndex
local t=e and self.data[e]or nil
self.onSelect(self,e,t)
end
end
function w:_clampSelection(a)
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
function w:setData(e)
t(1,e,"table")
local a={}
for t=1,#e do
local e=e[t]
if type(e)~="number"then
e=tonumber(e)or 0
end
a[t]=e
end
self.data=a
self:_clampSelection(false)
end
function w:getData()
return self.data
end
function w:setLabels(e)
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
function w:getLabels()
return self.labels
end
function w:getLabel(e)
if type(e)~="number"then
return nil
end
if not self.labels then
return nil
end
return self.labels[math.floor(e)]
end
function w:setChartType(e)
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
function w:setShowAxis(e)
self.showAxis=not not e
end
function w:setShowLabels(e)
self.showLabels=not not e
end
function w:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e or""
end
function w:setRange(a,e)
if a~=nil then
t(1,a,"number")
end
if e~=nil then
t(2,e,"number")
end
self.minValue=a
self.maxValue=e
end
function w:setRangePadding(e)
t(1,e,"number")
if e<0 then
e=0
end
self.rangePadding=e
end
function w:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function w:setSelectedIndex(e,a)
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
function w:getSelectedIndex()
return self.selectedIndex
end
function w:getSelectedValue()
local e=self.selectedIndex
if not e then
return nil
end
return self.data[e]
end
function w:onFocusChanged(e)
if e then
self:_clampSelection(true)
end
end
function w:_indexFromPoint(t)
local e=self._lastLayout
if not e or not e.bars then
return nil
end
local a=e.bars
for o=1,#a do
local e=a[o]
if t>=e.left and t<=e.right then
return o
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
function w:_moveSelection(a)
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
function w:draw(r,v)
if not self.visible then
return
end
local n,h,d,o=self:getAbsoluteRect()
local s=self.bg or e.black
local f=self.fg or e.white
i(r,n,h,d,o,s,s)
_(r,n,h,d,o)
if self.border then
p(v,n,h,d,o,self.border,s)
end
local t=self.border
local a=(t and t.thickness)or 0
local u=(t and t.left)and a or 0
local c=(t and t.right)and a or 0
local l=(t and t.top)and a or 0
local t=(t and t.bottom)and a or 0
local n=n+u
local h=h+l
local a=math.max(0,d-u-c)
local t=math.max(0,o-l-t)
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
local t=h+math.floor((t-1)/2)
r.text(a,t,o,e.lightGray,s)
end
return
end
local o=(self.showLabels and t>=2)and 1 or 0
local u=(self.showAxis and(t-o)>=2)and 1 or 0
local l=t-u-o
if l<1 then
l=t
u=0
o=0
end
local m=h
local c=m+l-1
local w=u>0 and(c+1)or nil
local u
if o>0 then
if w then
u=w+1
else
u=c+1
end
if u>h+t-1 then
u=h+t-1
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
local h=type(self.maxValue)=="number"and self.maxValue or o
if h==t then
h=h+1
t=t-1
end
local o=h-t
if o<=0 then
o=1
h=t+o
end
local y=self.rangePadding or 0
if y>0 then
local e=h-t
local e=e*y
if e==0 then
e=y
end
t=t-e
h=h+e
o=h-t
if o<=0 then
o=1
h=t+o
end
end
local h={}
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
h[o]={
left=t,
right=e,
width=a,
center=t+math.floor((a-1)/2)
}
end
if self.chartType=="bar"then
for a=1,d do
local n=self.data[a]or 0
local e=0
if o>0 then
e=(n-t)/o
end
e=A(e,0,1)
local e=math.floor(e*l+.5)
if l>0 and e<=0 and n>t then
e=1
end
if e>l then
e=l
end
if e<1 then
e=1
end
local o=c-e+1
if o<m then
o=m
e=c-m+1
end
local t=self.barColor or f
if self.selectedIndex==a then
t=self.highlightColor or t
end
i(r,h[a].left,o,h[a].width,e,t,t)
end
else
local a={}
for i=1,d do
local n=self.data[i]or 0
local e=0
if o>0 then
e=(n-t)/o
end
e=A(e,0,1)
local t=math.max(l-1,0)
local e=c-math.floor(e*t+.5)
if e<m then
e=m
end
if e>c then
e=c
end
a[i]={x=h[i].center,y=e}
end
for e=2,#a do
local t=a[e-1]
local e=a[e]
U(v,t.x,t.y,e.x,e.y,self.lineColor or f)
end
for t=1,#a do
local a=a[t]
local o=self.lineColor or f
local i="o"
if self.selectedIndex==t then
o=self.highlightColor or e.orange
i="O"
end
r.text(a.x,a.y,i,o,s)
end
end
if w then
i(r,n,w,a,1,s,s)
local e=string.rep("-",a)
r.text(n,w,e,self.axisColor or f,s)
end
if u then
i(r,n,u,a,1,s,s)
local t=self.labels or{}
for i=1,d do
local t=t[i]
if t and t~=""then
t=tostring(t)
local a=h[i]
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
local e=(self.selectedIndex==i)and(self.highlightColor or e.orange)or(self.axisColor or f)
r.text(o,u,t,e,s)
end
end
end
self._lastLayout={
innerX=n,
innerWidth=a,
dataCount=d,
bars=h
}
end
function w:handleEvent(e,...)
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
local e,a,t=...
if self:containsPoint(a,t)then
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
function f:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local t=setmetatable({},f)
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
t.scrollbar=R(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_normalizeSelection(true)
return t
end
function f:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-a)
local i=math.max(0,self.height-t-e)
return o,a,t,e,n,i
end
function f:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function f:_computeLayoutMetrics()
local t,a=self:getAbsoluteRect()
local o,s,n,s,e,i=self:_getInnerMetrics()
local o=t+o
local s=a+n
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
local t,n=M(self.scrollbar,#self.items,i,e)
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
function f:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function f:_ensureSelectionVisible()
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
function f:_normalizeSelection(t)
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
function f:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function f:setItems(a)
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
function f:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function f:setSelectedIndex(e,a)
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
function f:getSelectedIndex()
return self.selectedIndex
end
function f:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function f:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e
end
function f:setHighlightColors(a,e)
if a~=nil then
t(1,a,"number")
self.highlightBg=a
end
if e~=nil then
t(2,e,"number")
self.highlightFg=e
end
end
function f:setScrollbar(t)
self.scrollbar=R(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function f:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function f:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function f:_itemIndexFromPoint(o,t)
if not self:containsPoint(o,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
local i=e.innerX
local a=e.innerY
if o<i or o>=i+e.contentWidth then
return nil
end
if t<a or t>=a+e.innerHeight then
return nil
end
local e=t-a
local e=self.scrollOffset+e
if e<1 or e>#self.items then
return nil
end
return e
end
function f:_moveSelection(t)
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
function f:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
end
function f:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=T.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function f:_searchForPrefix(e)
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
function f:draw(a,h)
if not self.visible then
return
end
local t,s,o,n=self:getAbsoluteRect()
local d=self.bg or e.black
local u=self.fg or e.white
i(a,t,s,o,n,d,d)
_(a,t,s,o,n)
if self.border then
p(h,t,s,o,n,self.border,d)
end
local t=self:_computeLayoutMetrics()
local s=t.innerWidth
local n=t.innerHeight
local o=t.contentWidth
if s<=0 or n<=0 or o<=0 then
return
end
local r=t.innerX
local h=t.innerY
local l=t.scrollbarWidth
local s=t.scrollbarStyle
local c=#self.items
local d=d
local f=self.highlightBg or e.lightGray
local m=self.highlightFg or e.black
if c==0 then
for e=0,n-1 do
a.text(r,h+e,string.rep(" ",o),u,d)
end
if l>0 then
local e=(s and s.background)or d
i(a,t.scrollbarX,h,l,n,e,e)
end
local i=self.placeholder
if type(i)=="string"and#i>0 then
local t=i
if#t>o then
t=t:sub(1,o)
end
local o=r+math.floor((o-#t)/2)
if o<r then
o=r
end
a.text(o,h,t,e.lightGray,d)
end
if s then
L(a,t.scrollbarX,h,n,0,n,0,s)
end
return
end
for e=0,n-1 do
local n=h+e
local t=self.scrollOffset+e
if t>c then
a.text(r,n,string.rep(" ",o),u,d)
else
local e=self.items[t]or""
if#e>o then
e=e:sub(1,o)
end
local e=e
if#e<o then
e=e..string.rep(" ",o-#e)
end
local i=d
local o=u
if t==self.selectedIndex then
i=f
o=m
end
a.text(r,n,e,o,i)
end
end
if l>0 then
local e=(s and s.background)or d
i(a,t.scrollbarX,h,l,n,e,e)
if s then
L(a,t.scrollbarX,h,n,#self.items,n,math.max(0,self.scrollOffset-1),s)
end
end
end
function f:handleEvent(o,...)
if not self.visible then
return false
end
if o=="mouse_click"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.innerHeight then
local a=t-e.innerY
local t=math.max(0,self.scrollOffset-1)
local e=D(a,e.innerHeight,#self.items,e.innerHeight,t)
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
elseif o=="monitor_touch"then
local e,a,t=...
local e=self._autocompleteState
if e and e.visible and self:_isPointInAutocomplete(a,t)then
self.app:setFocus(self)
local t=self:_autocompleteIndexFromPoint(a,t)
if t then
if e.selectedIndex~=t then
e.selectedIndex=t
self:_refreshAutocompleteGhost()
end
return self:_acceptAutocomplete()
end
self:_hideAutocomplete()
return true
end
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.innerHeight then
local a=t-e.innerY
local t=math.max(0,self.scrollOffset-1)
local e=D(a,e.innerHeight,#self.items,e.innerHeight,t)
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
elseif o=="mouse_scroll"then
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
elseif o=="key"then
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
elseif o=="char"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
elseif o=="paste"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
end
return false
end
function j:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},j)
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
function j:_normalizeSelection()
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
function j:setItems(a)
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
function j:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function j:setSelectedIndex(e,a)
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
function j:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function j:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function j:_setOpen(e)
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
function j:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function j:_isPointInDropdown(o,a)
if not self._open or#self.items==0 then
return false
end
local t,e,n,i=self:getAbsoluteRect()
local e=e+i
return o>=t and o<t+n and a>=e and a<e+#self.items
end
function j:_indexFromPoint(t,e)
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
function j:_handlePress(e,t)
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
function j:draw(s,d)
if not self.visible then
return
end
local h,t,o,n=self:getAbsoluteRect()
local a=self.bg or e.black
local r=self.fg or e.white
i(s,h,t,o,n,a,a)
_(s,h,t,o,n)
if self.border then
p(d,h,t,o,n,self.border,a)
end
local e=self.border
local i=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local l=h+i
local h=math.max(0,o-i-u)
local u=t+d
local e=math.max(0,n-d-e)
local n=h>0 and 1 or 0
local i=math.max(0,h-n)
local o
if e>0 then
o=u+math.floor((e-1)/2)
else
o=t
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
s.text(l,o,e,r,a)
end
if n>0 then
local t=self._open and string.char(30)or string.char(31)
local e=l+h-1
s.text(e,o,t,r,a)
end
end
function j:_drawDropdown(r,u)
if not self._open or#self.items==0 or self.visible==false then
return
end
local a,e,s,t=self:getAbsoluteRect()
local n=e+t
local l=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local h=(e and e.right)and 1 or 0
local c=a+t
local t=math.max(0,s-t-h)
local d=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local h=l+e
i(r,a,n,s,h,self.dropdownBg,self.dropdownBg)
_(r,a,n,s,h)
for e=1,l do
local a=n+e-1
local o=self.items[e]or""
local e=d~=nil and d==e
local n=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local i=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if t>0 then
local e=o
if#e>t then
e=e:sub(1,t)
end
local t=math.max(0,t-#e)
local e=e..string.rep(" ",t)
r.text(c,a,e,i,n)
end
end
if self.border then
local e=o(self.border)
if e then
e.top=false
p(u,a,n,s,h,e,self.dropdownBg)
end
end
end
function j:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,e,t=...
return self:_handlePress(e,t)
elseif t=="monitor_touch"then
local a,t,e=...
return self:_handlePress(t,e)
elseif t=="mouse_scroll"then
local a,t,e=...
if self:containsPoint(t,e)or self:_isPointInDropdown(t,e)then
self.app:setFocus(self)
if a>0 then
self:setSelectedIndex(self.selectedIndex+1)
elseif a<0 then
self:setSelectedIndex(self.selectedIndex-1)
end
return true
end
elseif t=="mouse_move"then
local t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
end
elseif t=="mouse_drag"then
local a,e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
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
local e=((t+e-1)%#self.items)+1
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
function c:new(i,t)
t=t or{}
local o=o(t)or{}
if t and t.focusable==false then
o.focusable=false
else
o.focusable=true
end
o.width=math.max(8,math.floor(o.width or 18))
o.height=math.max(3,math.floor(o.height or 7))
local a=setmetatable({},c)
a:_init_base(i,o)
a.focusable=o.focusable~=false
a.tabSpacing=math.max(0,math.floor((t and t.tabSpacing)or 1))
a.tabPadding=math.max(0,math.floor((t and t.tabPadding)or 2))
a.tabHeight=math.max(1,math.floor((t and t.tabHeight)or 3))
a.tabBg=(t and t.tabBg)or a.bg or e.black
a.tabFg=(t and t.tabFg)or a.fg or e.white
a.activeTabBg=(t and t.activeTabBg)or e.white
a.activeTabFg=(t and t.activeTabFg)or e.black
a.hoverTabBg=(t and t.hoverTabBg)or e.lightGray
a.hoverTabFg=(t and t.hoverTabFg)or e.black
a.disabledTabFg=(t and t.disabledTabFg)or e.lightGray
a.bodyBg=(t and t.bodyBg)or a.bg or e.black
a.bodyFg=(t and t.bodyFg)or a.fg or e.white
a.separatorColor=(t and t.separatorColor)or e.gray
a.bodyRenderer=(t and t.bodyRenderer)or(t and t.renderBody)or nil
a.emptyText=t and t.emptyText or nil
a.onSelect=t and t.onSelect or nil
a.tabs={}
if t and type(t.tabs)=="table"then
a.tabs=a:_normalizeTabs(t.tabs)
end
if t and type(t.selectedIndex)=="number"then
a.selectedIndex=math.floor(t.selectedIndex)
elseif#a.tabs>0 then
a.selectedIndex=1
else
a.selectedIndex=0
end
a._hoverIndex=nil
a._tabRects={}
a._layoutCache=nil
if not a.border then
a.border=I(true)
end
a:_normalizeSelection(true)
return a
end
function c:_normalizeTabEntry(e,a)
if e==nil then
return nil
end
local t=type(e)
if t=="string"then
return{
id=a,
label=e,
value=e,
disabled=false
}
elseif t=="table"then
local t=e.label or e.text or e.title
if t==nil then
if e.id~=nil then
t=tostring(e.id)
elseif e.value~=nil then
t=tostring(e.value)
else
t=string.format("Tab %d",a)
end
else
t=tostring(t)
end
local e={
id=e.id~=nil and e.id or e.value or a,
label=t,
value=e.value~=nil and e.value or e.id or e,
disabled=not not e.disabled,
content=e.content,
tooltip=e.tooltip,
contentRenderer=e.contentRenderer or e.render
}
if e.contentRenderer~=nil and type(e.contentRenderer)~="function"then
e.contentRenderer=nil
end
return e
else
return{
id=a,
label=tostring(e),
value=e,
disabled=false
}
end
end
function c:_normalizeTabs(a)
local e={}
for t=1,#a do
local t=self:_normalizeTabEntry(a[t],t)
if t then
e[#e+1]=t
end
end
return e
end
function c:_findFirstEnabled()
for t=1,#self.tabs do
local e=self.tabs[t]
if e and not e.disabled then
return t
end
end
return 0
end
function c:_resolveSelectableIndex(t)
local a=#self.tabs
if a==0 then
return 0
end
t=math.max(1,math.min(a,math.floor(t)))
local e=self.tabs[t]
if e and not e.disabled then
return t
end
for t=t+1,a do
e=self.tabs[t]
if e and not e.disabled then
return t
end
end
for t=t-1,1,-1 do
e=self.tabs[t]
if e and not e.disabled then
return t
end
end
return 0
end
function c:_normalizeSelection(o)
local a=self.selectedIndex or 0
local t=#self.tabs
local e=a
if t==0 then
e=0
else
e=math.floor(e)
if e<1 or e>t then
e=math.max(1,math.min(t,e))
end
if t>0 then
local t=self.tabs[e]
if not t or t.disabled then
e=self:_resolveSelectableIndex(e)
end
if e==0 then
e=self:_findFirstEnabled()
end
end
end
if e<0 then
e=0
end
local t=e~=a
self.selectedIndex=e
if not o then
if t then
self:_notifySelect()
elseif a~=0 and e==0 then
self:_notifySelect()
end
end
end
function c:setTabs(o)
t(1,o,"table")
local n=self.selectedIndex or 0
local e=self:getSelectedTab()
local i=e and e.id
local a=e and e.label
self.tabs=self:_normalizeTabs(o)
if i~=nil then
for t=1,#self.tabs do
local e=self.tabs[t]
if e and e.id==i and not e.disabled then
self.selectedIndex=t
break
end
end
end
if(self.selectedIndex or 0)<1 or(self.selectedIndex or 0)>#self.tabs then
if a~=nil then
for t=1,#self.tabs do
local e=self.tabs[t]
if e and e.label==a and not e.disabled then
self.selectedIndex=t
break
end
end
end
end
if(self.selectedIndex or 0)<1 or(self.selectedIndex or 0)>#self.tabs then
self.selectedIndex=n
end
self:_normalizeSelection(false)
self._tabRects={}
end
function c:getTabs()
local t={}
for e=1,#self.tabs do
t[e]=o(self.tabs[e])
end
return t
end
function c:addTab(e)
local e=self:_normalizeTabEntry(e,#self.tabs+1)
if not e then
return
end
self.tabs[#self.tabs+1]=e
if self.selectedIndex==0 then
self.selectedIndex=#self.tabs
self:_normalizeSelection(false)
else
self:_normalizeSelection(true)
end
self._tabRects={}
end
function c:removeTab(e)
t(1,e,"number")
e=math.floor(e)
if e<1 or e>#self.tabs then
return
end
table.remove(self.tabs,e)
if self.selectedIndex==e then
self.selectedIndex=e
self:_normalizeSelection(false)
elseif self.selectedIndex>e then
self.selectedIndex=self.selectedIndex-1
self:_normalizeSelection(true)
else
self:_normalizeSelection(true)
end
self._tabRects={}
end
function c:setTabEnabled(e,a)
t(1,e,"number")
t(2,a,"boolean")
e=math.floor(e)
if e<1 or e>#self.tabs then
return
end
local t=self.tabs[e]
if not t then
return
end
if a then
if t.disabled then
t.disabled=false
if self.selectedIndex==0 then
self.selectedIndex=e
self:_normalizeSelection(false)
else
self:_normalizeSelection(true)
end
end
else
if not t.disabled then
t.disabled=true
if self.selectedIndex==e then
self:_normalizeSelection(false)
else
self:_normalizeSelection(true)
end
end
end
end
function c:setTabLabel(e,a)
t(1,e,"number")
t(2,a,"string")
e=math.floor(e)
if e<1 or e>#self.tabs then
return
end
local e=self.tabs[e]
if not e then
return
end
if e.label~=a then
e.label=a
self._tabRects={}
end
end
function c:selectTabById(o,a)
for t=1,#self.tabs do
local e=self.tabs[t]
if e and e.id==o then
self:setSelectedIndex(t,a)
return true
end
end
return false
end
function c:getSelectedIndex()
return self.selectedIndex or 0
end
function c:getSelectedTab()
local e=self.selectedIndex or 0
if e>=1 and e<=#self.tabs then
return self.tabs[e]
end
return nil
end
function c:setSelectedIndex(e,a)
if#self.tabs==0 then
if self.selectedIndex~=0 then
self.selectedIndex=0
if not a then
self:_notifySelect()
end
end
return
end
t(1,e,"number")
e=math.floor(e)
if e<1 then
e=1
elseif e>#self.tabs then
e=#self.tabs
end
if self.tabs[e]and self.tabs[e].disabled then
e=self:_resolveSelectableIndex(e)
end
if e==0 then
if self.selectedIndex~=0 then
self.selectedIndex=0
if not a then
self:_notifySelect()
end
end
return
end
if self.selectedIndex~=e then
self.selectedIndex=e
if not a then
self:_notifySelect()
end
end
end
function c:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function c:setBodyRenderer(e)
if e~=nil then
t(1,e,"function")
end
self.bodyRenderer=e
end
function c:setEmptyText(e)
if e~=nil then
t(1,e,"string")
end
self.emptyText=e
end
function c:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedTab(),self.selectedIndex or 0)
end
end
function c:_emitSelect()
if self.onSelect then
self.onSelect(self,self:getSelectedTab(),self.selectedIndex or 0)
end
end
function c:_computeTabLayout()
local n,i,o,s=self:getAbsoluteRect()
local e=self.border
local t=(e and e.left)and 1 or 0
local h=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=n+t
local i=i+a
local o=math.max(0,o-t-h)
local s=math.max(0,s-a-e)
local e=math.min(s,self.tabHeight or 3)
if e<0 then
e=0
end
local d=math.max(0,s-e)
local h={}
if o>0 and e>0 then
local t=n
local n=n+o-1
local r=math.max(0,self.tabSpacing or 0)
local s=math.max(0,self.tabPadding or 0)
for o=1,#self.tabs do
if t>n then
break
end
local a=self.tabs[o]
local a=a and a.label and tostring(a.label)or string.format("Tab %d",o)
local a=math.max(3,#a+s*2)
local n=n-t+1
if a>n then
a=n
end
if a<=0 then
break
end
h[o]={
x1=t,
y1=i,
x2=t+a-1,
y2=i+e-1,
width=a
}
t=t+a+r
end
end
self._tabRects=h
self._layoutCache={
innerX=n,
innerY=i,
innerWidth=o,
innerHeight=s,
tabHeight=e,
bodyX=n,
bodyY=i+e,
bodyWidth=o,
bodyHeight=d
}
return self._layoutCache,h
end
function c:_tabIndexFromPoint(a,t)
self:_computeTabLayout()
for o,e in pairs(self._tabRects)do
if e and a>=e.x1 and a<=e.x2 and t>=e.y1 and t<=e.y2 then
return o
end
end
return nil
end
function c:_moveSelection(a)
if#self.tabs==0 or a==0 then
return
end
a=a>0 and 1 or-1
local t=#self.tabs
local e=self.selectedIndex
if e<1 or e>t then
e=a>0 and 0 or t+1
end
for o=1,t do
e=e+a
if e<1 then
e=t
elseif e>t then
e=1
end
local t=self.tabs[e]
if t and not t.disabled then
self:setSelectedIndex(e)
return
end
end
end
function c:_renderBody(i,s,a)
local o=a.bodyWidth or 0
local h=a.bodyHeight or 0
if o<=0 or h<=0 then
return
end
local t=self:getSelectedTab()
if not t then
return
end
local n=t.contentRenderer
if n~=nil and type(n)=="function"then
n(self,t,i,s,a)
return
end
if type(t.content)=="function"then
t.content(self,t,i,s,a)
return
end
if self.bodyRenderer then
self.bodyRenderer(self,t,i,s,a)
return
end
if type(t.content)=="string"then
local n=W(t.content,o)
local t=math.min(h,#n)
local h=self.bodyFg or self.tabFg or e.white
local s=self.bodyBg or self.bg or e.black
for t=1,t do
local e=n[t]
if#e>o then
e=e:sub(1,o)
end
if#e<o then
e=e..string.rep(" ",o-#e)
end
i.text(a.bodyX,a.bodyY+t-1,e,h,s)
end
end
end
function c:onFocusChanged(e)
if not e then
self._hoverIndex=nil
end
end
function c:draw(n,d)
if not self.visible then
return
end
local a,t,o,h=self:getAbsoluteRect()
local s=self.bodyBg or self.bg or e.black
local r=self.bodyFg or self.fg or e.white
i(n,a,t,o,h,s,s)
_(n,a,t,o,h)
if self.border then
p(d,a,t,o,h,self.border,s)
end
local e=select(1,self:_computeTabLayout())
if not e or e.innerWidth<=0 or e.innerHeight<=0 then
return
end
local a=self.tabBg or s
local o=self.tabFg or r
if e.tabHeight>0 and e.innerWidth>0 then
i(n,e.innerX,e.innerY,e.innerWidth,e.tabHeight,a,a)
end
if self._hoverIndex and not self._tabRects[self._hoverIndex]then
self._hoverIndex=nil
end
for s,t in pairs(self._tabRects)do
local h=self.tabs[s]
if h and t then
local a=a
local o=o
if s==self.selectedIndex and self.selectedIndex>0 then
a=self.activeTabBg or a
o=self.activeTabFg or o
if self:isFocused()then
a=self.hoverTabBg or a
o=self.hoverTabFg or o
end
elseif self._hoverIndex and self._hoverIndex==s and not h.disabled then
a=self.hoverTabBg or a
o=self.hoverTabFg or o
end
if h.disabled then
o=self.disabledTabFg or o
end
i(n,t.x1,t.y1,t.width,e.tabHeight,a,a)
local r=math.max(0,self.tabPadding or 0)
local i=h.label or string.format("Tab %d",s)
i=tostring(i)
local s=t.width-r*2
local i=i
if s>0 then
if#i>s then
i=i:sub(1,s)
end
if#i<s then
i=i..string.rep(" ",s-#i)
end
local s=t.x1+r
local e=t.y1+math.max(0,math.floor((e.tabHeight-1)/2))
n.text(s,e,i,o,a)
else
local i=i
if#i>t.width then
i=i:sub(1,t.width)
end
local e=t.y1+math.max(0,math.floor((e.tabHeight-1)/2))
n.text(t.x1,e,i,o,a)
end
end
end
if e.bodyHeight>0 and e.bodyWidth>0 then
i(n,e.bodyX,e.bodyY,e.bodyWidth,e.bodyHeight,s,s)
local t=self:getSelectedTab()
if t then
self:_renderBody(n,d,e)
elseif self.emptyText then
local t=W(self.emptyText,e.bodyWidth)
local a=math.min(e.bodyHeight,#t)
for a=1,a do
local t=t[a]
if#t>e.bodyWidth then
t=t:sub(1,e.bodyWidth)
end
if#t<e.bodyWidth then
t=t..string.rep(" ",e.bodyWidth-#t)
end
n.text(e.bodyX,e.bodyY+a-1,t,r,s)
end
end
end
end
function c:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
local e=self:_tabIndexFromPoint(e,t)
if e then
local t=self.tabs[e]
if t and not t.disabled then
if self.selectedIndex~=e then
self:setSelectedIndex(e)
else
self:_emitSelect()
end
end
end
return true
end
elseif e=="monitor_touch"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e=self:_tabIndexFromPoint(t,e)
if e then
local t=self.tabs[e]
if t and not t.disabled then
if self.selectedIndex~=e then
self:setSelectedIndex(e)
else
self:_emitSelect()
end
end
end
return true
end
elseif e=="mouse_scroll"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
if e>0 then
self:_moveSelection(1)
elseif e<0 then
self:_moveSelection(-1)
end
return true
end
elseif e=="mouse_move"then
local t,e=...
if self:containsPoint(t,e)then
self._hoverIndex=self:_tabIndexFromPoint(t,e)
elseif self._hoverIndex then
self._hoverIndex=nil
end
elseif e=="mouse_drag"then
local a,t,e=...
if self:containsPoint(t,e)then
self._hoverIndex=self:_tabIndexFromPoint(t,e)
elseif self._hoverIndex then
self._hoverIndex=nil
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
elseif e==a.up then
self:_moveSelection(-1)
return true
elseif e==a.down then
self:_moveSelection(1)
return true
elseif e==a.home then
self:setSelectedIndex(1)
return true
elseif e==a["end"]then
self:setSelectedIndex(#self.tabs)
return true
elseif e==a.tab then
self:_moveSelection(1)
return true
elseif e==a.enter or e==a.space then
self:_emitSelect()
return true
end
end
return false
end
function m:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.width=math.max(1,math.floor(o.width or 1))
o.height=math.max(1,math.floor(o.height or 1))
local a=setmetatable({},m)
a:_init_base(i,o)
a.focusable=true
a.menuBg=(t and t.menuBg)or e.black
a.menuFg=(t and t.menuFg)or e.white
a.highlightBg=(t and t.highlightBg)or e.lightGray
a.highlightFg=(t and t.highlightFg)or e.black
a.shortcutFg=(t and t.shortcutFg)or a.menuFg
a.disabledFg=(t and t.disabledFg)or e.lightGray
a.separatorColor=(t and t.separatorColor)or a.disabledFg
a.maxWidth=math.max(8,math.floor((t and t.maxWidth)or 32))
if a.border==nil then
a.border=I(true)
end
a.onSelect=t and t.onSelect or nil
a.items=a:_normalizeItems(t and t.items or{})
a._levels={}
a._open=false
a._previousFocus=nil
return a
end
function m:setItems(e)
self.items=self:_normalizeItems(e)
if self._open then
self:close()
end
end
function m:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function m:isOpen()
return self._open
end
function m:draw(e,e)
end
function m:_normalizeItem(e)
if e==nil then
return nil
end
if e=="-"then
return{type="separator"}
end
local t=type(e)
if t=="string"then
return{type="item",label=e,shortcut=nil,disabled=false}
end
if t~="table"then
return nil
end
if e.separator or e.type=="separator"then
return{type="separator"}
end
local t=e.label or e.text
if t==nil then
return nil
end
t=tostring(t)
local t={
type="item",
label=t,
shortcut=e.shortcut and tostring(e.shortcut)or nil,
disabled=not not e.disabled,
action=e.onSelect or e.action or e.callback,
id=e.id,
value=e.value,
data=e.data
}
local e=e.submenu or e.items
if e then
local e=self:_normalizeItems(e)
if#e>0 then
t.submenu=e
end
end
return t
end
function m:_normalizeItems(t)
if type(t)~="table"then
return{}
end
local e={}
local a=true
for o=1,#t do
local t=self:_normalizeItem(t[o])
if t then
if t.type=="separator"then
if not a and#e>0 then
e[#e+1]=t
a=true
end
else
e[#e+1]=t
a=false
end
end
end
while#e>0 and e[#e].type=="separator"do
e[#e]=nil
end
return e
end
function m:_firstEnabledIndex(e)
for t=1,#e do
local e=e[t]
if e and e.type=="item"and not e.disabled then
return t
end
end
return nil
end
function m:_maxWidthForLevel()
local e=self.maxWidth
local t=self.app and self.app.root
if t and t.width then
e=math.max(1,math.min(e,t.width))
else
e=math.max(4,e)
end
return e
end
function m:_measureItems(n,r)
if not n or#n==0 then
return nil
end
local o=0
local t=0
for e=1,#n do
local e=n[e]
if e.type=="item"then
local a=#(e.label or"")
if a>o then
o=a
end
local e=e.shortcut
if e and e~=""then
local e=#e
if e>t then
t=e
end
end
end
end
local s=(self.border and self.border.left)and 1 or 0
local h=(self.border and self.border.right)and 1 or 0
local u=(self.border and self.border.top)and 1 or 0
local l=(self.border and self.border.bottom)and 1 or 0
local a=2
local i=(t>0)and 2 or 0
local e=o+a+i+t
if e<a+2 then
e=a+2
end
if e<o+a then
e=o+a
end
local d=e+s+h
if r then
r=math.max(s+h+4,math.floor(r))
if d>r then
e=r-s-h
if e<a+2 then
e=a+2
end
local n=math.max(0,e-a-1)
if t>n then
t=n
end
i=(t>0)and 2 or 0
local n=e-a-i-t
if n<1 then
n=1
end
if o>n then
o=n
end
e=o+a+i+t
d=e+s+h
end
end
if t==0 then
i=0
end
return{
itemWidth=e,
labelWidth=o,
shortcutWidth=t,
shortcutGap=i,
arrowWidth=a,
leftPad=s,
rightPad=h,
topPad=u,
bottomPad=l,
itemCount=#n,
totalWidth=d,
totalHeight=#n+u+l
}
end
function m:_buildLevel(r,a,o,l,u,e)
e=e or self:_measureItems(r,self:_maxWidthForLevel())
if not e or e.itemCount==0 then
return nil
end
local t=self.app and self.app.root or nil
local i=t and t.width or nil
local t=t and t.height or nil
local s=e.totalWidth
local h=e.totalHeight
local a=math.floor(a)
local o=math.floor(o)
if i then
if a<1 then
a=1
end
if a+s-1>i then
a=math.max(1,i-s+1)
end
end
if t then
if o<1 then
o=1
end
if o+h-1>t then
o=math.max(1,t-h+1)
end
end
local t=a+e.leftPad
local d=o+e.topPad
local n=t+e.itemWidth-1
if n<t then
n=t
end
local i
if e.shortcutWidth>0 then
i=n-e.shortcutWidth-1
if i<t then
i=t
end
end
return{
items=r,
metrics=e,
rect={x=a,y=o,width=s,height=h},
contentX=t,
contentY=d,
arrowX=n,
shortcutX=i,
highlightIndex=self:_firstEnabledIndex(r),
parentLevel=l,
parentIndex=u
}
end
function m:_closeLevelsAfter(t)
local e=self._levels
if not e then
return
end
for t=#e,t+1,-1 do
e[t]=nil
end
end
function m:_openSubmenu(e,i)
local o=self._levels
local a=o and o[e]
if not a then
return
end
local t=a.items[i]
if not t or t.type~="item"or not t.submenu or#t.submenu==0 then
self:_closeLevelsAfter(e)
return
end
local o=o[e+1]
if o and o.parentLevel==e and o.parentIndex==i then
return
end
local n=self:_measureItems(t.submenu,self:_maxWidthForLevel())
if not n then
self:_closeLevelsAfter(e)
return
end
local o=a.rect.x+a.rect.width
local h=a.contentY+i-1-n.topPad
local o=self:_buildLevel(t.submenu,o,h,e,i,n)
if not o then
self:_closeLevelsAfter(e)
return
end
local s=self.app and self.app.root or nil
local s=s and s.width or nil
if s and o.rect.x+o.rect.width-1>s then
local s=((self.border and self.border.left)and 1 or 0)
local a=a.rect.x-o.rect.width+s
local e=self:_buildLevel(t.submenu,a,h,e,i,n)
if e then
o=e
end
end
self:_closeLevelsAfter(e)
self._levels[#self._levels+1]=o
end
function m:_findItemAtPoint(i,a)
local e=self._levels
if not e or#e==0 then
return nil
end
for o=#e,1,-1 do
local e=e[o]
local t=e.rect
if i>=t.x and i<t.x+t.width and a>=t.y and a<t.y+t.height then
if a>=e.contentY and a<e.contentY+#e.items then
local t=a-e.contentY+1
if t>=1 and t<=#e.items then
return o,t
end
end
return o,nil
end
end
return nil
end
function m:_setHighlight(e,o,i)
local a=self._levels[e]
if not a then
return
end
if not o then
a.highlightIndex=nil
self:_closeLevelsAfter(e)
return
end
local t=a.items[o]
if not t or t.type~="item"or t.disabled then
a.highlightIndex=nil
self:_closeLevelsAfter(e)
return
end
a.highlightIndex=o
if t.submenu and#t.submenu>0 then
if i then
self:_openSubmenu(e,o)
end
else
self:_closeLevelsAfter(e)
end
end
function m:_handlePointerHover(t,e)
local e,t=self:_findItemAtPoint(t,e)
if not e then
return false
end
self:_setHighlight(e,t,true)
return true
end
function m:_handlePointerPress(a,e,t)
local e,a=self:_findItemAtPoint(e,t)
if not e then
self:close()
return false
end
if not a then
self:_closeLevelsAfter(e)
local e=self._levels[e]
if e then
e.highlightIndex=nil
end
return true
end
local o=self._levels[e]
local t=o and o.items[a]
if not t then
self:_closeLevelsAfter(e)
return true
end
if t.type=="separator"then
self:_closeLevelsAfter(e)
o.highlightIndex=nil
return true
end
if t.disabled then
self:_setHighlight(e,a,false)
return true
end
self:_setHighlight(e,a,false)
if t.submenu and#t.submenu>0 then
self:_openSubmenu(e,a)
return true
end
self:_activateItem(e,t)
return true
end
function m:_moveHighlight(i)
local e=self._levels
if not e or#e==0 then
return
end
local o=#e
local a=e[o]
local t=#a.items
if t==0 then
return
end
local e=a.highlightIndex or 0
for n=1,t do
e=e+i
if e<1 then
e=t
elseif e>t then
e=1
end
local t=a.items[e]
if t and t.type=="item"and not t.disabled then
self:_setHighlight(o,e,true)
return
end
end
end
function m:_activateHighlightedSubmenu()
local e=self._levels
if not e or#e==0 then
return
end
local a=#e
local e=e[a]
local t=e.highlightIndex
if not t then
return
end
local e=e.items[t]
if e and e.submenu and#e.submenu>0 then
self:_openSubmenu(a,t)
local e=self._levels[a+1]
if e and not e.highlightIndex then
e.highlightIndex=self:_firstEnabledIndex(e.items)
end
end
end
function m:_activateHighlightedItem()
local e=self._levels
if not e or#e==0 then
return
end
local t=#e
local e=e[t]
local a=e.highlightIndex
if not a then
return
end
local e=e.items[a]
if not e or e.type~="item"or e.disabled then
return
end
if e.submenu and#e.submenu>0 then
self:_openSubmenu(t,a)
local e=self._levels[t+1]
if e and not e.highlightIndex then
e.highlightIndex=self:_firstEnabledIndex(e.items)
end
return
end
self:_activateItem(t,e)
end
function m:_typeSearch(a)
if not a or a==""then
return
end
local e=self._levels
if not e or#e==0 then
return
end
local o=#e
local e=e[o]
local t=#e.items
if t==0 then
return
end
local n=e.highlightIndex or 0
local i=a:lower()
for a=1,t do
local t=((n+a-1)%t)+1
local e=e.items[t]
if e and e.type=="item"and not e.disabled then
local e=(e.label or""):lower()
if e:sub(1,1)==i then
self:_setHighlight(o,t,true)
return
end
end
end
end
function m:_activateItem(t,e)
if not e or e.type~="item"or e.disabled then
return
end
if e.action then
e.action(self,e)
end
if self.onSelect then
self.onSelect(self,e)
end
self:close()
end
function m:_setOpen(e)
e=not not e
if e then
if self._open then
return
end
self._open=true
if self.app then
self._previousFocus=self.app:getFocus()
self.app:_registerPopup(self)
self.app:setFocus(self)
end
else
if not self._open then
return
end
self._open=false
if self.app then
self.app:_unregisterPopup(self)
if self.app:getFocus()==self then
local e=self._previousFocus
if e and e.app==self.app and e.visible~=false then
self.app:setFocus(e)
else
self.app:setFocus(nil)
end
end
end
self._previousFocus=nil
self._levels={}
end
end
function m:open(o,i,a)
t(1,o,"number")
t(2,i,"number")
if a~=nil then
t(3,a,"table")
end
local e
if a and a.items then
e=self:_normalizeItems(a.items)
else
e=self.items
end
if not e or#e==0 then
self:close()
return false
end
local t=self:_measureItems(e,self:_maxWidthForLevel())
if not t then
self:close()
return false
end
local o=math.floor(o)
local a=math.floor(i)
local o=o-t.leftPad
local a=a-t.topPad
local e=self:_buildLevel(e,o,a,nil,nil,t)
if not e then
self:close()
return false
end
self._levels={e}
self:_setOpen(true)
return true
end
function m:close()
self:_setOpen(false)
end
function m:_drawDropdown(o,r)
if not self._open or self.visible==false then
return
end
local t=self._levels
if not t or#t==0 then
return
end
for a=1,#t do
local t=t[a]
local a=t.rect
i(o,a.x,a.y,a.width,a.height,self.menuBg,self.menuBg)
_(o,a.x,a.y,a.width,a.height)
local n=t.items
for i=1,#n do
local a=n[i]
local n=t.contentY+i-1
local h=t.highlightIndex==i and a.type=="item"and not a.disabled
local i=h and(self.highlightBg or self.menuBg)or self.menuBg
local s=self.menuFg or e.white
if a.type=="separator"then
local a=self.separatorColor or s
local e=string.rep("-",t.metrics.itemWidth)
o.text(t.contentX,n,e,a,i)
else
local s=a.disabled and(self.disabledFg or e.lightGray)or(h and(self.highlightFg or s)or s)
o.text(t.contentX,n,string.rep(" ",t.metrics.itemWidth),s,i)
local e=a.label or""
if#e>t.metrics.labelWidth then
e=e:sub(1,t.metrics.labelWidth)
end
if#e>0 then
o.text(t.contentX,n,e,s,i)
end
if t.shortcutX then
local e=a.shortcut or""
if#e>t.metrics.shortcutWidth then
e=e:sub(#e-t.metrics.shortcutWidth+1)
end
local a=math.max(0,t.metrics.shortcutWidth-#e)
if a>0 then
e=string.rep(" ",a)..e
end
local a=self.shortcutFg or s
o.text(t.shortcutX,n,e,a,i)
end
if a.submenu and a.submenu[1]~=nil then
o.text(t.arrowX,n,">",s,i)
end
end
end
if self.border then
p(r,a.x,a.y,a.width,a.height,self.border,self.menuBg)
end
end
end
function m:handleEvent(e,...)
if not self.visible or not self._open then
return false
end
if e=="mouse_click"then
local e,t,a=...
return self:_handlePointerPress(e,t,a)
elseif e=="monitor_touch"then
local a,t,e=...
return self:_handlePointerPress(1,t,e)
elseif e=="mouse_move"then
local t,e=...
return self:_handlePointerHover(t,e)
elseif e=="mouse_drag"then
local a,e,t=...
return self:_handlePointerHover(e,t)
elseif e=="mouse_scroll"then
self:close()
return false
elseif e=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==a.down then
self:_moveHighlight(1)
return true
elseif e==a.up then
self:_moveHighlight(-1)
return true
elseif e==a.right then
self:_activateHighlightedSubmenu()
return true
elseif e==a.left then
if#self._levels>1 then
self:_closeLevelsAfter(#self._levels-1)
else
self:close()
end
return true
elseif e==a.enter or e==a.space then
self:_activateHighlightedItem()
return true
elseif e==a.escape then
self:close()
return true
end
elseif e=="char"then
if not self:isFocused()then
return false
end
local e=...
if e and#e>0 then
self:_typeSearch(e:sub(1,1))
return true
end
elseif e=="paste"then
if not self:isFocused()then
return false
end
local e=...
if e and#e>0 then
self:_typeSearch(e:sub(1,1))
return true
end
end
return false
end
local o={}
o.__index=o
setmetatable(o,{__index=n})
local W={
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
local F={
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
local function C(a)
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
local function P(e)
return table.concat(e,"\n")
end
local function A(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function U(a,t,e,o)
if a<e then
return-1
end
if a>e then
return 1
end
if t<o then
return-1
end
if t>o then
return 1
end
return 0
end
local function G(e,t,i,o,a,n)
if U(e,t,i,o)<0 then
return false
end
if U(e,t,a,n)>=0 then
return false
end
return true
end
local function V(a)
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
keywords=W,
builtins=F,
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
for a,e in pairs(a)do
t[a]=e
end
if t.language=="lua"then
t.keywords=t.keywords or W
t.builtins=t.builtins or F
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
t.autocompleteHighlightBg=a.autocompleteHighlightBg or e.lightBlue
t.autocompleteHighlightFg=a.autocompleteHighlightFg or e.black
t.autocompleteBorder=I(a.autocompleteBorder==false and false or a.autocompleteBorder or true)
t.autocompleteMaxWidth=math.max(4,math.floor(a.autocompleteMaxWidth or math.max(t.width or i.width or 16,16)))
t.autocompleteGhostColor=a.autocompleteGhostColor or e.lightGray
t.syntax=V(a.syntax)
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
trigger="auto",
rect=nil
}
t._open=false
if not t.border then
t.border=I(true)
end
t.scrollbar=R(a.scrollbar,t.bg or e.black,t.fg or e.white)
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
self.scrollbar=R(t,self.bg or e.black,self.fg or e.white)
end
function o:onFocusChanged(e)
if not e then
self:_hideAutocomplete()
end
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
self.text=P(self._lines)
end
function o:_setTextInternal(e,a,t)
e=tostring(e or"")
e=self:_applyMaxLength(e)
self._lines=C(e)
self:_syncTextFromLines()
if a then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=A(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=A(self._cursorCol,1,#e+1)
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
e=A(e or 1,1,#self.text+1)
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
local n=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,i=self:getAbsoluteRect()
local o=o+a
local i=i+t
local s=math.max(0,self.width-a-n)
local n=math.max(0,self.height-t-e)
return o,i,s,n,a,t,e
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
local e,a=M(self.scrollbar,#self._lines,n,t)
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
local e,t=self:_getContentSize()
local a=self._scrollY+1
local o=self._scrollY+t
if self._cursorLine<a then
self._scrollY=self._cursorLine-1
elseif self._cursorLine>o then
self._scrollY=self._cursorLine-t
end
if self._scrollY<0 then
self._scrollY=0
end
local t=math.max(0,#self._lines-t)
if self._scrollY>t then
self._scrollY=t
end
local t=self._scrollX+1
local a=self._scrollX+e
if self._cursorCol<t then
self._scrollX=self._cursorCol-1
elseif self._cursorCol>a then
self._scrollX=self._cursorCol-e
end
if self._scrollX<0 then
self._scrollX=0
end
local t=self._lines[self._cursorLine]or""
local e=math.max(0,#t+1-e)
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
local o,a,e,t=self:_getSelectionRange()
return self:_collectRange(o,a,e,t)
end
function o:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local t,e=e.line,e.col
local o,a=self._cursorLine,self._cursorCol
if U(t,e,o,a)<=0 then
return t,e,o,a
else
return o,a,t,e
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
function o:_insertAt(e,a,t)
if t==nil or t==""then
return e,a
end
local t=C(t)
local o=self._lines[e]
local i=o:sub(1,a-1)
local a=o:sub(a)
self._lines[e]=i..t[1]
local e=e
for a=2,#t do
e=e+1
table.insert(self._lines,e,t[a])
end
self._lines[e]=self._lines[e]..a
local t=(#self._lines[e]-#a)+1
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
function o:_setCursorPosition(t,a,e)
e=e or{}
t=A(t,1,#self._lines)
local o=self._lines[t]or""
a=A(a,1,#o+1)
if e.extendSelection then
if not self._selectionAnchor then
self._selectionAnchor={line=self._cursorLine,col=self._cursorCol}
end
else
self:_clearSelection()
end
self._cursorLine=t
self._cursorCol=a
if not e.preservePreferred then
self._preferredCol=a
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
local e,t=self:_getSelectionRange()
self:_setCursorPosition(e,t)
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
function o:_moveCursorVertical(e,t)
local e=A(self._cursorLine+e,1,#self._lines)
local a=self._lines[e]or""
local a=A(self._preferredCol,1,#a+1)
self:_setCursorPosition(e,a,{extendSelection=t,preservePreferred=true})
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
function o:_moveCursorLineEnd(e)
local t=self._lines[self._cursorLine]
self:_setCursorPosition(self._cursorLine,#t+1,{extendSelection=e})
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
self._scrollY=A(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local a=select(1,self:_getContentSize())
local t=self._lines[self._cursorLine]or""
local t=math.max(0,#t-a)
self._scrollX=A(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(t,a)
local e=self:_computeLayoutMetrics()
local o=e.innerX
local i=e.innerY
local n=math.max(1,e.contentWidth)
local e=math.max(1,e.contentHeight)
local o=A(t-o,0,n-1)
local e=A(a-i,0,e-1)
local e=A(self._scrollY+e+1,1,#self._lines)
local t=self._lines[e]or""
local t=A(self._scrollX+o+1,1,#t+1)
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
for n,o,s in o:gmatch("()([%a_][%w_]*)()")do
local e=o:lower()
if t.keywords and t.keywords[e]then
if t.keywordColor then
for e=n,s-1 do
if a[e]==i then
a[e]=t.keywordColor
end
end
end
elseif t.builtins and t.builtins[o]then
if t.builtinColor then
for e=n,s-1 do
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
local function I(t,a,o,i)
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
function o:_buildLineSegments(s,e,r,h,t)
local a=self._lines[s]or""
local i=self:_computeSyntaxColors(a)
local o=self._scrollX+1
local n={}
for e=0,e-1 do
local e=o+e
local o
if e<=#a then
o=a:sub(e,e)
else
o=" "
end
local i=i and i[e]or r
local a=h
if t and G(s,e,t.startLine,t.startCol,t.endLine,t.endCol)then
a=self.selectionBg
i=self.selectionFg
end
I(n,o,i,a)
end
return n,a,i
end
function o:_drawSegments(a,t,i,e)
local t=t
for o=1,#e do
local e=e[o]
if e.text~=""then
a.text(t,i,e.text,e.fg,e.bg)
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
local r=self.overlayBg or self.bg or e.gray
local d=self.overlayFg or self.fg or e.white
local u=self.overlayActiveBg or e.orange
local c=self.overlayActiveFg or e.black
local i=n+i-o
for e=0,o-1 do
s.text(a,i+e,string.rep(" ",t),d,r)
end
local e=self._find
local n=#e.matches
local h=n>0 and string.format("%d/%d",math.max(1,e.index),n)or"0/0"
local n=e.matchCase and"CASE"or"case"
local h=string.format("Find: %s  %s  %s",e.findText,h,n)
local n="Replace: "..e.replaceText
local h=h
if#h>t then
h=h:sub(1,t)
end
local n=n
if#n>t then
n=n:sub(1,t)
end
s.text(a,i,h..string.rep(" ",math.max(0,t-#h)),d,r)
s.text(a,i+math.max(o-1,0),n..string.rep(" ",math.max(0,t-#n)),d,r)
local n,l,h
if e.activeField=="find"then
n=a+6
l=i
h=e.findText
else
n=a+9
l=i+math.max(o-1,0)
h=e.replaceText
end
local e=h
if#e>t-(n-a)then
e=e:sub(1,t-(n-a))
end
s.text(n,l,e..string.rep(" ",math.max(0,t-(n-a)-#e)),c,u)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
s.text(a,i+o-1,e..string.rep(" ",math.max(0,t-#e)),d,r)
end
end
function o:_setAutocompleteVisible(e)
local t=self._autocompleteState
e=not not e
if t.visible==e then
if not e then
t.rect=nil
end
return
end
t.visible=e
if e then
self._open=true
if self.app then
self.app:_registerPopup(self)
end
else
self._open=false
t.rect=nil
if self.app then
self.app:_unregisterPopup(self)
end
end
end
function o:_refreshAutocompleteGhost()
local e=self._autocompleteState
e.ghost=self:_computeAutocompleteGhost(e.items[e.selectedIndex],e.prefix,e.trigger)
end
function o:_hideAutocomplete()
local e=self._autocompleteState
if e.visible then
self:_setAutocompleteVisible(false)
else
e.rect=nil
end
e.items={}
e.ghost=""
e.prefix=""
e.trigger="auto"
e.selectedIndex=1
e.anchorLine=self._cursorLine
e.anchorCol=self._cursorCol
end
function o:_isPointInAutocomplete(a,t)
local e=self._autocompleteState and self._autocompleteState.rect
if not e then
return false
end
return a>=e.x and a<e.x+e.width and t>=e.y and t<e.y+e.height
end
function o:_autocompleteIndexFromPoint(a,t)
local e=self._autocompleteState and self._autocompleteState.rect
if not e then
return nil
end
if t<e.contentY or t>=e.contentY+e.itemCount then
return nil
end
if a<e.contentX or a>=e.contentX+e.itemWidth then
return nil
end
local t=t-e.contentY+1
if t<1 or t>e.itemCount then
return nil
end
return t
end
function o:_drawDropdown(f,y)
local t=self._autocompleteState
if not self.visible or not self._open then
if t then
t.rect=nil
end
return
end
if not t or not t.visible or#t.items==0 then
if t then
t.rect=nil
end
return
end
local a=self:_computeLayoutMetrics()
local w=a.innerX
local o=a.innerY
local h=a.contentWidth
local a=a.contentHeight
if h<=0 or a<=0 then
t.rect=nil
return
end
local a=A(t.anchorLine-(self._scrollY+1),0,a-1)
local c=o+a
local o=self.autocompleteBorder
local m=(o and o.top)and 1 or 0
local a=(o and o.bottom)and 1 or 0
local d=(o and o.left)and 1 or 0
local r=(o and o.right)and 1 or 0
local l=#t.items
local s=l+m+a
if s<=0 then
t.rect=nil
return
end
local a=0
for e=1,l do
local e=t.items[e]
local e=e and e.label or""
if#e>a then
a=#e
end
end
local n=self.autocompleteMaxWidth or h
n=math.max(1,n)
local u=math.min(h,n)
local a=math.max(u,a)
if a>n then
a=n
end
local u=self.app and self.app.root and self.app.root.width or(w+h-1)
if a+d+r>u then
a=math.max(1,u-d-r)
end
local r=a+d+r
if r<=0 or a<=0 then
t.rect=nil
return
end
local n=A(t.anchorCol-self._scrollX-1,0,h-1)
local n=w+n
local n=n
if n+r-1>u then
n=math.max(1,u-r+1)
end
if n<1 then
n=1
end
local h=c+1
if m>0 then
h=h+1
end
local u=self.app and self.app.root and self.app.root.height or(c+s)
local h=h
if h+s-1>u then
local e=c-s
if e>=1 then
h=e
else
h=math.max(1,u-s+1)
end
end
local w=n+d
local c=h+m
t.rect={
x=n,
y=h,
width=r,
height=s,
contentX=w,
contentY=c,
itemWidth=a,
itemCount=l
}
local d=self.autocompleteBg or self.bg or e.gray
i(f,n,h,r,s,d,d)
_(f,n,h,r,s)
local b=self.autocompleteFg or self.fg or e.white
local m=self.autocompleteHighlightBg or e.lightBlue
local v=self.autocompleteHighlightFg or e.black
for o=1,l do
local i=c+o-1
if i<1 or i>u then
break
end
local e=t.items[o]
local e=e and e.label or""
if#e>a then
e=e:sub(1,a)
end
local a=a-#e
if a>0 then
e=e..string.rep(" ",a)
end
local a=(o==t.selectedIndex)and m or d
local t=(o==t.selectedIndex)and v or b
f.text(w,i,e,t,a)
end
if o then
p(y,n,h,r,s,o,d)
end
end
function o:_updateAutocomplete(n)
if not self.autocomplete then
self:_hideAutocomplete()
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
local i
if e.visible and e.items and e.selectedIndex and e.items[e.selectedIndex]then
local e=e.items[e.selectedIndex]
i=e.insert or e.label
end
e.trigger=n or"auto"
self:_setAutocompleteVisible(true)
e.items={}
local s=math.min(self.autocompleteMaxItems,#a)
local n=1
for t=1,s do
local a=a[t]
e.items[t]=a
if i then
local e=a.insert or a.label
if e==i then
n=t
end
end
end
e.selectedIndex=n
e.anchorLine=self._cursorLine
e.anchorCol=t
e.prefix=o
self:_refreshAutocompleteGhost()
e.rect=nil
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
local o,a=self._cursorLine,self._cursorCol
self._selectionAnchor={line=e.anchorLine,col=e.anchorCol}
self._cursorLine=o
self._cursorCol=a
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
self:_refreshAutocompleteGhost()
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
local t=e.findText
local a=e.matchCase
for i=1,#self._lines do
local o=self._lines[i]
local o=a and o or o:lower()
local t=a and t or t:lower()
local a=1
while true do
local t,o=o:find(t,a,true)
if not t then
break
end
e.matches[#e.matches+1]={
line=i,
col=t,
length=o-t+1
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
local t=1
for a=1,#e.matches do
local e=e.matches[a]
if U(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
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
local o=t.line
local a=t.col
local i=self._lines[o]
self._lines[o]=i:sub(1,a-1)..(e.replaceText or"")..i:sub(a+t.length)
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
local b,v,y,w=self:getAbsoluteRect()
local s=self.bg or e.black
local f=self.fg or e.white
i(a,b,v,y,w,s,s)
_(a,b,v,y,w)
local o=self:_computeLayoutMetrics()
local r=o.innerX
local h=o.innerY
local t=o.innerWidth
local j=o.innerHeight
local n=o.contentWidth
local d=o.contentHeight
local c=o.overlayHeight
local u=o.scrollbarWidth
local m=o.scrollbarStyle
local g
local k=false
if self:_hasSelection()then
local a,o,t,e=self:_getSelectionRange()
g={
startLine=a,
startCol=o,
endLine=t,
endCol=e
}
k=true
end
local t=self._autocompleteState
local l=s
for i=0,d-1 do
local o=self._scrollY+i+1
local i=h+i
if o>#self._lines then
a.text(r,i,string.rep(" ",n),f,l)
else
local s,h,d=self:_buildLineSegments(o,n,f,l,g)
self:_drawSegments(a,r,i,s)
if self:isFocused()and o==self._cursorLine then
local t=self._cursorCol-self._scrollX-1
if t>=0 and t<n then
local e
if self._cursorCol<=#h then
e=h:sub(self._cursorCol,self._cursorCol)
else
e=" "
end
local n=l
local o=f
a.text(r+t,i,e,n,o)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not k and o==t.anchorLine then
local s=t.anchorCol+#t.prefix
local o=s-self._scrollX-1
if o<n then
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
if t~=""and o<n then
local n=n-o
if n>0 then
if#t>n then
t=t:sub(1,n)
end
if t~=""then
a.text(r+o,i,t,self.autocompleteGhostColor or e.lightGray,l)
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
if#t>n then
t=t:sub(1,n)
end
a.text(r,h,t..string.rep(" ",math.max(0,n-#t)),e.lightGray,l)
end
self:_drawFindOverlay(a,r,h,n,j)
if m then
local t=o.scrollbarX
local e=m.background or s
i(a,t,h,u,d,e,e)
L(a,t,h,d,#self._lines,d,self._scrollY,m)
if c>0 then
i(a,t,h+d,u,c,e,e)
end
elseif u>0 then
i(a,o.scrollbarX,h,u,d+c,s,s)
end
if self.border then
p(q,b,v,y,w,self.border,s)
end
end
function o:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local i,a,t=...
local o=self._autocompleteState
if o and o.visible and self:_isPointInAutocomplete(a,t)then
self.app:setFocus(self)
local e=self:_autocompleteIndexFromPoint(a,t)
if e then
if o.selectedIndex~=e then
o.selectedIndex=e
self:_refreshAutocompleteGhost()
end
if i==1 then
return self:_acceptAutocomplete()
elseif i==2 then
self:_hideAutocomplete()
return true
end
elseif i==2 then
self:_hideAutocomplete()
return true
end
return true
end
if self:containsPoint(a,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local o=e.scrollbarX
if a>=o and a<o+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.contentHeight then
local t=t-e.innerY
local e=D(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
if e~=self._scrollY then
self._scrollY=e
end
return true
end
end
local t,e=self:_cursorFromPoint(a,t)
if i==1 then
self:_setCursorPosition(t,e)
self._dragging=true
self._dragButton=i
self._dragAnchor={line=t,col=e}
elseif i==2 then
self:_setCursorPosition(t,e)
end
return true
end
if o and o.visible and not self:_isPointInAutocomplete(a,t)then
self:_hideAutocomplete()
end
elseif t=="mouse_drag"then
local o,a,t=...
local e=self._autocompleteState
if e and e.visible and self:_isPointInAutocomplete(a,t)then
local t=self:_autocompleteIndexFromPoint(a,t)
if t and e.selectedIndex~=t then
e.selectedIndex=t
self:_refreshAutocompleteGhost()
end
return true
end
if self._dragging and o==self._dragButton then
local t,e=self:_cursorFromPoint(a,t)
if not self._selectionAnchor and self._dragAnchor then
self._selectionAnchor={line=self._dragAnchor.line,col=self._dragAnchor.col}
end
self:_setCursorPosition(t,e,{extendSelection=true,keepAutocomplete=true})
return true
end
elseif t=="mouse_move"then
local t,a=...
local e=self._autocompleteState
if e and e.visible then
local t=self:_autocompleteIndexFromPoint(t,a)
if t and e.selectedIndex~=t then
e.selectedIndex=t
self:_refreshAutocompleteGhost()
end
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
local e,o,t=...
local a=self._autocompleteState
if a and a.visible and self:_isPointInAutocomplete(o,t)then
self.app:setFocus(self)
local e=self:_autocompleteIndexFromPoint(o,t)
if e then
if a.selectedIndex~=e then
a.selectedIndex=e
self:_refreshAutocompleteGhost()
end
return self:_acceptAutocomplete()
end
self:_hideAutocomplete()
return true
end
if self:containsPoint(o,t)then
self.app:setFocus(self)
local e=self:_computeLayoutMetrics()
if e.scrollbarStyle and e.scrollbarWidth>0 then
local a=e.scrollbarX
if o>=a and o<a+e.scrollbarWidth and t>=e.innerY and t<e.innerY+e.contentHeight then
local t=t-e.innerY
local e=D(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
if e~=self._scrollY then
self._scrollY=e
end
return true
end
end
local t,e=self:_cursorFromPoint(o,t)
self:_setCursorPosition(t,e)
return true
end
if a and a.visible then
self:_hideAutocomplete()
end
elseif t=="mouse_scroll"then
local e,a,t=...
local o=self._autocompleteState
if o and o.visible and self:_isPointInAutocomplete(a,t)then
if e>0 then
self:_moveAutocompleteSelection(1)
elseif e<0 then
self:_moveAutocompleteSelection(-1)
end
return true
end
if self:containsPoint(a,t)then
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
function y.create(a)
if a~=nil then
t(1,a,"table")
end
a=a or{}
local h=false
local i
local o=a.window
if o==nil then
i=Y.current()
local e,t=i.getSize()
o=ee.create(i,1,1,e,t,true)
o.setVisible(true)
h=true
end
local t=Q.new(o)
t.profiler.start_frame()
t.profiler.start_region("user")
local u=t.add_pixel_layer(5,"pixelui_pixels")
local c=t.add_text_layer(10,"pixelui_ui")
local d,l=o.getSize()
local n=a.background or e.black
t.fill(n)
local r=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=o,
box=t,
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
t.root=q:new(t,{
x=1,
y=1,
width=d,
height=l,
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
return q:new(self,e)
end
function s:createWindow(e)
return d:new(self,e)
end
function s:createButton(e)
return N:new(self,e)
end
function s:createLabel(e)
return E:new(self,e)
end
function s:createCheckBox(e)
return z:new(self,e)
end
function s:createToggle(e)
return b:new(self,e)
end
function s:createTextBox(e)
return o:new(self,e)
end
function s:createComboBox(e)
return j:new(self,e)
end
function s:createTabControl(e)
return c:new(self,e)
end
function s:createContextMenu(e)
return m:new(self,e)
end
function s:createList(e)
return f:new(self,e)
end
function s:createTable(e)
return r:new(self,e)
end
function s:createTreeView(e)
return u:new(self,e)
end
function s:createChart(e)
return w:new(self,e)
end
function s:createRadioButton(e)
return g:new(self,e)
end
function s:createProgressBar(e)
return k:new(self,e)
end
function s:createNotificationToast(e)
return h:new(self,e)
end
function s:createLoadingRing(e)
return v:new(self,e)
end
function s:createFreeDraw(e)
return S:new(self,e)
end
function s:createSlider(e)
return l:new(self,e)
end
function s:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=T.startTimer(self._animationInterval)
end
end
function s:_updateAnimations()
local a=self._animations
if not a or#a==0 then
return
end
local o=T.clock()
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
local o=e.onComplete
if o~=nil and type(o)~="function"then
error("options.onComplete must be a function",2)
end
local i=e.onCancel
if i~=nil and type(i)~="function"then
error("options.onCancel must be a function",2)
end
local t=e.easing
if t==nil then
t=H.linear
elseif type(t)=="string"then
t=H[t]
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
onComplete=o,
onCancel=i,
easing=t,
duration=e,
startTime=T.clock()
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
local p="completed"
local _="error"
local i="cancelled"
local A={}
local function I(e,t,...)
if not e then
return
end
for a=1,#e do
local e=e[a]
local a,e=pcall(e,...)
if not a then
print(t..tostring(e))
end
end
end
function x:getId()
return self.id
end
function x:getName()
return self.name
end
function x:setName(e)
t(1,e,"string")
self.name=e
end
function x:getStatus()
return self.status
end
function x:isRunning()
return self.status==a
end
function x:isFinished()
local e=self.status
return e==p or e==_ or e==i
end
function x:isCancelled()
return self._cancelRequested or self.status==i
end
function x:cancel()
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
function x:getResult()
if not self.result then
return nil
end
return K(self.result,1,self.result.n or#self.result)
end
function x:getResults()
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
function x:getError()
return self.error
end
function x:setMetadata(e,a)
t(1,e,"string")
local t=self.metadata[e]
if t==a then
return
end
self.metadata[e]=a
self:_emitMetadata(e,a)
end
function x:getMetadata(e)
t(1,e,"string")
return self.metadata[e]
end
function x:getAllMetadata()
local e={}
for t,a in pairs(self.metadata)do
e[t]=a
end
return e
end
function x:onStatusChange(e)
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
function x:onMetadataChange(e)
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
function x:_emitMetadata(e,t)
I(self._metadataListeners,"Thread metadata listener error: ",self,e,t)
end
function x:_setStatus(e)
if self.status==e then
return
end
self.status=e
I(self._statusListeners,"Thread status listener error: ",self,e)
end
local function I(e)
return setmetatable({_handle=e},O)
end
function O:checkCancelled()
if self._handle._cancelRequested then
error(A,0)
end
end
function O:isCancelled()
return self._handle._cancelRequested==true
end
function O:sleep(a)
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
local a=T.startTimer(a)
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
function O:yield()
self:checkCancelled()
self._handle.waiting="yield"
return coroutine.yield("yield")
end
function O:setMetadata(e,t)
self._handle:setMetadata(e,t)
end
function O:setStatus(e)
self._handle:setMetadata("status",e)
end
function O:setDetail(e)
self._handle:setMetadata("detail",e)
end
function O:setProgress(e)
if e~=nil then
t(1,e,"number")
end
self._handle:setMetadata("progress",e)
end
function O:getHandle()
return self._handle
end
function s:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
self._threadTicker=T.startTimer(0)
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
e:_setStatus(i)
self:_cleanupThread(e)
return
end
local t=e._resumeValue
e._resumeValue=nil
local a=B(coroutine.resume(e.co,t))
local t=a[1]
if not t then
local t=a[2]
if t==A then
e:_setStatus(i)
else
if type(t)=="string"and debug and debug.traceback then
t=debug.traceback(e.co,t)
end
e.error=t
print("PixelUI thread error: "..tostring(t))
e:_setStatus(_)
end
self:_cleanupThread(e)
return
end
if coroutine.status(e.co)=="dead"then
local o={n=a.n-1}
for t=2,a.n do
o[t-1]=a[t]
end
e.result=o
e:_setStatus(p)
self:_cleanupThread(e)
return
end
local t=a[2]
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
e:_setStatus(i)
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
},x)
local a=coroutine.create(function()
local e=I(t)
t._context=e
local e=B(o(e,self))
return K(e,1,e.n)
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
local o=self.layer
local i=self.pixelLayer
local t=1
while t<=#a do
local e=a[t]
if e and e._open and e.visible~=false then
e:_drawDropdown(o,i)
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
function s:_selectRadioInGroup(a,t,o)
if not a then
return
end
o=not not o
local i=self._radioGroups
local e=i[a]
if not e then
e={buttons={},lookup={},selected=nil}
i[a]=e
end
if t then
if not e.lookup[t]then
e.lookup[t]=true
e.buttons[#e.buttons+1]=t
end
t._registeredGroup=a
end
e.selected=t
for a=1,#e.buttons do
local e=e.buttons[a]
if e then
if e==t then
e:_applySelection(true,o)
else
e:_applySelection(false,o)
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
self._animationTimer=T.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or Y.current()
local e,t=e.getSize()
if self.window.reposition then
self.window.reposition(1,1,e,t)
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
local e={te()}
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
y.widgets={
Frame=function(t,e)
return q:new(t,e)
end,
Window=function(t,e)
return d:new(t,e)
end,
Button=function(t,e)
return N:new(t,e)
end,
Label=function(e,t)
return E:new(e,t)
end,
CheckBox=function(e,t)
return z:new(e,t)
end,
Toggle=function(e,t)
return b:new(e,t)
end,
TextBox=function(t,e)
return o:new(t,e)
end,
ComboBox=function(e,t)
return j:new(e,t)
end,
TabControl=function(e,t)
return c:new(e,t)
end,
ContextMenu=function(e,t)
return m:new(e,t)
end,
List=function(t,e)
return f:new(t,e)
end,
Table=function(t,e)
return r:new(t,e)
end,
TreeView=function(e,t)
return u:new(e,t)
end,
Chart=function(t,e)
return w:new(t,e)
end,
RadioButton=function(e,t)
return g:new(e,t)
end,
ProgressBar=function(e,t)
return k:new(e,t)
end,
Slider=function(e,t)
return l:new(e,t)
end,
LoadingRing=function(e,t)
return v:new(e,t)
end,
FreeDraw=function(e,t)
return S:new(e,t)
end,
NotificationToast=function(t,e)
return h:new(t,e)
end
}
y.Widget=n
y.Frame=q
y.Window=d
y.Button=N
y.Label=E
y.CheckBox=z
y.Toggle=b
y.TextBox=o
y.ComboBox=j
y.TabControl=c
y.ContextMenu=m
y.List=f
y.Table=r
y.TreeView=u
y.Chart=w
y.RadioButton=g
y.ProgressBar=k
y.Slider=l
y.LoadingRing=v
y.FreeDraw=S
y.NotificationToast=h
y.easings=H
y.ThreadHandle=x
y.ThreadContext=O
y.threadStatus={
running=a,
completed=p,
error=_,
cancelled=i
}
return y
