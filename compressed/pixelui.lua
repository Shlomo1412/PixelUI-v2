local oe=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local O=assert(rawget(_G,"os"),"os API unavailable")
local ne=assert(O.pullEvent,"os.pullEvent unavailable")
local ie=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local ae=table.pack or function(...)
return{n=select("#",...),...}
end
local te=assert(table.unpack,"table.unpack unavailable")
local t=require("cc.expect").expect
local ee=require("shrekbox")
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
local s={}
s.__index=s
local g={}
g.__index=g
setmetatable(g,{__index=s})
local i={}
i.__index=i
setmetatable(i,{__index=g})
local R={}
R.__index=R
setmetatable(R,{__index=s})
local E={}
E.__index=E
setmetatable(E,{__index=s})
local z={}
z.__index=z
setmetatable(z,{__index=s})
local b={}
b.__index=b
setmetatable(b,{__index=s})
local q={}
q.__index=q
setmetatable(q,{__index=s})
local l={}
l.__index=l
setmetatable(l,{__index=s})
local j={}
j.__index=j
local S={}
S.__index=S
local f={}
f.__index=f
setmetatable(f,{__index=s})
local d={}
d.__index=d
setmetatable(d,{__index=s})
local u={}
u.__index=u
setmetatable(u,{__index=s})
local w={}
w.__index=w
setmetatable(w,{__index=s})
local k={}
k.__index=k
setmetatable(k,{__index=s})
local x={}
x.__index=x
setmetatable(x,{__index=s})
local c={}
c.__index=c
setmetatable(c,{__index=s})
local m={}
m.__index=m
setmetatable(m,{__index=s})
local r={}
r.__index=r
setmetatable(r,{__index=s})
local v={}
v.__index=v
setmetatable(v,{__index=s})
local D={}
D.__index=D
setmetatable(D,{__index=s})
local h={}
h.__index=h
local p={"top","right","bottom","left"}
local se=string.char(7)
local A={
info={bg=e.blue,fg=e.white,accent=e.lightBlue,icon="i"},
success={bg=e.green,fg=e.black,accent=e.lime,icon="+"},
warning={bg=e.orange,fg=e.black,accent=e.yellow,icon="!"},
error={bg=e.red,fg=e.white,accent=e.white,icon="x"}
}
local function Z(e)
if e==nil then
return"info"
end
local e=tostring(e):lower()
if A[e]then
return e
end
return"info"
end
local function J(e)
if e==nil then
return 1,1,1,1
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
return e,e,e,e
end
local n,s,i,o=1,1,1,1
if type(e)=="table"then
local t=e.horizontal or e.x
local a=e.vertical or e.y
if t~=nil then
t=math.max(0,math.floor(t))
n=t
s=t
end
if a~=nil then
a=math.max(0,math.floor(a))
i=a
o=a
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
local function n(t,a,e)
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
local function X(e)
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
local function Y(e)
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
local function P(t,o)
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
n(t:sub(a),o,e)
break
end
n(t:sub(a,i-1),o,e)
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
local _={
close={
label="X",
fg=e.white,
bg=e.red,
hoverFg=e.white,
hoverBg=e.red,
pressFg=e.lightGray,
pressBg=e.red
},
maximize={
label="[]",
maximizeLabel="[]",
restoreLabel="][",
fg=e.white,
bg=e.gray,
hoverFg=e.white,
hoverBg=e.lightGray,
pressFg=e.black,
pressBg=e.lightGray
},
minimize={
label="_",
fg=e.white,
bg=e.gray,
hoverFg=e.white,
hoverBg=e.lightGray,
pressFg=e.black,
pressBg=e.lightGray
}
}
local function n(a,e)
local a=_[a]
local a=o(a)or{}
if e==nil or e==false or e==true then
return a
end
t(1,e,"table")
if e.label~=nil then
a.label=tostring(e.label)
end
if e.maximizeLabel~=nil then
a.maximizeLabel=tostring(e.maximizeLabel)
end
if e.restoreLabel~=nil then
a.restoreLabel=tostring(e.restoreLabel)
end
if e.fg~=nil then
a.fg=e.fg
end
if e.bg~=nil then
a.bg=e.bg
end
if e.restoreFg~=nil then
a.restoreFg=e.restoreFg
end
if e.restoreBg~=nil then
a.restoreBg=e.restoreBg
end
if e.width~=nil then
local e=math.max(1,math.floor(e.width))
a.width=e
end
if e.padding~=nil then
a.padding=math.max(0,math.floor(e.padding))
end
return a
end
local function I(e)
local t=(type(e)=="table"and e.buttons)or nil
local i
local a
local o
if type(e)=="table"then
i=e.closeButton or(type(t)=="table"and t.close)or nil
a=e.maximizeButton or(type(t)=="table"and t.maximize)or nil
o=e.minimizeButton or(type(t)=="table"and t.minimize)or nil
end
return{
close=n("close",i),
maximize=n("maximize",a),
minimize=n("minimize",o)
}
end
local function n(e,t)
if e==nil then
return t
end
if type(e)=="string"then
return H[e]or t
elseif type(e)=="function"then
return e
end
error("Invalid easing value",3)
end
local function _(e,a)
if e==nil then
return nil
end
if e==false then
return{enabled=false}
end
t(1,e,"table")
local t={
enabled=e.enabled~=false
}
if e.duration~=nil then
if type(e.duration)~="number"then
error("animation duration must be numeric",3)
end
t.duration=math.max(0,e.duration)
end
if e.easing~=nil then
t.easing=n(e.easing,a)
end
return t
end
local function B(e)
local a=.2
local o=H.easeOutQuad
if e==nil then
return{
enabled=true,
duration=a,
easing=o
}
end
t(1,e,"table")
if e.duration~=nil and type(e.duration)~="number"then
error("animation duration must be numeric",3)
end
local t={
enabled=e.enabled~=false,
duration=math.max(0,e.duration or a),
easing=n(e.easing,o)
}
local a={"maximize","minimize","restore"}
for o=1,#a do
local a=a[o]
local e=_(e[a],t.easing)
if e then
t[a]=e
end
end
return t
end
local function W(e)
if e>=0 then
return math.floor(e+.5)
end
return math.ceil(e-.5)
end
local function M(a,e)
t(nil,a,"string")
t(nil,e,"number")
if e<1 or e~=math.floor(e)then
error(('%s must be a positive integer, got "%s"'):format(a,tostring(e)),3)
end
end
local function N(a)
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
local function V(a)
local e=a.border
local t=e and math.max(1,math.floor(e.thickness or 1))or 0
local n=(e and e.left)and t or 0
local i=(e and e.right)and t or 0
local o=(e and e.top)and t or 0
local e=(e and e.bottom)and t or 0
local t=math.max(0,a.width-n-i)
local a=math.max(0,a.height-o-e)
return n,i,o,e,t,a
end
local function G(e,a)
if e==nil then
return{
enabled=a~=false,
height=1,
bg=nil,
fg=nil,
align="left",
buttons=I(nil),
buttonSpacing=1
}
end
if e==false then
return{enabled=false,height=0,bg=nil,fg=nil,align="left",buttons=I(nil),buttonSpacing=1}
end
if e==true then
return{enabled=true,height=1,bg=nil,fg=nil,align="left",buttons=I(nil),buttonSpacing=1}
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
local o=e.buttonSpacing~=nil and math.max(0,math.floor(e.buttonSpacing))or 1
return{
enabled=true,
height=t,
bg=e.bg,
fg=e.fg,
align=a,
buttons=I(e),
buttonSpacing=o
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
local p="^(%a[%w_]*)%.([%a_][%w_]*)$"
local function n(e)
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
local e,a=n(e)
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
local a,o=n(a)
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
local a,i=n(a)
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
local function T(e,t)
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
local e,a=n(e)
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
local e,a=n(a)
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
local function Q(e)
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
t.centerX=T(e.centerX,"x")
end
if e.centerY~=nil then
t.centerY=T(e.centerY,"y")
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
local T=string.char(30)
local _=string.char(31)
local function L(o,s,n)
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
local i=a.trackColor or e.gray
local t=a.thumbColor or e.lightGray
local o=a.arrowColor or n or e.white
local e=a.background or s or e.black
local s=math.max(1,math.floor(a.width or 1))
local n=math.max(1,math.floor(a.minThumbSize or 1))
return{
enabled=true,
alwaysVisible=not not a.alwaysVisible,
width=s,
trackColor=i,
thumbColor=t,
arrowColor=o,
background=e,
minThumbSize=n
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
local function F(e,o,t,a)
if not e or e.enabled==false then
return 0,nil
end
o=math.max(0,o or 0)
t=math.max(0,t or 0)
a=math.max(0,a or 0)
if a<=1 or t<=0 then
return 0,nil
end
if t<=2 then
return 0,nil
end
if not e.alwaysVisible and o<=t then
return 0,nil
end
local a=math.max(1,a-1)
local t=math.max(1,math.floor(e.width or 1))
if t>a then
t=a
end
if t<=0 then
return 0,nil
end
return t,e
end
local function C(o,i,a,t,l,d,m,e)
if not e or t<=0 then
return
end
local h=math.max(1,math.floor(e.width or 1))
local n=e.trackColor
local s=e.arrowColor
local r=e.thumbColor
local c=math.max(1,math.floor(e.minThumbSize or 1))
local e=math.max(0,h-1)
local u=T..string.rep(" ",e)
o.text(i,a,u,s,n)
if t>=2 then
local e=_..string.rep(" ",e)
o.text(i,a+t-1,e,s,n)
end
local a=a+1
local e=math.max(0,t-2)
local t=string.rep(" ",h)
for e=0,e-1 do
o.text(i,a+e,t,n,n)
end
local n=math.max(0,(l or 0)-(d or 0))
if n<=0 or e<=0 then
return
end
local u=math.max(0,math.min(n,math.floor((m or 0)+.5)))
local t=d/l
local t=math.max(c,math.floor(e*t+.5))
if t>e then
t=e
end
if t<1 then
t=1
end
local s=e-t
local e=a
if s>0 then
local t=p(n==0 and 0 or(u/n))
e=a+math.floor(t*s+.5)
if e>a+s then
e=a+s
end
end
local a=string.rep(" ",h)
for t=0,t-1 do
o.text(i,e+t,a,r,r)
end
end
local function U(t,a,i,e,o)
if a<=0 then
return o or 0
end
local e=math.max(0,(i or 0)-(e or 0))
if e<=0 then
return 0
end
local o=math.max(0,math.min(e,math.floor((o or 0)+.5)))
if t<=0 then
return math.max(0,o-1)
elseif t>=a-1 then
return math.min(e,o+1)
end
local a=a-2
if a<=0 then
return o
end
local t=t-1
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
local function n(h,s,n,t,e,o,i,a)
if t<=0 or e<=0 then
return
end
local a=a or" "
local t=a:rep(t)
for e=0,e-1 do
h.text(s,n+e,t,o,i)
end
end
local function T(a,i,n,o,t,s)
if o<=0 or t<=0 or not a then
return
end
local s=s or e.black
local e=(i-1)*2+1
local i=(n-1)*3+1
local o=o*2
local t=t*3
for t=0,t-1 do
local t=i+t
for o=0,o-1 do
a.pixel(e+o,t,s)
end
end
end
local function _(i,n,t,e,a)
if e<=0 or a<=0 then
return
end
local o=ee.transparent
for e=0,e-1 do
i.pixel(n+e,t,o)
if a>1 then
i.pixel(n+e,t+a-1,o)
end
end
for a=1,math.max(0,a-2)do
i.pixel(n,t+a,o)
if e>1 then
i.pixel(n+e-1,t+a,o)
end
end
end
local function p(r,t,h,o,i,e,a)
if o<=0 or i<=0 then
return
end
local n=e.color
local s=a or n
local a=(t-1)*2+1
local t=(h-1)*3+1
local o=o*2
local i=i*3
local l=3
local u=2
local h=math.min(e.thickness,i)
local d=math.min(e.thickness,o)
local l=math.min(i,math.max(h,l))
local u=math.min(o,math.max(d,u))
local function c(e,s,n)
for s=0,s-1 do
local e=e+s
if e<t or e>=t+i then break end
for t=0,o-1 do
r.pixel(a+t,e,n)
end
end
end
local function m(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
r.pixel(a+t,e,n)
end
end
end
local function f(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+o then break end
for a=0,i-1 do
r.pixel(e,t+a,n)
end
end
end
local function w(n,e,s)
for e=0,e-1 do
local e=n+e
if e<a or e>=a+o then break end
for a=0,i-1 do
r.pixel(e,t+a,s)
end
end
end
if e.left then
f(a,u,s)
end
if e.right then
f(a+o-u,u,s)
end
if e.top then
c(t,l,s)
end
if e.bottom then
c(t+i-l,l,s)
end
if e.top then
m(t,h,n)
end
if e.bottom then
m(t+i-h,h,n)
end
if e.left then
w(a,d,n)
end
if e.right then
w(a+o-d,d,n)
end
end
function r:new(i,a)
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
local e=setmetatable({},r)
e:_init_base(i,t)
e.focusable=false
local i=a.anchor~=nil
local t=X(a.anchor)
if not t and not i then
if a.x~=nil or a.y~=nil then
t=nil
else
t="top_right"
end
end
e.anchor=t
e.anchorMargins=Y(a.anchorMargin)
e.anchorAnimationDuration=math.max(.05,tonumber(a.anchorAnimationDuration)or .2)
e.anchorEasing=a.anchorEasing or"easeOutCubic"
e._anchorDirty=true
e._anchorAnimationHandle=nil
e.title=a.title~=nil and tostring(a.title)or nil
e.message=a.message~=nil and tostring(a.message)or""
e.icon=a.icon~=nil and tostring(a.icon)or nil
e.severity=Z(a.severity)
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
e.paddingLeft,e.paddingRight,e.paddingTop,e.paddingBottom=J(a.padding)
e._hideTimer=nil
e._wrappedLines={""}
e._lastWrapWidth=nil
e._lastMessage=nil
e:_refreshWrap(true)
return e
end
function r:_applyPadding(e,i)
local o,a,e,t=J(e)
if i or o~=self.paddingLeft or a~=self.paddingRight or e~=self.paddingTop or t~=self.paddingBottom then
self.paddingLeft=o
self.paddingRight=a
self.paddingTop=e
self.paddingBottom=t
self:_refreshWrap(true)
self._anchorDirty=true
end
end
function r:setPadding(e)
self:_applyPadding(e,false)
end
function r:getAnchor()
return self.anchor
end
function r:getAnchorMargins()
return o(self.anchorMargins)
end
function r:refreshAnchor(e)
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
function r:setAnchor(e)
local t=X(e)
if t==nil and e~=nil then
self.anchor=nil
else
self.anchor=t
end
self:refreshAnchor(false)
end
function r:setAnchorMargin(e)
self.anchorMargins=Y(e)
self:refreshAnchor(false)
end
function r:_computeAnchorPosition()
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
local h=self.width
local s=self.height
local a=self.anchorMargins or Y(nil)
local t
local e
if o=="top_right"then
t=i-h-(a.right or 0)+1
e=(a.top or 0)+1
elseif o=="top_left"then
t=(a.left or 0)+1
e=(a.top or 0)+1
elseif o=="bottom_right"then
t=i-h-(a.right or 0)+1
e=n-s-(a.bottom or 0)+1
elseif o=="bottom_left"then
t=(a.left or 0)+1
e=n-s-(a.bottom or 0)+1
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
if e+s-1>n then
e=math.max(1,n-s+1)
end
return t,e
end
function r:getAnchorTargetPosition()
return self:_computeAnchorPosition()
end
function r:_applyAnchorPosition(a)
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
local n=math.max(2,math.floor(self.width/6))
local i=math.max(1,math.floor(self.height/3))
local a=e
local o=t
if self.anchor=="top_right"then
a=e+n
o=math.max(1,t-i)
elseif self.anchor=="top_left"then
a=e-n
o=math.max(1,t-i)
elseif self.anchor=="bottom_right"then
a=e+n
o=t+i
elseif self.anchor=="bottom_left"then
a=e-n
o=t+i
end
s.setPosition(self,a,o)
local r=self.anchorAnimationDuration or .2
local h=self.anchorEasing or"easeOutCubic"
local i=a
local a=o
local n=e-i
local o=t-a
self._anchorAnimationHandle=self.app:animate({
duration=r,
easing=h,
update=function(e)
local t=math.floor(i+n*e+.5)
local e=math.floor(a+o*e+.5)
s.setPosition(self,t,e)
end,
onComplete=function()
s.setPosition(self,e,t)
self._anchorAnimationHandle=nil
end,
onCancel=function()
s.setPosition(self,e,t)
self._anchorAnimationHandle=nil
end
})
self._anchorDirty=false
return
end
if self.x~=e or self.y~=t then
s.setPosition(self,e,t)
end
self._anchorDirty=false
end
function r:_getActiveBorder()
if self.border then
return self.border
end
return nil
end
function r:_refreshWrap(o,t)
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
self._wrappedLines=P(self.message,e)
self._lastWrapWidth=e
self._lastMessage=self.message
end
function r:_getStyle()
local a=self.severity
local e=A.info
if a~=nil then
local t=A[a]
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
for e,a in pairs(self.styleOverride)do
t[e]=a
end
end
return t or e
end
function r:_cancelTimer()
if self._hideTimer then
if O.cancelTimer then
pcall(O.cancelTimer,self._hideTimer)
end
self._hideTimer=nil
end
end
function r:_scheduleHide(e)
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
self._hideTimer=O.startTimer(e)
end
function r:setTitle(e)
if e==nil then
self.title=nil
else
self.title=tostring(e)
end
end
function r:getTitle()
return self.title
end
function r:setMessage(e)
if e==nil then
e=""
end
local e=tostring(e)
if self.message~=e then
self.message=e
self:_refreshWrap(true)
end
end
function r:getMessage()
return self.message
end
function r:setSeverity(e)
local e=Z(e)
if self.severity~=e then
self.severity=e
end
end
function r:getSeverity()
return self.severity
end
function r:setIcon(e)
if e==nil or e==""then
self.icon=nil
return
end
self.icon=tostring(e)
end
function r:getIcon()
return self.icon
end
function r:setAutoHide(e)
e=not not e
if self.autoHide~=e then
self.autoHide=e
if not e then
self:_cancelTimer()
end
end
end
function r:isAutoHide()
return self.autoHide
end
function r:setDuration(e)
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
function r:getDuration()
return self.duration
end
function r:setDismissOnClick(e)
self.dismissOnClick=not not e
end
function r:isDismissOnClick()
return self.dismissOnClick
end
function r:setOnDismiss(e)
if e~=nil and type(e)~="function"then
error("onDismiss handler must be a function",2)
end
self.onDismiss=e
end
function r:setVariants(e)
if e~=nil and type(e)~="table"then
error("variants must be a table",2)
end
self.variantOverrides=e and o(e)or nil
end
function r:setStyle(e)
if e~=nil and type(e)~="table"then
error("style must be a table",2)
end
self.styleOverride=e and o(e)or nil
end
function r:present(e)
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
function r:show(t)
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
function r:hide(t)
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
function r:setSize(e,t)
s.setSize(self,e,t)
self:_refreshWrap(true)
self._anchorDirty=true
if self.anchor then
self:_applyAnchorPosition(false)
end
end
function r:setBorder(e)
s.setBorder(self,e)
self:_refreshWrap(true)
self._anchorDirty=true
end
function r:_renderLine(n,i,o,t,e,a,s)
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
n.text(i,o,e,a,s)
end
function r:draw(s,l)
if not self.visible then
return
end
if self._anchorDirty and not self._anchorAnimationHandle then
self:_applyAnchorPosition(false)
end
local h,r,o,a=self:getAbsoluteRect()
if o<=0 or a<=0 then
return
end
local i=self:_getStyle()or A.info
local t=i.bg or self.bg or e.gray
local d=i.fg or self.fg or e.white
local c=i.accent or d
local m=i.titleColor or d
local u=i.iconColor or c
n(s,h,r,o,a,t,t)
_(s,h,r,o,a)
local e=self.border
if e then
p(l,h,r,o,a,e,t)
else
p(l,h,r,o,a,{
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
local c=(e and e.right)and e.thickness or 0
local n=(e and e.top)and e.thickness or 0
local f=(e and e.bottom)and e.thickness or 0
local h=h+l
local e=r+n
local o=math.max(0,o-l-c)
local a=math.max(0,a-n-f)
local h=h+(self.paddingLeft or 0)
local e=e+(self.paddingTop or 0)
local n=math.max(0,o-(self.paddingLeft or 0)-(self.paddingRight or 0))
local o=math.max(0,a-(self.paddingTop or 0)-(self.paddingBottom or 0))
if n<=0 or o<=0 then
return
end
local a=self.icon
if not a or a==""then
a=i.icon or""
end
a=tostring(a or"")
local i=0
local r=h
local e=e
if a~=""and n>0 then
local a=a:sub(1,1)
s.text(h,e,a,u,t)
if n>=3 then
s.text(h+1,e," ",u,t)
i=2
else
i=1
end
r=h+i
end
local a=math.max(0,n-i)
self:_refreshWrap(false,a)
if self.title and self.title~=""and o>0 and a>0 then
self:_renderLine(s,r,e,a,self.title,m,t)
e=e+1
o=o-1
end
if o>0 and a>0 then
local i=self._wrappedLines or{""}
local o=math.min(o,#i)
for o=1,o do
self:_renderLine(s,r,e,a,i[o],d,t)
e=e+1
end
end
end
function r:handleEvent(e,...)
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
function r:onFocusChanged()
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
if O.cancelTimer then
pcall(O.cancelTimer,self._tickTimer)
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
self._tickTimer=O.startTimer(self.speed)
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
function v:draw(h,r)
if not self.visible then
return
end
local i,o,t,a=self:getAbsoluteRect()
if t<=0 or a<=0 then
return
end
local e=self.bg or self.app.background
n(h,i,o,t,a,e,e)
_(h,i,o,t,a)
if self.border then
p(r,i,o,t,a,self.border,e)
end
local d=(self.border and self.border.left)and 1 or 0
local u=(self.border and self.border.right)and 1 or 0
local l=(self.border and self.border.top)and 1 or 0
local c=(self.border and self.border.bottom)and 1 or 0
local s=i+d
local i=o+l
local o=math.max(0,t-d-u)
local a=math.max(0,a-l-c)
if o<=0 or a<=0 then
return
end
n(h,s,i,o,a,e,e)
local u=s+(o-1)/2
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
local f=n*n
local m=t*t
local t=math.max(3,math.floor(self.segmentCount or 12))
local h=self._phase%t
local c=self.direction>=0 and 1 or-1
local n=math.pi*2
local w=self:_computeTrailColors()
for a=0,a-1 do
local d=i+a
local a=d-l
for o=0,o-1 do
local l=s+o
local o=l-u
local s=o*o+a*a
local i=e
if s<=f and s>=m then
local a=math.atan(a,o)
if a<0 then
a=a+n
end
local o=math.floor(a/n*t)%t
local a
if c>=0 then
a=(h-o)%t
else
a=(o-h)%t
end
if a==0 then
i=self.color or e
else
local t=math.floor(a+1e-4)
if t<1 then
t=1
end
i=w[t]or e
end
end
r.pixel(l,d,i)
end
end
end
function v:handleEvent(t,...)
if t=="timer"then
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
return s.handleEvent(self,t,...)
end
local function A(e)
local a,t=e.x,e.y
local e=e.parent
while e do
a=a+e.x-1
t=t+e.y-1
e=e.parent
end
return a,t
end
function s:_init_base(o,a)
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
self.border=N(a.border)
self.focusable=a.focusable==true
self._focused=false
self.constraints=nil
M("width",self.width)
M("height",self.height)
if a.constraints~=nil then
self.constraints=Q(a.constraints)
local t,e=self:_applySizeConstraints(self.width,self.height)
self.width=t
self.height=e
end
end
function s:setSize(e,t)
M("width",e)
M("height",t)
local e,t=self:_applySizeConstraints(e,t)
self.width=e
self.height=t
end
function s:_applyConstraintLayout()
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
local n=e and e.width or nil
local i=e and e.height or nil
if not o and t.widthPercent and n then
o=math.max(1,math.floor(n*t.widthPercent+.5))
end
if not a and t.heightPercent and i then
a=math.max(1,math.floor(i*t.heightPercent+.5))
end
local o=o or self.width
local a=a or self.height
local o,a=self:_applySizeConstraints(o,a)
if o~=self.width or a~=self.height then
self:setSize(o,a)
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
local e=self.x
local a=self.y
local o=h(t.centerX,"x",n,self.width,o)
if o then
e=o
end
local t=h(t.centerY,"y",i,self.height,s)
if t then
a=t
end
if e~=self.x or a~=self.y then
self:setPosition(e,a)
end
end
function s:_applySizeConstraints(e,t)
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
function s:setConstraints(e)
if e==nil or e==false then
self.constraints=nil
else
self.constraints=Q(e)
end
local e,t=self:_applySizeConstraints(self.width,self.height)
if e~=self.width or t~=self.height then
self:setSize(e,t)
end
self:_applyConstraintLayout()
end
local function M(e)
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
local function Y(e)
if not e then
return nil
end
local t=string.format("%s.%s",e.target or"parent",e.property or"center")
if e.offset and e.offset~=0 then
return{reference=t,offset=e.offset}
end
return t
end
function s:getConstraints()
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
local a=M(e.width)
if a~=nil then
t.width=a
end
local a=M(e.height)
if a~=nil then
t.height=a
end
if e.widthPercent then
t.widthPercent=e.widthPercent
end
if e.heightPercent then
t.heightPercent=e.heightPercent
end
local a=Y(e.centerX)
if a~=nil then
t.centerX=a
end
local a=Y(e.centerY)
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
function s:setPosition(e,a)
t(1,e,"number")
t(2,a,"number")
self.x=math.floor(e)
self.y=math.floor(a)
end
function s:setZ(e)
t(1,e,"number")
self.z=e
end
function s:setBorder(e)
if e==nil then
self.border=nil
return
end
if e==false then
self.border=nil
return
end
if e==true then
self.border=N(true)
return
end
t(1,e,"table","boolean")
self.border=N(e)
end
function s:isFocused()
return self._focused
end
function s:setFocused(e)
e=not not e
if self._focused==e then
return
end
self._focused=e
self:onFocusChanged(e)
end
function s:onFocusChanged(e)
end
function s:getAbsoluteRect()
local t,e=A(self)
return t,e,self.width,self.height
end
function s:containsPoint(a,t)
local e,o,n,i=self:getAbsoluteRect()
return a>=e and a<e+n and t>=o and t<o+i
end
function s:draw(e,e)
error("draw needs implementation for widget",2)
end
function s:handleEvent(e,...)
return false
end
function g:new(a,t)
local e=setmetatable({},g)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function g:addChild(e)
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
function g:_applyConstraintsToChildren()
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
function g:setSize(e,t)
s.setSize(self,e,t)
self:_applyConstraintsToChildren()
end
function g:removeChild(e)
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
local function M(e)
local a={}
for t=1,#e do
a[t]=e[t]
end
return a
end
local function Y(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function g:getChildren()
return M(self._children)
end
function g:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function g:draw(h,r)
if not self.visible then
return
end
local s,i,o,a=self:getAbsoluteRect()
local e=self.bg or self.app.background
local d,u=s+1,i+1
local t=math.max(0,o-2)
local l=math.max(0,a-2)
if t>0 and l>0 then
n(h,d,u,t,l,e,e)
T(r,d,u,t,l,e)
elseif o>0 and a>0 then
n(h,s,i,o,a,e,e)
T(r,s,i,o,a,e)
end
_(h,s,i,o,a)
local n=self.title
if type(n)=="string"and#n>0 then
local o=t>0 and t or o
local s=t>0 and d or s
local a=(a>2)and(i+1)or i
if o>0 then
local t=n
if#t>o then
t=t:sub(1,o)
end
if#t<o then
t=t..string.rep(" ",o-#t)
end
h.text(s,a,t,self.fg,e)
end
end
if self.border then
p(r,s,i,o,a,self.border,e)
end
local e=M(self._children)
Y(e)
for t=1,#e do
e[t]:draw(h,r)
end
end
function g:handleEvent(t,...)
if not self.visible then
return false
end
if s.handleEvent(self,t,...)then
return true
end
local e=M(self._children)
Y(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function i:new(e,t)
t=t or{}
local e=g.new(g,e,t)
setmetatable(e,i)
e.draggable=t.draggable~=false
e.resizable=t.resizable~=false
e.closable=t.closable~=false
e.maximizable=t.maximizable~=false
e.minimizable=t.minimizable~=false
e.hideBorderWhenMaximized=t.hideBorderWhenMaximized~=false
e._titleBar=G(t.titleBar,nil)
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
e._isMinimized=false
e._restoreRect=nil
e._normalRect=nil
local a=t.geometryAnimation or t.windowAnimation or t.animation
e._geometryAnimation=B(a)
e._geometryAnimationHandle=nil
if t.minimizedHeight~=nil then
if type(t.minimizedHeight)~="number"then
error("minimizedHeight must be numeric",2)
end
e.minimizedHeight=math.max(1,math.floor(t.minimizedHeight))
end
e.onMinimize=t.onMinimize
return e
end
function i:_refreshTitleBarState()
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
function i:_invalidateTitleLayout()
self._titleLayoutCache=nil
self._titleButtonRects=nil
end
function i:_isBorderVisible()
if not self.border then
return false
end
if self._isMaximized and self.hideBorderWhenMaximized then
return false
end
return true
end
function i:_computeInnerOffsets()
if self:_isBorderVisible()then
return V(self)
end
return 0,0,0,0,self.width,self.height
end
function i:_resolveGeometryAnimation(i)
local e=self._geometryAnimation or{enabled=false,duration=0,easing=H.linear}
local a=e.enabled~=false
local t=e.duration or 0
local o=e.easing or H.linear
local e=e[i]
if e then
if e.enabled~=nil then
a=e.enabled
end
if e.duration~=nil then
t=e.duration
end
if e.easing~=nil then
o=e.easing
end
end
if t<0 then
t=0
end
return a,t,o
end
function i:_stopGeometryAnimation()
if not self._geometryAnimationHandle then
return
end
local e=self._geometryAnimationHandle
self._geometryAnimationHandle=nil
if e.cancel then
e:cancel()
end
end
function i:_applyGeometry(e)
if not e then
return
end
local o=W(e.x or self.x)
local a=W(e.y or self.y)
local t=math.max(1,W(e.width or self.width))
local e=math.max(1,W(e.height or self.height))
if o~=self.x or a~=self.y then
s.setPosition(self,o,a)
end
if t~=self.width or e~=self.height then
g.setSize(self,t,e)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
end
function i:_transitionGeometry(e,t,a)
if not t then
if a then
a()
end
return
end
local e,i,s=self:_resolveGeometryAnimation(e)
if not self.app or not e or i<=0 then
self:_applyGeometry(t)
if a then
a()
end
return
end
self:_stopGeometryAnimation()
local e={
x=self.x,
y=self.y,
width=self.width,
height=self.height
}
local o={
x=t.x-e.x,
y=t.y-e.y,
width=t.width-e.width,
height=t.height-e.height
}
local n
n=self.app:animate({
duration=i,
easing=s,
update=function(t)
local e={
x=e.x+o.x*t,
y=e.y+o.y*t,
width=e.width+o.width*t,
height=e.height+o.height*t
}
self:_applyGeometry(e)
end,
onComplete=function()
self._geometryAnimationHandle=nil
self:_applyGeometry(t)
if a then
a()
end
end,
onCancel=function()
self._geometryAnimationHandle=nil
end
})
self._geometryAnimationHandle=n
end
function i:_computeTitleLayout()
local r=self:_getVisibleTitleBarHeight()
local a=self._titleBar
if r<=0 or not a or not a.enabled then
self:_invalidateTitleLayout()
return nil
end
local t,n=A(self)
local e,i=self:_computeInnerOffsets()
local o=t+e
local i=math.max(0,self.width-e-i)
if i<=0 then
o=t
i=self.width
end
local e={
barX=t,
barY=n,
barWidth=self.width,
barHeight=r,
innerX=o,
innerWidth=i,
textBaseline=n,
buttonRects={},
buttonOrder={},
buttonMetrics={},
maximizeState=self._isMaximized and"restore"or"maximize"
}
local d=a.buttons or I(nil)
local l=math.max(0,math.floor(a.buttonSpacing or 1))
local s=t+math.max(0,self.width-1)
local function u(o)
local e=d[o]
if not e then
return nil
end
local n=math.max(0,e.padding or 0)
local t=e.width
if t==nil then
local a=tostring(e.label or"")
local i=a
if o=="maximize"then
local t=tostring(e.maximizeLabel or a)
local e=tostring(e.restoreLabel or t)
i=e
a=t
end
local e=math.max(#a,#i)
t=math.max(1,e+n*2)
else
t=math.max(1,math.floor(t))
end
return e,t,n
end
local function h(o)
local i,a,d=u(o)
if not i or a<=0 then
return nil
end
if s-a+1<t then
return nil
end
local t=s
local h=t-a+1
local t={x1=h,y1=n,x2=t,y2=n,width=a,height=r}
e.buttonRects[o]=t
e.buttonOrder[#e.buttonOrder+1]=o
e.buttonMetrics[o]={style=i,padding=d,width=a}
s=h-l-1
return t
end
if self.closable then
h("close")
end
if self.maximizable then
h("maximize")
end
if self.minimizable then
h("minimize")
end
e.titleStart=o
e.titleEnd=s
if e.titleEnd<e.titleStart then
e.titleWidth=0
else
e.titleWidth=e.titleEnd-e.titleStart+1
end
e.innerSpacing=l
e.buttonStyles=d
e.textFillX=o
e.textFillWidth=i
self._titleLayoutCache=e
self._titleButtonRects=e.buttonRects
return e
end
function i:_hitTestTitleButton(a,t)
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
function i:_drawTitleButton(l,m,a,r,d,c)
local e=a.buttonRects and a.buttonRects[r]
if not e then
return
end
local t=a.buttonMetrics and a.buttonMetrics[r]
if not t then
return
end
local o=t.style or{}
local u=math.max(0,t.padding or 0)
local i=e.width-u*2
if i<=0 then
return
end
local h=o.fg or d
local s=o.bg or c
local t=tostring(o.label or"")
if r=="maximize"then
local e=tostring(o.maximizeLabel or t)
local i=tostring(o.restoreLabel or e)
if a.maximizeState=="restore"then
t=i
h=o.restoreFg or h
s=o.restoreBg or s
else
t=e
end
end
if#t>i then
t=t:sub(1,i)
end
local o=s or c or self.bg or self.app.background
n(l,e.x1,e.y1,e.width,a.barHeight,o,o)
T(m,e.x1,e.y1,e.width,a.barHeight,o)
if#t>0 then
local a=e.x1+u
local i=math.floor((i-#t)/2)
if i>0 then
a=a+i
end
l.text(a,e.y1,t,h or d,o)
end
end
function i:_fillTitleBarPixels(t,e,n)
if not t or not e then
return
end
local i=(e.barX-1)*2+1
local a=(e.barY-1)*3+1
local o=e.barWidth*2
local e=math.min(e.barHeight*3,self.height*3)
for s=0,e-1 do
for e=0,o-1 do
t.pixel(i+e,a+s,n)
end
end
end
function i:_hitTestResize(a,s)
if not self.resizable then
return nil
end
local o,e=A(self)
local n=o+math.max(0,self.width-1)
local i=e+math.max(0,self.height-1)
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
if s>=i-t+1 and s<=i then
e.bottom=true
end
if not e.right and not e.left and not e.bottom then
return nil
end
return e
end
function i:_beginResize(o,i,a,t,e)
if not e then
return
end
self:_restoreFromMaximize()
self._resizing=true
self._resizeSource=o
self._resizeIdentifier=i
self._resizeEdges=e
local e=self.constraints or{}
self._resizeStart={
pointerX=a,
pointerY=t,
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
function i:_updateResize(a,t)
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
function i:_endResize()
self._resizing=false
self._resizeSource=nil
self._resizeIdentifier=nil
self._resizeEdges=nil
self._resizeStart=nil
end
function i:_restoreFromMaximize()
if not self._isMaximized and not self._isMinimized then
return
end
self:restore(true)
end
function i:_computeMaximizedGeometry()
local e=self.parent
if e then
local a,n,o,n,t,i=V(e)
local t=math.max(1,t)
local i=math.max(1,i)
local a=a+1
local o=o+1
if self.app and e==self.app.root then
a=1
o=1
t=e.width
i=e.height
end
return{x=a,y=o,width=t,height=i}
end
local e=self.app and self.app.root or nil
if e then
return{x=1,y=1,width=e.width,height=e.height}
end
return{x=self.x,y=self.y,width=self.width,height=self.height}
end
function i:_computeMinimizedGeometry()
local t=self._restoreRect or{x=self.x,y=self.y,width=self.width,height=self.height}
local e
if self.minimizedHeight then
e=self.minimizedHeight
else
local t,t,o,a=self:_computeInnerOffsets()
local t=self:_getVisibleTitleBarHeight()
e=o+a+math.max(1,t)
if e<1 then
e=1
end
end
return{
x=t.x,
y=t.y,
width=t.width,
height=e
}
end
function i:_captureRestoreRect()
local e={
x=self.x,
y=self.y,
width=self.width,
height=self.height
}
self._restoreRect=e
self._normalRect=o(e)
end
function i:maximize()
if not self.maximizable or self._isMaximized then
return
end
if self._isMinimized then
self:restore(true)
end
self:_captureRestoreRect()
local e=self:_computeMaximizedGeometry()
self._isMaximized=true
self._isMinimized=false
self:bringToFront()
self:_invalidateTitleLayout()
self:_transitionGeometry("maximize",e,function()
self._restoreRect=self._restoreRect or o(e)
if self.onMaximize then
self:onMaximize()
end
end)
end
function i:restore(a)
if not self._isMaximized and not self._isMinimized then
return
end
local e=self._normalRect or self._restoreRect or{
x=self.x,
y=self.y,
width=self.width,
height=self.height
}
self._isMaximized=false
self._isMinimized=false
self:_invalidateTitleLayout()
local function t()
self._restoreRect=nil
self._normalRect=nil
if self.onRestore then
self:onRestore()
end
end
if a then
self:_stopGeometryAnimation()
self:_applyGeometry(e)
t()
return
end
self:_transitionGeometry("restore",e,t)
end
function i:toggleMaximize()
if self._isMaximized then
self:restore()
else
if self._isMinimized then
self:restore(true)
end
self:maximize()
end
end
function i:minimize()
if not self.minimizable or self._isMinimized then
return
end
if self._isMaximized then
self:restore(true)
end
self:_captureRestoreRect()
local e=self:_computeMinimizedGeometry()
self._isMinimized=true
self._isMaximized=false
self:bringToFront()
self:_invalidateTitleLayout()
self:_transitionGeometry("minimize",e,function()
if self.onMinimize then
self:onMinimize()
end
end)
end
function i:toggleMinimize()
if self._isMinimized then
self:restore()
else
if self._isMaximized then
self:restore(true)
end
self:minimize()
end
end
function i:isMinimized()
return not not self._isMinimized
end
function i:close()
if self.onClose then
local e=self:onClose()
if e==false then
return
end
end
self:_stopGeometryAnimation()
self.visible=false
self:_endDrag()
self:_endResize()
self._isMaximized=false
self._isMinimized=false
self._restoreRect=nil
self._normalRect=nil
end
function i:_getVisibleTitleBarHeight()
local e=self._titleBar
if not e or not e.enabled then
return 0
end
local a,a,a,a,a,t=self:_computeInnerOffsets()
if t<=0 then
return 0
end
local e=math.max(1,math.floor(e.height or 1))
if e>t then
e=t
end
return e
end
function i:setTitleBar(e)
self._titleBar=G(e,nil)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function i:getTitleBar()
local e=self._titleBar
if not e then
return nil
end
local e=o(e)
if e and e.buttons then
local t={}
if e.buttons.close then
t.close=o(e.buttons.close)
end
if e.buttons.maximize then
t.maximize=o(e.buttons.maximize)
end
e.buttons=t
end
return e
end
function i:setDraggable(e)
self.draggable=not not e
end
function i:isDraggable()
return not not self.draggable
end
function i:setResizable(e)
self.resizable=not not e
self:_invalidateTitleLayout()
end
function i:isResizable()
return not not self.resizable
end
function i:setClosable(e)
self.closable=not not e
self:_invalidateTitleLayout()
end
function i:isClosable()
return not not self.closable
end
function i:setMaximizable(e)
self.maximizable=not not e
self:_invalidateTitleLayout()
end
function i:isMaximizable()
return not not self.maximizable
end
function i:setMinimizable(e)
self.minimizable=not not e
self:_invalidateTitleLayout()
end
function i:isMinimizable()
return not not self.minimizable
end
function i:setHideBorderWhenMaximized(e)
local e=not not e
if self.hideBorderWhenMaximized==e then
return
end
self.hideBorderWhenMaximized=e
self:_invalidateTitleLayout()
end
function i:hidesBorderWhenMaximized()
return not not self.hideBorderWhenMaximized
end
function i:setMinimizedHeight(e)
if e==nil then
self.minimizedHeight=nil
if self._isMinimized then
self:_applyGeometry(self:_computeMinimizedGeometry())
end
return
end
t(1,e,"number")
self.minimizedHeight=math.max(1,math.floor(e))
if self._isMinimized then
self:_applyGeometry(self:_computeMinimizedGeometry())
end
end
function i:getMinimizedHeight()
return self.minimizedHeight
end
function i:setGeometryAnimation(e)
if e==nil then
self._geometryAnimation=B(nil)
return
end
t(1,e,"table")
self._geometryAnimation=B(e)
end
function i:setOnMinimize(e)
if e~=nil then
t(1,e,"function")
end
self.onMinimize=e
end
function i:setTitle(e)
g.setTitle(self,e)
self:_invalidateTitleLayout()
end
function i:getContentOffset()
local e,t,a=self:_computeInnerOffsets()
local t=self:_getVisibleTitleBarHeight()
return e,a+t
end
function i:setSize(t,e)
g.setSize(self,t,e)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function i:setBorder(e)
s.setBorder(self,e)
self:_refreshTitleBarState()
self:_invalidateTitleLayout()
end
function i:bringToFront()
local e=self.parent
if not e then
return
end
e._orderCounter=(e._orderCounter or 0)+1
self._orderIndex=e._orderCounter
end
function i:_pointInTitleBar(a,t)
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
function i:_beginDrag(t,e,n,i)
self:_restoreFromMaximize()
local a,o=A(self)
self._dragging=true
self._dragSource=t
self._dragIdentifier=e
self._dragOffsetX=n-a
self._dragOffsetY=i-o
self:bringToFront()
if self.app then
self.app:setFocus(nil)
end
end
function i:_updateDragPosition(t,o)
if not self._dragging then
return
end
local e=self.parent
local a=self._dragOffsetX or 0
local i=self._dragOffsetY or 0
local a=t-a
local t=o-i
if e then
local i,o=A(e)
local h=i
local s=o
local n=i+math.max(0,e.width-self.width)
local e=o+math.max(0,e.height-self.height)
a=K(a,h,n)
t=K(t,s,e)
local a=a-i+1
local e=t-o+1
self:setPosition(a,e)
else
self:setPosition(a,t)
end
end
function i:_endDrag()
self._dragging=false
self._dragSource=nil
self._dragIdentifier=nil
self._dragOffsetX=0
self._dragOffsetY=0
end
function i:draw(a,o)
if not self.visible then
return
end
local h,s,r,d=self:getAbsoluteRect()
local u,c,i,c,t,l=self:_computeInnerOffsets()
local u=h+u
local c=s+i
local i=self.bg or self.app.background
if t>0 and l>0 then
n(a,u,c,t,l,i,i)
T(o,u,c,t,l,i)
else
n(a,h,s,r,d,i,i)
T(o,h,s,r,d,i)
end
_(a,h,s,r,d)
local l=self._titleBar
local t=nil
local u=nil
if l then
t=self:_computeTitleLayout()
if t then
u=l.bg or i
local s=u or i
local h=l.fg or self.fg or e.white
n(a,t.barX,t.textBaseline,t.barWidth,t.barHeight,s,s)
T(o,t.barX,t.textBaseline,t.barWidth,t.barHeight,s)
local n=t.titleWidth or 0
local i=self.title or""
if n>0 and i~=""then
if#i>n then
i=i:sub(1,n)
end
local e=n-#i
local n=l.align or"left"
local o=i
if e>0 then
if n=="center"then
local t=math.floor(e/2)
local e=e-t
o=string.rep(" ",t)..i..string.rep(" ",e)
elseif n=="right"then
o=string.rep(" ",e)..i
else
o=i..string.rep(" ",e)
end
end
a.text(t.titleStart,t.textBaseline,o,h,s)
end
local i=l.fg or self.fg or e.white
local e=t.buttonOrder or{}
for n=1,#e do
local e=e[n]
if e=="maximize"and self.maximizable then
self:_drawTitleButton(a,o,t,e,i,s)
elseif e=="close"and self.closable then
self:_drawTitleButton(a,o,t,e,i,s)
elseif e=="minimize"and self.minimizable then
self:_drawTitleButton(a,o,t,e,i,s)
end
end
end
end
if self:_isBorderVisible()then
p(o,h,s,r,d,self.border,i)
end
local t=M(self._children)
Y(t)
if#t==0 then
return
end
if not(a and a.text and o and o.pixel)then
for e=1,#t do
t[e]:draw(a,o)
end
return
end
local i=h
local e=s
local l=h+r-1
local m=s+d-1
local s=(i-1)*2+1
local h=(e-1)*3+1
local c=s+r*2-1
local u=h+d*3-1
local r=a.text
local d=o.pixel
local function f()
a.text=r
o.pixel=d
end
a.text=function(t,n,a,d,h)
if not a or a==""then
return
end
if n<e or n>m then
return
end
local t=t
local e=1
local s=#a
if t<i then
local a=i-t
e=e+a
t=i
end
if e>s then
return
end
local i=l-t+1
if i<=0 then
return
end
local i=math.min(s,e+i-1)
if i<e then
return
end
local e=a:sub(e,i)
if e==""then
return
end
r(t,n,e,d,h)
end
o.pixel=function(e,t,a)
if e<s or e>c or t<h or t>u then
return
end
d(e,t,a)
end
local e,t=pcall(function()
for e=1,#t do
t[e]:draw(a,o)
end
end)
f()
if not e then
error(t,0)
end
end
function i:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local o,e,t=...
local a=self:_hitTestTitleButton(e,t)
if a=="close"and self.closable then
self:close()
return true
elseif a=="maximize"and self.maximizable then
self:toggleMaximize()
return true
elseif a=="minimize"and self.minimizable then
self:toggleMinimize()
return true
end
local a=self:_hitTestResize(e,t)
if a then
self:_beginResize("mouse",o,e,t,a)
return true
end
if self.draggable and self:_pointInTitleBar(e,t)then
self:_beginDrag("mouse",o,e,t)
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
local o,e,t=...
local a=self:_hitTestTitleButton(e,t)
if a=="close"and self.closable then
self:close()
return true
elseif a=="maximize"and self.maximizable then
self:toggleMaximize()
return true
elseif a=="minimize"and self.minimizable then
self:toggleMinimize()
return true
end
local a=self:_hitTestResize(e,t)
if a then
self:_beginResize("monitor",o,e,t,a)
return true
end
if self.draggable and self:_pointInTitleBar(e,t)then
self:_beginDrag("monitor",o,e,t)
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
return g.handleEvent(self,e,...)
end
local function I(e)
return e=="mouse_click"or e=="mouse_up"or e=="mouse_drag"or e=="mouse_scroll"or e=="monitor_touch"or e=="monitor_up"or e=="monitor_drag"or e=="monitor_scroll"
end
local function T(e,...)
if e=="mouse_click"or e=="mouse_up"or e=="mouse_drag"then
local a,t,e=...
return t,e
elseif e=="mouse_scroll"then
local a,t,e=...
return t,e
elseif e=="monitor_touch"or e=="monitor_up"or e=="monitor_drag"or e=="monitor_scroll"then
local a,t,e=...
return t,e
end
return nil,nil
end
local A=setmetatable({},{__index=i})
A.__index=A
function A:new(t,a)
a=a or{}
local t=i.new(i,t,a)
setmetatable(t,A)
local i=a.modal~=false
t.modal=i
local o=a.backdropColor
if o==false then
o=nil
end
if i and o==nil then
o=e.gray
end
t.backdropColor=o
if a.backdropPixelColor~=nil then
if a.backdropPixelColor==false then
t.backdropPixelColor=nil
else
t.backdropPixelColor=a.backdropPixelColor
end
else
t.backdropPixelColor=o
end
t.closeOnBackdrop=a.closeOnBackdrop~=false
t.closeOnEscape=a.closeOnEscape~=false
t._modalRaised=false
if a.resizable==nil then
t:setResizable(false)
end
if a.maximizable==nil then
t:setMaximizable(false)
end
if a.minimizable==nil then
t:setMinimizable(false)
end
return t
end
function A:setModal(t)
t=not not t
if self.modal==t then
return
end
self.modal=t
if t and self.backdropColor==nil then
self.backdropColor=e.black
if self.backdropPixelColor==nil then
self.backdropPixelColor=self.backdropColor
end
end
self._modalRaised=false
end
function A:isModal()
return not not self.modal
end
function A:setBackdropColor(t,e)
if t==false then
self.backdropColor=nil
else
self.backdropColor=t
end
if e==false then
self.backdropPixelColor=nil
elseif e~=nil then
self.backdropPixelColor=e
else
self.backdropPixelColor=self.backdropColor
end
end
function A:getBackdropColor()
return self.backdropColor
end
function A:setCloseOnBackdrop(e)
self.closeOnBackdrop=not not e
end
function A:setCloseOnEscape(e)
self.closeOnEscape=not not e
end
function A:draw(e,t)
if not self.visible then
return
end
if self.modal then
if not self._modalRaised then
self:bringToFront()
self._modalRaised=true
end
else
self._modalRaised=false
end
i.draw(self,e,t)
end
function A:_consumeModalEvent(e,...)
if not self.modal then
return false
end
if e=="key"then
local e=...
if self.closeOnEscape and e==a.escape then
self:close()
return true
end
return true
end
if e=="char"or e=="paste"or e=="key_up"then
return true
end
if I(e)then
local o,t=T(e,...)
local a=false
if o and t then
a=self:containsPoint(o,t)
end
if not a and(e=="mouse_click"or e=="monitor_touch")then
if self.closeOnBackdrop then
self:close()
end
end
return true
end
return false
end
function A:handleEvent(e,...)
if not self.visible then
return false
end
local t=i.handleEvent(self,e,...)
if t then
return true
end
if self.modal then
if self:_consumeModalEvent(e,...)then
return true
end
end
return false
end
function A:close()
local e=self.visible
i.close(self)
if e and not self.visible then
self._modalRaised=false
end
end
local function M(e,t,o)
local a=t
local t=o
if type(e)=="number"then
local e=math.max(0,math.floor(e))
a,t=e,e
elseif type(e)=="table"then
if e.horizontal~=nil then
a=math.max(0,math.floor(e.horizontal))
elseif e.x~=nil then
a=math.max(0,math.floor(e.x))
end
if e.vertical~=nil then
t=math.max(0,math.floor(e.vertical))
elseif e.y~=nil then
t=math.max(0,math.floor(e.y))
end
end
return a,t
end
local function I(e,t)
if type(e)~="string"then
return t
end
local e=e:lower()
if e~="left"and e~="center"and e~="right"then
return t
end
return e
end
local T=setmetatable({},{__index=A})
T.__index=T
function T:new(o,a)
a=a or{}
if a.modal==nil then
a.modal=true
end
if a.resizable==nil then
a.resizable=false
end
local t=A.new(A,o,a)
setmetatable(t,T)
t.autoClose=a.autoClose~=false
t.buttonAlign=I(a.buttonAlign,"center")
t.buttonGap=math.max(0,math.floor(a.buttonGap or 2))
t.buttonHeight=math.max(1,math.floor(a.buttonHeight or 3))
t.minButtonWidth=math.max(1,math.floor(a.minButtonWidth or 6))
t.buttonLabelPadding=math.max(0,math.floor(a.buttonLabelPadding or 2))
t.buttonAreaSpacing=math.max(0,math.floor(a.buttonAreaSpacing or 1))
t.contentPaddingX,t.contentPaddingY=M(a.contentPadding,2,1)
t.messagePaddingX,t.messagePaddingY=M(a.messagePadding,1,1)
t.messageFg=a.messageFg or e.lightBlue
t.messageBg=a.messageBg or e.white
t.wrapMessage=a.wrap~=false
t._buttons={}
local i
if a.contentBorder==false then
i=nil
else
i={color=a.contentBorderColor or e.lightGray}
end
t._contentFrame=g:new(o,{
width=1,
height=1,
bg=t.messageBg,
fg=t.messageFg,
border=i
})
t._contentFrame.focusable=false
t:addChild(t._contentFrame)
t._messageLabel=E:new(o,{
text=a.message or"",
wrap=t.wrapMessage,
bg=t.messageBg,
fg=t.messageFg,
width=1,
height=1,
align=a.messageAlign or"left",
verticalAlign=a.messageVerticalAlign or"top"
})
t._messageLabel.focusable=false
t._contentFrame:addChild(t._messageLabel)
t.onResult=a.onResult
t:setMessage(a.message or"")
t:setButtons(a.buttons)
if a.bg==nil then
t.bg=e.gray
end
t:_updateLayout()
return t
end
function T:setMessage(e)
if e==nil then
e=""
end
e=tostring(e)
self.message=e
if self._messageLabel then
self._messageLabel:setText(e)
end
self:_updateLayout()
end
function T:getMessage()
return self.message or""
end
function T:setOnResult(e)
if e~=nil then
t(1,e,"function")
end
self.onResult=e
end
function T:_createButtonEntry(t,i)
local a={}
local o
local s=self.autoClose
local n
local r
local l
local d
local h
if type(t)=="string"then
o=t
a.id=t
elseif type(t)=="table"then
o=t.label or t.id or("Button "..tostring(i))
a.id=t.id or t.value or o
if t.autoClose~=nil then
s=not not t.autoClose
end
if t.width~=nil then
n=math.max(1,math.floor(t.width))
end
if t.height~=nil then
r=math.max(1,math.floor(t.height))
end
l=t.bg
d=t.fg
h=t.onSelect
else
error("MsgBox button config at index "..tostring(i).." must be a string or table",3)
end
o=tostring(o)
if not a.id or a.id==""then
a.id=tostring(i)
end
local n=n or math.max(self.minButtonWidth,#o+self.buttonLabelPadding*2)
local i=r or self.buttonHeight
local e=R:new(self.app,{
label=o,
width=n,
height=i,
bg=l or e.white,
fg=d or e.black
})
e.focusable=false
a.button=e
a.autoClose=s
a.config=t
a.onSelect=h
e.onClick=function()
self:_handleButtonSelection(a)
end
return a
end
function T:setButtons(t)
if self._buttons then
for e=1,#self._buttons do
local e=self._buttons[e]
if e and e.button and e.button.parent then
e.button.parent:removeChild(e.button)
end
end
end
self._buttons={}
if t==nil then
t={{id="ok",label="OK",autoClose=true}}
end
if type(t)~="table"then
error("MsgBox:setButtons expects a table or nil",2)
end
for e=1,#t do
local e=self:_createButtonEntry(t[e],e)
self._buttons[#self._buttons+1]=e
self:addChild(e.button)
end
self:_updateLayout()
end
function T:_handleButtonSelection(e)
if not e then
return
end
if e.onSelect then
e.onSelect(self,e.id,e.button)
end
local t
if self.onResult then
t=self.onResult(self,e.id,e.button)
end
if e.autoClose and t~=false then
self:close()
end
end
function T:setButtonAlign(e)
self.buttonAlign=I(e,self.buttonAlign)
self:_updateLayout()
end
function T:setAutoClose(e)
self.autoClose=not not e
end
function T:setButtonGap(e)
self.buttonGap=math.max(0,math.floor(e or self.buttonGap))
self:_updateLayout()
end
function T:_updateLayout()
if not self._contentFrame then
return
end
local n,e,o,e,t,a=self:_computeInnerOffsets()
local e=self:_getVisibleTitleBarHeight()
local i=math.max(1,t)
local a=math.max(1,a-e)
local s=n+1
local h=o+e+1
local o=#self._buttons
local n=o>0 and self.buttonHeight or 0
local e=a
local t=e
if o>0 then
local e=self.buttonAreaSpacing
if a<=n then
e=0
t=math.max(1,a-n)
else
local o=math.max(0,a-n-1)
if e>o then
e=o
end
t=math.max(1,a-n-e)
end
self._buttonRowY=h+t+e
else
self._buttonRowY=nil
end
self._contentFrame:setPosition(s,h)
self._contentFrame:setSize(i,math.max(1,t))
local a=math.max(1,i-self.messagePaddingX*2)
local e=math.max(1,t-self.messagePaddingY*2)
self._messageLabel:setSize(a,e)
self._messageLabel:setPosition(self.messagePaddingX+1,self.messagePaddingY+1)
if o>0 then
local e=0
for t=1,o do
local a=self._buttons[t].button
e=e+a.width
if t>1 then
e=e+self.buttonGap
end
end
local a
if self.buttonAlign=="left"then
a=s
elseif self.buttonAlign=="right"then
a=s+math.max(0,i-e)
else
a=s+math.max(0,math.floor((i-e)/2))
end
local a=a
local t=self._buttonRowY or(h+t)
for e=1,o do
local e=self._buttons[e]
local e=e.button
e:setSize(e.width,self.buttonHeight)
e:setPosition(a,t)
a=a+e.width+self.buttonGap
end
end
end
function T:setSize(t,e)
i.setSize(self,t,e)
self:_updateLayout()
end
function T:setBorder(e)
i.setBorder(self,e)
self:_updateLayout()
end
function T:setTitleBar(e)
i.setTitleBar(self,e)
self:_updateLayout()
end
function R:new(a,e)
local t=setmetatable({},R)
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
function R:setLabel(e)
t(1,e,"string")
self.label=e
end
function R:setOnClick(e)
if e~=nil then
t(1,e,"function")
end
self.onClick=e
end
function R:draw(r,c)
if not self.visible then
return
end
local o,s,t,a=self:getAbsoluteRect()
local h=self.bg or e.gray
local i=self.fg or e.white
local e=h
local d=i
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=o+1,s+1
local i=math.max(0,t-2)
local h=math.max(0,a-2)
if i>0 and h>0 then
n(r,l,u,i,h,e,e)
else
n(r,o,s,t,a,e,e)
end
_(r,o,s,t,a)
if self.border then
p(c,o,s,t,a,self.border,e)
end
local a=self.label or""
local t=i>0 and i or t
if#a>t then
a=a:sub(1,t)
end
local n=0
if t>#a then
n=math.floor((t-#a)/2)
end
local a=string.rep(" ",n)..a
if#a<t then
a=a..string.rep(" ",t-#a)
end
local o=i>0 and l or o
local t
if h>0 then
t=u+math.floor((h-1)/2)
else
t=s
end
r.text(o,t,a,d,e)
end
function R:handleEvent(e,...)
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
local t=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-t-a)
local i=math.max(0,self.height-o-e)
return t,a,o,e,n,i
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
local o=not not self.wrap
local a,a,a,a,i=self:_getInnerMetrics()
if not e and self._lastText==t and self._lastWrap==o and self._lastInnerWidth==i then
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
if o then
self:_wrapLine(t,i,e)
else
e[#e+1]=t
end
break
end
local t=t:sub(a,n-1)
t=t:gsub("\r","")
if o then
self:_wrapLine(t,i,e)
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
self._lastWrap=o
self._lastInnerWidth=i
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
s.setSize(self,t,e)
self:_updateLines(true)
end
function E:setBorder(e)
s.setBorder(self,e)
self:_updateLines(true)
end
function E:draw(d,f)
if not self.visible then
return
end
local h,s,u,l=self:getAbsoluteRect()
local r=self.bg or self.app.background or e.black
local m=self.fg or e.white
n(d,h,s,u,l,r,r)
_(d,h,s,u,l)
local e,t,o,t,a,i=self:_getInnerMetrics()
local t=h+e
local w=s+o
self:_updateLines(false)
local c=self._lines or{""}
local o=#c
if o==0 then
c={""}
o=1
end
if a>0 and i>0 then
local e=math.min(o,i)
local n=1
if o>e then
if self.verticalAlign=="bottom"then
n=o-e+1
elseif self.verticalAlign=="middle"then
n=math.floor((o-e)/2)+1
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
local i=w+o
for e=0,e-1 do
local e=c[n+e]or""
if#e>a then
e=e:sub(1,a)
end
local o=t
if self.align=="center"then
o=t+math.floor((a-#e)/2)
elseif self.align=="right"then
o=t+a-#e
end
if o<t then
o=t
end
if o+#e>t+a then
o=t+a-#e
end
if#e>0 then
d.text(o,i,e,m,r)
end
i=i+1
end
end
if self.border then
p(f,h,s,u,l,self.border,r)
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
function z:draw(r,l)
if not self.visible then
return
end
local s,h,t,i=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local o=a
local d=e
if self:isFocused()then
o=self.focusBg or o
d=self.focusFg or d
end
n(r,s,h,t,i,o,o)
_(r,s,h,t,i)
if self.border then
p(l,s,h,t,i,self.border,o)
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
local t=h+math.floor((i-1)/2)
r.text(s,t,e,d,o)
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
local o=e-t
local a=self.transitionEasing or H.easeInOutQuad
self._animationHandle=self.app:animate({
duration=self.transitionDuration,
easing=a,
update=function(e)
local e=t+o*e
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
function b:setColors(e,a,o,i,s,n,h)
if e~=nil then
t(1,e,"number")
self.trackColorOn=e
end
if a~=nil then
t(2,a,"number")
self.trackColorOff=a
end
if o~=nil then
t(3,o,"number")
self.thumbColor=o
end
if i~=nil then
t(4,i,"number")
self.onLabelColor=i
end
if s~=nil then
t(5,s,"number")
self.offLabelColor=s
end
if n~=nil then
t(6,n,"number")
self.trackColorDisabled=n
end
if h~=nil then
t(7,h,"number")
self.knobColorDisabled=h
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
local t,o,s,a=self:getAbsoluteRect()
local i=self.bg or e.black
local w=self.fg or e.white
n(l,t,o,s,a,i,i)
_(l,t,o,s,a)
if self.border then
p(d,t,o,s,a,self.border,i)
end
local a,r,i,r,s,h=V(self)
if s<=0 or h<=0 then
return
end
local a=t+a
local i=o+i
local t=s
local o=h
local s=self._thumbProgress
if s==nil then
s=self.value and 1 or 0
end
if s<0 then
s=0
elseif s>1 then
s=1
end
local y=self.trackColorOn or e.green
local m=self.trackColorOff or e.red
local c=self.trackColorDisabled or m
local h=self.disabled and c or m
n(l,a,i,t,o,h,h)
local h=math.floor(t*s+.5)
if h>0 then
if h>t then
h=t
end
local e=self.disabled and c or y
n(l,a,i,h,o,e,e)
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
local f=math.max(0,u-h)
local u=math.floor(f*s+.5)
if u>f then
u=f
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
n(l,u,i,h,o,r,r)
local n=""
if self.showLabel then
n=self.value and(self.labelOn or"On")or(self.labelOff or"Off")
end
if n~=""and o>0 then
local e=math.max(0,t-2)
if e>0 and#n>e then
n=n:sub(1,e)
end
local r=self.value and(self.onLabelColor or w)or(self.offLabelColor or w)
local h
if s>=.5 then
h=self.disabled and c or y
else
h=self.disabled and c or m
end
local o=i+math.floor((o-1)/2)
local e=a+math.floor((t-#n)/2)
if e<a then
e=a
end
if e+#n-1>a+t-1 then
e=a+t-#n
end
if#n>0 then
l.text(e,o,n,r,h)
end
end
if self:isFocused()then
local e=self.focusOutline or self.focusFg or e.white
if t>0 then
for t=0,t-1 do
d.pixel(a+t,i,e)
if o>1 then
d.pixel(a+t,i+o-1,e)
end
end
end
if o>0 then
for o=0,o-1 do
d.pixel(a,i+o,e)
if t>1 then
d.pixel(a+t-1,i+o,e)
end
end
end
end
if self.disabled then
local n=self.knobColorDisabled or e.lightGray
for e=0,t-1,2 do
local e=a+e
d.pixel(e,i,n)
if o>1 then
d.pixel(e,i+o-1,n)
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
function k:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},k)
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
t._dotChar=se
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
function k:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function k:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function k:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function k:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function k:setLabel(e)
t(1,e,"string")
self.label=e
end
function k:setValue(e)
self.value=e
end
function k:getValue()
return self.value
end
function k:setGroup(e)
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
function k:getGroup()
return self.group
end
function k:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function k:setSelected(e)
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
function k:isSelected()
return self.selected
end
function k:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function k:draw(r,d)
if not self.visible then
return
end
local s,i,t,o=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local h=e
if self:isFocused()then
a=self.focusBg or a
h=self.focusFg or h
end
n(r,s,i,t,o,a,a)
_(r,s,i,t,o)
if self.border then
p(d,s,i,t,o,self.border,a)
end
local i=i+math.floor((o-1)/2)
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
r.text(s,i,e,h,a)
end
end
function k:handleEvent(e,...)
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
function q:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},q)
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
t.border=N(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
end
return t
end
function q:_clampValue(e)
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
function q:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function q:_startIndeterminateAnimation()
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
function q:setRange(e,a)
t(1,e,"number")
t(2,a,"number")
if a<=e then
error("ProgressBar max must be greater than min",2)
end
self.min=e
self.max=a
self.value=self:_clampValue(self.value)
end
function q:getRange()
return self.min,self.max
end
function q:setValue(e)
if self.indeterminate then
return
end
t(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function q:getValue()
return self.value
end
function q:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function q:setIndeterminate(e)
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
function q:isIndeterminate()
return self.indeterminate
end
function q:setLabel(e)
if e~=nil then
t(1,e,"string")
end
self.label=e
end
function q:setShowPercent(e)
self.showPercent=not not e
end
function q:setColors(a,o,e)
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
self.textColor=e
end
end
function q:draw(s,d)
if not self.visible then
return
end
local a,r,t,o=self:getAbsoluteRect()
local i=self.trackColor or(self.bg or e.gray)
local h=self.fillColor or e.lightBlue
local m=self.textColor or(self.fg or e.white)
n(s,a,r,t,o,i,i)
_(s,a,r,t,o)
if self.border then
p(d,a,r,t,o,self.border,i)
end
local e=self.border
local l=(e and e.left)and 1 or 0
local c=(e and e.right)and 1 or 0
local u=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+l
local d=r+u
local t=math.max(0,t-l-c)
local o=math.max(0,o-u-e)
if t<=0 or o<=0 then
return
end
n(s,a,d,t,o,i,i)
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
n(s,a+u,d,r,o,h,h)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
n(s,a,d,l,o,h,h)
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
local d=d+math.floor((o-1)/2)
local o=a+math.floor((t-#e)/2)
if o<a then
o=a
end
for t=1,#e do
local n=e:sub(t,t)
local e=(o-a)+(t-1)
local a=i
if self.indeterminate then
if e>=u and e<u+r then
a=h
end
else
if e<l then
a=h
end
end
s.text(o+t-1,d,n,m,a)
end
end
end
function q:handleEvent(e,...)
return false
end
function D:new(i,t)
t=t or{}
local e=o(t)or{}
e.focusable=false
e.width=math.max(1,math.floor(e.width or 10))
e.height=math.max(1,math.floor(e.height or 4))
local a=setmetatable({},D)
a:_init_base(i,e)
a.onDraw=t.onDraw
a.clear=t.clear~=false
return a
end
function D:setOnDraw(e)
if e~=nil and type(e)~="function"then
error("FreeDraw:setOnDraw expects a function or nil",2)
end
self.onDraw=e
end
function D:setClear(e)
self.clear=not not e
end
function D:draw(r,d)
if not self.visible then
return
end
local s,h,a,o=self:getAbsoluteRect()
if a<=0 or o<=0 then
return
end
if self.clear then
local e=self.bg or self.app.background or e.black
n(r,s,h,a,o,e,e)
end
if self.onDraw then
local t=self._ctx or{}
t.app=self.app
t.box=self.app.box
t.textLayer=r
t.pixelLayer=d
t.x=s
t.y=h
t.width=a
t.height=o
local u=self.bg or self.app.background or e.black
local l=self.fg or e.white
t.fill=function(e)
local e=e or u
n(r,s,h,a,o,e,e)
end
t.write=function(i,n,e,d,c)
local i=math.floor(i or 1)
local n=math.floor(n or 1)
if type(e)~="string"then
e=tostring(e or"")
end
if n<1 or n>o then
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
r.text(s+i-1,h+n-1,e,d or l,c or u)
end
t.pixel=function(t,e,i)
local t=math.floor(t or 1)
local e=math.floor(e or 1)
if t<1 or t>a or e<1 or e>o then
return
end
d.pixel(s+t-1,h+e-1,i or l)
end
self._ctx=t
self.onDraw(self,t)
end
if self.border then
p(d,s,h,a,o,self.border,self.bg or self.app.background or e.black)
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
local e
local o
if type(a.value)=="table"then
e=a.value[1]
o=a.value[2]
end
if type(a.startValue)=="number"then
e=a.startValue
end
if type(a.endValue)=="number"then
o=a.endValue
end
if type(e)~="number"then
e=t.min
end
if type(o)~="number"then
o=t.max
end
if e>o then
e,o=o,e
end
t.lowerValue=t:_applyStep(e)
t.upperValue=t:_applyStep(o)
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
t.border=N(true)
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
local o,h=self:getAbsoluteRect()
local n=math.max(0,self.width-a-i)
local s=math.max(0,self.height-t-e)
local i=o+a
local o=h+t
return i,o,n,s,a,t,e
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
function l:setRangeValues(a,e,o)
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
function l:getRangeValues()
return self.lowerValue,self.upperValue
end
function l:setRangeLimits(a,e)
t(1,a,"number")
t(2,e,"number")
if e<=a then
error("Slider max must be greater than min",2)
end
self.min=a
self.max=e
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
function l:_positionFromPoint(t)
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
function l:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local n=self:_valueToPosition(self.lowerValue,a)
local s=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local o=math.abs(t-n)
local i=math.abs(t-s)
if o==i then
if t>s then
e="upper"
elseif t<n then
e="lower"
end
elseif o<i then
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
function l:draw(o,f)
if not self.visible then
return
end
local h,d,r,l=self:getAbsoluteRect()
local s=self.bg or self.app.background or e.black
n(o,h,d,r,l,s,s)
_(o,h,d,r,l)
local i,m,t,u=self:_getInnerMetrics()
if t<=0 or u<=0 then
if self.border then
p(f,h,d,r,l,self.border,s)
end
return
end
local a
local c=nil
if self.showValue and u>=2 then
c=m
a=m+u-1
else
a=m+math.floor((u-1)/2)
end
n(o,i,a,t,1,self.trackColor,self.trackColor)
local m
if self:isFocused()then
m=self._activeHandle or self._focusedHandle
end
local function u(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if m and s==m then
t=self.fg or e.white
end
o.text(i+n,a," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local s=t-e+1
if s>0 then
n(o,i+e,a,s,1,self.fillColor,self.fillColor)
end
u(e,"lower")
u(t,"upper")
else
local e=self:_valueToPosition(self.value,t)
local t=e+1
if t>0 then
n(o,i,a,t,1,self.fillColor,self.fillColor)
end
u(e,"single")
end
if self.showValue and c then
local a=self:_formatDisplayValue()
if a and a~=""then
if#a>t then
a=a:sub(1,t)
end
local t=i+math.floor((t-#a)/2)
if t<i then
t=i
end
o.text(t,c,a,self.fg or e.white,s)
end
end
if self.border then
p(f,h,d,r,l,self.border,s)
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
t.border=N(true)
end
t.scrollbar=L(a.scrollbar,t.bg or e.black,t.fg or e.white)
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
for o,t in pairs(t)do
a=a+1
if a>4 then
e[#e+1]="..."
break
end
e[#e+1]=tostring(o).."="..tostring(t)
end
table.sort(e,function(t,e)
return t<e
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
local t={}
for a=1,#e do
t[a]=e[a]
end
self.data=t
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
function d:_getColumnById(e)
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
function d:_applySort(e,a,u)
local t=self:_getColumnById(e)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=a=="desc"and"desc"or"asc"
local l=self.sortDirection=="desc"
local n=t.comparator
table.sort(self._rows,function(h,r)
local i=self.data[h]
local s=self.data[r]
local a=d._resolveColumnValue(t,i)
local o=d._resolveColumnValue(t,s)
local e=0
if n then
local a,t=pcall(n,a,o,i,s,t)
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
local t=tostring(a or""):lower()
local a=tostring(o or""):lower()
if t<a then
e=-1
elseif t>a then
e=1
else
e=0
end
end
end
if e==0 then
return h<r
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
function d:setSort(e,t,a)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,t or self.sortDirection,a)
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
self.scrollbar=L(t,self.bg or e.black,self.fg or e.white)
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
local e=(e and e.bottom)and 1 or 0
local s,n=self:getAbsoluteRect()
local o=math.max(0,self.width-a-o)
local i=math.max(0,self.height-t-e)
local a=s+a
local e=n+t
return a,e,o,i
end
function d:_computeLayoutMetrics()
local o,r,t,a=self:_getInnerMetrics()
if t<=0 or a<=0 then
return{
innerX=o,
innerY=r,
innerWidth=t,
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
local s=math.max(0,a-h)
local e,n=F(self.scrollbar,#self._rows,s,t)
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
innerX=o,
innerY=r,
innerWidth=t,
innerHeight=a,
headerHeight=h,
rowsHeight=s,
contentWidth=i,
scrollbarWidth=e,
scrollbarStyle=n,
scrollbarX=o+i
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
function d:draw(a,b)
if not self.visible then
return
end
local m,f,c,l=self:getAbsoluteRect()
local s=self.bg or e.black
local g=self.fg or e.white
n(a,m,f,c,l,s,s)
_(a,m,f,c,l)
local t=self:_computeLayoutMetrics()
local i=t.innerWidth
local k=t.innerHeight
local o=t.contentWidth
if i<=0 or k<=0 or o<=0 then
if self.border then
p(b,m,f,c,l,self.border,s)
end
return
end
local i=t.innerX
local u=t.innerY
local v=t.headerHeight
local j=t.rowsHeight
local w=t.scrollbarWidth
local r=t.scrollbarStyle
local y=self.headerBg or s
local q=self.headerFg or g
if v>0 then
a.text(i,u,string.rep(" ",o),y,y)
local n=i
local s=o
for e=1,#self.columns do
local h=self.columns[e]
local t=math.max(1,math.min(h.width,s))
if e==#self.columns then
t=math.max(1,s)
end
if t<=0 then
break
end
local e=h.title or h.id
local r=""
if self.sortColumn==h.id then
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
a.text(n,u,e,q,y)
n=n+t
s=o-(n-i)
if s<=0 then
break
end
end
end
local v=u+v
local h=j
local y=self.rowBg or s
local g=self.rowFg or g
if h<=0 then
if w>0 then
local e=(r and r.background)or s
n(a,t.scrollbarX,u,w,k,e,e)
end
if self.border then
p(b,m,f,c,l,self.border,s)
end
return
end
if#self._rows==0 then
for e=0,h-1 do
local e=v+e
a.text(i,e,string.rep(" ",o),g,y)
end
if self.placeholder and self.placeholder~=""then
local t=self.placeholder
if#t>o then
t=t:sub(1,o)
end
local n=h>0 and math.min(h-1,math.floor(h/2))or 0
local n=v+n
local o=i+math.floor((o-#t)/2)
if o<i then
o=i
end
a.text(o,n,t,e.lightGray,y)
end
else
for n=0,h-1 do
local t=self.scrollOffset+n
local m=v+n
if t>#self._rows then
a.text(i,m,string.rep(" ",o),g,y)
else
local n=self._rows[t]
local l=self.data[n]
local c=self.allowRowSelection and t==self.selectedIndex
local s=y
local u=g
if c then
s=self.highlightBg or e.lightGray
u=self.highlightFg or e.black
elseif self.zebra and(t%2==0)then
s=self.zebraBg or s
end
local h=i
local r=o
for e=1,#self.columns do
local t=self.columns[e]
local n=math.max(1,math.min(t.width,r))
if e==#self.columns then
n=math.max(1,r)
end
if n<=0 then
break
end
local e=d._resolveColumnValue(t,l)
e=self:_formatCell(t,l,e)
if#e>n then
e=e:sub(1,n)
end
if t.align=="right"then
if#e<n then
e=string.rep(" ",n-#e)..e
end
elseif t.align=="center"then
local a=n-#e
local t=math.floor(a/2)
local a=a-t
e=string.rep(" ",t)..e..string.rep(" ",a)
else
if#e<n then
e=e..string.rep(" ",n-#e)
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
a.text(h,m,e,d,s)
h=h+n
r=o-(h-i)
if r<=0 then
break
end
end
end
end
end
if w>0 then
local e=(r and r.background)or s
n(a,t.scrollbarX,u,w,k,e,e)
if r and h>0 then
local e=math.max(0,self.scrollOffset-1)
C(a,t.scrollbarX,v,h,#self._rows,h,e,r)
end
end
if self.border then
p(b,m,f,c,l,self.border,s)
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
local a=O.clock()
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
local t=self.selectedIndex>=1 and self.selectedIndex or 0
for a=1,#self._rows do
local t=((t+a-1)%#self._rows)+1
local o=self.data[self._rows[t]]
local a=self.columns[1]
local a=d._resolveColumnValue(a,o)
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
local e=U(a,e.rowsHeight,#self._rows,e.rowsHeight,t)
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
return n(t,e)
elseif o=="monitor_touch"then
local a,e,t=...
return n(e,t)
elseif o=="mouse_scroll"then
local a,e,t=...
if self:containsPoint(e,t)then
self.scrollOffset=self.scrollOffset+a
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
a.border=N(true)
end
a.scrollbar=L(t and t.scrollbar,a.bg or e.black,a.fg or e.white)
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
self.scrollbar=L(t,self.bg or e.black,self.fg or e.white)
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
function u:_findVisibleIndex(a)
if a==nil then
return nil
end
local e=self._flatNodes
for t=1,#e do
if e[t].node==a then
return t
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
local t,n=self:getAbsoluteRect()
local a,i,s,i,e,o=self:_getInnerMetrics()
local i=t+a
local s=n+s
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
local t,n=F(self.scrollbar,#self._flatNodes,o,e)
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
function u:_rowFromPoint(o,t)
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
local t=t-a
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
local o=self._flatNodes
local t=#o
if t==0 then
return
end
local a=self._selectedIndex>=1 and self._selectedIndex or 0
for i=1,t do
local a=((a+i-1)%t)+1
local t=o[a].node
local t=t and t.label or""
if t:lower():sub(1,#e)==e then
self:_setSelectedIndex(a,false)
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
local a=O.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function u:draw(s,r)
if not self.visible then
return
end
local o,a,i,t=self:getAbsoluteRect()
local h=self.bg or e.black
local m=self.fg or e.white
n(s,o,a,i,t,h,h)
_(s,o,a,i,t)
if self.border then
p(r,o,a,i,t,self.border,h)
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
s.text(u,l+e,string.rep(" ",i),m,h)
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
s.text(a,l,t,e.lightGray,h)
end
if c>0 then
local e=(d and d.background)or h
n(s,o.scrollbarX,l,c,r,e,e)
if d then
C(s,o.scrollbarX,l,r,0,r,0,d)
end
end
return
end
for t=0,r-1 do
local d=l+t
local r=self.scrollOffset+t
if r>w then
s.text(u,d,string.rep(" ",i),m,h)
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
local n
if o and o.children and#o.children>0 then
n=o.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
else
n=self.toggleSymbols.leaf
end
n=tostring(n or" ")
local t=i-t
local a=a
if t>0 then
local e=n:sub(1,1)
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
local t=h
local o=m
if r==self._selectedIndex then
t=self.highlightBg or e.lightGray
o=self.highlightFg or e.black
end
s.text(u,d,a,o,t)
end
end
if c>0 then
local e=(d and d.background)or h
n(s,o.scrollbarX,l,c,r,e,e)
if d then
C(s,o.scrollbarX,l,r,#self._flatNodes,r,math.max(0,self.scrollOffset-1),d)
end
end
end
function u:handleEvent(t,...)
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
local e=U(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
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
local e=U(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
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
local function I(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function M(r,t,a,h,s,n)
if not r then
return
end
n=n or e.white
local i=math.abs(h-t)
local d=t<h and 1 or-1
local o=-math.abs(s-a)
local l=a<s and 1 or-1
local e=i+o
while true do
r.pixel(t,a,n)
if t==h and a==s then
break
end
local n=2*e
if n>=o then
e=e+o
t=t+d
end
if n<=i then
e=e+i
a=a+l
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
function w:setRange(e,a)
if e~=nil then
t(1,e,"number")
end
if a~=nil then
t(2,a,"number")
end
self.minValue=e
self.maxValue=a
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
function w:draw(d,v)
if not self.visible then
return
end
local h,i,a,r=self:getAbsoluteRect()
local s=self.bg or e.black
local w=self.fg or e.white
n(d,h,i,a,r,s,s)
_(d,h,i,a,r)
if self.border then
p(v,h,i,a,r,self.border,s)
end
local t=self.border
local o=(t and t.thickness)or 0
local l=(t and t.left)and o or 0
local c=(t and t.right)and o or 0
local u=(t and t.top)and o or 0
local t=(t and t.bottom)and o or 0
local o=h+l
local h=i+u
local a=math.max(0,a-l-c)
local t=math.max(0,r-u-t)
self._lastLayout=nil
if a<=0 or t<=0 then
return
end
local r=#self.data
if r==0 then
local i=self.placeholder or""
if i~=""then
local i=i
if#i>a then
i=i:sub(1,a)
end
local a=o+math.floor((a-#i)/2)
if a<o then
a=o
end
local t=h+math.floor((t-1)/2)
d.text(a,t,i,e.lightGray,s)
end
return
end
local i=(self.showLabels and t>=2)and 1 or 0
local u=(self.showAxis and(t-i)>=2)and 1 or 0
local l=t-u-i
if l<1 then
l=t
u=0
i=0
end
local m=h
local c=m+l-1
local f=u>0 and(c+1)or nil
local u
if i>0 then
if f then
u=f+1
else
u=c+1
end
if u>h+t-1 then
u=h+t-1
end
end
local t=math.huge
local i=-math.huge
for e=1,r do
local e=self.data[e]or 0
if e<t then
t=e
end
if e>i then
i=e
end
end
if t==math.huge then
t=0
end
if i==-math.huge then
i=0
end
local t=type(self.minValue)=="number"and self.minValue or t
local h=type(self.maxValue)=="number"and self.maxValue or i
if h==t then
h=h+1
t=t-1
end
local i=h-t
if i<=0 then
i=1
h=t+i
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
i=h-t
if i<=0 then
i=1
h=t+i
end
end
local h={}
for i=1,r do
local t=o+math.floor((i-1)*a/r)
local e=o+math.floor(i*a/r)-1
if e<t then
e=t
end
if e>o+a-1 then
e=o+a-1
end
local a=e-t+1
if a<1 then
a=1
end
h[i]={
left=t,
right=e,
width=a,
center=t+math.floor((a-1)/2)
}
end
if self.chartType=="bar"then
for a=1,r do
local o=self.data[a]or 0
local e=0
if i>0 then
e=(o-t)/i
end
e=I(e,0,1)
local e=math.floor(e*l+.5)
if l>0 and e<=0 and o>t then
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
local t=self.barColor or w
if self.selectedIndex==a then
t=self.highlightColor or t
end
n(d,h[a].left,o,h[a].width,e,t,t)
end
else
local a={}
for o=1,r do
local n=self.data[o]or 0
local e=0
if i>0 then
e=(n-t)/i
end
e=I(e,0,1)
local t=math.max(l-1,0)
local e=c-math.floor(e*t+.5)
if e<m then
e=m
end
if e>c then
e=c
end
a[o]={x=h[o].center,y=e}
end
for e=2,#a do
local t=a[e-1]
local e=a[e]
M(v,t.x,t.y,e.x,e.y,self.lineColor or w)
end
for i=1,#a do
local t=a[i]
local a=self.lineColor or w
local o="o"
if self.selectedIndex==i then
a=self.highlightColor or e.orange
o="O"
end
d.text(t.x,t.y,o,a,s)
end
end
if f then
n(d,o,f,a,1,s,s)
local e=string.rep("-",a)
d.text(o,f,e,self.axisColor or w,s)
end
if u then
n(d,o,u,a,1,s,s)
local t=self.labels or{}
for i=1,r do
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
local e=(self.selectedIndex==i)and(self.highlightColor or e.orange)or(self.axisColor or w)
d.text(o,u,t,e,s)
end
end
end
self._lastLayout={
innerX=o,
innerWidth=a,
dataCount=r,
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
t.border=N(true)
end
t.scrollbar=L(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_normalizeSelection(true)
return t
end
function f:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-t-a)
local n=math.max(0,self.height-o-e)
return t,a,o,e,i,n
end
function f:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function f:_computeLayoutMetrics()
local a,e=self:getAbsoluteRect()
local o,s,n,s,t,i=self:_getInnerMetrics()
local o=a+o
local s=e+n
if t<=0 or i<=0 then
return{
innerX=o,
innerY=s,
innerWidth=t,
innerHeight=i,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=o
}
end
local e,n=F(self.scrollbar,#self.items,i,t)
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
innerX=o,
innerY=s,
innerWidth=t,
innerHeight=i,
contentWidth=a,
scrollbarWidth=e,
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
local t={}
for e=1,#self.items do
t[e]=self.items[e]
end
return t
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
self.scrollbar=L(t,self.bg or e.black,self.fg or e.white)
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
function f:_itemIndexFromPoint(a,t)
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
local a=O.clock()
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
local o=self.selectedIndex>=1 and self.selectedIndex or 0
for a=1,t do
local t=((o+a-1)%t)+1
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
local o,t,i,s=self:getAbsoluteRect()
local d=self.bg or e.black
local u=self.fg or e.white
n(a,o,t,i,s,d,d)
_(a,o,t,i,s)
if self.border then
p(h,o,t,i,s,self.border,d)
end
local t=self:_computeLayoutMetrics()
local s=t.innerWidth
local i=t.innerHeight
local o=t.contentWidth
if s<=0 or i<=0 or o<=0 then
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
for e=0,i-1 do
a.text(r,h+e,string.rep(" ",o),u,d)
end
if l>0 then
local e=(s and s.background)or d
n(a,t.scrollbarX,h,l,i,e,e)
end
local n=self.placeholder
if type(n)=="string"and#n>0 then
local t=n
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
C(a,t.scrollbarX,h,i,0,i,0,s)
end
return
end
for e=0,i-1 do
local i=h+e
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
local e=(s and s.background)or d
n(a,t.scrollbarX,h,l,i,e,e)
if s then
C(a,t.scrollbarX,h,i,#self.items,i,math.max(0,self.scrollOffset-1),s)
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
local e=U(a,e.innerHeight,#self.items,e.innerHeight,t)
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
local e=U(a,e.innerHeight,#self.items,e.innerHeight,t)
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
function x:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},x)
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
a.border=N(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function x:_normalizeSelection()
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
function x:setItems(a)
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
function x:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function x:setSelectedIndex(e,a)
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
function x:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function x:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function x:_setOpen(e)
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
function x:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function x:_isPointInDropdown(o,a)
if not self._open or#self.items==0 then
return false
end
local t,e,n,i=self:getAbsoluteRect()
local e=e+i
return o>=t and o<t+n and a>=e and a<e+#self.items
end
function x:_indexFromPoint(t,e)
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
function x:_handlePress(e,t)
local i,i,o,a=self:getAbsoluteRect()
if o<=0 or a<=0 then
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
function x:draw(h,d)
if not self.visible then
return
end
local o,a,i,s=self:getAbsoluteRect()
local t=self.bg or e.black
local r=self.fg or e.white
n(h,o,a,i,s,t,t)
_(h,o,a,i,s)
if self.border then
p(d,o,a,i,s,self.border,t)
end
local e=self.border
local n=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local l=o+n
local n=math.max(0,i-n-u)
local u=a+d
local e=math.max(0,s-d-e)
local s=n>0 and 1 or 0
local o=math.max(0,n-s)
local i
if e>0 then
i=u+math.floor((e-1)/2)
else
i=a
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
h.text(l,i,e,r,t)
end
if s>0 then
local e=self._open and string.char(30)or string.char(31)
local a=l+n-1
h.text(a,i,e,r,t)
end
end
function x:_drawDropdown(h,u)
if not self._open or#self.items==0 or self.visible==false then
return
end
local s,e,i,t=self:getAbsoluteRect()
local a=e+t
local d=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local r=(e and e.right)and 1 or 0
local c=s+t
local t=math.max(0,i-t-r)
local l=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local r=d+e
n(h,s,a,i,r,self.dropdownBg,self.dropdownBg)
_(h,s,a,i,r)
for e=1,d do
local n=a+e-1
local i=self.items[e]or""
local e=l~=nil and l==e
local a=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local o=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if t>0 then
local e=i
if#e>t then
e=e:sub(1,t)
end
local t=math.max(0,t-#e)
local e=e..string.rep(" ",t)
h.text(c,n,e,o,a)
end
end
if self.border then
local e=o(self.border)
if e then
e.top=false
p(u,s,a,i,r,e,self.dropdownBg)
end
end
end
function x:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
return self:_handlePress(e,t)
elseif e=="monitor_touch"then
local a,t,e=...
return self:_handlePress(t,e)
elseif e=="mouse_scroll"then
local t,a,e=...
if self:containsPoint(a,e)or self:_isPointInDropdown(a,e)then
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
local t=((e+t-1)%#self.items)+1
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
a.border=N(true)
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
for e=1,#self.tabs do
local t=self.tabs[e]
if t and not t.disabled then
return e
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
local e={}
for t=1,#self.tabs do
e[t]=o(self.tabs[t])
end
return e
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
function c:selectTabById(a,o)
for e=1,#self.tabs do
local t=self.tabs[e]
if t and t.id==a then
self:setSelectedIndex(e,o)
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
local o,n,s,r=self:getAbsoluteRect()
local e=self.border
local t=(e and e.left)and 1 or 0
local h=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=o+t
local o=n+a
local n=math.max(0,s-t-h)
local h=math.max(0,r-a-e)
local e=math.min(h,self.tabHeight or 3)
if e<0 then
e=0
end
local d=math.max(0,h-e)
local s={}
if n>0 and e>0 then
local a=i
local n=i+n-1
local r=math.max(0,self.tabSpacing or 0)
local h=math.max(0,self.tabPadding or 0)
for i=1,#self.tabs do
if a>n then
break
end
local t=self.tabs[i]
local t=t and t.label and tostring(t.label)or string.format("Tab %d",i)
local t=math.max(3,#t+h*2)
local n=n-a+1
if t>n then
t=n
end
if t<=0 then
break
end
s[i]={
x1=a,
y1=o,
x2=a+t-1,
y2=o+e-1,
width=t
}
a=a+t+r
end
end
self._tabRects=s
self._layoutCache={
innerX=i,
innerY=o,
innerWidth=n,
innerHeight=h,
tabHeight=e,
bodyX=i,
bodyY=o+e,
bodyWidth=n,
bodyHeight=d
}
return self._layoutCache,s
end
function c:_tabIndexFromPoint(t,a)
self:_computeTabLayout()
for o,e in pairs(self._tabRects)do
if e and t>=e.x1 and t<=e.x2 and a>=e.y1 and a<=e.y2 then
return o
end
end
return nil
end
function c:_moveSelection(t)
if#self.tabs==0 or t==0 then
return
end
t=t>0 and 1 or-1
local a=#self.tabs
local e=self.selectedIndex
if e<1 or e>a then
e=t>0 and 0 or a+1
end
for o=1,a do
e=e+t
if e<1 then
e=a
elseif e>a then
e=1
end
local t=self.tabs[e]
if t and not t.disabled then
self:setSelectedIndex(e)
return
end
end
end
function c:_renderBody(i,n,a)
local o=a.bodyWidth or 0
local h=a.bodyHeight or 0
if o<=0 or h<=0 then
return
end
local t=self:getSelectedTab()
if not t then
return
end
local s=t.contentRenderer
if s~=nil and type(s)=="function"then
s(self,t,i,n,a)
return
end
if type(t.content)=="function"then
t.content(self,t,i,n,a)
return
end
if self.bodyRenderer then
self.bodyRenderer(self,t,i,n,a)
return
end
if type(t.content)=="string"then
local n=P(t.content,o)
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
function c:draw(i,r)
if not self.visible then
return
end
local h,o,t,a=self:getAbsoluteRect()
local s=self.bodyBg or self.bg or e.black
local d=self.bodyFg or self.fg or e.white
n(i,h,o,t,a,s,s)
_(i,h,o,t,a)
if self.border then
p(r,h,o,t,a,self.border,s)
end
local e=select(1,self:_computeTabLayout())
if not e or e.innerWidth<=0 or e.innerHeight<=0 then
return
end
local a=self.tabBg or s
local l=self.tabFg or d
if e.tabHeight>0 and e.innerWidth>0 then
n(i,e.innerX,e.innerY,e.innerWidth,e.tabHeight,a,a)
end
if self._hoverIndex and not self._tabRects[self._hoverIndex]then
self._hoverIndex=nil
end
for s,t in pairs(self._tabRects)do
local h=self.tabs[s]
if h and t then
local o=a
local a=l
if s==self.selectedIndex and self.selectedIndex>0 then
o=self.activeTabBg or o
a=self.activeTabFg or a
if self:isFocused()then
o=self.hoverTabBg or o
a=self.hoverTabFg or a
end
elseif self._hoverIndex and self._hoverIndex==s and not h.disabled then
o=self.hoverTabBg or o
a=self.hoverTabFg or a
end
if h.disabled then
a=self.disabledTabFg or a
end
n(i,t.x1,t.y1,t.width,e.tabHeight,o,o)
local r=math.max(0,self.tabPadding or 0)
local n=h.label or string.format("Tab %d",s)
n=tostring(n)
local s=t.width-r*2
local n=n
if s>0 then
if#n>s then
n=n:sub(1,s)
end
if#n<s then
n=n..string.rep(" ",s-#n)
end
local s=t.x1+r
local e=t.y1+math.max(0,math.floor((e.tabHeight-1)/2))
i.text(s,e,n,a,o)
else
local n=n
if#n>t.width then
n=n:sub(1,t.width)
end
local e=t.y1+math.max(0,math.floor((e.tabHeight-1)/2))
i.text(t.x1,e,n,a,o)
end
end
end
if e.bodyHeight>0 and e.bodyWidth>0 then
n(i,e.bodyX,e.bodyY,e.bodyWidth,e.bodyHeight,s,s)
local t=self:getSelectedTab()
if t then
self:_renderBody(i,r,e)
elseif self.emptyText then
local t=P(self.emptyText,e.bodyWidth)
local a=math.min(e.bodyHeight,#t)
for a=1,a do
local t=t[a]
if#t>e.bodyWidth then
t=t:sub(1,e.bodyWidth)
end
if#t<e.bodyWidth then
t=t..string.rep(" ",e.bodyWidth-#t)
end
i.text(e.bodyX,e.bodyY+a-1,t,d,s)
end
end
end
end
function c:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
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
elseif e=="monitor_touch"then
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
elseif e=="mouse_move"then
local e,t=...
if self:containsPoint(e,t)then
self._hoverIndex=self:_tabIndexFromPoint(e,t)
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
a.border=N(true)
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
function m:_measureItems(n,h)
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
local r=(self.border and self.border.left)and 1 or 0
local s=(self.border and self.border.right)and 1 or 0
local l=(self.border and self.border.top)and 1 or 0
local u=(self.border and self.border.bottom)and 1 or 0
local a=2
local i=(t>0)and 2 or 0
local e=o+a+i+t
if e<a+2 then
e=a+2
end
if e<o+a then
e=o+a
end
local d=e+r+s
if h then
h=math.max(r+s+4,math.floor(h))
if d>h then
e=h-r-s
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
d=e+r+s
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
leftPad=r,
rightPad=s,
topPad=l,
bottomPad=u,
itemCount=#n,
totalWidth=d,
totalHeight=#n+l+u
}
end
function m:_buildLevel(s,o,n,u,l,e)
e=e or self:_measureItems(s,self:_maxWidthForLevel())
if not e or e.itemCount==0 then
return nil
end
local t=self.app and self.app.root or nil
local a=t and t.width or nil
local i=t and t.height or nil
local h=e.totalWidth
local r=e.totalHeight
local o=math.floor(o)
local t=math.floor(n)
if a then
if o<1 then
o=1
end
if o+h-1>a then
o=math.max(1,a-h+1)
end
end
if i then
if t<1 then
t=1
end
if t+r-1>i then
t=math.max(1,i-r+1)
end
end
local a=o+e.leftPad
local d=t+e.topPad
local n=a+e.itemWidth-1
if n<a then
n=a
end
local i
if e.shortcutWidth>0 then
i=n-e.shortcutWidth-1
if i<a then
i=a
end
end
return{
items=s,
metrics=e,
rect={x=o,y=t,width=h,height=r},
contentX=a,
contentY=d,
arrowX=n,
shortcutX=i,
highlightIndex=self:_firstEnabledIndex(s),
parentLevel=u,
parentIndex=l
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
local a=self._levels
local o=a and a[e]
if not o then
return
end
local t=o.items[i]
if not t or t.type~="item"or not t.submenu or#t.submenu==0 then
self:_closeLevelsAfter(e)
return
end
local a=a[e+1]
if a and a.parentLevel==e and a.parentIndex==i then
return
end
local n=self:_measureItems(t.submenu,self:_maxWidthForLevel())
if not n then
self:_closeLevelsAfter(e)
return
end
local a=o.rect.x+o.rect.width
local s=o.contentY+i-1-n.topPad
local a=self:_buildLevel(t.submenu,a,s,e,i,n)
if not a then
self:_closeLevelsAfter(e)
return
end
local h=self.app and self.app.root or nil
local h=h and h.width or nil
if h and a.rect.x+a.rect.width-1>h then
local h=((self.border and self.border.left)and 1 or 0)
local o=o.rect.x-a.rect.width+h
local e=self:_buildLevel(t.submenu,o,s,e,i,n)
if e then
a=e
end
end
self:_closeLevelsAfter(e)
self._levels[#self._levels+1]=a
end
function m:_findItemAtPoint(i,a)
local e=self._levels
if not e or#e==0 then
return nil
end
for o=#e,1,-1 do
local t=e[o]
local e=t.rect
if i>=e.x and i<e.x+e.width and a>=e.y and a<e.y+e.height then
if a>=t.contentY and a<t.contentY+#t.items then
local e=a-t.contentY+1
if e>=1 and e<=#t.items then
return o,e
end
end
return o,nil
end
end
return nil
end
function m:_setHighlight(t,o,i)
local e=self._levels[t]
if not e then
return
end
if not o then
e.highlightIndex=nil
self:_closeLevelsAfter(t)
return
end
local a=e.items[o]
if not a or a.type~="item"or a.disabled then
e.highlightIndex=nil
self:_closeLevelsAfter(t)
return
end
e.highlightIndex=o
if a.submenu and#a.submenu>0 then
if i then
self:_openSubmenu(t,o)
end
else
self:_closeLevelsAfter(t)
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
function m:_handlePointerPress(a,t,e)
local e,a=self:_findItemAtPoint(t,e)
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
function m:_typeSearch(t)
if not t or t==""then
return
end
local e=self._levels
if not e or#e==0 then
return
end
local o=#e
local a=e[o]
local e=#a.items
if e==0 then
return
end
local i=a.highlightIndex or 0
local n=t:lower()
for t=1,e do
local t=((i+t-1)%e)+1
local e=a.items[t]
if e and e.type=="item"and not e.disabled then
local e=(e.label or""):lower()
if e:sub(1,1)==n then
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
function m:open(i,o,a)
t(1,i,"number")
t(2,o,"number")
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
local i=math.floor(i)
local a=math.floor(o)
local o=i-t.leftPad
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
n(o,a.x,a.y,a.width,a.height,self.menuBg,self.menuBg)
_(o,a.x,a.y,a.width,a.height)
local n=t.items
for i=1,#n do
local a=n[i]
local n=t.contentY+i-1
local h=t.highlightIndex==i and a.type=="item"and not a.disabled
local i=h and(self.highlightBg or self.menuBg)or self.menuBg
local s=self.menuFg or e.white
if a.type=="separator"then
local e=self.separatorColor or s
local a=string.rep("-",t.metrics.itemWidth)
o.text(t.contentX,n,a,e,i)
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
local t,a,e=...
return self:_handlePointerPress(t,a,e)
elseif e=="monitor_touch"then
local a,e,t=...
return self:_handlePointerPress(1,e,t)
elseif e=="mouse_move"then
local e,t=...
return self:_handlePointerHover(e,t)
elseif e=="mouse_drag"then
local a,t,e=...
return self:_handlePointerHover(t,e)
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
setmetatable(o,{__index=s})
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
local P={
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
local function Y(t)
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
local function B(e)
return table.concat(e,"\n")
end
local function I(e,a,t)
if e<a then
return a
end
if e>t then
return t
end
return e
end
local function M(e,t,o,a)
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
local function G(t,e,n,i,o,a)
if M(t,e,n,i)<0 then
return false
end
if M(t,e,o,a)>=0 then
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
builtins=P,
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
t.builtins=t.builtins or P
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
t.autocompleteBorder=N(a.autocompleteBorder==false and false or a.autocompleteBorder or true)
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
t.border=N(true)
end
t.scrollbar=L(a.scrollbar,t.bg or e.black,t.fg or e.white)
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
self.scrollbar=L(t,self.bg or e.black,self.fg or e.white)
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
self.text=B(self._lines)
end
function o:_setTextInternal(e,a,t)
e=tostring(e or"")
e=self:_applyMaxLength(e)
self._lines=Y(e)
self:_syncTextFromLines()
if a then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=I(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=I(self._cursorCol,1,#e+1)
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
e=I(e or 1,1,#self.text+1)
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
local t=(e and e.left)and 1 or 0
local h=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i,o=self:getAbsoluteRect()
local n=i+t
local s=o+a
local i=math.max(0,self.width-t-h)
local o=math.max(0,self.height-a-e)
return n,s,i,o,t,a,e
end
function o:_getOverlayHeight(e)
if not self._find.visible then
return 0
end
return math.min(2,e)
end
function o:_computeLayoutMetrics()
local n,e,a,i=self:getAbsoluteRect()
local s,h,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
s=n
h=e
t=math.max(1,a)
o=math.max(1,i)
end
local r=self:_getOverlayHeight(o)
local n=math.max(1,o-r)
local e,a=F(self.scrollbar,#self._lines,n,t)
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
local e,t=self:_getContentSize()
local o=self._scrollY+1
local a=self._scrollY+t
if self._cursorLine<o then
self._scrollY=self._cursorLine-1
elseif self._cursorLine>a then
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
local t,a,o,e=self:_getSelectionRange()
local e=self:_collectRange(t,a,o,e)
return#e
end
function o:getSelectionText()
if not self:_hasSelection()then
return""
end
local e,t,a,o=self:_getSelectionRange()
return self:_collectRange(e,t,a,o)
end
function o:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local a,o=e.line,e.col
local t,e=self._cursorLine,self._cursorCol
if M(a,o,t,e)<=0 then
return a,o,t,e
else
return t,e,a,o
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
local a=Y(a)
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
function o:_setCursorPosition(t,a,e)
e=e or{}
t=I(t,1,#self._lines)
local o=self._lines[t]or""
a=I(a,1,#o+1)
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
function o:_moveCursorVertical(e,t)
local e=I(self._cursorLine+e,1,#self._lines)
local a=self._lines[e]or""
local a=I(self._preferredCol,1,#a+1)
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
self._scrollY=I(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local a=select(1,self:_getContentSize())
local t=self._lines[self._cursorLine]or""
local t=math.max(0,#t-a)
self._scrollX=I(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(o,n)
local e=self:_computeLayoutMetrics()
local i=e.innerX
local a=e.innerY
local t=math.max(1,e.contentWidth)
local e=math.max(1,e.contentHeight)
local t=I(o-i,0,t-1)
local e=I(n-a,0,e-1)
local e=I(self._scrollY+e+1,1,#self._lines)
local a=self._lines[e]or""
local t=I(self._scrollX+t+1,1,#a+1)
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
for e,o,n in o:gmatch("()([%a_][%w_]*)()")do
local s=o:lower()
if t.keywords and t.keywords[s]then
if t.keywordColor then
for e=e,n-1 do
if a[e]==i then
a[e]=t.keywordColor
end
end
end
elseif t.builtins and t.builtins[o]then
if t.builtinColor then
for e=e,n-1 do
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
local function N(t,a,i,o)
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
function o:_buildLineSegments(s,t,h,r,e)
local a=self._lines[s]or""
local o=self:_computeSyntaxColors(a)
local i=self._scrollX+1
local n={}
for t=0,t-1 do
local t=i+t
local i
if t<=#a then
i=a:sub(t,t)
else
i=" "
end
local a=o and o[t]or h
local o=r
if e and G(s,t,e.startLine,e.startCol,e.endLine,e.endCol)then
o=self.selectionBg
a=self.selectionFg
end
N(n,i,a,o)
end
return n,a,o
end
function o:_drawSegments(i,t,o,e)
local t=t
for a=1,#e do
local e=e[a]
if e.text~=""then
i.text(t,o,e.text,e.fg,e.bg)
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
local r=self.overlayBg or self.bg or e.gray
local d=self.overlayFg or self.fg or e.white
local c=self.overlayActiveBg or e.orange
local u=self.overlayActiveFg or e.black
local i=n+i-o
for e=0,o-1 do
h.text(a,i+e,string.rep(" ",t),d,r)
end
local e=self._find
local n=#e.matches
local s=n>0 and string.format("%d/%d",math.max(1,e.index),n)or"0/0"
local n=e.matchCase and"CASE"or"case"
local n=string.format("Find: %s  %s  %s",e.findText,s,n)
local l="Replace: "..e.replaceText
local s=n
if#s>t then
s=s:sub(1,t)
end
local n=l
if#n>t then
n=n:sub(1,t)
end
h.text(a,i,s..string.rep(" ",math.max(0,t-#s)),d,r)
h.text(a,i+math.max(o-1,0),n..string.rep(" ",math.max(0,t-#n)),d,r)
local n,s,l
if e.activeField=="find"then
n=a+6
s=i
l=e.findText
else
n=a+9
s=i+math.max(o-1,0)
l=e.replaceText
end
local e=l
if#e>t-(n-a)then
e=e:sub(1,t-(n-a))
end
h.text(n,s,e..string.rep(" ",math.max(0,t-(n-a)-#e)),u,c)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
h.text(a,i+o-1,e..string.rep(" ",math.max(0,t-#e)),d,r)
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
function o:_isPointInAutocomplete(t,a)
local e=self._autocompleteState and self._autocompleteState.rect
if not e then
return false
end
return t>=e.x and t<e.x+e.width and a>=e.y and a<e.y+e.height
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
function o:_drawDropdown(c,y)
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
local a=I(t.anchorLine-(self._scrollY+1),0,a-1)
local f=o+a
local a=self.autocompleteBorder
local m=(a and a.top)and 1 or 0
local o=(a and a.bottom)and 1 or 0
local u=(a and a.left)and 1 or 0
local r=(a and a.right)and 1 or 0
local l=#t.items
local i=l+m+o
if i<=0 then
t.rect=nil
return
end
local o=0
for e=1,l do
local e=t.items[e]
local e=e and e.label or""
if#e>o then
o=#e
end
end
local s=self.autocompleteMaxWidth or h
s=math.max(1,s)
local d=math.min(h,s)
local o=math.max(d,o)
if o>s then
o=s
end
local d=self.app and self.app.root and self.app.root.width or(w+h-1)
if o+u+r>d then
o=math.max(1,d-u-r)
end
local r=o+u+r
if r<=0 or o<=0 then
t.rect=nil
return
end
local s=I(t.anchorCol-self._scrollX-1,0,h-1)
local s=w+s
local s=s
if s+r-1>d then
s=math.max(1,d-r+1)
end
if s<1 then
s=1
end
local h=f+1
if m>0 then
h=h+1
end
local w=self.app and self.app.root and self.app.root.height or(f+i)
local h=h
if h+i-1>w then
local e=f-i
if e>=1 then
h=e
else
h=math.max(1,w-i+1)
end
end
local f=s+u
local u=h+m
t.rect={
x=s,
y=h,
width=r,
height=i,
contentX=f,
contentY=u,
itemWidth=o,
itemCount=l
}
local d=self.autocompleteBg or self.bg or e.gray
n(c,s,h,r,i,d,d)
_(c,s,h,r,i)
local m=self.autocompleteFg or self.fg or e.white
local v=self.autocompleteHighlightBg or e.lightBlue
local n=self.autocompleteHighlightFg or e.black
for a=1,l do
local i=u+a-1
if i<1 or i>w then
break
end
local e=t.items[a]
local e=e and e.label or""
if#e>o then
e=e:sub(1,o)
end
local o=o-#e
if o>0 then
e=e..string.rep(" ",o)
end
local o=(a==t.selectedIndex)and v or d
local t=(a==t.selectedIndex)and n or m
c.text(f,i,e,t,o)
end
if a then
p(y,s,h,r,i,a,d)
end
end
function o:_updateAutocomplete(n)
if not self.autocomplete then
self:_hideAutocomplete()
return
end
local e=self._lines[self._cursorLine]or""
local a=self._cursorCol-1
local t=a
while t>=1 do
local e=e:sub(t,t)
if not e:match("[%w_]")then
break
end
t=t-1
end
t=t+1
local o=e:sub(t,a)
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
for o=1,s do
local t=a[o]
e.items[o]=t
if i then
local e=t.insert or t.label
if e==i then
n=o
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
local o=e:lower()
local a=t:lower()
if o:sub(1,#t)~=a then
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
local i=e.findText
local o=e.matchCase
for a=1,#self._lines do
local t=self._lines[a]
local t=o and t or t:lower()
local i=o and i or i:lower()
local o=1
while true do
local t,i=t:find(i,o,true)
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
if M(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
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
local o=t.col
local a=self._lines[i]
self._lines[i]=a:sub(1,o-1)..(e.replaceText or"")..a:sub(o+t.length)
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
local c,f,m,w=self:getAbsoluteRect()
local h=self.bg or e.black
local y=self.fg or e.white
n(a,c,f,m,w,h,h)
_(a,c,f,m,w)
local o=self:_computeLayoutMetrics()
local d=o.innerX
local s=o.innerY
local t=o.innerWidth
local j=o.innerHeight
local i=o.contentWidth
local r=o.contentHeight
local v=o.overlayHeight
local u=o.scrollbarWidth
local b=o.scrollbarStyle
local k
local g=false
if self:_hasSelection()then
local o,e,t,a=self:_getSelectionRange()
k={
startLine=o,
startCol=e,
endLine=t,
endCol=a
}
g=true
end
local t=self._autocompleteState
local l=h
for n=0,r-1 do
local o=self._scrollY+n+1
local n=s+n
if o>#self._lines then
a.text(d,n,string.rep(" ",i),y,l)
else
local s,h,r=self:_buildLineSegments(o,i,y,l,k)
self:_drawSegments(a,d,n,s)
if self:isFocused()and o==self._cursorLine then
local e=self._cursorCol-self._scrollX-1
if e>=0 and e<i then
local t
if self._cursorCol<=#h then
t=h:sub(self._cursorCol,self._cursorCol)
else
t=" "
end
local i=l
local o=y
a.text(d+e,n,t,i,o)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not g and o==t.anchorLine then
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
a.text(d+o,n,t,self.autocompleteGhostColor or e.lightGray,l)
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
a.text(d,s,t..string.rep(" ",math.max(0,i-#t)),e.lightGray,l)
end
self:_drawFindOverlay(a,d,s,i,j)
if b then
local t=o.scrollbarX
local e=b.background or h
n(a,t,s,u,r,e,e)
C(a,t,s,r,#self._lines,r,self._scrollY,b)
if v>0 then
n(a,t,s+r,u,v,e,e)
end
elseif u>0 then
n(a,o.scrollbarX,s,u,r+v,h,h)
end
if self.border then
p(q,c,f,m,w,self.border,h)
end
end
function o:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local o,a,t=...
local i=self._autocompleteState
if i and i.visible and self:_isPointInAutocomplete(a,t)then
self.app:setFocus(self)
local e=self:_autocompleteIndexFromPoint(a,t)
if e then
if i.selectedIndex~=e then
i.selectedIndex=e
self:_refreshAutocompleteGhost()
end
if o==1 then
return self:_acceptAutocomplete()
elseif o==2 then
self:_hideAutocomplete()
return true
end
elseif o==2 then
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
local e=U(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
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
if i and i.visible and not self:_isPointInAutocomplete(a,t)then
self:_hideAutocomplete()
end
elseif e=="mouse_drag"then
local i,o,a=...
local e=self._autocompleteState
if e and e.visible and self:_isPointInAutocomplete(o,a)then
local t=self:_autocompleteIndexFromPoint(o,a)
if t and e.selectedIndex~=t then
e.selectedIndex=t
self:_refreshAutocompleteGhost()
end
return true
end
if self._dragging and i==self._dragButton then
local t,e=self:_cursorFromPoint(o,a)
if not self._selectionAnchor and self._dragAnchor then
self._selectionAnchor={line=self._dragAnchor.line,col=self._dragAnchor.col}
end
self:_setCursorPosition(t,e,{extendSelection=true,keepAutocomplete=true})
return true
end
elseif e=="mouse_move"then
local t,a=...
local e=self._autocompleteState
if e and e.visible then
local t=self:_autocompleteIndexFromPoint(t,a)
if t and e.selectedIndex~=t then
e.selectedIndex=t
self:_refreshAutocompleteGhost()
end
end
elseif e=="mouse_up"then
local e=...
if self._dragging and e==self._dragButton then
self._dragging=false
self._dragButton=nil
self._dragAnchor=nil
return true
end
elseif e=="monitor_touch"then
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
local e=U(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
if e~=self._scrollY then
self._scrollY=e
end
return true
end
end
local e,t=self:_cursorFromPoint(o,t)
self:_setCursorPosition(e,t)
return true
end
if a and a.visible then
self:_hideAutocomplete()
end
elseif e=="mouse_scroll"then
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
elseif e=="char"then
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
elseif e=="paste"then
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
elseif e=="key"then
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
elseif e=="key_up"then
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
local s=false
local i
local o=a.window
if o==nil then
i=oe.current()
local e,t=i.getSize()
o=ie.create(i,1,1,e,t,true)
o.setVisible(true)
s=true
end
local t=ee.new(o)
t.profiler.start_frame()
t.profiler.start_region("user")
local r=t.add_pixel_layer(5,"pixelui_pixels")
local c=t.add_text_layer(10,"pixelui_ui")
local d,l=o.getSize()
local n=a.background or e.black
t.fill(n)
local u=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=o,
box=t,
layer=c,
pixelLayer=r,
background=n,
running=false,
_autoWindow=s,
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
},h)
t.root=g:new(t,{
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
function h:getRoot()
return self.root
end
function h:setBackground(e)
t(1,e,"number")
self.background=e
self.box.fill(e)
end
function h:getLayer()
return self.layer
end
function h:getPixelLayer()
return self.pixelLayer
end
function h:createFrame(e)
return g:new(self,e)
end
function h:createWindow(e)
return i:new(self,e)
end
function h:createDialog(e)
return A:new(self,e)
end
function h:createMsgBox(e)
return T:new(self,e)
end
function h:createButton(e)
return R:new(self,e)
end
function h:createLabel(e)
return E:new(self,e)
end
function h:createCheckBox(e)
return z:new(self,e)
end
function h:createToggle(e)
return b:new(self,e)
end
function h:createTextBox(e)
return o:new(self,e)
end
function h:createComboBox(e)
return x:new(self,e)
end
function h:createTabControl(e)
return c:new(self,e)
end
function h:createContextMenu(e)
return m:new(self,e)
end
function h:createList(e)
return f:new(self,e)
end
function h:createTable(e)
return d:new(self,e)
end
function h:createTreeView(e)
return u:new(self,e)
end
function h:createChart(e)
return w:new(self,e)
end
function h:createRadioButton(e)
return k:new(self,e)
end
function h:createProgressBar(e)
return q:new(self,e)
end
function h:createNotificationToast(e)
return r:new(self,e)
end
function h:createLoadingRing(e)
return v:new(self,e)
end
function h:createFreeDraw(e)
return D:new(self,e)
end
function h:createSlider(e)
return l:new(self,e)
end
function h:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=O.startTimer(self._animationInterval)
end
end
function h:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=O.clock()
local a=1
while a<=#t do
local e=t[a]
if e._cancelled then
if e.onCancel then
e.onCancel(e.handle)
end
e._finished=true
table.remove(t,a)
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
table.remove(t,a)
else
a=a+1
end
end
end
end
function h:_clearAnimations(t)
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
function h:animate(e)
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
startTime=O.clock()
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
local n="cancelled"
local N={}
local function I(e,t,...)
if not e then
return
end
for a=1,#e do
local e=e[a]
local e,a=pcall(e,...)
if not e then
print(t..tostring(a))
end
end
end
function j:getId()
return self.id
end
function j:getName()
return self.name
end
function j:setName(e)
t(1,e,"string")
self.name=e
end
function j:getStatus()
return self.status
end
function j:isRunning()
return self.status==a
end
function j:isFinished()
local e=self.status
return e==p or e==_ or e==n
end
function j:isCancelled()
return self._cancelRequested or self.status==n
end
function j:cancel()
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
function j:getResult()
if not self.result then
return nil
end
return te(self.result,1,self.result.n or#self.result)
end
function j:getResults()
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
function j:getError()
return self.error
end
function j:setMetadata(e,a)
t(1,e,"string")
local t=self.metadata[e]
if t==a then
return
end
self.metadata[e]=a
self:_emitMetadata(e,a)
end
function j:getMetadata(e)
t(1,e,"string")
return self.metadata[e]
end
function j:getAllMetadata()
local e={}
for a,t in pairs(self.metadata)do
e[a]=t
end
return e
end
function j:onStatusChange(e)
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
function j:onMetadataChange(e)
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
function j:_emitMetadata(e,t)
I(self._metadataListeners,"Thread metadata listener error: ",self,e,t)
end
function j:_setStatus(e)
if self.status==e then
return
end
self.status=e
I(self._statusListeners,"Thread status listener error: ",self,e)
end
local function I(e)
return setmetatable({_handle=e},S)
end
function S:checkCancelled()
if self._handle._cancelRequested then
error(N,0)
end
end
function S:isCancelled()
return self._handle._cancelRequested==true
end
function S:sleep(a)
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
local a=O.startTimer(a)
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
function S:yield()
self:checkCancelled()
self._handle.waiting="yield"
return coroutine.yield("yield")
end
function S:setMetadata(e,t)
self._handle:setMetadata(e,t)
end
function S:setStatus(e)
self._handle:setMetadata("status",e)
end
function S:setDetail(e)
self._handle:setMetadata("detail",e)
end
function S:setProgress(e)
if e~=nil then
t(1,e,"number")
end
self._handle:setMetadata("progress",e)
end
function S:getHandle()
return self._handle
end
function h:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
self._threadTicker=O.startTimer(0)
return
end
end
end
function h:_cleanupThread(e)
if e.timerId and self._threadTimers then
self._threadTimers[e.timerId]=nil
e.timerId=nil
end
e.waiting=nil
e._ready=false
e._resumeValue=nil
end
function h:_resumeThread(e)
if e.status~=a then
return
end
if e._cancelRequested then
e:_setStatus(n)
self:_cleanupThread(e)
return
end
local t=e._resumeValue
e._resumeValue=nil
local a=ae(coroutine.resume(e.co,t))
local t=a[1]
if not t then
local t=a[2]
if t==N then
e:_setStatus(n)
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
local t={n=a.n-1}
for o=2,a.n do
t[o-1]=a[o]
end
e.result=t
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
function h:_serviceThreads()
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
function h:_shutdownThreads()
if not self._threads then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a then
e._cancelRequested=true
e:_setStatus(n)
self:_cleanupThread(e)
end
end
self._threadTimers={}
self._threadTicker=nil
end
function h:spawnThread(o,e)
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
},j)
local a=coroutine.create(function()
local e=I(t)
t._context=e
local e=ae(o(e,self))
return te(e,1,e.n)
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
function h:getThreads()
local e={}
if not self._threads then
return e
end
for t=1,#self._threads do
e[t]=self._threads[t]
end
return e
end
function h:_registerPopup(e)
if not e then
return
end
local t=self._popupLookup
if not t[e]then
t[e]=true
table.insert(self._popupWidgets,e)
end
end
function h:_unregisterPopup(e)
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
function h:_drawPopups()
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
function h:_registerRadioButton(e)
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
function h:_unregisterRadioButton(t)
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
function h:_selectRadioInGroup(o,t,a)
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
function h:setFocus(e)
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
function h:getFocus()
return self._focusWidget
end
function h:render()
self.box.fill(self.background)
self.pixelLayer.clear()
self.layer.clear()
self.root:draw(self.layer,self.pixelLayer)
self:_drawPopups()
self.box.render()
end
function h:step(e,...)
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
self._animationTimer=O.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or oe.current()
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
function h:run()
self.running=true
self:render()
while self.running do
local e={ne()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
self:_shutdownThreads()
end
function h:stop()
self.running=false
self:_clearAnimations(true)
self:_shutdownThreads()
end
y.widgets={
Frame=function(e,t)
return g:new(e,t)
end,
Window=function(e,t)
return i:new(e,t)
end,
Dialog=function(t,e)
return A:new(t,e)
end,
MsgBox=function(e,t)
return T:new(e,t)
end,
Button=function(t,e)
return R:new(t,e)
end,
Label=function(e,t)
return E:new(e,t)
end,
CheckBox=function(t,e)
return z:new(t,e)
end,
Toggle=function(t,e)
return b:new(t,e)
end,
TextBox=function(e,t)
return o:new(e,t)
end,
ComboBox=function(e,t)
return x:new(e,t)
end,
TabControl=function(t,e)
return c:new(t,e)
end,
ContextMenu=function(t,e)
return m:new(t,e)
end,
List=function(e,t)
return f:new(e,t)
end,
Table=function(t,e)
return d:new(t,e)
end,
TreeView=function(e,t)
return u:new(e,t)
end,
Chart=function(e,t)
return w:new(e,t)
end,
RadioButton=function(t,e)
return k:new(t,e)
end,
ProgressBar=function(e,t)
return q:new(e,t)
end,
Slider=function(t,e)
return l:new(t,e)
end,
LoadingRing=function(t,e)
return v:new(t,e)
end,
FreeDraw=function(t,e)
return D:new(t,e)
end,
NotificationToast=function(t,e)
return r:new(t,e)
end
}
y.Widget=s
y.Frame=g
y.Window=i
y.Dialog=A
y.MsgBox=T
y.Button=R
y.Label=E
y.CheckBox=z
y.Toggle=b
y.TextBox=o
y.ComboBox=x
y.TabControl=c
y.ContextMenu=m
y.List=f
y.Table=d
y.TreeView=u
y.Chart=w
y.RadioButton=k
y.ProgressBar=q
y.Slider=l
y.LoadingRing=v
y.FreeDraw=D
y.NotificationToast=r
y.easings=H
y.ThreadHandle=j
y.ThreadContext=S
y.threadStatus={
running=a,
completed=p,
error=_,
cancelled=n
}
return y
