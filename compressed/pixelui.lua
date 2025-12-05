local G=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local I=assert(rawget(_G,"os"),"os API unavailable")
local ie=assert(I.pullEvent,"os.pullEvent unavailable")
local ne=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local Q=table.pack or function(...)
return{n=select("#",...),...}
end
local K=assert(table.unpack,"table.unpack unavailable")
local t=require("cc.expect").expect
local J=require("shrekbox")
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
local b={}
b.__index=b
setmetatable(b,{__index=s})
local i={}
i.__index=i
setmetatable(i,{__index=b})
local S={}
S.__index=S
setmetatable(S,{__index=s})
local E={}
E.__index=E
setmetatable(E,{__index=s})
local _={}
_.__index=_
setmetatable(_,{__index=s})
local g={}
g.__index=g
setmetatable(g,{__index=s})
local k={}
k.__index=k
setmetatable(k,{__index=s})
local u={}
u.__index=u
setmetatable(u,{__index=s})
local j={}
j.__index=j
local N={}
N.__index=N
local f={}
f.__index=f
setmetatable(f,{__index=s})
local l={}
l.__index=l
setmetatable(l,{__index=s})
local c={}
c.__index=c
setmetatable(c,{__index=s})
local w={}
w.__index=w
setmetatable(w,{__index=s})
local q={}
q.__index=q
setmetatable(q,{__index=s})
local x={}
x.__index=x
setmetatable(x,{__index=s})
local d={}
d.__index=d
setmetatable(d,{__index=s})
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
local O={
info={bg=e.blue,fg=e.white,accent=e.lightBlue,icon="i"},
success={bg=e.green,fg=e.black,accent=e.lime,icon="+"},
warning={bg=e.orange,fg=e.black,accent=e.yellow,icon="!"},
error={bg=e.red,fg=e.white,accent=e.white,icon="x"}
}
local function ee(e)
if e==nil then
return"info"
end
local e=tostring(e):lower()
if O[e]then
return e
end
return"info"
end
local function Z(e)
if e==nil then
return 1,1,1,1
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
return e,e,e,e
end
local n,i,s,o=1,1,1,1
if type(e)=="table"then
local t=e.horizontal or e.x
local a=e.vertical or e.y
if t~=nil then
t=math.max(0,math.floor(t))
n=t
i=t
end
if a~=nil then
a=math.max(0,math.floor(a))
s=a
o=a
end
if e.left~=nil then
n=math.max(0,math.floor(e.left))
end
if e.right~=nil then
i=math.max(0,math.floor(e.right))
end
if e.top~=nil then
s=math.max(0,math.floor(e.top))
end
if e.bottom~=nil then
o=math.max(0,math.floor(e.bottom))
end
end
return n,i,s,o
end
local function z(e,a,t)
if a<=0 then
t[#t+1]=""
return
end
e=(e or""):gsub("\r","")
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
local i,o,a,t=1,1,1,1
if e==nil then
return{top=i,right=o,bottom=a,left=t}
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
i,o,a,t=e,e,e,e
elseif type(e)=="table"then
if e.all~=nil then
local e=math.max(0,math.floor(e.all))
i,o,a,t=e,e,e,e
end
if e.vertical~=nil then
local e=math.max(0,math.floor(e.vertical))
i,a=e,e
end
if e.horizontal~=nil then
local e=math.max(0,math.floor(e.horizontal))
o,t=e,e
end
if e.top~=nil then
i=math.max(0,math.floor(e.top))
end
if e.right~=nil then
o=math.max(0,math.floor(e.right))
end
if e.bottom~=nil then
a=math.max(0,math.floor(e.bottom))
end
if e.left~=nil then
t=math.max(0,math.floor(e.left))
end
end
return{top=i,right=o,bottom=a,left=t}
end
local function P(t,i)
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
z(t:sub(a),i,e)
break
end
z(t:sub(a,o-1),i,e)
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
local z={
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
local a=z[a]
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
local function A(e)
local t=(type(e)=="table"and e.buttons)or nil
local a
local o
local i
if type(e)=="table"then
a=e.closeButton or(type(t)=="table"and t.close)or nil
o=e.maximizeButton or(type(t)=="table"and t.maximize)or nil
i=e.minimizeButton or(type(t)=="table"and t.minimize)or nil
end
return{
close=n("close",a),
maximize=n("maximize",o),
minimize=n("minimize",i)
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
local function z(e,a)
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
local e=z(e[a],t.easing)
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
local function R(a)
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
local o=(e and e.right)and t or 0
local i=(e and e.top)and t or 0
local e=(e and e.bottom)and t or 0
local t=math.max(0,a.width-n-o)
local a=math.max(0,a.height-i-e)
return n,o,i,e,t,a
end
local function ae(e,a)
if e==nil then
return{
enabled=a~=false,
height=1,
bg=nil,
fg=nil,
align="left",
buttons=A(nil),
buttonSpacing=1
}
end
if e==false then
return{enabled=false,height=0,bg=nil,fg=nil,align="left",buttons=A(nil),buttonSpacing=1}
end
if e==true then
return{enabled=true,height=1,bg=nil,fg=nil,align="left",buttons=A(nil),buttonSpacing=1}
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
buttons=A(e),
buttonSpacing=o
}
end
local function te(a,e,t)
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
local t,e=e:match(p)
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
local o=z(e.percent,t..".percent")
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
local o=e.reference or e.of or e.target or e.align
local a=e.offset and math.floor(e.offset)or 0
if o then
local e,o=n(o)
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
local function oe(e)
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
t.widthPercent=z(e.widthPercent,"widthPercent")
end
if e.heightPercent~=nil then
t.heightPercent=z(e.heightPercent,"heightPercent")
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
local p=string.char(31)
local function L(o,n,i)
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
local t=a.trackColor or e.gray
local o=a.thumbColor or e.lightGray
local i=a.arrowColor or i or e.white
local e=a.background or n or e.black
local s=math.max(1,math.floor(a.width or 1))
local n=math.max(1,math.floor(a.minThumbSize or 1))
return{
enabled=true,
alwaysVisible=not not a.alwaysVisible,
width=s,
trackColor=t,
thumbColor=o,
arrowColor=i,
background=e,
minThumbSize=n
}
end
local function z(e)
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
local function C(n,i,a,t,r,d,u,e)
if not e or t<=0 then
return
end
local h=math.max(1,math.floor(e.width or 1))
local o=e.trackColor
local s=e.arrowColor
local l=e.thumbColor
local c=math.max(1,math.floor(e.minThumbSize or 1))
local e=math.max(0,h-1)
local m=T..string.rep(" ",e)
n.text(i,a,m,s,o)
if t>=2 then
local e=p..string.rep(" ",e)
n.text(i,a+t-1,e,s,o)
end
local a=a+1
local e=math.max(0,t-2)
local t=string.rep(" ",h)
for e=0,e-1 do
n.text(i,a+e,t,o,o)
end
local s=math.max(0,(r or 0)-(d or 0))
if s<=0 or e<=0 then
return
end
local u=math.max(0,math.min(s,math.floor((u or 0)+.5)))
local t=d/r
local t=math.max(c,math.floor(e*t+.5))
if t>e then
t=e
end
if t<1 then
t=1
end
local o=e-t
local e=a
if o>0 then
local t=z(s==0 and 0 or(u/s))
e=a+math.floor(t*o+.5)
if e>a+o then
e=a+o
end
end
local a=string.rep(" ",h)
for t=0,t-1 do
n.text(i,e+t,a,l,l)
end
end
local function U(t,a,e,i,o)
if a<=0 then
return o or 0
end
local e=math.max(0,(e or 0)-(i or 0))
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
local function n(h,s,n,t,e,i,o,a)
if t<=0 or e<=0 then
return
end
local a=a or" "
local t=a:rep(t)
for e=0,e-1 do
h.text(s,n+e,t,i,o)
end
end
local function T(t,i,n,a,o,s)
if a<=0 or o<=0 or not t then
return
end
local s=s or e.black
local e=(i-1)*2+1
local i=(n-1)*3+1
local a=a*2
local o=o*3
for o=0,o-1 do
local o=i+o
for a=0,a-1 do
t.pixel(e+a,o,s)
end
end
end
local function z(e,t,a,n,o)
if n<=0 or o<=0 then
return
end
local i=J.transparent
for n=0,n-1 do
e.pixel(t+n,a,i)
if o>1 then
e.pixel(t+n,a+o-1,i)
end
end
for o=1,math.max(0,o-2)do
e.pixel(t,a+o,i)
if n>1 then
e.pixel(t+n-1,a+o,i)
end
end
end
local function p(s,t,h,i,o,e,a)
if i<=0 or o<=0 then
return
end
local n=e.color
local r=a or n
local t=(t-1)*2+1
local a=(h-1)*3+1
local i=i*2
local o=o*3
local l=3
local u=2
local h=math.min(e.thickness,o)
local d=math.min(e.thickness,i)
local l=math.min(o,math.max(h,l))
local u=math.min(i,math.max(d,u))
local function m(h,e,n)
for e=0,e-1 do
local e=h+e
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(t+a,e,n)
end
end
end
local function c(h,e,n)
for e=0,e-1 do
local e=h+e
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(t+a,e,n)
end
end
end
local function f(e,h,n)
for h=0,h-1 do
local e=e+h
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(e,a+t,n)
end
end
end
local function w(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(e,a+t,n)
end
end
end
if e.left then
f(t,u,r)
end
if e.right then
f(t+i-u,u,r)
end
if e.top then
m(a,l,r)
end
if e.bottom then
m(a+o-l,l,r)
end
if e.top then
c(a,h,n)
end
if e.bottom then
c(a+o-h,h,n)
end
if e.left then
w(t,d,n)
end
if e.right then
w(t+i-d,d,n)
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
e.severity=ee(a.severity)
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
e.paddingLeft,e.paddingRight,e.paddingTop,e.paddingBottom=Z(a.padding)
e._hideTimer=nil
e._wrappedLines={""}
e._lastWrapWidth=nil
e._lastMessage=nil
e:_refreshWrap(true)
return e
end
function r:_applyPadding(e,i)
local e,a,t,o=Z(e)
if i or e~=self.paddingLeft or a~=self.paddingRight or t~=self.paddingTop or o~=self.paddingBottom then
self.paddingLeft=e
self.paddingRight=a
self.paddingTop=t
self.paddingBottom=o
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
function r:setAnchor(t)
local e=X(t)
if e==nil and t~=nil then
self.anchor=nil
else
self.anchor=e
end
self:refreshAnchor(false)
end
function r:setAnchorMargin(e)
self.anchorMargins=Y(e)
self:refreshAnchor(false)
end
function r:_computeAnchorPosition()
local i=self.anchor
if not i then
return nil,nil
end
local e=self.parent
if not e then
return nil,nil
end
local n=e.width
local o=e.height
if type(n)~="number"or type(o)~="number"then
return nil,nil
end
local h=self.width
local s=self.height
local a=self.anchorMargins or Y(nil)
local t
local e
if i=="top_right"then
t=n-h-(a.right or 0)+1
e=(a.top or 0)+1
elseif i=="top_left"then
t=(a.left or 0)+1
e=(a.top or 0)+1
elseif i=="bottom_right"then
t=n-h-(a.right or 0)+1
e=o-s-(a.bottom or 0)+1
elseif i=="bottom_left"then
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
if t+h-1>n then
t=math.max(1,n-h+1)
end
if e+s-1>o then
e=math.max(1,o-s+1)
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
local i=math.max(2,math.floor(self.width/6))
local n=math.max(1,math.floor(self.height/3))
local o=e
local a=t
if self.anchor=="top_right"then
o=e+i
a=math.max(1,t-n)
elseif self.anchor=="top_left"then
o=e-i
a=math.max(1,t-n)
elseif self.anchor=="bottom_right"then
o=e+i
a=t+n
elseif self.anchor=="bottom_left"then
o=e-i
a=t+n
end
s.setPosition(self,o,a)
local r=self.anchorAnimationDuration or .2
local h=self.anchorEasing or"easeOutCubic"
local o=o
local a=a
local i=e-o
local n=t-a
self._anchorAnimationHandle=self.app:animate({
duration=r,
easing=h,
update=function(e)
local t=math.floor(o+i*e+.5)
local e=math.floor(a+n*e+.5)
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
local e=O.info
if a~=nil then
local t=O[a]
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
function r:_cancelTimer()
if self._hideTimer then
if I.cancelTimer then
pcall(I.cancelTimer,self._hideTimer)
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
self._hideTimer=I.startTimer(e)
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
local e=ee(e)
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
function r:_renderLine(i,a,s,t,e,n,o)
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
i.text(a,s,e,n,o)
end
function r:draw(o,l)
if not self.visible then
return
end
if self._anchorDirty and not self._anchorAnimationHandle then
self:_applyAnchorPosition(false)
end
local h,r,a,i=self:getAbsoluteRect()
if a<=0 or i<=0 then
return
end
local s=self:_getStyle()or O.info
local t=s.bg or self.bg or e.gray
local d=s.fg or self.fg or e.white
local u=s.accent or d
local f=s.titleColor or d
local c=s.iconColor or u
n(o,h,r,a,i,t,t)
z(o,h,r,a,i)
local e=self.border
if e then
p(l,h,r,a,i,e,t)
else
p(l,h,r,a,i,{
color=u,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
},t)
end
local e=e
local n=(e and e.left)and e.thickness or 0
local m=(e and e.right)and e.thickness or 0
local l=(e and e.top)and e.thickness or 0
local u=(e and e.bottom)and e.thickness or 0
local h=h+n
local r=r+l
local e=math.max(0,a-n-m)
local a=math.max(0,i-l-u)
local h=h+(self.paddingLeft or 0)
local l=r+(self.paddingTop or 0)
local n=math.max(0,e-(self.paddingLeft or 0)-(self.paddingRight or 0))
local i=math.max(0,a-(self.paddingTop or 0)-(self.paddingBottom or 0))
if n<=0 or i<=0 then
return
end
local a=self.icon
if not a or a==""then
a=s.icon or""
end
a=tostring(a or"")
local s=0
local r=h
local e=l
if a~=""and n>0 then
local a=a:sub(1,1)
o.text(h,e,a,c,t)
if n>=3 then
o.text(h+1,e," ",c,t)
s=2
else
s=1
end
r=h+s
end
local a=math.max(0,n-s)
self:_refreshWrap(false,a)
if self.title and self.title~=""and i>0 and a>0 then
self:_renderLine(o,r,e,a,self.title,f,t)
e=e+1
i=i-1
end
if i>0 and a>0 then
local n=self._wrappedLines or{""}
local i=math.min(i,#n)
for i=1,i do
self:_renderLine(o,r,e,a,n[i],d,t)
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
local a,e,t=...
if self.dismissOnClick and self:containsPoint(e,t)then
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
if I.cancelTimer then
pcall(I.cancelTimer,self._tickTimer)
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
self._tickTimer=I.startTimer(self.speed)
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
function v:draw(r,d)
if not self.visible then
return
end
local o,i,t,a=self:getAbsoluteRect()
if t<=0 or a<=0 then
return
end
local e=self.bg or self.app.background
n(r,o,i,t,a,e,e)
z(r,o,i,t,a)
if self.border then
p(d,o,i,t,a,self.border,e)
end
local l=(self.border and self.border.left)and 1 or 0
local c=(self.border and self.border.right)and 1 or 0
local u=(self.border and self.border.top)and 1 or 0
local m=(self.border and self.border.bottom)and 1 or 0
local s=o+l
local h=i+u
local o=math.max(0,t-l-c)
local a=math.max(0,a-u-m)
if o<=0 or a<=0 then
return
end
n(r,s,h,o,a,e,e)
local w=s+(o-1)/2
local l=h+(a-1)/2
local i=math.floor(math.min(o,a)/2)
local t=self.radiusPixels and math.floor(self.radiusPixels)or i
if t>i then
t=i
end
if t<1 then
t=1
end
local n=math.max(1,math.min(math.floor(self.thickness or 1),t))
local i=t+.35
local t=math.max(0,t-n+.35)
local m=i*i
local f=t*t
local t=math.max(3,math.floor(self.segmentCount or 12))
local n=self._phase%t
local c=self.direction>=0 and 1 or-1
local r=math.pi*2
local u=self:_computeTrailColors()
for a=0,a-1 do
local h=h+a
local i=h-l
for a=0,o-1 do
local s=s+a
local a=s-w
local l=a*a+i*i
local o=e
if l<=m and l>=f then
local a=math.atan(i,a)
if a<0 then
a=a+r
end
local i=math.floor(a/r*t)%t
local a
if c>=0 then
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
o=u[t]or e
end
end
d.pixel(s,h,o)
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
return s.handleEvent(self,a,...)
end
local function O(e)
local t,a=e.x,e.y
local e=e.parent
while e do
t=t+e.x-1
a=a+e.y-1
e=e.parent
end
return t,a
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
self.border=R(a.border)
self.focusable=a.focusable==true
self._focused=false
self.constraints=nil
M("width",self.width)
M("height",self.height)
if a.constraints~=nil then
self.constraints=oe(a.constraints)
local e,t=self:_applySizeConstraints(self.width,self.height)
self.width=e
self.height=t
end
end
function s:setSize(e,t)
M("width",e)
M("height",t)
local t,e=self:_applySizeConstraints(e,t)
self.width=t
self.height=e
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
self.constraints=oe(e)
end
local t,e=self:_applySizeConstraints(self.width,self.height)
if t~=self.width or e~=self.height then
self:setSize(t,e)
end
self:_applyConstraintLayout()
end
local function Y(e)
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
local function M(e)
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
local a=Y(e.width)
if a~=nil then
t.width=a
end
local a=Y(e.height)
if a~=nil then
t.height=a
end
if e.widthPercent then
t.widthPercent=e.widthPercent
end
if e.heightPercent then
t.heightPercent=e.heightPercent
end
local a=M(e.centerX)
if a~=nil then
t.centerX=a
end
local a=M(e.centerY)
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
function s:setPosition(a,e)
t(1,a,"number")
t(2,e,"number")
self.x=math.floor(a)
self.y=math.floor(e)
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
self.border=R(true)
return
end
t(1,e,"table","boolean")
self.border=R(e)
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
local e,t=O(self)
return e,t,self.width,self.height
end
function s:getSize()
return self.width,self.height
end
function s:containsPoint(e,a)
local t,o,i,n=self:getAbsoluteRect()
return e>=t and e<t+i and a>=o and a<o+n
end
function s:draw(e,e)
error("draw needs implementation for widget",2)
end
function s:handleEvent(e,...)
return false
end
function b:new(a,t)
local e=setmetatable({},b)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function b:addChild(e)
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
function b:_applyConstraintsToChildren()
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
function b:setSize(e,t)
s.setSize(self,e,t)
self:_applyConstraintsToChildren()
local a=self.onSizeChange
if type(a)=="function"then
a(self,e,t)
end
end
function b:setOnSizeChange(e)
if e~=nil then
t(1,e,"function")
end
self.onSizeChange=e
end
function b:removeChild(e)
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
local t={}
for a=1,#e do
t[a]=e[a]
end
return t
end
local function Y(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function b:getChildren()
return M(self._children)
end
function b:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function b:draw(h,r)
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
z(h,s,i,o,a)
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
function b:handleEvent(t,...)
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
local e=b.new(b,e,t)
setmetatable(e,i)
e.draggable=t.draggable~=false
e.resizable=t.resizable~=false
e.closable=t.closable~=false
e.maximizable=t.maximizable~=false
e.minimizable=t.minimizable~=false
e.hideBorderWhenMaximized=t.hideBorderWhenMaximized~=false
e._titleBar=ae(t.titleBar,nil)
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
b.setSize(self,t,e)
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
local e,n,s=self:_resolveGeometryAnimation(e)
if not self.app or not e or n<=0 then
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
local i
i=self.app:animate({
duration=n,
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
self._geometryAnimationHandle=i
end
function i:_computeTitleLayout()
local d=self:_getVisibleTitleBarHeight()
local t=self._titleBar
if d<=0 or not t or not t.enabled then
self:_invalidateTitleLayout()
return nil
end
local a,s=O(self)
local e,o=self:_computeInnerOffsets()
local n=a+e
local i=math.max(0,self.width-e-o)
if i<=0 then
n=a
i=self.width
end
local e={
barX=a,
barY=s,
barWidth=self.width,
barHeight=d,
innerX=n,
innerWidth=i,
textBaseline=s,
buttonRects={},
buttonOrder={},
buttonMetrics={},
maximizeState=self._isMaximized and"restore"or"maximize"
}
local u=t.buttons or A(nil)
local l=math.max(0,math.floor(t.buttonSpacing or 1))
local h=a+math.max(0,self.width-1)
local function c(n)
local e=u[n]
if not e then
return nil
end
local i=math.max(0,e.padding or 0)
local t=e.width
if t==nil then
local a=tostring(e.label or"")
local o=a
if n=="maximize"then
local t=tostring(e.maximizeLabel or a)
local e=tostring(e.restoreLabel or t)
o=e
a=t
end
local e=math.max(#a,#o)
t=math.max(1,e+i*2)
else
t=math.max(1,math.floor(t))
end
return e,t,i
end
local function r(o)
local n,t,r=c(o)
if not n or t<=0 then
return nil
end
if h-t+1<a then
return nil
end
local i=h
local a=i-t+1
local i={x1=a,y1=s,x2=i,y2=s,width=t,height=d}
e.buttonRects[o]=i
e.buttonOrder[#e.buttonOrder+1]=o
e.buttonMetrics[o]={style=n,padding=r,width=t}
h=a-l-1
return i
end
if self.closable then
r("close")
end
if self.maximizable then
r("maximize")
end
if self.minimizable then
r("minimize")
end
e.titleStart=n
e.titleEnd=h
if e.titleEnd<e.titleStart then
e.titleWidth=0
else
e.titleWidth=e.titleEnd-e.titleStart+1
end
e.innerSpacing=l
e.buttonStyles=u
e.textFillX=n
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
function i:_drawTitleButton(d,m,a,s,l,u)
local e=a.buttonRects and a.buttonRects[s]
if not e then
return
end
local t=a.buttonMetrics and a.buttonMetrics[s]
if not t then
return
end
local o=t.style or{}
local c=math.max(0,t.padding or 0)
local i=e.width-c*2
if i<=0 then
return
end
local r=o.fg or l
local h=o.bg or u
local t=tostring(o.label or"")
if s=="maximize"then
local e=tostring(o.maximizeLabel or t)
local i=tostring(o.restoreLabel or e)
if a.maximizeState=="restore"then
t=i
r=o.restoreFg or r
h=o.restoreBg or h
else
t=e
end
end
if#t>i then
t=t:sub(1,i)
end
local o=h or u or self.bg or self.app.background
n(d,e.x1,e.y1,e.width,a.barHeight,o,o)
T(m,e.x1,e.y1,e.width,a.barHeight,o)
if#t>0 then
local a=e.x1+c
local i=math.floor((i-#t)/2)
if i>0 then
a=a+i
end
d.text(a,e.y1,t,r or l,o)
end
end
function i:_fillTitleBarPixels(t,e,a)
if not t or not e then
return
end
local n=(e.barX-1)*2+1
local o=(e.barY-1)*3+1
local s=e.barWidth*2
local e=math.min(e.barHeight*3,self.height*3)
for i=0,e-1 do
for e=0,s-1 do
t.pixel(n+e,o+i,a)
end
end
end
function i:_hitTestResize(t,s)
if not self.resizable then
return nil
end
local o,e=O(self)
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
function i:_beginResize(t,a,o,i,e)
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
pointerX=o,
pointerY=i,
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
function i:_updateResize(t,a)
if not self._resizing or not self._resizeStart then
return
end
local e=self._resizeStart
local o=t-e.pointerX
local i=a-e.pointerY
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
local o,i,n,i,t,a=V(e)
local t=math.max(1,t)
local a=math.max(1,a)
local i=o+1
local o=n+1
if self.app and e==self.app.root then
i=1
o=1
t=e.width
a=e.height
end
return{x=i,y=o,width=t,height=a}
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
local a,a,o,t=self:_computeInnerOffsets()
local a=self:_getVisibleTitleBarHeight()
e=o+t+math.max(1,a)
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
local t=self._normalRect or self._restoreRect or{
x=self.x,
y=self.y,
width=self.width,
height=self.height
}
self._isMaximized=false
self._isMinimized=false
self:_invalidateTitleLayout()
local function e()
self._restoreRect=nil
self._normalRect=nil
if self.onRestore then
self:onRestore()
end
end
if a then
self:_stopGeometryAnimation()
self:_applyGeometry(t)
e()
return
end
self:_transitionGeometry("restore",t,e)
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
self._titleBar=ae(e,nil)
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
b.setTitle(self,e)
self:_invalidateTitleLayout()
end
function i:getContentOffset()
local a,e,t=self:_computeInnerOffsets()
local e=self:_getVisibleTitleBarHeight()
return a,t+e
end
function i:setSize(e,t)
b.setSize(self,e,t)
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
function i:_pointInTitleBar(t,a)
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
function i:_beginDrag(o,e,t,a)
self:_restoreFromMaximize()
local i,n=O(self)
self._dragging=true
self._dragSource=o
self._dragIdentifier=e
self._dragOffsetX=t-i
self._dragOffsetY=a-n
self:bringToFront()
if self.app then
self.app:setFocus(nil)
end
end
function i:_updateDragPosition(a,t)
if not self._dragging then
return
end
local e=self.parent
local i=self._dragOffsetX or 0
local o=self._dragOffsetY or 0
local a=a-i
local t=t-o
if e then
local o,i=O(e)
local h=o
local s=i
local n=o+math.max(0,e.width-self.width)
local e=i+math.max(0,e.height-self.height)
a=te(a,h,n)
t=te(t,s,e)
local e=a-o+1
local t=t-i+1
self:setPosition(e,t)
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
local r,h,d,l=self:getAbsoluteRect()
local i,c,u,c,s,t=self:_computeInnerOffsets()
local c=r+i
local u=h+u
local i=self.bg or self.app.background
if s>0 and t>0 then
n(a,c,u,s,t,i,i)
T(o,c,u,s,t,i)
else
n(a,r,h,d,l,i,i)
T(o,r,h,d,l,i)
end
z(a,r,h,d,l)
local u=self._titleBar
local t=nil
local s=nil
if u then
t=self:_computeTitleLayout()
if t then
s=u.bg or i
local s=s or i
local h=u.fg or self.fg or e.white
n(a,t.barX,t.textBaseline,t.barWidth,t.barHeight,s,s)
T(o,t.barX,t.textBaseline,t.barWidth,t.barHeight,s)
local n=t.titleWidth or 0
local i=self.title or""
if n>0 and i~=""then
if#i>n then
i=i:sub(1,n)
end
local e=n-#i
local n=u.align or"left"
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
local i=u.fg or self.fg or e.white
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
p(o,r,h,d,l,self.border,i)
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
local i=r
local e=h
local w=r+d-1
local f=h+l-1
local u=(i-1)*2+1
local r=(e-1)*3+1
local m=u+d*2-1
local c=r+l*3-1
local h=a.text
local s=o.pixel
local function l()
a.text=h
o.pixel=s
end
a.text=function(t,n,a,d,r)
if not a or a==""then
return
end
if n<e or n>f then
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
local i=w-t+1
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
h(t,n,e,d,r)
end
o.pixel=function(e,t,a)
if e<u or e>m or t<r or t>c then
return
end
s(e,t,a)
end
local e,t=pcall(function()
for e=1,#t do
t[e]:draw(a,o)
end
end)
l()
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
local t,e,a=...
if self._resizing and self._resizeSource=="mouse"and t==self._resizeIdentifier then
self:_updateResize(e,a)
return true
end
if self._dragging and self._dragSource=="mouse"and t==self._dragIdentifier then
self:_updateDragPosition(e,a)
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
elseif a=="minimize"and self.minimizable then
self:toggleMinimize()
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
return b.handleEvent(self,e,...)
end
local function A(e)
return e=="mouse_click"or e=="mouse_up"or e=="mouse_drag"or e=="mouse_scroll"or e=="monitor_touch"or e=="monitor_up"or e=="monitor_drag"or e=="monitor_scroll"
end
local function O(e,...)
if e=="mouse_click"or e=="mouse_up"or e=="mouse_drag"then
local a,t,e=...
return t,e
elseif e=="mouse_scroll"then
local a,e,t=...
return e,t
elseif e=="monitor_touch"or e=="monitor_up"or e=="monitor_drag"or e=="monitor_scroll"then
local a,t,e=...
return t,e
end
return nil,nil
end
local T=setmetatable({},{__index=i})
T.__index=T
function T:new(t,a)
a=a or{}
local t=i.new(i,t,a)
setmetatable(t,T)
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
function T:setModal(t)
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
function T:isModal()
return not not self.modal
end
function T:setBackdropColor(t,e)
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
function T:getBackdropColor()
return self.backdropColor
end
function T:setCloseOnBackdrop(e)
self.closeOnBackdrop=not not e
end
function T:setCloseOnEscape(e)
self.closeOnEscape=not not e
end
function T:draw(e,t)
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
function T:_consumeModalEvent(e,...)
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
if A(e)then
local o,a=O(e,...)
local t=false
if o and a then
t=self:containsPoint(o,a)
end
if not t and(e=="mouse_click"or e=="monitor_touch")then
if self.closeOnBackdrop then
self:close()
end
end
return true
end
return false
end
function T:handleEvent(e,...)
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
function T:close()
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
local function O(e,t)
if type(e)~="string"then
return t
end
local e=e:lower()
if e~="left"and e~="center"and e~="right"then
return t
end
return e
end
local A=setmetatable({},{__index=T})
A.__index=A
function A:new(i,a)
a=a or{}
if a.modal==nil then
a.modal=true
end
if a.resizable==nil then
a.resizable=false
end
local t=T.new(T,i,a)
setmetatable(t,A)
t.autoClose=a.autoClose~=false
t.buttonAlign=O(a.buttonAlign,"center")
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
local o
if a.contentBorder==false then
o=nil
else
o={color=a.contentBorderColor or e.lightGray}
end
t._contentFrame=b:new(i,{
width=1,
height=1,
bg=t.messageBg,
fg=t.messageFg,
border=o
})
t._contentFrame.focusable=false
t:addChild(t._contentFrame)
t._messageLabel=E:new(i,{
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
function A:setMessage(e)
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
function A:getMessage()
return self.message or""
end
function A:setOnResult(e)
if e~=nil then
t(1,e,"function")
end
self.onResult=e
end
function A:_createButtonEntry(t,i)
local a={}
local o
local s=self.autoClose
local h
local d
local l
local r
local n
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
h=math.max(1,math.floor(t.width))
end
if t.height~=nil then
d=math.max(1,math.floor(t.height))
end
l=t.bg
r=t.fg
n=t.onSelect
else
error("MsgBox button config at index "..tostring(i).." must be a string or table",3)
end
o=tostring(o)
if not a.id or a.id==""then
a.id=tostring(i)
end
local h=h or math.max(self.minButtonWidth,#o+self.buttonLabelPadding*2)
local i=d or self.buttonHeight
local e=S:new(self.app,{
label=o,
width=h,
height=i,
bg=l or e.white,
fg=r or e.black
})
e.focusable=false
a.button=e
a.autoClose=s
a.config=t
a.onSelect=n
e.onClick=function()
self:_handleButtonSelection(a)
end
return a
end
function A:setButtons(e)
if self._buttons then
for e=1,#self._buttons do
local e=self._buttons[e]
if e and e.button and e.button.parent then
e.button.parent:removeChild(e.button)
end
end
end
self._buttons={}
if e==nil then
e={{id="ok",label="OK",autoClose=true}}
end
if type(e)~="table"then
error("MsgBox:setButtons expects a table or nil",2)
end
for t=1,#e do
local e=self:_createButtonEntry(e[t],t)
self._buttons[#self._buttons+1]=e
self:addChild(e.button)
end
self:_updateLayout()
end
function A:_handleButtonSelection(e)
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
function A:setButtonAlign(e)
self.buttonAlign=O(e,self.buttonAlign)
self:_updateLayout()
end
function A:setAutoClose(e)
self.autoClose=not not e
end
function A:setButtonGap(e)
self.buttonGap=math.max(0,math.floor(e or self.buttonGap))
self:_updateLayout()
end
function A:_updateLayout()
if not self._contentFrame then
return
end
local o,t,a,t,e,i=self:_computeInnerOffsets()
local t=self:_getVisibleTitleBarHeight()
local n=math.max(1,e)
local e=math.max(1,i-t)
local o=o+1
local s=a+t+1
local a=#self._buttons
local i=a>0 and self.buttonHeight or 0
local t=e
local t=t
if a>0 then
local a=self.buttonAreaSpacing
if e<=i then
a=0
t=math.max(1,e-i)
else
local o=math.max(0,e-i-1)
if a>o then
a=o
end
t=math.max(1,e-i-a)
end
self._buttonRowY=s+t+a
else
self._buttonRowY=nil
end
self._contentFrame:setPosition(o,s)
self._contentFrame:setSize(n,math.max(1,t))
local e=math.max(1,n-self.messagePaddingX*2)
local i=math.max(1,t-self.messagePaddingY*2)
self._messageLabel:setSize(e,i)
self._messageLabel:setPosition(self.messagePaddingX+1,self.messagePaddingY+1)
if a>0 then
local e=0
for t=1,a do
local a=self._buttons[t].button
e=e+a.width
if t>1 then
e=e+self.buttonGap
end
end
local i
if self.buttonAlign=="left"then
i=o
elseif self.buttonAlign=="right"then
i=o+math.max(0,n-e)
else
i=o+math.max(0,math.floor((n-e)/2))
end
local o=i
local t=self._buttonRowY or(s+t)
for e=1,a do
local e=self._buttons[e]
local e=e.button
e:setSize(e.width,self.buttonHeight)
e:setPosition(o,t)
o=o+e.width+self.buttonGap
end
end
end
function A:setSize(t,e)
i.setSize(self,t,e)
self:_updateLayout()
end
function A:setBorder(e)
i.setBorder(self,e)
self:_updateLayout()
end
function A:setTitleBar(e)
i.setTitleBar(self,e)
self:_updateLayout()
end
function S:new(a,e)
local t=setmetatable({},S)
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
function S:setLabel(e)
t(1,e,"string")
self.label=e
end
function S:setOnClick(e)
if e~=nil then
t(1,e,"function")
end
self.onClick=e
end
function S:draw(h,c)
if not self.visible then
return
end
local i,o,a,t=self:getAbsoluteRect()
local s=self.bg or e.gray
local r=self.fg or e.white
local e=s
local d=r
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=i+1,o+1
local s=math.max(0,a-2)
local r=math.max(0,t-2)
if s>0 and r>0 then
n(h,l,u,s,r,e,e)
else
n(h,i,o,a,t,e,e)
end
z(h,i,o,a,t)
if self.border then
p(c,i,o,a,t,self.border,e)
end
local t=self.label or""
local a=s>0 and s or a
if#t>a then
t=t:sub(1,a)
end
local n=0
if a>#t then
n=math.floor((a-#t)/2)
end
local t=string.rep(" ",n)..t
if#t<a then
t=t..string.rep(" ",a-#t)
end
local i=s>0 and l or i
local a
if r>0 then
a=u+math.floor((r-1)/2)
else
a=o
end
h.text(i,a,t,d,e)
end
function S:handleEvent(e,...)
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
local t=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-t-a)
local n=math.max(0,self.height-o-e)
return t,a,o,e,i,n
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
function E:draw(u,w)
if not self.visible then
return
end
local s,h,d,l=self:getAbsoluteRect()
local r=self.bg or self.app.background or e.black
local f=self.fg or e.white
n(u,s,h,d,l,r,r)
z(u,s,h,d,l)
local e,t,o,t,a,i=self:_getInnerMetrics()
local t=s+e
local m=h+o
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
local i=m+o
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
u.text(o,i,e,f,r)
end
i=i+1
end
end
if self.border then
p(w,s,h,d,l,self.border,r)
end
end
function _:new(n,t)
t=t or{}
local o=o(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},_)
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
function _:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function _:_setState(t,e,o)
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
function _:setLabel(e)
t(1,e,"string")
self.label=e
end
function _:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function _:setAllowIndeterminate(e)
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
function _:setChecked(e)
t(1,e,"boolean")
self:_setState(e,false,false)
end
function _:isChecked()
return self.checked
end
function _:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
t(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function _:isIndeterminate()
return self.indeterminate
end
function _:toggle()
self:_activate()
end
function _:_activate()
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
function _:draw(d,a)
if not self.visible then
return
end
local h,s,t,i=self:getAbsoluteRect()
local o=self.bg or e.black
local e=self.fg or e.white
local o=o
local r=e
if self:isFocused()then
o=self.focusBg or o
r=self.focusFg or r
end
n(d,h,s,t,i,o,o)
z(d,h,s,t,i)
if self.border then
p(a,h,s,t,i,self.border,o)
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
local t=s+math.floor((i-1)/2)
d.text(h,t,e,r,o)
end
function _:handleEvent(e,...)
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
function g:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},g)
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
function g:_cancelAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
end
function g:_setThumbProgress(e)
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
function g:_animateThumb(e)
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
function g:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function g:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function g:setValue(e,t)
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
function g:isOn()
return self.value
end
function g:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function g:setLabels(e,a)
if e~=nil then
t(1,e,"string")
self.labelOn=e
end
if a~=nil then
t(2,a,"string")
self.labelOff=a
end
end
function g:setShowLabel(e)
self.showLabel=not not e
end
function g:setDisabled(e)
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
function g:isDisabled()
return self.disabled
end
function g:setColors(e,o,a,s,n,i,h)
if e~=nil then
t(1,e,"number")
self.trackColorOn=e
end
if o~=nil then
t(2,o,"number")
self.trackColorOff=o
end
if a~=nil then
t(3,a,"number")
self.thumbColor=a
end
if s~=nil then
t(4,s,"number")
self.onLabelColor=s
end
if n~=nil then
t(5,n,"number")
self.offLabelColor=n
end
if i~=nil then
t(6,i,"number")
self.trackColorDisabled=i
end
if h~=nil then
t(7,h,"number")
self.knobColorDisabled=h
end
end
function g:setTransition(a,e)
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
function g:setKnobStyle(a,e)
if a~=nil then
t(1,a,"number")
self.knobWidth=math.max(1,math.floor(a))
end
if e~=nil then
t(2,e,"number")
self.knobMargin=math.max(0,math.floor(e))
end
end
function g:draw(l,d)
if not self.visible then
return
end
local a,t,s,o=self:getAbsoluteRect()
local i=self.bg or e.black
local w=self.fg or e.white
n(l,a,t,s,o,i,i)
z(l,a,t,s,o)
if self.border then
p(d,a,t,s,o,self.border,i)
end
local h,r,s,r,o,i=V(self)
if o<=0 or i<=0 then
return
end
local a=a+h
local s=t+s
local t=o
local o=i
local h=self._thumbProgress
if h==nil then
h=self.value and 1 or 0
end
if h<0 then
h=0
elseif h>1 then
h=1
end
local y=self.trackColorOn or e.green
local m=self.trackColorOff or e.red
local c=self.trackColorDisabled or m
local i=self.disabled and c or m
n(l,a,s,t,o,i,i)
local i=math.floor(t*h+.5)
if i>0 then
if i>t then
i=t
end
local e=self.disabled and c or y
n(l,a,s,i,o,e,e)
end
local r=self.knobMargin or 0
if r<0 then
r=0
end
if r*2>=t then
r=math.max(0,math.floor((t-1)/2))
end
local u=math.max(1,t-r*2)
local i=self.knobWidth and math.max(1,math.min(math.floor(self.knobWidth),u))
if not i then
i=math.max(1,math.floor(u/2))
if u>=4 then
i=math.max(2,i)
end
end
local u=math.max(0,u-i)
local f=math.floor(u*h+.5)
if f>u then
f=u
end
local u=a+r+f
if u+i-1>a+t-1 then
u=a+t-i
elseif u<a+r then
u=a+r
end
local r=self.thumbColor or e.white
if self.disabled then
r=self.knobColorDisabled or r
end
n(l,u,s,i,o,r,r)
local i=""
if self.showLabel then
i=self.value and(self.labelOn or"On")or(self.labelOff or"Off")
end
if i~=""and o>0 then
local e=math.max(0,t-2)
if e>0 and#i>e then
i=i:sub(1,e)
end
local r=self.value and(self.onLabelColor or w)or(self.offLabelColor or w)
local n
if h>=.5 then
n=self.disabled and c or y
else
n=self.disabled and c or m
end
local o=s+math.floor((o-1)/2)
local e=a+math.floor((t-#i)/2)
if e<a then
e=a
end
if e+#i-1>a+t-1 then
e=a+t-#i
end
if#i>0 then
l.text(e,o,i,r,n)
end
end
if self:isFocused()then
local e=self.focusOutline or self.focusFg or e.white
if t>0 then
for t=0,t-1 do
d.pixel(a+t,s,e)
if o>1 then
d.pixel(a+t,s+o-1,e)
end
end
end
if o>0 then
for o=0,o-1 do
d.pixel(a,s+o,e)
if t>1 then
d.pixel(a+t-1,s+o,e)
end
end
end
end
if self.disabled then
local i=self.knobColorDisabled or e.lightGray
for e=0,t-1,2 do
local e=a+e
d.pixel(e,s,i)
if o>1 then
d.pixel(e,s+o-1,i)
end
end
end
end
function g:handleEvent(e,...)
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
function q:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},q)
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
function q:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function q:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function q:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function q:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function q:setLabel(e)
t(1,e,"string")
self.label=e
end
function q:setValue(e)
self.value=e
end
function q:getValue()
return self.value
end
function q:setGroup(e)
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
function q:getGroup()
return self.group
end
function q:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function q:setSelected(e)
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
function q:isSelected()
return self.selected
end
function q:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function q:draw(h,d)
if not self.visible then
return
end
local o,i,t,s=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local r=e
if self:isFocused()then
a=self.focusBg or a
r=self.focusFg or r
end
n(h,o,i,t,s,a,a)
z(h,o,i,t,s)
if self.border then
p(d,o,i,t,s,self.border,a)
end
local n=i+math.floor((s-1)/2)
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
h.text(o,n,e,r,a)
end
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
t.border=R(true)
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
function k:setRange(a,e)
t(1,a,"number")
t(2,e,"number")
if e<=a then
error("ProgressBar max must be greater than min",2)
end
self.min=a
self.max=e
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
function k:draw(o,a)
if not self.visible then
return
end
local t,s,l,r=self:getAbsoluteRect()
local i=self.trackColor or(self.bg or e.gray)
local h=self.fillColor or e.lightBlue
local f=self.textColor or(self.fg or e.white)
n(o,t,s,l,r,i,i)
z(o,t,s,l,r)
if self.border then
p(a,t,s,l,r,self.border,i)
end
local e=self.border
local c=(e and e.left)and 1 or 0
local m=(e and e.right)and 1 or 0
local u=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=t+c
local d=s+u
local t=math.max(0,l-c-m)
local s=math.max(0,r-u-e)
if t<=0 or s<=0 then
return
end
n(o,a,d,t,s,i,i)
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
n(o,a+u,d,r,s,h,h)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
n(o,a,d,l,s,h,h)
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
local s=d+math.floor((s-1)/2)
local n=a+math.floor((t-#e)/2)
if n<a then
n=a
end
for t=1,#e do
local d=e:sub(t,t)
local e=(n-a)+(t-1)
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
o.text(n+t-1,s,d,f,a)
end
end
end
function k:handleEvent(e,...)
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
local l=self.bg or self.app.background or e.black
local u=self.fg or e.white
t.fill=function(e)
local e=e or l
n(r,s,h,a,o,e,e)
end
t.write=function(i,n,e,c,d)
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
r.text(s+i-1,h+n-1,e,c or u,d or l)
end
t.pixel=function(e,n,i)
local t=math.floor(e or 1)
local e=math.floor(n or 1)
if t<1 or t>a or e<1 or e>o then
return
end
d.pixel(s+t-1,h+e-1,i or u)
end
self._ctx=t
self.onDraw(self,t)
end
if self.border then
p(d,s,h,a,o,self.border,self.bg or self.app.background or e.black)
end
end
function u:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=o.width or 12
if o.height==nil then
o.height=a.showValue and 2 or 1
end
local t=setmetatable({},u)
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
t.border=R(true)
end
return t
end
function u:_clampValue(e)
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
function u:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function u:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i,n=self:getAbsoluteRect()
local s=math.max(0,self.width-a-o)
local o=math.max(0,self.height-t-e)
local h=i+a
local i=n+t
return h,i,s,o,a,t,e
end
function u:_valueToPosition(o,a)
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
function u:_positionToValue(e,t)
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
function u:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function u:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function u:_setSingleValue(e,t)
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
function u:setValue(e)
if self.range then
return
end
t(1,e,"number")
self:_setSingleValue(e,false)
end
function u:getValue()
return self.value
end
function u:_setLowerValue(e,t)
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
function u:_setUpperValue(e,t)
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
function u:setRangeValues(e,a,o)
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
function u:getRangeValues()
return self.lowerValue,self.upperValue
end
function u:setRangeLimits(e,a)
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
function u:setStep(e)
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
function u:setShowValue(e)
self.showValue=not not e
end
function u:setColors(a,e,o)
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
function u:_formatNumber(o)
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
function u:_formatDisplayValue()
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
function u:_getStepForNudge(t)
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
function u:_positionFromPoint(e)
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
function u:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local n=self:_valueToPosition(self.lowerValue,a)
local s=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local i=math.abs(t-n)
local o=math.abs(t-s)
if i==o then
if t>s then
e="upper"
elseif t<n then
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
function u:_updateInteraction(e)
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
function u:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function u:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function u:_nudgeValue(e)
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
function u:onFocusChanged(e)
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
function u:draw(a,f)
if not self.visible then
return
end
local l,d,h,r=self:getAbsoluteRect()
local s=self.bg or self.app.background or e.black
n(a,l,d,h,r,s,s)
z(a,l,d,h,r)
local i,c,t,u=self:_getInnerMetrics()
if t<=0 or u<=0 then
if self.border then
p(f,l,d,h,r,self.border,s)
end
return
end
local o
local m=nil
if self.showValue and u>=2 then
m=c
o=c+u-1
else
o=c+math.floor((u-1)/2)
end
n(a,i,o,t,1,self.trackColor,self.trackColor)
local u
if self:isFocused()then
u=self._activeHandle or self._focusedHandle
end
local function c(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if u and s==u then
t=self.fg or e.white
end
a.text(i+n,o," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local s=t-e+1
if s>0 then
n(a,i+e,o,s,1,self.fillColor,self.fillColor)
end
c(e,"lower")
c(t,"upper")
else
local t=self:_valueToPosition(self.value,t)
local e=t+1
if e>0 then
n(a,i,o,e,1,self.fillColor,self.fillColor)
end
c(t,"single")
end
if self.showValue and m then
local o=self:_formatDisplayValue()
if o and o~=""then
if#o>t then
o=o:sub(1,t)
end
local t=i+math.floor((t-#o)/2)
if t<i then
t=i
end
a.text(t,m,o,self.fg or e.white,s)
end
end
if self.border then
p(f,l,d,h,r,self.border,s)
end
end
function u:handleEvent(t,...)
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
function l:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},l)
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
t.border=R(true)
end
t.scrollbar=L(a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_ensureSelectionVisible()
return t
end
function l:_normalizeColumns(e)
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
function l:_recomputeColumnMetrics()
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
function l:_ensureColumnsForData()
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
table.sort(t,function(e,t)
return e.id<t.id
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
function l:setColumns(e)
if e~=nil then
t(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function l:getColumns()
local e={}
for t=1,#self.columns do
e[t]=o(self.columns[t])
end
return e
end
function l:setData(e)
t(1,e,"table")
local t={}
for a=1,#e do
t[a]=e[a]
end
self.data=t
self:_ensureColumnsForData()
self:_refreshRows()
end
function l:getData()
local e={}
for t=1,#self.data do
e[t]=self.data[t]
end
return e
end
function l:_refreshRows()
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
function l:_getColumnById(e)
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
function l:_applySort(e,a,u)
local t=self:_getColumnById(e)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=a=="desc"and"desc"or"asc"
local d=self.sortDirection=="desc"
local r=t.comparator
table.sort(self._rows,function(h,s)
local n=self.data[h]
local i=self.data[s]
local o=l._resolveColumnValue(t,n)
local a=l._resolveColumnValue(t,i)
local e=0
if r then
local a,t=pcall(r,o,a,n,i,t)
if a and type(t)=="number"then
e=t
end
end
if e==0 then
if type(o)=="number"and type(a)=="number"then
if o<a then
e=-1
elseif o>a then
e=1
else
e=0
end
else
local t=tostring(o or""):lower()
local a=tostring(a or""):lower()
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
return h<s
end
if d then
return e>0
end
return e<0
end)
if not u and self.onSort then
self.onSort(self,self.sortColumn,self.sortDirection)
end
self:_ensureSelectionVisible()
end
function l:setSort(e,a,t)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,a or self.sortDirection,t)
end
function l:getSort()
return self.sortColumn,self.sortDirection
end
function l:setOnSort(e)
if e~=nil then
t(1,e,"function")
end
self.onSort=e
end
function l:setScrollbar(t)
self.scrollbar=L(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function l:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function l:getSelectedIndex()
return self.selectedIndex
end
function l:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function l:setSelectedIndex(e,a)
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
function l:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function l:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local i=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local n=(e and e.bottom)and 1 or 0
local e,o=self:getAbsoluteRect()
local i=math.max(0,self.width-a-i)
local n=math.max(0,self.height-t-n)
local a=e+a
local e=o+t
return a,e,i,n
end
function l:_computeLayoutMetrics()
local i,s,t,a=self:_getInnerMetrics()
if t<=0 or a<=0 then
return{
innerX=i,
innerY=s,
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
local h=a>=1 and 1 or 0
local r=math.max(0,a-h)
local e,n=F(self.scrollbar,#self._rows,r,t)
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
innerY=s,
innerWidth=t,
innerHeight=a,
headerHeight=h,
rowsHeight=r,
contentWidth=o,
scrollbarWidth=e,
scrollbarStyle=n,
scrollbarX=i+o
}
end
function l:_getRowsVisible()
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
function l:_clampScroll()
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
function l:_ensureSelectionVisible()
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
function l:_rowFromPoint(a,t)
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
function l:_columnFromPoint(a,t)
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
function l._resolveColumnValue(e,t)
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
function l:_formatCell(t,a,e)
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
function l:draw(a,k)
if not self.visible then
return
end
local f,m,u,c=self:getAbsoluteRect()
local s=self.bg or e.black
local b=self.fg or e.white
n(a,f,m,u,c,s,s)
z(a,f,m,u,c)
local t=self:_computeLayoutMetrics()
local i=t.innerWidth
local g=t.innerHeight
local o=t.contentWidth
if i<=0 or g<=0 or o<=0 then
if self.border then
p(k,f,m,u,c,self.border,s)
end
return
end
local i=t.innerX
local d=t.innerY
local v=t.headerHeight
local j=t.rowsHeight
local y=t.scrollbarWidth
local r=t.scrollbarStyle
local w=self.headerBg or s
local q=self.headerFg or b
if v>0 then
a.text(i,d,string.rep(" ",o),w,w)
local n=i
local h=o
for e=1,#self.columns do
local s=self.columns[e]
local t=math.max(1,math.min(s.width,h))
if e==#self.columns then
t=math.max(1,h)
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
a.text(n,d,e,q,w)
n=n+t
h=o-(n-i)
if h<=0 then
break
end
end
end
local v=d+v
local h=j
local w=self.rowBg or s
local b=self.rowFg or b
if h<=0 then
if y>0 then
local e=(r and r.background)or s
n(a,t.scrollbarX,d,y,g,e,e)
end
if self.border then
p(k,f,m,u,c,self.border,s)
end
return
end
if#self._rows==0 then
for e=0,h-1 do
local e=v+e
a.text(i,e,string.rep(" ",o),b,w)
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
a.text(o,n,t,e.lightGray,w)
end
else
for n=0,h-1 do
local t=self.scrollOffset+n
local c=v+n
if t>#self._rows then
a.text(i,c,string.rep(" ",o),b,w)
else
local n=self._rows[t]
local u=self.data[n]
local m=self.allowRowSelection and t==self.selectedIndex
local h=w
local d=b
if m then
h=self.highlightBg or e.lightGray
d=self.highlightFg or e.black
elseif self.zebra and(t%2==0)then
h=self.zebraBg or h
end
local s=i
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
local e=l._resolveColumnValue(t,u)
e=self:_formatCell(t,u,e)
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
local d=d
if t.color then
if type(t.color)=="number"then
d=t.color
elseif type(t.color)=="function"then
local t,e=pcall(t.color,e,u,t,m)
if t and type(e)=="number"then
d=e
end
end
end
a.text(s,c,e,d,h)
s=s+n
r=o-(s-i)
if r<=0 then
break
end
end
end
end
end
if y>0 then
local e=(r and r.background)or s
n(a,t.scrollbarX,d,y,g,e,e)
if r and h>0 then
local e=math.max(0,self.scrollOffset-1)
C(a,t.scrollbarX,v,h,#self._rows,h,e,r)
end
end
if self.border then
p(k,f,m,u,c,self.border,s)
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
local a=I.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=(e.buffer or"")..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function l:_searchForPrefix(e)
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
local a=l._resolveColumnValue(a,o)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function l:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function l:handleEvent(o,...)
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
return i(t,e)
elseif o=="monitor_touch"then
local a,e,t=...
return i(e,t)
elseif o=="mouse_scroll"then
local e,t,a=...
if self:containsPoint(t,a)then
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
function c:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local t=setmetatable({},c)
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
t.border=R(true)
end
t.scrollbar=L(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:setNodes((a and a.nodes)or{})
return t
end
function c:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function c:setOnToggle(e)
if e~=nil then
t(1,e,"function")
end
self.onToggle=e
end
function c:setScrollbar(t)
self.scrollbar=L(t,self.bg or e.black,self.fg or e.white)
self:_ensureSelectionVisible()
end
function c:_copyNodes(e,i)
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
function c:setNodes(e)
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
function c:getSelectedNode()
return self.selectedNode
end
function c:setSelectedNode(e)
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
function c:expandNode(e)
self:_toggleNode(e,true)
end
function c:collapseNode(e)
self:_toggleNode(e,false)
end
function c:toggleNode(e)
self:_toggleNode(e,nil)
end
function c:_rebuildFlatNodes()
local t={}
local function a(e,o)
for i=1,#e do
local e=e[i]
t[#t+1]={node=e,depth=o}
if e.expanded and e.children and#e.children>0 then
a(e.children,o+1)
end
end
end
a(self.nodes,0)
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
function c:_findVisibleIndex(e)
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
function c:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-t-o)
local i=math.max(0,self.height-a-e)
return t,o,a,e,n,i
end
function c:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function c:_computeLayoutMetrics()
local o,i=self:getAbsoluteRect()
local e,s,n,s,t,a=self:_getInnerMetrics()
local o=o+e
local s=i+n
if t<=0 or a<=0 then
return{
innerX=o,
innerY=s,
innerWidth=t,
innerHeight=a,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=o
}
end
local e,n=F(self.scrollbar,#self._flatNodes,a,t)
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
innerY=s,
innerWidth=t,
innerHeight=a,
contentWidth=i,
scrollbarWidth=e,
scrollbarStyle=n,
scrollbarX=o+i
}
end
function c:_ensureSelectionVisible()
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
function c:_setSelectedIndex(e,a)
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
function c:_selectNode(t,a)
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
function c:_moveSelection(a)
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
function c:_scrollBy(t)
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
function c:_rowFromPoint(i,t)
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
function c:_toggleNode(e,a)
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
function c:_notifySelect()
if self.onSelect then
self.onSelect(self,self.selectedNode,self._selectedIndex)
end
end
function c:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function c:_searchForPrefix(e)
if not e or e==""then
return
end
local a=self._flatNodes
local t=#a
if t==0 then
return
end
local o=self._selectedIndex>=1 and self._selectedIndex or 0
for i=1,t do
local t=((o+i-1)%t)+1
local a=a[t].node
local a=a and a.label or""
if a:lower():sub(1,#e)==e then
self:_setSelectedIndex(t,false)
return
end
end
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
local a=I.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function c:draw(s,h)
if not self.visible then
return
end
local a,i,o,t=self:getAbsoluteRect()
local r=self.bg or e.black
local m=self.fg or e.white
n(s,a,i,o,t,r,r)
z(s,a,i,o,t)
if self.border then
p(h,a,i,o,t,self.border,r)
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
s.text(u,l+e,string.rep(" ",i),m,r)
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
s.text(a,l,t,e.lightGray,r)
end
if c>0 then
local e=(d and d.background)or r
n(s,o.scrollbarX,l,c,h,e,e)
if d then
C(s,o.scrollbarX,l,h,0,h,0,d)
end
end
return
end
for t=0,h-1 do
local d=l+t
local h=self.scrollOffset+t
if h>w then
s.text(u,d,string.rep(" ",i),m,r)
else
local t=f[h]
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
n(s,o.scrollbarX,l,c,h,e,e)
if d then
C(s,o.scrollbarX,l,h,#self._flatNodes,h,math.max(0,self.scrollOffset-1),d)
end
end
end
function c:handleEvent(t,...)
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
local function O(e,a,t)
if e<a then
return a
end
if e>t then
return t
end
return e
end
local function M(r,a,t,h,s,n)
if not r then
return
end
n=n or e.white
local i=math.abs(h-a)
local l=a<h and 1 or-1
local o=-math.abs(s-t)
local d=t<s and 1 or-1
local e=i+o
while true do
r.pixel(a,t,n)
if a==h and t==s then
break
end
local n=2*e
if n>=o then
e=e+o
a=a+l
end
if n<=i then
e=e+i
t=t+d
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
a.selectable=not(t and t.selectable==false)
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
if a.selectable then
if t and t.selectedIndex then
a:setSelectedIndex(t.selectedIndex,true)
else
a:_clampSelection(true)
end
else
a.selectedIndex=nil
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
if not self.selectable then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not a then
self:_emitSelect()
end
end
return
end
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
if self.selectable then
self:_clampSelection(false)
elseif self.selectedIndex~=nil then
self.selectedIndex=nil
self:_emitSelect()
end
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
function w:setSelectable(e,t)
if e==nil then
e=true
else
e=not not e
end
if self.selectable==e then
return
end
self.selectable=e
if not e then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not t then
self:_emitSelect()
end
end
else
self:_clampSelection(t)
end
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
if not self.selectable then
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
if e and self.selectable then
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
if not self.selectable then
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
local o,h,d,i=self:getAbsoluteRect()
local s=self.bg or e.black
local w=self.fg or e.white
n(r,o,h,d,i,s,s)
z(r,o,h,d,i)
if self.border then
p(v,o,h,d,i,self.border,s)
end
local t=self.border
local a=(t and t.thickness)or 0
local l=(t and t.left)and a or 0
local c=(t and t.right)and a or 0
local u=(t and t.top)and a or 0
local t=(t and t.bottom)and a or 0
local o=o+l
local h=h+u
local a=math.max(0,d-l-c)
local t=math.max(0,i-u-t)
self._lastLayout=nil
if a<=0 or t<=0 then
return
end
local d=#self.data
if d==0 then
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
r.text(a,t,i,e.lightGray,s)
end
return
end
local i=(self.showLabels and t>=2)and 1 or 0
local c=(self.showAxis and(t-i)>=2)and 1 or 0
local l=t-c-i
if l<1 then
l=t
c=0
i=0
end
local m=h
local u=m+l-1
local f=c>0 and(u+1)or nil
local c
if i>0 then
if f then
c=f+1
else
c=u+1
end
if c>h+t-1 then
c=h+t-1
end
end
local t=math.huge
local i=-math.huge
for e=1,d do
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
for i=1,d do
local t=o+math.floor((i-1)*a/d)
local e=o+math.floor(i*a/d)-1
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
for a=1,d do
local o=self.data[a]or 0
local e=0
if i>0 then
e=(o-t)/i
end
e=O(e,0,1)
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
local o=u-e+1
if o<m then
o=m
e=u-m+1
end
local t=self.barColor or w
if self.selectable and self.selectedIndex==a then
t=self.highlightColor or t
end
n(r,h[a].left,o,h[a].width,e,t,t)
end
else
local a={}
for o=1,d do
local n=self.data[o]or 0
local e=0
if i>0 then
e=(n-t)/i
end
e=O(e,0,1)
local t=math.max(l-1,0)
local e=u-math.floor(e*t+.5)
if e<m then
e=m
end
if e>u then
e=u
end
a[o]={x=h[o].center,y=e}
end
for t=2,#a do
local e=a[t-1]
local t=a[t]
M(v,e.x,e.y,t.x,t.y,self.lineColor or w)
end
for t=1,#a do
local o=a[t]
local a=self.lineColor or w
local i="o"
if self.selectable and self.selectedIndex==t then
a=self.highlightColor or e.orange
i="O"
end
r.text(o.x,o.y,i,a,s)
end
end
if f then
n(r,o,f,a,1,s,s)
local e=string.rep("-",a)
r.text(o,f,e,self.axisColor or w,s)
end
if c then
n(r,o,c,a,1,s,s)
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
local e=(self.selectable and self.selectedIndex==i)and(self.highlightColor or e.orange)or(self.axisColor or w)
r.text(o,c,t,e,s)
end
end
end
self._lastLayout={
innerX=o,
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
if e and self.selectable then
self:setSelectedIndex(e,false)
end
return true
end
elseif e=="mouse_scroll"then
local e,a,t=...
if self:containsPoint(a,t)then
self.app:setFocus(self)
self:_computeTabLayout()
if self:_isPointInTabStrip(a,t)and self._scrollState and self._scrollState.scrollable then
local e=e>0 and 1 or-1
if self:_adjustScroll(e)then
return true
end
end
if self.selectable then
if e>0 then
self:_moveSelection(1)
elseif e<0 then
self:_moveSelection(-1)
end
end
return true
end
elseif e=="key"then
if not self:isFocused()then
return false
end
if not self.selectable then
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
t.border=R(true)
end
t.scrollbar=L(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_normalizeSelection(true)
return t
end
function f:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-t-o)
local n=math.max(0,self.height-a-e)
return t,o,a,e,i,n
end
function f:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function f:_computeLayoutMetrics()
local o,a=self:getAbsoluteRect()
local t,s,n,s,e,i=self:_getInnerMetrics()
local o=o+t
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
local t,n=F(self.scrollbar,#self.items,i,e)
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
local a=self:getSelectedItem()
local t=self.selectedIndex
self.items=e
if#e==0 then
self.selectedIndex=0
self.scrollOffset=1
if(t~=0 or a~=nil)and self.onSelect then
self.onSelect(self,nil,0)
end
return
end
self:_normalizeSelection(true)
local e=self:getSelectedItem()
if(t~=self.selectedIndex)or(a~=e)then
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
local a=I.clock()
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
local a=((o+a-1)%t)+1
local t=self.items[a]
if t and t:lower():sub(1,#e)==e then
self:setSelectedIndex(a)
return
end
end
end
function f:draw(a,h)
if not self.visible then
return
end
local t,o,s,i=self:getAbsoluteRect()
local r=self.bg or e.black
local u=self.fg or e.white
n(a,t,o,s,i,r,r)
z(a,t,o,s,i)
if self.border then
p(h,t,o,s,i,self.border,r)
end
local t=self:_computeLayoutMetrics()
local s=t.innerWidth
local i=t.innerHeight
local o=t.contentWidth
if s<=0 or i<=0 or o<=0 then
return
end
local d=t.innerX
local h=t.innerY
local l=t.scrollbarWidth
local s=t.scrollbarStyle
local c=#self.items
local r=r
local f=self.highlightBg or e.lightGray
local m=self.highlightFg or e.black
if c==0 then
for e=0,i-1 do
a.text(d,h+e,string.rep(" ",o),u,r)
end
if l>0 then
local e=(s and s.background)or r
n(a,t.scrollbarX,h,l,i,e,e)
end
local n=self.placeholder
if type(n)=="string"and#n>0 then
local t=n
if#t>o then
t=t:sub(1,o)
end
local o=d+math.floor((o-#t)/2)
if o<d then
o=d
end
a.text(o,h,t,e.lightGray,r)
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
a.text(d,i,string.rep(" ",o),u,r)
else
local e=self.items[t]or""
if#e>o then
e=e:sub(1,o)
end
local e=e
if#e<o then
e=e..string.rep(" ",o-#e)
end
local o=r
local n=u
if t==self.selectedIndex then
o=f
n=m
end
a.text(d,i,e,n,o)
end
end
if l>0 then
local e=(s and s.background)or r
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
a.border=R(true)
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
local t,e,i,n=self:getAbsoluteRect()
local e=e+n
return o>=t and o<t+i and a>=e and a<e+#self.items
end
function x:_indexFromPoint(t,e)
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
function x:_handlePress(e,t)
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
function x:draw(s,d)
if not self.visible then
return
end
local o,a,h,i=self:getAbsoluteRect()
local t=self.bg or e.black
local r=self.fg or e.white
n(s,o,a,h,i,t,t)
z(s,o,a,h,i)
if self.border then
p(d,o,a,h,i,self.border,t)
end
local e=self.border
local n=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local l=o+n
local n=math.max(0,h-n-u)
local u=a+d
local e=math.max(0,i-d-e)
local h=n>0 and 1 or 0
local o=math.max(0,n-h)
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
s.text(l,i,e,r,t)
end
if h>0 then
local e=self._open and string.char(30)or string.char(31)
local a=l+n-1
s.text(a,i,e,r,t)
end
end
function x:_drawDropdown(r,c)
if not self._open or#self.items==0 or self.visible==false then
return
end
local t,i,a,e=self:getAbsoluteRect()
local i=i+e
local l=#self.items
local e=self.border
local s=(e and e.left)and 1 or 0
local h=(e and e.right)and 1 or 0
local u=t+s
local s=math.max(0,a-s-h)
local d=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local h=l+e
n(r,t,i,a,h,self.dropdownBg,self.dropdownBg)
z(r,t,i,a,h)
for e=1,l do
local t=i+e-1
local a=self.items[e]or""
local e=d~=nil and d==e
local o=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local i=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if s>0 then
local e=a
if#e>s then
e=e:sub(1,s)
end
local a=math.max(0,s-#e)
local e=e..string.rep(" ",a)
r.text(u,t,e,i,o)
end
end
if self.border then
local e=o(self.border)
if e then
e.top=false
p(c,t,i,a,h,e,self.dropdownBg)
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
local a,e,t=...
return self:_handlePress(e,t)
elseif e=="mouse_scroll"then
local e,t,a=...
if self:containsPoint(t,a)or self:_isPointInDropdown(t,a)then
self.app:setFocus(self)
if e>0 then
self:setSelectedIndex(self.selectedIndex+1)
elseif e<0 then
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
local a,e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
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
local O="x"
local W=string.char(7)
local function M(t)
if t==nil then
return nil
end
local e=type(t)
if e=="number"then
local e=math.floor(t)
if e<0 then
e=0
elseif e>255 then
e=255
end
return string.char(e)
end
local e=tostring(t)
if e==""then
return nil
end
return e
end
local function Y(a)
local t={
enabled=false,
char=O,
spacing=1,
fg=nil,
bg=nil
}
local function o(e)
if e==nil then
return
end
local a=type(e)
if a=="boolean"then
t.enabled=e
elseif a=="string"or a=="number"then
t.enabled=true
local e=M(e)
if e then
t.char=e
end
elseif a=="table"then
if e.enabled~=nil then
t.enabled=not not e.enabled
end
local a=e.char or e.label or e.symbol or e.glyph or e.text or e.value
if a==nil and e.code~=nil then
a=e.code
end
a=M(a)
if a then
t.char=a
end
local a=e.spacing or e.gap or e.padding
if a~=nil then
t.spacing=math.max(0,math.floor(a))
end
if e.fg or e.color or e.foreground or e.textColor then
t.fg=e.fg or e.color or e.foreground or e.textColor
end
if e.bg or e.background or e.fill then
t.bg=e.bg or e.background or e.fill
end
else
t.enabled=not not e
end
end
if a then
if a.tabCloseButton~=nil then
o(a.tabCloseButton)
elseif a.closeButton~=nil then
o(a.closeButton)
end
if a.enableCloseButton~=nil then
t.enabled=not not a.enableCloseButton
end
local e=M(a.closeButtonChar)
if e then
t.char=e
end
if a.closeButtonSpacing~=nil then
t.spacing=math.max(0,math.floor(a.closeButtonSpacing))
end
if a.closeButtonFg~=nil then
t.fg=a.closeButtonFg
end
if a.closeButtonBg~=nil then
t.bg=a.closeButtonBg
end
end
if not t.char or t.char==""then
t.char=O
end
t.spacing=math.max(0,math.floor(t.spacing or 0))
return t
end
local function V(a)
local t=nil
local o=1
local function i(e)
if e==nil then
return
end
local a=type(e)
if a=="boolean"then
if e then
t=W
else
t=nil
end
elseif a=="table"then
if e.enabled==false then
t=nil
else
local a=e.char or e.symbol or e.glyph or e.text or e.value
if a==nil and e.code~=nil then
a=e.code
end
a=M(a)
if a then
t=a
elseif e.enabled==true and not t then
t=W
end
local e=e.spacing or e.gap or e.padding
if e~=nil then
o=math.max(0,math.floor(e))
end
end
else
local e=M(e)
if e then
t=e
end
end
end
if a then
if a.tabIndicator~=nil then
i(a.tabIndicator)
elseif a.currentTabIndicator~=nil then
i(a.currentTabIndicator)
elseif a.indicator~=nil then
i(a.indicator)
end
local e=M(a.indicatorChar)
if e then
t=e
end
if a.indicatorSpacing~=nil then
o=math.max(0,math.floor(a.indicatorSpacing))
end
end
if t~=nil and t~=""then
return t,o
end
return nil,o
end
function d:new(i,t)
t=t or{}
local o=o(t)or{}
if t and t.focusable==false then
o.focusable=false
else
o.focusable=true
end
o.width=math.max(8,math.floor(o.width or 18))
o.height=math.max(3,math.floor(o.height or 7))
local a=setmetatable({},d)
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
a.autoShrink=t and t.autoShrink==false and false or true
local e=nil
if t then
if type(t.onCloseTab)=="function"then
e=t.onCloseTab
elseif type(t.onTabClose)=="function"then
e=t.onTabClose
end
end
a.onCloseTab=e
a.tabCloseButton=Y(t)
local o,e=V(t)
a.tabIndicatorChar=o
a.tabIndicatorSpacing=math.max(0,math.floor((e or 0)))
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
a._scrollIndex=1
a._scrollState={scrollable=false,first=1,last=0,canScrollLeft=false,canScrollRight=false}
a._tabStripRect=nil
a:_normalizeSelection(true)
return a
end
function d:_normalizeTabEntry(e,a)
if e==nil then
return nil
end
local t=type(e)
if t=="string"then
return{
id=a,
label=e,
value=e,
disabled=false,
closeable=true
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
contentRenderer=e.contentRenderer or e.render,
closeable=e.closeable~=false
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
disabled=false,
closeable=true
}
end
end
function d:_normalizeTabs(a)
local e={}
for t=1,#a do
local t=self:_normalizeTabEntry(a[t],t)
if t then
e[#e+1]=t
end
end
return e
end
function d:_findFirstEnabled()
for t=1,#self.tabs do
local e=self.tabs[t]
if e and not e.disabled then
return t
end
end
return 0
end
function d:_resolveSelectableIndex(t)
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
function d:_normalizeSelection(o)
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
function d:setTabs(a)
t(1,a,"table")
local n=self.selectedIndex or 0
local e=self:getSelectedTab()
local i=e and e.id
local o=e and e.label
self.tabs=self:_normalizeTabs(a)
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
if o~=nil then
for t=1,#self.tabs do
local e=self.tabs[t]
if e and e.label==o and not e.disabled then
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
self._scrollIndex=1
self:_invalidateLayout()
end
function d:getTabs()
local t={}
for e=1,#self.tabs do
t[e]=o(self.tabs[e])
end
return t
end
function d:addTab(e)
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
self:_invalidateLayout()
end
function d:removeTab(e)
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
self:_ensureScrollIndexValid()
self:_invalidateLayout()
end
function d:setTabEnabled(e,a)
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
function d:setTabLabel(e,a)
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
self:_invalidateLayout()
end
end
function d:selectTabById(o,a)
for e=1,#self.tabs do
local t=self.tabs[e]
if t and t.id==o then
self:setSelectedIndex(e,a)
return true
end
end
return false
end
function d:getSelectedIndex()
return self.selectedIndex or 0
end
function d:getSelectedTab()
local e=self.selectedIndex or 0
if e>=1 and e<=#self.tabs then
return self.tabs[e]
end
return nil
end
function d:setSelectedIndex(e,a)
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
function d:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function d:setOnCloseTab(e)
if e~=nil then
t(1,e,"function")
end
self.onCloseTab=e
end
function d:setBodyRenderer(e)
if e~=nil then
t(1,e,"function")
end
self.bodyRenderer=e
end
function d:setEmptyText(e)
if e~=nil then
t(1,e,"string")
end
self.emptyText=e
end
function d:setTabCloseButton(t)
local e
if t==nil then
e={tabCloseButton=false}
else
e={tabCloseButton=t}
end
self.tabCloseButton=Y(e)
self:_invalidateLayout()
end
function d:setTabIndicator(a,e)
if e~=nil then
t(2,e,"number")
end
local t={}
if a==nil then
t.tabIndicator=false
else
t.tabIndicator=a
end
if e~=nil then
t.indicatorSpacing=e
end
local e,t=V(t)
self.tabIndicatorChar=e
self.tabIndicatorSpacing=math.max(0,math.floor((t or 0)))
self:_invalidateLayout()
end
function d:setTabClosable(e,a)
t(1,e,"number")
if a~=nil then
t(2,a,"boolean")
end
e=math.floor(e)
if e<1 or e>#self.tabs then
return
end
local e=self.tabs[e]
if not e then
return
end
local t=(a~=false)
if e.closeable~=t then
e.closeable=t
self:_invalidateLayout()
end
end
function d:setAutoShrink(e)
if e==nil then
e=true
else
t(1,e,"boolean")
end
local e=not not e
if self.autoShrink~=e then
self.autoShrink=e
self._scrollIndex=1
self:_invalidateLayout()
end
end
function d:_invalidateLayout()
self._tabRects={}
self._layoutCache=nil
self._tabStripRect=nil
self._scrollState=self._scrollState or{scrollable=false,first=1,last=0,canScrollLeft=false,canScrollRight=false}
end
function d:_ensureScrollIndexValid()
local t=#self.tabs
if t<=0 then
self._scrollIndex=1
return
end
local e=self._scrollIndex or 1
if e<1 then
e=1
elseif e>t then
e=t
end
self._scrollIndex=e
end
function d:_isPointInTabStrip(t,a)
local e=self._tabStripRect
if not e then
return false
end
return t>=e.x and t<e.x+e.width and a>=e.y and a<e.y+e.height
end
function d:_adjustScroll(t)
t=math.floor(t or 0)
if t==0 then
return false
end
local a=self._scrollState
if not a then
self:_computeTabLayout()
a=self._scrollState
end
if not a or not a.scrollable then
return false
end
local o=#self.tabs
if o==0 then
return false
end
self:_ensureScrollIndexValid()
local e=self._scrollIndex
if t>0 then
if not a.canScrollRight then
return false
end
e=math.min(o,e+t)
else
if not a.canScrollLeft then
return false
end
e=math.max(1,e+t)
end
if e~=self._scrollIndex then
self._scrollIndex=e
self._hoverIndex=nil
self:_invalidateLayout()
local t=self.selectedIndex or 0
self:_computeTabLayout()
local e=self._scrollState
if e and e.scrollable then
if t<e.first and e.first<=#self.tabs then
self:setSelectedIndex(e.first,true)
elseif t>e.last and e.last>=1 then
self:setSelectedIndex(e.last,true)
end
end
return true
end
return false
end
function d:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedTab(),self.selectedIndex or 0)
end
end
function d:_emitSelect()
if self.onSelect then
self.onSelect(self,self:getSelectedTab(),self.selectedIndex or 0)
end
end
function d:_computeTabLayout()
local n,i,o,s=self:getAbsoluteRect()
local e=self.border
local a=(e and e.left)and 1 or 0
local r=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local h=n+a
local d=i+t
local a=math.max(0,o-a-r)
local e=math.max(0,s-t-e)
local o=math.min(e,self.tabHeight or 3)
if o<0 then
o=0
end
local t=math.max(0,e-o)
local r={
innerX=h,
innerY=d,
innerWidth=a,
innerHeight=e,
tabHeight=o,
bodyX=h,
bodyY=d+o,
bodyWidth=a,
bodyHeight=t
}
self._layoutCache=r
if o>0 and a>0 then
self._tabStripRect={x=h,y=d,width=a,height=o}
else
self._tabStripRect=nil
end
local t=#self.tabs
if a<=0 or o<=0 or t==0 then
self._tabRects={}
self._scrollState={scrollable=false,first=1,last=0,canScrollLeft=false,canScrollRight=false}
return r,self._tabRects
end
local u=math.max(0,self.tabSpacing or 0)
local l=math.max(0,self.tabPadding or 0)
local e=self.tabIndicatorChar
local i=math.max(0,self.tabIndicatorSpacing or 0)
local n=0
if e and e~=""then
n=#e+i
end
local i=self.tabCloseButton or{enabled=false,char=O,spacing=1}
local e=i.char or O
if not e or e==""then
e=O
end
local w=i.enabled and e~=nil and e~=""
local m=math.max(1,#e)
local f=math.max(0,i.spacing or 0)
local s={}
local i=0
local c=0
for e=1,t do
local t=self.tabs[e]
local a=t and t.label and tostring(t.label)or string.format("Tab %d",e)
if a==""then
a=string.format("Tab %d",e)
end
local h=math.max(1,#a)
local o=w and t and t.closeable~=false
local t=o and m or 0
local m=o and f or 0
local u=l
local l=l
local d=u+l+n+h+t+m
local r=n+h+t
s[e]={
index=e,
label=a,
labelLength=h,
padLeft=u,
padRight=l,
minPadLeft=0,
minPadRight=0,
indicatorWidth=n,
closeable=o,
closeCharWidth=t,
closeSpacing=m,
minCloseSpacing=0,
width=d,
minWidth=r
}
i=i+d
c=c+r
end
local e=u*math.max(0,t-1)
local n=i+e
local l=math.max(0,n-a)
if l>0 and self.autoShrink then
local e=i-c
if e>0 then
local h=math.min(l,e)
local o=h
while o>0 do
local a=false
for e=1,t do
if o<=0 then
break
end
local e=s[e]
if e.padLeft>e.minPadLeft then
e.padLeft=e.padLeft-1
e.width=e.width-1
o=o-1
a=true
elseif e.padRight>e.minPadRight then
e.padRight=e.padRight-1
e.width=e.width-1
o=o-1
a=true
elseif e.closeSpacing>e.minCloseSpacing then
e.closeSpacing=e.closeSpacing-1
e.width=e.width-1
o=o-1
a=true
end
end
if not a then
break
end
end
local e=h-o
if e>0 then
i=i-e
n=n-e
l=math.max(0,n-a)
end
end
end
local c=l>0
if not c then
self._scrollIndex=1
end
local function n(i)
local e=0
local o=i-1
for i=i,t do
local t=s[i]
local n=math.min(t.width,a)
local t=n
if e>0 then
t=t+u
end
if e+t>a then
if e==0 then
o=i
e=n
end
break
end
e=e+t
o=i
end
if o<i then
o=math.min(i,t)
end
return o
end
local function m(t)
local e=t
local t=math.min(s[t].width,a)
while e>1 do
local o=math.min(s[e-1].width,a)
local o=t+u+o
if o>a then
break
end
e=e-1
t=o
end
return e
end
local l={}
local e
local i
if c then
self:_ensureScrollIndexValid()
e=math.max(1,math.min(self._scrollIndex or 1,t))
local a=self.selectedIndex or 0
local o=n(e)
if a>=1 and a<=t then
if a<e or a>o then
e=m(a)
o=n(e)
while a>o and e<a do
e=math.min(a,e+1)
o=n(e)
if e>=t then
break
end
end
if a<e then
e=a
o=n(e)
end
end
end
self._scrollIndex=e
i=n(e)
self._scrollState={
scrollable=true,
first=e,
last=i,
canScrollLeft=e>1,
canScrollRight=i<t
}
else
e=1
i=t
self._scrollState={
scrollable=false,
first=1,
last=t,
canScrollLeft=false,
canScrollRight=false
}
end
e=math.max(1,math.min(e or 1,t))
i=math.max(e,math.min(i or t,t))
local n=h
local h=h+a-1
for i=e,i do
local e=s[i]
local a=math.min(e.width,a)
if n+a-1>h then
a=h-n+1
if a<1 then
break
end
end
local t={
x1=n,
y1=d,
x2=n+a-1,
y2=d+o-1,
width=a,
padLeft=e.padLeft,
padRight=e.padRight,
indicatorWidth=e.indicatorWidth,
closeable=e.closeable,
closeCharWidth=e.closeCharWidth,
closeSpacingWidth=e.closeSpacing,
closeWidth=e.closeCharWidth+e.closeSpacing,
labelLength=e.labelLength,
label=e.label
}
t.labelAvailable=a-e.padLeft-e.padRight-e.indicatorWidth-t.closeWidth
if t.labelAvailable<0 then
t.labelAvailable=0
end
if e.closeCharWidth>0 then
local e=t.x2-e.closeCharWidth+1
if e<t.x1 then
e=t.x1
end
t.closeRect={
x1=e,
y1=t.y1,
x2=t.x2,
y2=t.y2
}
end
l[i]=t
n=t.x2+1+u
if n>h then
break
end
end
self._tabRects=l
r.firstTabIndex=e
r.lastTabIndex=i
return r,l
end
function d:_tabIndexFromPoint(a,t)
self:_computeTabLayout()
for o,e in pairs(self._tabRects)do
if e and a>=e.x1 and a<=e.x2 and t>=e.y1 and t<=e.y2 then
return o
end
end
return nil
end
function d:_hitTestTabArea(a,t)
self:_computeTabLayout()
for o,e in pairs(self._tabRects)do
if e and a>=e.x1 and a<=e.x2 and t>=e.y1 and t<=e.y2 then
if e.closeRect and a>=e.closeRect.x1 and a<=e.closeRect.x2 and t>=e.closeRect.y1 and t<=e.closeRect.y2 then
return o,"close"
end
return o,"tab"
end
end
return nil,nil
end
function d:_canCloseTab(t)
if not t or t.disabled then
return false
end
local e=self.tabCloseButton
if not e or not e.enabled then
return false
end
if not e.char or e.char==""then
return false
end
if t.closeable==false then
return false
end
return true
end
function d:_tryCloseTab(e)
if type(e)~="number"then
return false
end
e=math.floor(e)
if e<1 or e>#self.tabs then
return false
end
local t=self.tabs[e]
if not self:_canCloseTab(t)then
return false
end
if self.onCloseTab then
local e=self.onCloseTab(self,t,e)
if e==false then
return false
end
end
self:removeTab(e)
self._hoverIndex=nil
return true
end
function d:_moveSelection(a)
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
function d:_renderBody(i,n,a)
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
local s=self.bodyFg or self.tabFg or e.white
local h=self.bodyBg or self.bg or e.black
for t=1,t do
local e=n[t]
if#e>o then
e=e:sub(1,o)
end
if#e<o then
e=e..string.rep(" ",o-#e)
end
i.text(a.bodyX,a.bodyY+t-1,e,s,h)
end
end
end
function d:onFocusChanged(e)
if not e then
self._hoverIndex=nil
end
end
function d:draw(s,v)
if not self.visible then
return
end
local o,i,t,a=self:getAbsoluteRect()
local h=self.bodyBg or self.bg or e.black
local b=self.bodyFg or self.fg or e.white
n(s,o,i,t,a,h,h)
z(s,o,i,t,a)
if self.border then
p(v,o,i,t,a,self.border,h)
end
local t=select(1,self:_computeTabLayout())
if not t or t.innerWidth<=0 or t.innerHeight<=0 then
return
end
local o=self.tabBg or h
local d=self.tabFg or b
if t.tabHeight>0 and t.innerWidth>0 then
n(s,t.innerX,t.innerY,t.innerWidth,t.tabHeight,o,o)
end
if self._hoverIndex and not self._tabRects[self._hoverIndex]then
self._hoverIndex=nil
end
local e=self.tabCloseButton or{enabled=false,char=O,spacing=1}
local r=e.char or O
if not r or r==""then
r=O
end
local g=e.enabled and r~=nil and r~=""
local k=e.fg
local q=e.bg
local u=self.tabIndicatorChar
local f=math.max(0,self.tabIndicatorSpacing or 0)
local m=""
local c=""
if u and u~=""then
m=u
c=string.rep(" ",#u)
if f>0 then
local e=string.rep(" ",f)
m=m..e
c=c..e
end
end
for l,e in pairs(self._tabRects)do
local a=self.tabs[l]
if a and e then
local i=o
local o=d
if l==self.selectedIndex and self.selectedIndex>0 then
i=self.activeTabBg or i
o=self.activeTabFg or o
if self:isFocused()then
i=self.hoverTabBg or i
o=self.hoverTabFg or o
end
elseif self._hoverIndex and self._hoverIndex==l and not a.disabled then
i=self.hoverTabBg or i
o=self.hoverTabFg or o
end
if a.disabled then
o=self.disabledTabFg or o
end
n(s,e.x1,e.y1,e.width,t.tabHeight,i,i)
local n=e.padLeft
if n==nil then
n=math.max(0,self.tabPadding or 0)
end
local h=e.padRight
if h==nil then
h=n
end
local w=e.label or a.label or string.format("Tab %d",l)
w=tostring(w)
local d=e.indicatorWidth or 0
local y=e.closeWidth or 0
local a=e.labelAvailable
if a==nil then
a=e.width-n-h-d-y
end
a=math.max(0,a)
local y=e.x1+n
local p=e.y1+math.max(0,math.floor((t.tabHeight-1)/2))
local h=""
if d>0 then
local e
if l==self.selectedIndex and self.selectedIndex>0 then
e=m
else
e=c
end
if e==""then
e=u or""
if f>0 then
e=e..string.rep(" ",f)
end
end
if#e>d then
h=e:sub(1,d)
else
h=e..string.rep(" ",d-#e)
end
end
if#h>a then
h=h:sub(1,a)
end
local t=#h
local d=math.max(0,a-t)
local t=w
if d>0 then
if#t>d then
t=t:sub(1,d)
end
if#t<d then
t=t..string.rep(" ",d-#t)
end
else
t=""
end
local t=h..t
if#t<a then
t=t..string.rep(" ",a-#t)
end
if a>0 and y<=e.x2 then
s.text(y,p,t,o,i)
end
if g and e.closeable and e.closeCharWidth and e.closeCharWidth>0 and e.closeRect then
local t=r
if#t>e.closeCharWidth then
t=t:sub(1,e.closeCharWidth)
elseif#t<e.closeCharWidth then
t=t..string.rep(" ",e.closeCharWidth-#t)
end
local h=k or o
local r=q or i
s.text(e.closeRect.x1,p,t,h,r)
local t=e.closeSpacingWidth or 0
if t>0 then
local h=y+math.max(0,a)-1
local a=e.closeRect.x1-t
if a<=h then
local e=h-a+1
t=t-e
a=a+e
end
if t>0 then
if a<e.x1+n then
t=t-((e.x1+n)-a)
a=e.x1+n
end
if t>0 then
s.text(a,p,string.rep(" ",t),o,i)
end
end
end
end
end
end
if t.bodyHeight>0 and t.bodyWidth>0 then
n(s,t.bodyX,t.bodyY,t.bodyWidth,t.bodyHeight,h,h)
local e=self:getSelectedTab()
if e then
self:_renderBody(s,v,t)
elseif self.emptyText then
local e=P(self.emptyText,t.bodyWidth)
local a=math.min(t.bodyHeight,#e)
for a=1,a do
local e=e[a]
if#e>t.bodyWidth then
e=e:sub(1,t.bodyWidth)
end
if#e<t.bodyWidth then
e=e..string.rep(" ",t.bodyWidth-#e)
end
s.text(t.bodyX,t.bodyY+a-1,e,b,h)
end
end
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
local e,t=self:_hitTestTabArea(e,t)
if e then
if t=="close"then
local t=self:_tryCloseTab(e)
if not t then
local t=self.tabs[e]
if t and not t.disabled then
if self.selectedIndex~=e then
self:setSelectedIndex(e)
else
self:_emitSelect()
end
end
end
else
local t=self.tabs[e]
if t and not t.disabled then
if self.selectedIndex~=e then
self:setSelectedIndex(e)
else
self:_emitSelect()
end
end
end
end
return true
end
elseif t=="monitor_touch"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e,t=self:_hitTestTabArea(t,e)
if e then
if t=="close"then
local t=self:_tryCloseTab(e)
if not t then
local t=self.tabs[e]
if t and not t.disabled then
if self.selectedIndex~=e then
self:setSelectedIndex(e)
else
self:_emitSelect()
end
end
end
else
local t=self.tabs[e]
if t and not t.disabled then
if self.selectedIndex~=e then
self:setSelectedIndex(e)
else
self:_emitSelect()
end
end
end
end
return true
end
elseif t=="mouse_scroll"then
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
elseif t=="mouse_move"then
local e,t=...
if self:containsPoint(e,t)then
self._hoverIndex=self:_tabIndexFromPoint(e,t)
elseif self._hoverIndex then
self._hoverIndex=nil
end
elseif t=="mouse_drag"then
local a,e,t=...
if self:containsPoint(e,t)then
self._hoverIndex=self:_tabIndexFromPoint(e,t)
elseif self._hoverIndex then
self._hoverIndex=nil
end
elseif t=="key"then
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
a.border=R(true)
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
function m:_measureItems(i,s)
if not i or#i==0 then
return nil
end
local o=0
local a=0
for e=1,#i do
local e=i[e]
if e.type=="item"then
local t=#(e.label or"")
if t>o then
o=t
end
local e=e.shortcut
if e and e~=""then
local e=#e
if e>a then
a=e
end
end
end
end
local r=(self.border and self.border.left)and 1 or 0
local h=(self.border and self.border.right)and 1 or 0
local u=(self.border and self.border.top)and 1 or 0
local l=(self.border and self.border.bottom)and 1 or 0
local t=2
local n=(a>0)and 2 or 0
local e=o+t+n+a
if e<t+2 then
e=t+2
end
if e<o+t then
e=o+t
end
local d=e+r+h
if s then
s=math.max(r+h+4,math.floor(s))
if d>s then
e=s-r-h
if e<t+2 then
e=t+2
end
local i=math.max(0,e-t-1)
if a>i then
a=i
end
n=(a>0)and 2 or 0
local i=e-t-n-a
if i<1 then
i=1
end
if o>i then
o=i
end
e=o+t+n+a
d=e+r+h
end
end
if a==0 then
n=0
end
return{
itemWidth=e,
labelWidth=o,
shortcutWidth=a,
shortcutGap=n,
arrowWidth=t,
leftPad=r,
rightPad=h,
topPad=u,
bottomPad=l,
itemCount=#i,
totalWidth=d,
totalHeight=#i+u+l
}
end
function m:_buildLevel(r,a,n,u,l,e)
e=e or self:_measureItems(r,self:_maxWidthForLevel())
if not e or e.itemCount==0 then
return nil
end
local t=self.app and self.app.root or nil
local i=t and t.width or nil
local t=t and t.height or nil
local h=e.totalWidth
local s=e.totalHeight
local o=math.floor(a)
local a=math.floor(n)
if i then
if o<1 then
o=1
end
if o+h-1>i then
o=math.max(1,i-h+1)
end
end
if t then
if a<1 then
a=1
end
if a+s-1>t then
a=math.max(1,t-s+1)
end
end
local t=o+e.leftPad
local d=a+e.topPad
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
rect={x=o,y=a,width=h,height=s},
contentX=t,
contentY=d,
arrowX=n,
shortcutX=i,
highlightIndex=self:_firstEnabledIndex(r),
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
function m:_handlePointerHover(e,t)
local e,t=self:_findItemAtPoint(e,t)
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
local t=e[a]
local e=t.highlightIndex
if not e then
return
end
local t=t.items[e]
if t and t.submenu and#t.submenu>0 then
self:_openSubmenu(a,e)
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
local i=e.highlightIndex or 0
local n=a:lower()
for a=1,t do
local t=((i+a-1)%t)+1
local e=e.items[t]
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
local a=math.floor(o)
local o=math.floor(i)
local a=a-t.leftPad
local o=o-t.topPad
local e=self:_buildLevel(e,a,o,nil,nil,t)
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
z(o,a.x,a.y,a.width,a.height)
local i=t.items
for n=1,#i do
local a=i[n]
local i=t.contentY+n-1
local h=t.highlightIndex==n and a.type=="item"and not a.disabled
local n=h and(self.highlightBg or self.menuBg)or self.menuBg
local s=self.menuFg or e.white
if a.type=="separator"then
local a=self.separatorColor or s
local e=string.rep("-",t.metrics.itemWidth)
o.text(t.contentX,i,e,a,n)
else
local s=a.disabled and(self.disabledFg or e.lightGray)or(h and(self.highlightFg or s)or s)
o.text(t.contentX,i,string.rep(" ",t.metrics.itemWidth),s,n)
local e=a.label or""
if#e>t.metrics.labelWidth then
e=e:sub(1,t.metrics.labelWidth)
end
if#e>0 then
o.text(t.contentX,i,e,s,n)
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
o.text(t.shortcutX,i,e,a,n)
end
if a.submenu and a.submenu[1]~=nil then
o.text(t.arrowX,i,">",s,n)
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
local function O(e,t,a)
if e<t then
return t
end
if e>a then
return a
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
local function V(t,e,o,a,i,n)
if M(t,e,o,a)<0 then
return false
end
if M(t,e,i,n)>=0 then
return false
end
return true
end
local function X(a)
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
t.placeholderColor=a.placeholderColor or a.placeholderFg
t.onChange=a.onChange or nil
t.onCursorMove=a.onCursorMove or nil
t.maxLength=a.maxLength or nil
t.multiline=a.multiline~=false
t.numericOnly=not not a.numericOnly
if t.numericOnly then
t.multiline=false
end
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
t.autocompleteBorder=R(a.autocompleteBorder==false and false or a.autocompleteBorder or true)
t.autocompleteMaxWidth=math.max(4,math.floor(a.autocompleteMaxWidth or math.max(t.width or i.width or 16,16)))
t.autocompleteGhostColor=a.autocompleteGhostColor or e.lightGray
t.syntax=X(a.syntax)
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
function o:setPlaceholderColor(e)
if e~=nil then
t(1,e,"number")
end
self.placeholderColor=e
end
function o:setNumericOnly(e)
if e==nil then
e=true
else
t(1,e,"boolean")
end
self.numericOnly=not not e
if self.numericOnly then
self.multiline=false
end
local e=self.text
if self.numericOnly then
e=self:_sanitizeNumericInput(e)
if not self:_isNumericText(e)then
e=""
end
end
if e~=self.text then
self:_setTextInternal(e,true,false)
end
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
function o:_positionToIndex(t,e)
t=O(t or 1,1,#self._lines)
local e=(e or 1)-1
if e<0 then
e=0
end
for t=1,t-1 do
e=e+#self._lines[t]+1
end
return e+1
end
function o:_getSelectionIndices()
if self:_hasSelection()then
local o,t,a,e=self:_getSelectionRange()
local t=self:_positionToIndex(o,t)
local e=self:_positionToIndex(a,e)
return t,e
end
local e=self:_positionToIndex(self._cursorLine,self._cursorCol)
return e,e
end
function o:_simulateReplacementText(e)
local t,a=self:_getSelectionIndices()
local t=self.text:sub(1,t-1)
local a=self.text:sub(a)
return t..(e or"")..a
end
function o:_sanitizeNumericInput(e)
if not e or e==""then
return""
end
local e=tostring(e):gsub("[^0-9%+%-%.]","")
return e
end
function o:_isNumericText(e)
if e==nil or e==""then
return true
end
if e=="+"or e=="-"then
return true
end
if e=="."or e=="+."or e=="-."then
return true
end
if e:match("^[+-]?%d+$")then
return true
end
if e:match("^[+-]?%d+%.%d*$")then
return true
end
if e:match("^[+-]?%d*%.%d+$")then
return true
end
return false
end
function o:_allowsNumericInsertion(e)
local e=self:_simulateReplacementText(e)
return self:_isNumericText(e)
end
function o:_syncTextFromLines()
self.text=B(self._lines)
end
function o:_setTextInternal(e,a,t)
e=tostring(e or"")
if self.numericOnly then
e=self:_sanitizeNumericInput(e)
if not self:_isNumericText(e)then
e=""
end
end
e=self:_applyMaxLength(e)
self._lines=Y(e)
self:_syncTextFromLines()
if a then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=O(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=O(self._cursorCol,1,#e+1)
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
e=O(e or 1,1,#self.text+1)
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
local t=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,i=self:getAbsoluteRect()
local o=o+t
local i=i+a
local s=math.max(0,self.width-t-n)
local n=math.max(0,self.height-a-e)
return o,i,s,n,t,a,e
end
function o:_getOverlayHeight(e)
if not self._find.visible then
return 0
end
return math.min(2,e)
end
function o:_computeLayoutMetrics()
local n,i,a,e=self:getAbsoluteRect()
local s,r,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
s=n
r=i
t=math.max(1,a)
o=math.max(1,e)
end
local h=self:_getOverlayHeight(o)
local n=math.max(1,o-h)
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
local t,e,a,o=self:_getSelectionRange()
local e=self:_collectRange(t,e,a,o)
return#e
end
function o:getSelectionText()
if not self:_hasSelection()then
return""
end
local e,a,t,o=self:_getSelectionRange()
return self:_collectRange(e,a,t,o)
end
function o:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local o,a=e.line,e.col
local e,t=self._cursorLine,self._cursorCol
if M(o,a,e,t)<=0 then
return o,a,e,t
else
return e,t,o,a
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
function o:_insertAt(e,a,t)
if t==nil or t==""then
return e,a
end
local t=Y(t)
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
function o:_deleteSelection(n)
local e,t,a,o=self:_getSelectionRange()
if not e then
return 0
end
local i=self:_collectRange(e,t,a,o)
self:_removeRange(e,t,a,o)
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
if self.numericOnly then
local t=self:_sanitizeNumericInput(e)
if t==""then
return false
end
if not self:_allowsNumericInsertion(t)then
return false
end
e=t
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
if self.numericOnly then
return false
end
if not self.multiline then
return false
end
return self:_insertTextAtCursor("\n")
end
function o:_insertTab()
if self.numericOnly then
return false
end
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
t=O(t,1,#self._lines)
local o=self._lines[t]or""
a=O(a,1,#o+1)
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
function o:_moveCursorVertical(e,t)
local e=O(self._cursorLine+e,1,#self._lines)
local a=self._lines[e]or""
local a=O(self._preferredCol,1,#a+1)
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
self._scrollY=O(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local t=select(1,self:_getContentSize())
local a=self._lines[self._cursorLine]or""
local t=math.max(0,#a-t)
self._scrollX=O(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(a,t)
local e=self:_computeLayoutMetrics()
local o=e.innerX
local i=e.innerY
local n=math.max(1,e.contentWidth)
local e=math.max(1,e.contentHeight)
local a=O(a-o,0,n-1)
local e=O(t-i,0,e-1)
local e=O(self._scrollY+e+1,1,#self._lines)
local t=self._lines[e]or""
local t=O(self._scrollX+a+1,1,#t+1)
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
local function R(t,a,o,i)
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
function o:_buildLineSegments(n,t,r,h,e)
local a=self._lines[n]or""
local o=self:_computeSyntaxColors(a)
local i=self._scrollX+1
local s={}
for t=0,t-1 do
local t=i+t
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
R(s,i,o,a)
end
return s,a,o
end
function o:_drawSegments(a,t,o,e)
local t=t
for i=1,#e do
local e=e[i]
if e.text~=""then
a.text(t,o,e.text,e.fg,e.bg)
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
local n=n+i-o
for e=0,o-1 do
h.text(a,n+e,string.rep(" ",t),d,r)
end
local e=self._find
local i=#e.matches
local i=i>0 and string.format("%d/%d",math.max(1,e.index),i)or"0/0"
local s=e.matchCase and"CASE"or"case"
local i=string.format("Find: %s  %s  %s",e.findText,i,s)
local l="Replace: "..e.replaceText
local s=i
if#s>t then
s=s:sub(1,t)
end
local i=l
if#i>t then
i=i:sub(1,t)
end
h.text(a,n,s..string.rep(" ",math.max(0,t-#s)),d,r)
h.text(a,n+math.max(o-1,0),i..string.rep(" ",math.max(0,t-#i)),d,r)
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
h.text(i,s,e..string.rep(" ",math.max(0,t-(i-a)-#e)),u,c)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
h.text(a,n+o-1,e..string.rep(" ",math.max(0,t-#e)),d,r)
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
local a=O(t.anchorLine-(self._scrollY+1),0,a-1)
local f=o+a
local a=self.autocompleteBorder
local m=(a and a.top)and 1 or 0
local o=(a and a.bottom)and 1 or 0
local u=(a and a.left)and 1 or 0
local r=(a and a.right)and 1 or 0
local d=#t.items
local i=d+m+o
if i<=0 then
t.rect=nil
return
end
local o=0
for e=1,d do
local e=t.items[e]
local e=e and e.label or""
if#e>o then
o=#e
end
end
local s=self.autocompleteMaxWidth or h
s=math.max(1,s)
local l=math.min(h,s)
local o=math.max(l,o)
if o>s then
o=s
end
local l=self.app and self.app.root and self.app.root.width or(w+h-1)
if o+u+r>l then
o=math.max(1,l-u-r)
end
local r=o+u+r
if r<=0 or o<=0 then
t.rect=nil
return
end
local s=O(t.anchorCol-self._scrollX-1,0,h-1)
local s=w+s
local s=s
if s+r-1>l then
s=math.max(1,l-r+1)
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
itemCount=d
}
local l=self.autocompleteBg or self.bg or e.gray
n(c,s,h,r,i,l,l)
z(c,s,h,r,i)
local n=self.autocompleteFg or self.fg or e.white
local m=self.autocompleteHighlightBg or e.lightBlue
local v=self.autocompleteHighlightFg or e.black
for a=1,d do
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
local o=(a==t.selectedIndex)and m or l
local t=(a==t.selectedIndex)and v or n
c.text(f,i,e,t,o)
end
if a then
p(y,s,h,r,i,a,l)
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
local t=e.findText
local o=e.matchCase
for i=1,#self._lines do
local a=self._lines[i]
local n=o and a or a:lower()
local t=o and t or t:lower()
local a=1
while true do
local t,o=n:find(t,a,true)
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
function o:draw(a,q)
if not self.visible then
return
end
local b,y,m,w=self:getAbsoluteRect()
local s=self.bg or e.black
local f=self.fg or e.white
n(a,b,y,m,w,s,s)
z(a,b,y,m,w)
local o=self:_computeLayoutMetrics()
local d=o.innerX
local h=o.innerY
local t=o.innerWidth
local j=o.innerHeight
local i=o.contentWidth
local r=o.contentHeight
local c=o.overlayHeight
local u=o.scrollbarWidth
local v=o.scrollbarStyle
local k
local g=false
if self:_hasSelection()then
local t,o,a,e=self:_getSelectionRange()
k={
startLine=t,
startCol=o,
endLine=a,
endCol=e
}
g=true
end
local t=self._autocompleteState
local l=s
for n=0,r-1 do
local o=self._scrollY+n+1
local n=h+n
if o>#self._lines then
a.text(d,n,string.rep(" ",i),f,l)
else
local h,s,r=self:_buildLineSegments(o,i,f,l,k)
self:_drawSegments(a,d,n,h)
if self:isFocused()and o==self._cursorLine then
local e=self._cursorCol-self._scrollX-1
if e>=0 and e<i then
local t
if self._cursorCol<=#s then
t=s:sub(self._cursorCol,self._cursorCol)
else
t=" "
end
local o=l
local i=f
a.text(d+e,n,t,o,i)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not g and o==t.anchorLine then
local h=t.anchorCol+#t.prefix
local o=h-self._scrollX-1
if o<i then
local t=t.ghost
local s=#s
if h<=s then
local e=s-h+1
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
local e=self.placeholderColor or e.lightGray
a.text(d,h,t..string.rep(" ",math.max(0,i-#t)),e,l)
end
self:_drawFindOverlay(a,d,h,i,j)
if v then
local t=o.scrollbarX
local e=v.background or s
n(a,t,h,u,r,e,e)
C(a,t,h,r,#self._lines,r,self._scrollY,v)
if c>0 then
n(a,t,h+r,u,c,e,e)
end
elseif u>0 then
n(a,o.scrollbarX,h,u,r+c,s,s)
end
if self.border then
p(q,b,y,m,w,self.border,s)
end
end
function o:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
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
if i and i.visible and not self:_isPointInAutocomplete(a,t)then
self:_hideAutocomplete()
end
elseif t=="mouse_drag"then
local i,a,o=...
local e=self._autocompleteState
if e and e.visible and self:_isPointInAutocomplete(a,o)then
local t=self:_autocompleteIndexFromPoint(a,o)
if t and e.selectedIndex~=t then
e.selectedIndex=t
self:_refreshAutocompleteGhost()
end
return true
end
if self._dragging and i==self._dragButton then
local e,t=self:_cursorFromPoint(a,o)
if not self._selectionAnchor and self._dragAnchor then
self._selectionAnchor={line=self._dragAnchor.line,col=self._dragAnchor.col}
end
self:_setCursorPosition(e,t,{extendSelection=true,keepAutocomplete=true})
return true
end
elseif t=="mouse_move"then
local a,t=...
local e=self._autocompleteState
if e and e.visible then
local t=self:_autocompleteIndexFromPoint(a,t)
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
local e,a,t=...
local o=self._autocompleteState
if o and o.visible and self:_isPointInAutocomplete(a,t)then
self.app:setFocus(self)
local e=self:_autocompleteIndexFromPoint(a,t)
if e then
if o.selectedIndex~=e then
o.selectedIndex=e
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
self:_setCursorPosition(t,e)
return true
end
if o and o.visible then
self:_hideAutocomplete()
end
elseif t=="mouse_scroll"then
local e,t,o=...
local a=self._autocompleteState
if a and a.visible and self:_isPointInAutocomplete(t,o)then
if e>0 then
self:_moveAutocompleteSelection(1)
elseif e<0 then
self:_moveAutocompleteSelection(-1)
end
return true
end
if self:containsPoint(t,o)then
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
local s=false
local i
local o=a.window
if o==nil then
i=G.current()
local t,e=i.getSize()
o=ne.create(i,1,1,t,e,true)
o.setVisible(true)
s=true
end
local t=J.new(o)
t.profiler.start_frame()
t.profiler.start_region("user")
local d=t.add_pixel_layer(5,"pixelui_pixels")
local r=t.add_text_layer(10,"pixelui_ui")
local l,u=o.getSize()
local n=a.background or e.black
t.fill(n)
local c=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=o,
box=t,
layer=r,
pixelLayer=d,
background=n,
running=false,
_autoWindow=s,
_parentTerminal=i,
_focusWidget=nil,
_popupWidgets={},
_popupLookup={},
_animations={},
_animationTimer=nil,
_animationInterval=c,
_radioGroups={},
_threads={},
_threadTimers={},
_threadTicker=nil,
_threadIdCounter=0
},h)
t.root=b:new(t,{
x=1,
y=1,
width=l,
height=u,
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
return b:new(self,e)
end
function h:createWindow(e)
return i:new(self,e)
end
function h:createDialog(e)
return T:new(self,e)
end
function h:createMsgBox(e)
return A:new(self,e)
end
function h:createButton(e)
return S:new(self,e)
end
function h:createLabel(e)
return E:new(self,e)
end
function h:createCheckBox(e)
return _:new(self,e)
end
function h:createToggle(e)
return g:new(self,e)
end
function h:createTextBox(e)
return o:new(self,e)
end
function h:createComboBox(e)
return x:new(self,e)
end
function h:createTabControl(e)
return d:new(self,e)
end
function h:createContextMenu(e)
return m:new(self,e)
end
function h:createList(e)
return f:new(self,e)
end
function h:createTable(e)
return l:new(self,e)
end
function h:createTreeView(e)
return c:new(self,e)
end
function h:createChart(e)
return w:new(self,e)
end
function h:createRadioButton(e)
return q:new(self,e)
end
function h:createProgressBar(e)
return k:new(self,e)
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
return u:new(self,e)
end
function h:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=I.startTimer(self._animationInterval)
end
end
function h:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=I.clock()
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
onComplete=i,
onCancel=o,
easing=t,
duration=e,
startTime=I.clock()
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
local z="error"
local n="cancelled"
local R={}
local function O(e,a,...)
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
return e==p or e==z or e==n
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
return K(self.result,1,self.result.n or#self.result)
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
local e,t=pcall(e,self,self.status)
if not e then
print("Thread status listener error: "..tostring(t))
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
local e,t=pcall(e,self,a,t)
if not e then
print("Thread metadata listener error: "..tostring(t))
end
end
end
function j:_emitMetadata(e,t)
O(self._metadataListeners,"Thread metadata listener error: ",self,e,t)
end
function j:_setStatus(e)
if self.status==e then
return
end
self.status=e
O(self._statusListeners,"Thread status listener error: ",self,e)
end
local function O(e)
return setmetatable({_handle=e},N)
end
function N:checkCancelled()
if self._handle._cancelRequested then
error(R,0)
end
end
function N:isCancelled()
return self._handle._cancelRequested==true
end
function N:sleep(a)
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
local a=I.startTimer(a)
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
function N:yield()
self:checkCancelled()
self._handle.waiting="yield"
return coroutine.yield("yield")
end
function N:setMetadata(t,e)
self._handle:setMetadata(t,e)
end
function N:setStatus(e)
self._handle:setMetadata("status",e)
end
function N:setDetail(e)
self._handle:setMetadata("detail",e)
end
function N:setProgress(e)
if e~=nil then
t(1,e,"number")
end
self._handle:setMetadata("progress",e)
end
function N:getHandle()
return self._handle
end
function h:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
self._threadTicker=I.startTimer(0)
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
local t=Q(coroutine.resume(e.co,t))
local a=t[1]
if not a then
local t=t[2]
if t==R then
e:_setStatus(n)
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
local a={n=t.n-1}
for o=2,t.n do
a[o-1]=t[o]
end
e.result=a
e:_setStatus(p)
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
local e=O(t)
t._context=e
local e=Q(o(e,self))
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
function h:_dispatchPopupEvent(o,...)
local t=self._popupWidgets
if not t or#t==0 then
return false
end
for a=#t,1,-1 do
local e=t[a]
if e and e._open and e.visible~=false then
if e:handleEvent(o,...)then
return true
end
else
if e then
self._popupLookup[e]=nil
end
table.remove(t,a)
end
end
return false
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
self._animationTimer=I.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or G.current()
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
if not t and(e=="mouse_click"or e=="mouse_up"or e=="mouse_drag"or e=="mouse_move"or e=="mouse_scroll"or e=="monitor_touch")then
t=self:_dispatchPopupEvent(e,...)
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
local e={ie()}
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
return b:new(e,t)
end,
Window=function(t,e)
return i:new(t,e)
end,
Dialog=function(t,e)
return T:new(t,e)
end,
MsgBox=function(e,t)
return A:new(e,t)
end,
Button=function(t,e)
return S:new(t,e)
end,
Label=function(t,e)
return E:new(t,e)
end,
CheckBox=function(e,t)
return _:new(e,t)
end,
Toggle=function(t,e)
return g:new(t,e)
end,
TextBox=function(t,e)
return o:new(t,e)
end,
ComboBox=function(e,t)
return x:new(e,t)
end,
TabControl=function(t,e)
return d:new(t,e)
end,
ContextMenu=function(t,e)
return m:new(t,e)
end,
List=function(e,t)
return f:new(e,t)
end,
Table=function(t,e)
return l:new(t,e)
end,
TreeView=function(t,e)
return c:new(t,e)
end,
Chart=function(e,t)
return w:new(e,t)
end,
RadioButton=function(t,e)
return q:new(t,e)
end,
ProgressBar=function(t,e)
return k:new(t,e)
end,
Slider=function(e,t)
return u:new(e,t)
end,
LoadingRing=function(t,e)
return v:new(t,e)
end,
FreeDraw=function(t,e)
return D:new(t,e)
end,
NotificationToast=function(e,t)
return r:new(e,t)
end
}
y.Widget=s
y.Frame=b
y.Window=i
y.Dialog=T
y.MsgBox=A
y.Button=S
y.Label=E
y.CheckBox=_
y.Toggle=g
y.TextBox=o
y.ComboBox=x
y.TabControl=d
y.ContextMenu=m
y.List=f
y.Table=l
y.TreeView=c
y.Chart=w
y.RadioButton=q
y.ProgressBar=k
y.Slider=u
y.LoadingRing=v
y.FreeDraw=D
y.NotificationToast=r
y.easings=H
y.ThreadHandle=j
y.ThreadContext=N
y.threadStatus={
running=a,
completed=p,
error=z,
cancelled=n
}
return y
