local C=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local x=assert(rawget(_G,"os"),"os API unavailable")
local V=assert(x.pullEvent,"os.pullEvent unavailable")
local P=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local M=table.pack or function(...)
return{n=select("#",...),...}
end
local F=assert(table.unpack,"table.unpack unavailable")
local t=require("cc.expect").expect
local W=require("shrekbox")
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
local h={}
h.__index=h
local z={}
z.__index=z
setmetatable(z,{__index=h})
local T={}
T.__index=T
setmetatable(T,{__index=h})
local k={}
k.__index=k
setmetatable(k,{__index=h})
local g={}
g.__index=g
setmetatable(g,{__index=h})
local q={}
q.__index=q
setmetatable(q,{__index=h})
local y={}
y.__index=y
setmetatable(y,{__index=h})
local d={}
d.__index=d
setmetatable(d,{__index=h})
local v={}
v.__index=v
local _={}
_.__index=_
local u={}
u.__index=u
setmetatable(u,{__index=h})
local s={}
s.__index=s
setmetatable(s,{__index=h})
local l={}
l.__index=l
setmetatable(l,{__index=h})
local c={}
c.__index=c
setmetatable(c,{__index=h})
local w={}
w.__index=w
setmetatable(w,{__index=h})
local p={}
p.__index=p
setmetatable(p,{__index=h})
local i={}
i.__index=i
setmetatable(i,{__index=h})
local m={}
m.__index=m
setmetatable(m,{__index=h})
local n={}
n.__index=n
local r={"top","right","bottom","left"}
local G=string.char(7)
local H={
info={bg=e.blue,fg=e.white,accent=e.lightBlue,icon="i"},
success={bg=e.green,fg=e.black,accent=e.lime,icon="+"},
warning={bg=e.orange,fg=e.black,accent=e.yellow,icon="!"},
error={bg=e.red,fg=e.white,accent=e.white,icon="x"}
}
local function U(e)
if e==nil then
return"info"
end
local e=tostring(e):lower()
if H[e]then
return e
end
return"info"
end
local function Y(e)
if e==nil then
return 1,1,1,1
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
return e,e,e,e
end
local s,i,o,n=1,1,1,1
if type(e)=="table"then
local a=e.horizontal or e.x
local t=e.vertical or e.y
if a~=nil then
a=math.max(0,math.floor(a))
s=a
i=a
end
if t~=nil then
t=math.max(0,math.floor(t))
o=t
n=t
end
if e.left~=nil then
s=math.max(0,math.floor(e.left))
end
if e.right~=nil then
i=math.max(0,math.floor(e.right))
end
if e.top~=nil then
o=math.max(0,math.floor(e.top))
end
if e.bottom~=nil then
n=math.max(0,math.floor(e.bottom))
end
end
return s,i,o,n
end
local function b(e,a,t)
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
local function L(e)
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
local function D(e)
local t,a,o,i=1,1,1,1
if e==nil then
return{top=t,right=a,bottom=o,left=i}
end
if type(e)=="number"then
local e=math.max(0,math.floor(e))
t,a,o,i=e,e,e,e
elseif type(e)=="table"then
if e.all~=nil then
local e=math.max(0,math.floor(e.all))
t,a,o,i=e,e,e,e
end
if e.vertical~=nil then
local e=math.max(0,math.floor(e.vertical))
t,o=e,e
end
if e.horizontal~=nil then
local e=math.max(0,math.floor(e.horizontal))
a,i=e,e
end
if e.top~=nil then
t=math.max(0,math.floor(e.top))
end
if e.right~=nil then
a=math.max(0,math.floor(e.right))
end
if e.bottom~=nil then
o=math.max(0,math.floor(e.bottom))
end
if e.left~=nil then
i=math.max(0,math.floor(e.left))
end
end
return{top=t,right=a,bottom=o,left=i}
end
local function B(t,i)
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
b(t:sub(a),i,e)
break
end
b(t:sub(a,o-1),i,e)
a=o+1
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
local function A(a)
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
local b=string.char(30)
local j=string.char(31)
local function O(o,i,n)
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
local t=a.thumbColor or e.lightGray
local n=a.arrowColor or n or e.white
local e=a.background or i or e.black
local i=math.max(1,math.floor(a.width or 1))
local s=math.max(1,math.floor(a.minThumbSize or 1))
return{
enabled=true,
alwaysVisible=not not a.alwaysVisible,
width=i,
trackColor=o,
thumbColor=t,
arrowColor=n,
background=e,
minThumbSize=s
}
end
local function I(e)
if e<0 then
return 0
end
if e>1 then
return 1
end
return e
end
local function S(e,o,t,a)
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
local function N(n,s,a,o,i,r,c,e)
if not e or o<=0 then
return
end
local h=math.max(1,math.floor(e.width or 1))
local t=e.trackColor
local d=e.arrowColor
local l=e.thumbColor
local m=math.max(1,math.floor(e.minThumbSize or 1))
local e=math.max(0,h-1)
local u=b..string.rep(" ",e)
n.text(s,a,u,d,t)
if o>=2 then
local e=j..string.rep(" ",e)
n.text(s,a+o-1,e,d,t)
end
local a=a+1
local e=math.max(0,o-2)
local o=string.rep(" ",h)
for e=0,e-1 do
n.text(s,a+e,o,t,t)
end
local o=math.max(0,(i or 0)-(r or 0))
if o<=0 or e<=0 then
return
end
local d=math.max(0,math.min(o,math.floor((c or 0)+.5)))
local t=r/i
local t=math.max(m,math.floor(e*t+.5))
if t>e then
t=e
end
if t<1 then
t=1
end
local i=e-t
local e=a
if i>0 then
local t=I(o==0 and 0 or(d/o))
e=a+math.floor(t*i+.5)
if e>a+i then
e=a+i
end
end
local a=string.rep(" ",h)
for t=0,t-1 do
n.text(s,e+t,a,l,l)
end
end
local function I(t,a,i,e,o)
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
local function r(h,o,a,e,t,i,s,n)
if e<=0 or t<=0 then
return
end
local n=n or" "
local e=n:rep(e)
for t=0,t-1 do
h.text(o,a+t,e,i,s)
end
end
local function j(o,a,t,e,i)
if e<=0 or i<=0 then
return
end
local n=W.transparent
for e=0,e-1 do
o.pixel(a+e,t,n)
if i>1 then
o.pixel(a+e,t+i-1,n)
end
end
for i=1,math.max(0,i-2)do
o.pixel(a,t+i,n)
if e>1 then
o.pixel(a+e-1,t+i,n)
end
end
end
local function b(d,i,a,o,s,e,t)
if o<=0 or s<=0 then
return
end
local n=e.color
local h=t or n
local t=(i-1)*2+1
local a=(a-1)*3+1
local i=o*2
local o=s*3
local l=3
local u=2
local s=math.min(e.thickness,o)
local r=math.min(e.thickness,i)
local l=math.min(o,math.max(s,l))
local u=math.min(i,math.max(r,u))
local function w(n,e,s)
for e=0,e-1 do
local e=n+e
if e<a or e>=a+o then break end
for a=0,i-1 do
d.pixel(t+a,e,s)
end
end
end
local function f(n,e,s)
for e=0,e-1 do
local e=n+e
if e<a or e>=a+o then break end
for a=0,i-1 do
d.pixel(t+a,e,s)
end
end
end
local function c(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
d.pixel(e,a+t,n)
end
end
end
local function m(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
d.pixel(e,a+t,n)
end
end
end
if e.left then
c(t,u,h)
end
if e.right then
c(t+i-u,u,h)
end
if e.top then
w(a,l,h)
end
if e.bottom then
w(a+o-l,l,h)
end
if e.top then
f(a,s,n)
end
if e.bottom then
f(a+o-s,s,n)
end
if e.left then
m(t,r,n)
end
if e.right then
m(t+i-r,r,n)
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
local t=L(a.anchor)
if not t and not i then
if a.x~=nil or a.y~=nil then
t=nil
else
t="top_right"
end
end
e.anchor=t
e.anchorMargins=D(a.anchorMargin)
e.anchorAnimationDuration=math.max(.05,tonumber(a.anchorAnimationDuration)or .2)
e.anchorEasing=a.anchorEasing or"easeOutCubic"
e._anchorDirty=true
e._anchorAnimationHandle=nil
e.title=a.title~=nil and tostring(a.title)or nil
e.message=a.message~=nil and tostring(a.message)or""
e.icon=a.icon~=nil and tostring(a.icon)or nil
e.severity=U(a.severity)
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
e.paddingLeft,e.paddingRight,e.paddingTop,e.paddingBottom=Y(a.padding)
e._hideTimer=nil
e._wrappedLines={""}
e._lastWrapWidth=nil
e._lastMessage=nil
e:_refreshWrap(true)
return e
end
function i:_applyPadding(e,i)
local t,e,a,o=Y(e)
if i or t~=self.paddingLeft or e~=self.paddingRight or a~=self.paddingTop or o~=self.paddingBottom then
self.paddingLeft=t
self.paddingRight=e
self.paddingTop=a
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
local e=L(t)
if e==nil and t~=nil then
self.anchor=nil
else
self.anchor=e
end
self:refreshAnchor(false)
end
function i:setAnchorMargin(e)
self.anchorMargins=D(e)
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
local h=self.width
local s=self.height
local a=self.anchorMargins or D(nil)
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
h.setPosition(self,a,o)
local r=self.anchorAnimationDuration or .2
local n=self.anchorEasing or"easeOutCubic"
local a=a
local o=o
local s=e-a
local i=t-o
self._anchorAnimationHandle=self.app:animate({
duration=r,
easing=n,
update=function(e)
local t=math.floor(a+s*e+.5)
local e=math.floor(o+i*e+.5)
h.setPosition(self,t,e)
end,
onComplete=function()
h.setPosition(self,e,t)
self._anchorAnimationHandle=nil
end,
onCancel=function()
h.setPosition(self,e,t)
self._anchorAnimationHandle=nil
end
})
self._anchorDirty=false
return
end
if self.x~=e or self.y~=t then
h.setPosition(self,e,t)
end
self._anchorDirty=false
end
function i:_getActiveBorder()
if self.border then
return self.border
end
return nil
end
function i:_refreshWrap(a,t)
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
if not a and self._lastWrapWidth==e and self._lastMessage==self.message then
return
end
self._wrappedLines=B(self.message,e)
self._lastWrapWidth=e
self._lastMessage=self.message
end
function i:_getStyle()
local a=self.severity
local e=H.info
if a~=nil then
local t=H[a]
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
function i:_cancelTimer()
if self._hideTimer then
if x.cancelTimer then
pcall(x.cancelTimer,self._hideTimer)
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
self._hideTimer=x.startTimer(e)
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
local e=U(e)
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
h.setSize(self,e,t)
self:_refreshWrap(true)
self._anchorDirty=true
if self.anchor then
self:_applyAnchorPosition(false)
end
end
function i:setBorder(e)
h.setBorder(self,e)
self:_refreshWrap(true)
self._anchorDirty=true
end
function i:_renderLine(s,o,a,t,e,n,i)
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
s.text(o,a,e,n,i)
end
function i:draw(o,u)
if not self.visible then
return
end
if self._anchorDirty and not self._anchorAnimationHandle then
self:_applyAnchorPosition(false)
end
local h,s,a,i=self:getAbsoluteRect()
if a<=0 or i<=0 then
return
end
local n=self:_getStyle()or H.info
local t=n.bg or self.bg or e.gray
local d=n.fg or self.fg or e.white
local c=n.accent or d
local f=n.titleColor or d
local l=n.iconColor or c
r(o,h,s,a,i,t,t)
j(o,h,s,a,i)
local e=self.border
if e then
b(u,h,s,a,i,e,t)
else
b(u,h,s,a,i,{
color=c,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
},t)
end
local e=e
local r=(e and e.left)and e.thickness or 0
local m=(e and e.right)and e.thickness or 0
local u=(e and e.top)and e.thickness or 0
local e=(e and e.bottom)and e.thickness or 0
local c=h+r
local h=s+u
local a=math.max(0,a-r-m)
local e=math.max(0,i-u-e)
local s=c+(self.paddingLeft or 0)
local u=h+(self.paddingTop or 0)
local h=math.max(0,a-(self.paddingLeft or 0)-(self.paddingRight or 0))
local i=math.max(0,e-(self.paddingTop or 0)-(self.paddingBottom or 0))
if h<=0 or i<=0 then
return
end
local a=self.icon
if not a or a==""then
a=n.icon or""
end
a=tostring(a or"")
local n=0
local r=s
local e=u
if a~=""and h>0 then
local a=a:sub(1,1)
o.text(s,e,a,l,t)
if h>=3 then
o.text(s+1,e," ",l,t)
n=2
else
n=1
end
r=s+n
end
local a=math.max(0,h-n)
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
if x.cancelTimer then
pcall(x.cancelTimer,self._tickTimer)
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
self._tickTimer=x.startTimer(self.speed)
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
function m:draw(s,l)
if not self.visible then
return
end
local o,i,a,t=self:getAbsoluteRect()
if a<=0 or t<=0 then
return
end
local e=self.bg or self.app.background
r(s,o,i,a,t,e,e)
j(s,o,i,a,t)
if self.border then
b(l,o,i,a,t,self.border,e)
end
local d=(self.border and self.border.left)and 1 or 0
local c=(self.border and self.border.right)and 1 or 0
local u=(self.border and self.border.top)and 1 or 0
local m=(self.border and self.border.bottom)and 1 or 0
local n=o+d
local h=i+u
local a=math.max(0,a-d-c)
local o=math.max(0,t-u-m)
if a<=0 or o<=0 then
return
end
r(s,n,h,a,o,e,e)
local y=n+(a-1)/2
local w=h+(o-1)/2
local i=math.floor(math.min(a,o)/2)
local t=self.radiusPixels and math.floor(self.radiusPixels)or i
if t>i then
t=i
end
if t<1 then
t=1
end
local s=math.max(1,math.min(math.floor(self.thickness or 1),t))
local i=t+.35
local t=math.max(0,t-s+.35)
local m=i*i
local f=t*t
local t=math.max(3,math.floor(self.segmentCount or 12))
local d=self._phase%t
local c=self.direction>=0 and 1 or-1
local r=math.pi*2
local u=self:_computeTrailColors()
for o=0,o-1 do
local s=h+o
local o=s-w
for a=0,a-1 do
local h=n+a
local a=h-y
local n=a*a+o*o
local i=e
if n<=m and n>=f then
local a=math.atan(o,a)
if a<0 then
a=a+r
end
local o=math.floor(a/r*t)%t
local a
if c>=0 then
a=(d-o)%t
else
a=(o-d)%t
end
if a==0 then
i=self.color or e
else
local t=math.floor(a+1e-4)
if t<1 then
t=1
end
i=u[t]or e
end
end
l.pixel(h,s,i)
end
end
end
function m:handleEvent(t,...)
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
return h.handleEvent(self,t,...)
end
local function H(e)
local a,t=e.x,e.y
local e=e.parent
while e do
a=a+e.x-1
t=t+e.y-1
e=e.parent
end
return a,t
end
function h:_init_base(o,a)
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
self.border=A(a.border)
self.focusable=a.focusable==true
self._focused=false
E("width",self.width)
E("height",self.height)
end
function h:setSize(t,e)
E("width",t)
E("height",e)
self.width=t
self.height=e
end
function h:setPosition(e,a)
t(1,e,"number")
t(2,a,"number")
self.x=math.floor(e)
self.y=math.floor(a)
end
function h:setZ(e)
t(1,e,"number")
self.z=e
end
function h:setBorder(e)
if e==nil then
self.border=nil
return
end
if e==false then
self.border=nil
return
end
if e==true then
self.border=A(true)
return
end
t(1,e,"table","boolean")
self.border=A(e)
end
function h:isFocused()
return self._focused
end
function h:setFocused(e)
e=not not e
if self._focused==e then
return
end
self._focused=e
self:onFocusChanged(e)
end
function h:onFocusChanged(e)
end
function h:getAbsoluteRect()
local t,e=H(self)
return t,e,self.width,self.height
end
function h:containsPoint(a,t)
local o,e,n,i=self:getAbsoluteRect()
return a>=o and a<o+n and t>=e and t<e+i
end
function h:draw(e,e)
error("draw needs implementation for widget",2)
end
function h:handleEvent(e,...)
return false
end
function z:new(a,t)
local e=setmetatable({},z)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function z:addChild(e)
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
return e
end
function z:removeChild(e)
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
local e={}
for a=1,#t do
e[a]=t[a]
end
return e
end
local function H(e)
table.sort(e,function(t,e)
if t.z==e.z then
return(t._orderIndex or 0)<(e._orderIndex or 0)
end
return t.z<e.z
end)
end
function z:getChildren()
return E(self._children)
end
function z:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function z:draw(s,l)
if not self.visible then
return
end
local n,t,a,o=self:getAbsoluteRect()
local i=self.bg or self.app.background
local d,u=n+1,t+1
local e=math.max(0,a-2)
local h=math.max(0,o-2)
if e>0 and h>0 then
r(s,d,u,e,h,i,i)
elseif a>0 and o>0 then
r(s,n,t,a,o,i,i)
end
j(s,n,t,a,o)
local h=self.title
if type(h)=="string"and#h>0 then
local a=e>0 and e or a
local n=e>0 and d or n
local t=(o>2)and(t+1)or t
if a>0 then
local e=h
if#e>a then
e=e:sub(1,a)
end
if#e<a then
e=e..string.rep(" ",a-#e)
end
s.text(n,t,e,self.fg,i)
end
end
if self.border then
b(l,n,t,a,o,self.border,i)
end
local e=E(self._children)
H(e)
for t=1,#e do
e[t]:draw(s,l)
end
end
function z:handleEvent(t,...)
if not self.visible then
return false
end
if h.handleEvent(self,t,...)then
return true
end
local e=E(self._children)
H(e)
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
function T:draw(h,c)
if not self.visible then
return
end
local o,i,a,t=self:getAbsoluteRect()
local n=self.bg or e.gray
local s=self.fg or e.white
local e=n
local d=s
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=o+1,i+1
local n=math.max(0,a-2)
local s=math.max(0,t-2)
if n>0 and s>0 then
r(h,l,u,n,s,e,e)
else
r(h,o,i,a,t,e,e)
end
j(h,o,i,a,t)
if self.border then
b(c,o,i,a,t,self.border,e)
end
local t=self.label or""
local a=n>0 and n or a
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
local o=n>0 and l or o
local a
if s>0 then
a=u+math.floor((s-1)/2)
else
a=i
end
h.text(o,a,t,d,e)
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
local o=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-o-t)
local n=math.max(0,self.height-a-e)
return o,t,a,e,i,n
end
function k:_wrapLine(t,a,e)
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
function k:_updateLines(e)
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
function k:setHorizontalAlign(e)
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
h.setSize(self,t,e)
self:_updateLines(true)
end
function k:setBorder(e)
h.setBorder(self,e)
self:_updateLines(true)
end
function k:draw(u,c)
if not self.visible then
return
end
local h,s,d,l=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
local m=self.fg or e.white
r(u,h,s,d,l,n,n)
j(u,h,s,d,l)
local t,o,e,o,a,i=self:_getInnerMetrics()
local t=h+t
local f=s+e
self:_updateLines(false)
local r=self._lines or{""}
local o=#r
if o==0 then
r={""}
o=1
end
if a>0 and i>0 then
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
local i=f+o
for e=0,e-1 do
local e=r[s+e]or""
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
u.text(o,i,e,m,n)
end
i=i+1
end
end
if self.border then
b(c,h,s,d,l,self.border,n)
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
function g:_setState(t,e,o)
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
function g:draw(d,a)
if not self.visible then
return
end
local n,s,t,i=self:getAbsoluteRect()
local o=self.bg or e.black
local e=self.fg or e.white
local o=o
local h=e
if self:isFocused()then
o=self.focusBg or o
h=self.focusFg or h
end
r(d,n,s,t,i,o,o)
j(d,n,s,t,i)
if self.border then
b(a,n,s,t,i,self.border,o)
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
d.text(n,t,e,h,o)
end
function g:handleEvent(e,...)
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
function q:setColors(n,i,a,o,e)
if n~=nil then
t(1,n,"number")
self.trackColorOn=n
end
if i~=nil then
t(2,i,"number")
self.trackColorOff=i
end
if a~=nil then
t(3,a,"number")
self.thumbColor=a
end
if o~=nil then
t(4,o,"number")
self.onLabelColor=o
end
if e~=nil then
t(5,e,"number")
self.offLabelColor=e
end
end
function q:draw(d,s)
if not self.visible then
return
end
local n,o,a,i=self:getAbsoluteRect()
local t=self.bg or e.black
local u=self.fg or e.white
r(d,n,o,a,i,t,t)
j(d,n,o,a,i)
if self.border then
b(s,n,o,a,i,self.border,t)
end
local t=self.border
local l=(t and t.left)and t.thickness or 0
local c=(t and t.right)and t.thickness or 0
local h=(t and t.top)and t.thickness or 0
local m=(t and t.bottom)and t.thickness or 0
local t=n+l
local n=o+h
local a=math.max(0,a-l-c)
local o=math.max(0,i-h-m)
if a<=0 or o<=0 then
return
end
local t=t
local n=n
local a=a
local i=o
local o=self.trackColorOff or e.gray
local h=self.trackColorOn or e.lightBlue
local c=self.value and h or o
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
function w:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},w)
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
t._dotChar=G
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
function w:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function w:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function w:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function w:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function w:setLabel(e)
t(1,e,"string")
self.label=e
end
function w:setValue(e)
self.value=e
end
function w:getValue()
return self.value
end
function w:setGroup(e)
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
function w:getGroup()
return self.group
end
function w:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function w:setSelected(e)
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
function w:isSelected()
return self.selected
end
function w:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function w:draw(h,d)
if not self.visible then
return
end
local i,o,t,n=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local s=e
if self:isFocused()then
a=self.focusBg or a
s=self.focusFg or s
end
r(h,i,o,t,n,a,a)
j(h,i,o,t,n)
if self.border then
b(d,i,o,t,n,self.border,a)
end
local n=o+math.floor((n-1)/2)
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
function w:handleEvent(e,...)
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
function y:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},y)
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
t.border=A(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
end
return t
end
function y:_clampValue(e)
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
function y:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function y:_startIndeterminateAnimation()
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
function y:setRange(a,e)
t(1,a,"number")
t(2,e,"number")
if e<=a then
error("ProgressBar max must be greater than min",2)
end
self.min=a
self.max=e
self.value=self:_clampValue(self.value)
end
function y:getRange()
return self.min,self.max
end
function y:setValue(e)
if self.indeterminate then
return
end
t(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function y:getValue()
return self.value
end
function y:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function y:setIndeterminate(e)
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
function y:isIndeterminate()
return self.indeterminate
end
function y:setLabel(e)
if e~=nil then
t(1,e,"string")
end
self.label=e
end
function y:setShowPercent(e)
self.showPercent=not not e
end
function y:setColors(o,a,e)
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
function y:draw(n,d)
if not self.visible then
return
end
local a,t,o,i=self:getAbsoluteRect()
local s=self.trackColor or(self.bg or e.gray)
local h=self.fillColor or e.lightBlue
local c=self.textColor or(self.fg or e.white)
r(n,a,t,o,i,s,s)
j(n,a,t,o,i)
if self.border then
b(d,a,t,o,i,self.border,s)
end
local e=self.border
local d=(e and e.left)and 1 or 0
local m=(e and e.right)and 1 or 0
local u=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+d
local l=t+u
local t=math.max(0,o-d-m)
local i=math.max(0,i-u-e)
if t<=0 or i<=0 then
return
end
r(n,a,l,t,i,s,s)
local u=0
local d=0
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
d=math.floor(t*e+.5)
r(n,a+d,l,o,i,h,h)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
u=math.floor(t*e+.5)
if u>0 then
r(n,a,l,u,i,h,h)
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
local l=l+math.floor((i-1)/2)
local i=a+math.floor((t-#e)/2)
if i<a then
i=a
end
for t=1,#e do
local r=e:sub(t,t)
local e=(i-a)+(t-1)
local a=s
if self.indeterminate then
if e>=d and e<d+o then
a=h
end
else
if e<u then
a=h
end
end
n.text(i+t-1,l,r,c,a)
end
end
end
function y:handleEvent(e,...)
return false
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
t.border=A(true)
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
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i,s=self:getAbsoluteRect()
local n=math.max(0,self.width-a-o)
local h=math.max(0,self.height-t-e)
local o=i+a
local i=s+t
return o,i,n,h,a,t,e
end
function d:_valueToPosition(o,a)
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
function d:setRangeValues(e,a,o)
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
function d:getRangeValues()
return self.lowerValue,self.upperValue
end
function d:setRangeLimits(a,e)
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
function d:setColors(a,o,e)
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
local e,a=self:_positionFromPoint(e)
if not e then
return false
end
if self.range then
local s=self:_valueToPosition(self.lowerValue,a)
local i=self:_valueToPosition(self.upperValue,a)
local t=self._focusedHandle or"lower"
local n=math.abs(e-s)
local o=math.abs(e-i)
if n==o then
if e>i then
t="upper"
elseif e<s then
t="lower"
end
elseif n<o then
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
local u,l,h,d=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
r(o,u,l,h,d,n,n)
j(o,u,l,h,d)
local i,c,t,s=self:_getInnerMetrics()
if t<=0 or s<=0 then
if self.border then
b(f,u,l,h,d,self.border,n)
end
return
end
local a
local m=nil
if self.showValue and s>=2 then
m=c
a=c+s-1
else
a=c+math.floor((s-1)/2)
end
r(o,i,a,t,1,self.trackColor,self.trackColor)
local c
if self:isFocused()then
c=self._activeHandle or self._focusedHandle
end
local function s(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if c and s==c then
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
local n=t-e+1
if n>0 then
r(o,i+e,a,n,1,self.fillColor,self.fillColor)
end
s(e,"lower")
s(t,"upper")
else
local e=self:_valueToPosition(self.value,t)
local t=e+1
if t>0 then
r(o,i,a,t,1,self.fillColor,self.fillColor)
end
s(e,"single")
end
if self.showValue and m then
local a=self:_formatDisplayValue()
if a and a~=""then
if#a>t then
a=a:sub(1,t)
end
local t=i+math.floor((t-#a)/2)
if t<i then
t=i
end
o.text(t,m,a,self.fg or e.white,n)
end
end
if self.border then
b(f,u,l,h,d,self.border,n)
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
function s:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},s)
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
t.border=A(true)
end
t.scrollbar=O(a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_ensureSelectionVisible()
return t
end
function s:_normalizeColumns(e)
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
function s:_recomputeColumnMetrics()
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
function s:_ensureColumnsForData()
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
accessor=function(a)
if type(a)=="table"then
local e={}
local t=0
for a,o in pairs(a)do
t=t+1
if t>4 then
e[#e+1]="..."
break
end
e[#e+1]=tostring(a).."="..tostring(o)
end
table.sort(e,function(e,t)
return e<t
end)
return"{"..table.concat(e,", ").."}"
end
return tostring(a)
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
function s:setColumns(e)
if e~=nil then
t(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function s:getColumns()
local e={}
for t=1,#self.columns do
e[t]=o(self.columns[t])
end
return e
end
function s:setData(e)
t(1,e,"table")
local a={}
for t=1,#e do
a[t]=e[t]
end
self.data=a
self:_ensureColumnsForData()
self:_refreshRows()
end
function s:getData()
local t={}
for e=1,#self.data do
t[e]=self.data[e]
end
return t
end
function s:_refreshRows()
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
function s:_getColumnById(e)
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
function s:_applySort(t,e,u)
local t=self:_getColumnById(t)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=e=="desc"and"desc"or"asc"
local l=self.sortDirection=="desc"
local r=t.comparator
table.sort(self._rows,function(d,h)
local n=self.data[d]
local i=self.data[h]
local o=s._resolveColumnValue(t,n)
local a=s._resolveColumnValue(t,i)
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
return d<h
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
function s:setSort(e,a,t)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,a or self.sortDirection,t)
end
function s:getSort()
return self.sortColumn,self.sortDirection
end
function s:setOnSort(e)
if e~=nil then
t(1,e,"function")
end
self.onSort=e
end
function s:setScrollbar(t)
self.scrollbar=O(t,self.bg or e.black,self.fg or e.white)
self:_clampScroll()
end
function s:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function s:getSelectedIndex()
return self.selectedIndex
end
function s:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function s:setSelectedIndex(e,a)
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
function s:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function s:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i,s=self:getAbsoluteRect()
local n=math.max(0,self.width-a-o)
local o=math.max(0,self.height-t-e)
local a=i+a
local e=s+t
return a,e,n,o
end
function s:_computeLayoutMetrics()
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
local e,n=S(self.scrollbar,#self._rows,s,t)
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
function s:_getRowsVisible()
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
function s:_clampScroll()
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
function s:_ensureSelectionVisible()
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
function s:_rowFromPoint(a,t)
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
function s:_columnFromPoint(a,t)
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
function s._resolveColumnValue(e,t)
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
function s:_formatCell(t,a,e)
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
function s:draw(o,k)
if not self.visible then
return
end
local w,f,m,u=self:getAbsoluteRect()
local h=self.bg or e.black
local v=self.fg or e.white
r(o,w,f,m,u,h,h)
j(o,w,f,m,u)
local t=self:_computeLayoutMetrics()
local i=t.innerWidth
local g=t.innerHeight
local a=t.contentWidth
if i<=0 or g<=0 or a<=0 then
if self.border then
b(k,w,f,m,u,self.border,h)
end
return
end
local i=t.innerX
local c=t.innerY
local y=t.headerHeight
local q=t.rowsHeight
local p=t.scrollbarWidth
local l=t.scrollbarStyle
local d=self.headerBg or h
local j=self.headerFg or v
if y>0 then
o.text(i,c,string.rep(" ",a),d,d)
local s=i
local h=a
for e=1,#self.columns do
local n=self.columns[e]
local t=math.max(1,math.min(n.width,h))
if e==#self.columns then
t=math.max(1,h)
end
if t<=0 then
break
end
local e=n.title or n.id
local r=""
if self.sortColumn==n.id then
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
o.text(s,c,e,j,d)
s=s+t
h=a-(s-i)
if h<=0 then
break
end
end
end
local y=c+y
local d=q
local n=self.rowBg or h
local v=self.rowFg or v
if d<=0 then
if p>0 then
local e=(l and l.background)or h
r(o,t.scrollbarX,c,p,g,e,e)
end
if self.border then
b(k,w,f,m,u,self.border,h)
end
return
end
if#self._rows==0 then
for e=0,d-1 do
local e=y+e
o.text(i,e,string.rep(" ",a),v,n)
end
if self.placeholder and self.placeholder~=""then
local t=self.placeholder
if#t>a then
t=t:sub(1,a)
end
local s=d>0 and math.min(d-1,math.floor(d/2))or 0
local s=y+s
local a=i+math.floor((a-#t)/2)
if a<i then
a=i
end
o.text(a,s,t,e.lightGray,n)
end
else
for h=0,d-1 do
local t=self.scrollOffset+h
local m=y+h
if t>#self._rows then
o.text(i,m,string.rep(" ",a),v,n)
else
local h=self._rows[t]
local l=self.data[h]
local c=self.allowRowSelection and t==self.selectedIndex
local d=n
local u=v
if c then
d=self.highlightBg or e.lightGray
u=self.highlightFg or e.black
elseif self.zebra and(t%2==0)then
d=self.zebraBg or d
end
local r=i
local h=a
for e=1,#self.columns do
local t=self.columns[e]
local n=math.max(1,math.min(t.width,h))
if e==#self.columns then
n=math.max(1,h)
end
if n<=0 then
break
end
local e=s._resolveColumnValue(t,l)
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
local s=u
if t.color then
if type(t.color)=="number"then
s=t.color
elseif type(t.color)=="function"then
local t,e=pcall(t.color,e,l,t,c)
if t and type(e)=="number"then
s=e
end
end
end
o.text(r,m,e,s,d)
r=r+n
h=a-(r-i)
if h<=0 then
break
end
end
end
end
end
if p>0 then
local e=(l and l.background)or h
r(o,t.scrollbarX,c,p,g,e,e)
if l and d>0 then
local e=math.max(0,self.scrollOffset-1)
N(o,t.scrollbarX,y,d,#self._rows,d,e,l)
end
end
if self.border then
b(k,w,f,m,u,self.border,h)
end
end
function s:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=x.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=(e.buffer or"")..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function s:_searchForPrefix(e)
if not e or e==""then
return
end
if#self._rows==0 then
return
end
local t=self.selectedIndex>=1 and self.selectedIndex or 0
for a=1,#self._rows do
local t=((t+a-1)%#self._rows)+1
local a=self.data[self._rows[t]]
local o=self.columns[1]
local a=s._resolveColumnValue(o,a)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function s:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function s:handleEvent(o,...)
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
local e=I(a,e.rowsHeight,#self._rows,e.rowsHeight,t)
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
local a,t,e=...
return i(t,e)
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
function l:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local a=setmetatable({},l)
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
a.border=A(true)
end
a.scrollbar=O(t and t.scrollbar,a.bg or e.black,a.fg or e.white)
a:setNodes((t and t.nodes)or{})
return a
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
self.scrollbar=O(t,self.bg or e.black,self.fg or e.white)
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
function l:_findVisibleIndex(a)
if a==nil then
return nil
end
local t=self._flatNodes
for e=1,#t do
if t[e].node==a then
return e
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
local i=math.max(0,self.width-o-a)
local n=math.max(0,self.height-t-e)
return o,a,t,e,i,n
end
function l:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function l:_computeLayoutMetrics()
local n,i=self:getAbsoluteRect()
local a,s,t,s,e,o=self:_getInnerMetrics()
local a=n+a
local s=i+t
if e<=0 or o<=0 then
return{
innerX=a,
innerY=s,
innerWidth=e,
innerHeight=o,
contentWidth=0,
scrollbarWidth=0,
scrollbarStyle=nil,
scrollbarX=a
}
end
local t,n=S(self.scrollbar,#self._flatNodes,o,e)
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
innerX=a,
innerY=s,
innerWidth=e,
innerHeight=o,
contentWidth=i,
scrollbarWidth=t,
scrollbarStyle=n,
scrollbarX=a+i
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
function l:_scrollBy(e)
if e==0 then
return
end
local t=#self._flatNodes
if t==0 then
self.scrollOffset=1
return
end
local a=self:_getInnerHeight()
local t=math.max(1,t-a+1)
self.scrollOffset=math.min(t,math.max(1,self.scrollOffset+e))
end
function l:_rowFromPoint(a,t)
if not self:containsPoint(a,t)then
return nil
end
local e=self:_computeLayoutMetrics()
if e.innerWidth<=0 or e.innerHeight<=0 or e.contentWidth<=0 then
return nil
end
local o=e.innerX
local i=e.innerY
if a<o or a>=o+e.contentWidth then
return nil
end
if t<i or t>=i+e.innerHeight then
return nil
end
local t=t-i
local t=self.scrollOffset+t
if t<1 or t>#self._flatNodes then
return nil
end
return t,o,e.contentWidth
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
local o=((i+o-1)%t)+1
local t=a[o].node
local t=t and t.label or""
if t:lower():sub(1,#e)==e then
self:_setSelectedIndex(o,false)
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
local a=x.clock()
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
local t,a,i,o=self:getAbsoluteRect()
local s=self.bg or e.black
local m=self.fg or e.white
r(n,t,a,i,o,s,s)
j(n,t,a,i,o)
if self.border then
b(h,t,a,i,o,self.border,s)
end
local i=self:_computeLayoutMetrics()
local t=i.innerWidth
local h=i.innerHeight
local o=i.contentWidth
local c=i.scrollbarWidth
local d=i.scrollbarStyle
if t<=0 or h<=0 or o<=0 then
return
end
local u=i.innerX
local l=i.innerY
local f=self._flatNodes
local w=#f
if w==0 then
for e=0,h-1 do
n.text(u,l+e,string.rep(" ",o),m,s)
end
local t=self.placeholder
if type(t)=="string"and#t>0 then
local t=t
if#t>o then
t=t:sub(1,o)
end
local a=u+math.floor((o-#t)/2)
if a<u then
a=u
end
n.text(a,l,t,e.lightGray,s)
end
if c>0 then
local e=(d and d.background)or s
r(n,i.scrollbarX,l,c,h,e,e)
if d then
N(n,i.scrollbarX,l,h,0,h,0,d)
end
end
return
end
for t=0,h-1 do
local d=l+t
local r=self.scrollOffset+t
if r>w then
n.text(u,d,string.rep(" ",o),m,s)
else
local t=f[r]
local i=t.node
local t=t.depth or 0
local t=t*self.indentWidth
if t>o-1 then
t=o-1
end
if t<0 then
t=0
end
local a=t>0 and string.rep(" ",t)or""
local h
if i and i.children and#i.children>0 then
h=i.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
else
h=self.toggleSymbols.leaf
end
h=tostring(h or" ")
local t=o-t
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
local e=(i and i.label)or""
if#e>t then
e=e:sub(1,t)
end
a=a..e
t=t-#e
end
if t>0 then
a=a..string.rep(" ",t)
elseif#a>o then
a=a:sub(1,o)
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
r(n,i.scrollbarX,l,c,h,e,e)
if d then
N(n,i.scrollbarX,l,h,#self._flatNodes,h,math.max(0,self.scrollOffset-1),d)
end
end
end
function l:handleEvent(o,...)
if not self.visible then
return false
end
if o=="mouse_click"then
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
local e=I(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
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
elseif o=="monitor_touch"then
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
local e=I(a,e.innerHeight,#self._flatNodes,e.innerHeight,t)
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
local function E(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function H(r,t,a,s,h,i)
if not r then
return
end
i=i or e.white
local o=math.abs(s-t)
local d=t<s and 1 or-1
local n=-math.abs(h-a)
local l=a<h and 1 or-1
local e=o+n
while true do
r.pixel(t,a,i)
if t==s and a==h then
break
end
local i=2*e
if i>=n then
e=e+n
t=t+d
end
if i<=o then
e=e+o
a=a+l
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
function c:setRange(a,e)
if a~=nil then
t(1,a,"number")
end
if e~=nil then
t(2,e,"number")
end
self.minValue=a
self.maxValue=e
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
function c:draw(d,p)
if not self.visible then
return
end
local i,a,n,h=self:getAbsoluteRect()
local o=self.bg or e.black
local f=self.fg or e.white
r(d,i,a,n,h,o,o)
j(d,i,a,n,h)
if self.border then
b(p,i,a,n,h,self.border,o)
end
local t=self.border
local s=(t and t.thickness)or 0
local u=(t and t.left)and s or 0
local c=(t and t.right)and s or 0
local l=(t and t.top)and s or 0
local t=(t and t.bottom)and s or 0
local i=i+u
local s=a+l
local a=math.max(0,n-u-c)
local t=math.max(0,h-l-t)
self._lastLayout=nil
if a<=0 or t<=0 then
return
end
local h=#self.data
if h==0 then
local n=self.placeholder or""
if n~=""then
local n=n
if#n>a then
n=n:sub(1,a)
end
local a=i+math.floor((a-#n)/2)
if a<i then
a=i
end
local t=s+math.floor((t-1)/2)
d.text(a,t,n,e.lightGray,o)
end
return
end
local n=(self.showLabels and t>=2)and 1 or 0
local c=(self.showAxis and(t-n)>=2)and 1 or 0
local l=t-c-n
if l<1 then
l=t
c=0
n=0
end
local m=s
local u=m+l-1
local w=c>0 and(u+1)or nil
local c
if n>0 then
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
local n=-math.huge
for e=1,h do
local e=self.data[e]or 0
if e<t then
t=e
end
if e>n then
n=e
end
end
if t==math.huge then
t=0
end
if n==-math.huge then
n=0
end
local t=type(self.minValue)=="number"and self.minValue or t
local s=type(self.maxValue)=="number"and self.maxValue or n
if s==t then
s=s+1
t=t-1
end
local n=s-t
if n<=0 then
n=1
s=t+n
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
n=s-t
if n<=0 then
n=1
s=t+n
end
end
local s={}
for o=1,h do
local t=i+math.floor((o-1)*a/h)
local e=i+math.floor(o*a/h)-1
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
for a=1,h do
local o=self.data[a]or 0
local e=0
if n>0 then
e=(o-t)/n
end
e=E(e,0,1)
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
local t=self.barColor or f
if self.selectedIndex==a then
t=self.highlightColor or t
end
r(d,s[a].left,o,s[a].width,e,t,t)
end
else
local a={}
for o=1,h do
local i=self.data[o]or 0
local e=0
if n>0 then
e=(i-t)/n
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
a[o]={x=s[o].center,y=e}
end
for e=2,#a do
local t=a[e-1]
local e=a[e]
H(p,t.x,t.y,e.x,e.y,self.lineColor or f)
end
for n=1,#a do
local i=a[n]
local t=self.lineColor or f
local a="o"
if self.selectedIndex==n then
t=self.highlightColor or e.orange
a="O"
end
d.text(i.x,i.y,a,t,o)
end
end
if w then
r(d,i,w,a,1,o,o)
local e=string.rep("-",a)
d.text(i,w,e,self.axisColor or f,o)
end
if c then
r(d,i,c,a,1,o,o)
local t=self.labels or{}
for n=1,h do
local t=t[n]
if t and t~=""then
t=tostring(t)
local a=s[n]
local i=a.width
if i>0 and#t>i then
t=t:sub(1,i)
end
local i=a.left+math.floor((a.width-#t)/2)
if i<a.left then
i=a.left
end
if i+#t-1>a.right then
i=a.right-#t+1
end
local e=(self.selectedIndex==n)and(self.highlightColor or e.orange)or(self.axisColor or f)
d.text(i,c,t,e,o)
end
end
end
self._lastLayout={
innerX=i,
innerWidth=a,
dataCount=h,
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
t.border=A(true)
end
t.scrollbar=O(a and a.scrollbar,t.bg or e.black,t.fg or e.white)
t:_normalizeSelection(true)
return t
end
function u:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-a-t)
local i=math.max(0,self.height-o-e)
return a,t,o,e,n,i
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
local t,n=S(self.scrollbar,#self.items,o,e)
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
function u:setHighlightColors(e,a)
if e~=nil then
t(1,e,"number")
self.highlightBg=e
end
if a~=nil then
t(2,a,"number")
self.highlightFg=a
end
end
function u:setScrollbar(t)
self.scrollbar=O(t,self.bg or e.black,self.fg or e.white)
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
local a=x.clock()
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
function u:draw(a,s)
if not self.visible then
return
end
local i,n,o,t=self:getAbsoluteRect()
local d=self.bg or e.black
local u=self.fg or e.white
r(a,i,n,o,t,d,d)
j(a,i,n,o,t)
if self.border then
b(s,i,n,o,t,self.border,d)
end
local t=self:_computeLayoutMetrics()
local n=t.innerWidth
local i=t.innerHeight
local o=t.contentWidth
if n<=0 or i<=0 or o<=0 then
return
end
local h=t.innerX
local s=t.innerY
local l=t.scrollbarWidth
local n=t.scrollbarStyle
local c=#self.items
local d=d
local f=self.highlightBg or e.lightGray
local m=self.highlightFg or e.black
if c==0 then
for e=0,i-1 do
a.text(h,s+e,string.rep(" ",o),u,d)
end
if l>0 then
local e=(n and n.background)or d
r(a,t.scrollbarX,s,l,i,e,e)
end
local r=self.placeholder
if type(r)=="string"and#r>0 then
local t=r
if#t>o then
t=t:sub(1,o)
end
local o=h+math.floor((o-#t)/2)
if o<h then
o=h
end
a.text(o,s,t,e.lightGray,d)
end
if n then
N(a,t.scrollbarX,s,i,0,i,0,n)
end
return
end
for e=0,i-1 do
local i=s+e
local t=self.scrollOffset+e
if t>c then
a.text(h,i,string.rep(" ",o),u,d)
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
a.text(h,i,e,n,o)
end
end
if l>0 then
local e=(n and n.background)or d
r(a,t.scrollbarX,s,l,i,e,e)
if n then
N(a,t.scrollbarX,s,i,#self.items,i,math.max(0,self.scrollOffset-1),n)
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
local e=I(a,e.innerHeight,#self.items,e.innerHeight,t)
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
local e=I(a,e.innerHeight,#self.items,e.innerHeight,t)
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
function p:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},p)
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
a.border=A(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function p:_normalizeSelection()
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
function p:setItems(a)
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
function p:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function p:setSelectedIndex(e,a)
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
function p:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function p:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function p:_setOpen(e)
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
function p:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function p:_isPointInDropdown(t,a)
if not self._open or#self.items==0 then
return false
end
local e,o,i,n=self:getAbsoluteRect()
local o=o+n
return t>=e and t<e+i and a>=o and a<o+#self.items
end
function p:_indexFromPoint(t,e)
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
function p:_handlePress(e,t)
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
function p:draw(s,h)
if not self.visible then
return
end
local i,a,n,o=self:getAbsoluteRect()
local t=self.bg or e.black
local l=self.fg or e.white
r(s,i,a,n,o,t,t)
j(s,i,a,n,o)
if self.border then
b(h,i,a,n,o,self.border,t)
end
local e=self.border
local r=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local h=i+r
local n=math.max(0,n-r-u)
local u=a+d
local e=math.max(0,o-d-e)
local r=n>0 and 1 or 0
local i=math.max(0,n-r)
local o
if e>0 then
o=u+math.floor((e-1)/2)
else
o=a
end
local e=self:getSelectedItem()
if not e or e==""then
e=self.placeholder or""
end
if i>0 then
if#e>i then
e=e:sub(1,i)
end
local a=math.max(0,i-#e)
local e=e..string.rep(" ",a)
s.text(h,o,e,l,t)
end
if r>0 then
local a=self._open and string.char(30)or string.char(31)
local e=h+n-1
s.text(e,o,a,l,t)
end
end
function p:_drawDropdown(h,u)
if not self._open or#self.items==0 or self.visible==false then
return
end
local n,t,i,e=self:getAbsoluteRect()
local a=t+e
local d=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local s=(e and e.right)and 1 or 0
local c=n+t
local t=math.max(0,i-t-s)
local l=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local s=d+e
r(h,n,a,i,s,self.dropdownBg,self.dropdownBg)
j(h,n,a,i,s)
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
b(u,n,a,i,s,e,self.dropdownBg)
end
end
end
function p:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,e,t=...
return self:_handlePress(e,t)
elseif t=="monitor_touch"then
local a,e,t=...
return self:_handlePress(e,t)
elseif t=="mouse_scroll"then
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
setmetatable(o,{__index=h})
local D={
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
local L={
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
local function U(a)
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
local function Y(e)
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
local function H(e,t,o,a)
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
local function B(e,t,a,o,n,i)
if H(e,t,a,o)<0 then
return false
end
if H(e,t,n,i)>=0 then
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
keywords=D,
builtins=L,
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
t.keywords=t.keywords or D
t.builtins=t.builtins or L
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
t.border=A(true)
end
t.scrollbar=O(a.scrollbar,t.bg or e.black,t.fg or e.white)
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
self.scrollbar=O(t,self.bg or e.black,self.fg or e.white)
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
self.text=Y(self._lines)
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
local e,a,i,s=self:getAbsoluteRect()
local n,h,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
n=e
h=a
t=math.max(1,i)
o=math.max(1,s)
end
local r=self:_getOverlayHeight(o)
local s=math.max(1,o-r)
local e,a=S(self.scrollbar,#self._lines,s,t)
if e>0 and t-e<1 then
if a and(a.alwaysVisible or#self._lines>s)then
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
innerX=n,
innerY=h,
innerWidth=t,
innerHeight=o,
contentWidth=i,
contentHeight=s,
overlayHeight=r,
scrollbarWidth=e,
scrollbarStyle=a,
scrollbarX=n+i
}
end
function o:_getContentSize()
local e=self:_computeLayoutMetrics()
return math.max(1,e.contentWidth),math.max(1,e.contentHeight)
end
function o:_ensureCursorVisible()
local t,e=self:_getContentSize()
local a=self._scrollY+1
local o=self._scrollY+e
if self._cursorLine<a then
self._scrollY=self._cursorLine-1
elseif self._cursorLine>o then
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
local e,a,o,t=self:_getSelectionRange()
local e=self:_collectRange(e,a,o,t)
return#e
end
function o:getSelectionText()
if not self:_hasSelection()then
return""
end
local o,a,t,e=self:_getSelectionRange()
return self:_collectRange(o,a,t,e)
end
function o:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local o,a=e.line,e.col
local e,t=self._cursorLine,self._cursorCol
if H(o,a,e,t)<=0 then
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
t=E(t,1,#self._lines)
local o=self._lines[t]or""
a=E(a,1,#o+1)
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
self._scrollY=E(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local t=select(1,self:_getContentSize())
local a=self._lines[self._cursorLine]or""
local t=math.max(0,#a-t)
self._scrollX=E(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(i,n)
local e=self:_computeLayoutMetrics()
local o=e.innerX
local a=e.innerY
local t=math.max(1,e.contentWidth)
local e=math.max(1,e.contentHeight)
local t=E(i-o,0,t-1)
local e=E(n-a,0,e-1)
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
function o:_buildLineSegments(s,t,r,h,e)
local a=self._lines[s]or""
local i=self:_computeSyntaxColors(a)
local o=self._scrollX+1
local n={}
for t=0,t-1 do
local t=o+t
local o
if t<=#a then
o=a:sub(t,t)
else
o=" "
end
local a=i and i[t]or r
local i=h
if e and B(s,t,e.startLine,e.startCol,e.endLine,e.endCol)then
i=self.selectionBg
a=self.selectionFg
end
E(n,o,a,i)
end
return n,a,i
end
function o:_drawSegments(o,t,a,e)
local t=t
for i=1,#e do
local e=e[i]
if e.text~=""then
o.text(t,a,e.text,e.fg,e.bg)
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
local n=n+i-o
for e=0,o-1 do
s.text(a,n+e,string.rep(" ",t),d,r)
end
local e=self._find
local i=#e.matches
local h=i>0 and string.format("%d/%d",math.max(1,e.index),i)or"0/0"
local i=e.matchCase and"CASE"or"case"
local h=string.format("Find: %s  %s  %s",e.findText,h,i)
local i="Replace: "..e.replaceText
local h=h
if#h>t then
h=h:sub(1,t)
end
local i=i
if#i>t then
i=i:sub(1,t)
end
s.text(a,n,h..string.rep(" ",math.max(0,t-#h)),d,r)
s.text(a,n+math.max(o-1,0),i..string.rep(" ",math.max(0,t-#i)),d,r)
local i,l,h
if e.activeField=="find"then
i=a+6
l=n
h=e.findText
else
i=a+9
l=n+math.max(o-1,0)
h=e.replaceText
end
local e=h
if#e>t-(i-a)then
e=e:sub(1,t-(i-a))
end
s.text(i,l,e..string.rep(" ",math.max(0,t-(i-a)-#e)),c,u)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
s.text(a,n+o-1,e..string.rep(" ",math.max(0,t-#e)),d,r)
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
local a=e.findText
local t=e.matchCase
for o=1,#self._lines do
local i=self._lines[o]
local i=t and i or i:lower()
local t=t and a or a:lower()
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
if H(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
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
local o=t.line
local i=t.col
local a=self._lines[o]
self._lines[o]=a:sub(1,i-1)..(e.replaceText or"")..a:sub(i+t.length)
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
local y,f,w,p=self:getAbsoluteRect()
local n=self.bg or e.black
local v=self.fg or e.white
r(a,y,f,w,p,n,n)
j(a,y,f,w,p)
local o=self:_computeLayoutMetrics()
local d=o.innerX
local s=o.innerY
local t=o.innerWidth
local q=o.innerHeight
local i=o.contentWidth
local h=o.contentHeight
local c=o.overlayHeight
local u=o.scrollbarWidth
local m=o.scrollbarStyle
local g
local k=false
if self:_hasSelection()then
local o,a,t,e=self:_getSelectionRange()
g={
startLine=o,
startCol=a,
endLine=t,
endCol=e
}
k=true
end
local t=self._autocompleteState
local l=n
for n=0,h-1 do
local o=self._scrollY+n+1
local n=s+n
if o>#self._lines then
a.text(d,n,string.rep(" ",i),v,l)
else
local s,h,r=self:_buildLineSegments(o,i,v,l,g)
self:_drawSegments(a,d,n,s)
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
local o=v
a.text(d+t,n,e,i,o)
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
self:_drawFindOverlay(a,d,s,i,q)
if m then
local t=o.scrollbarX
local e=m.background or n
r(a,t,s,u,h,e,e)
N(a,t,s,h,#self._lines,h,self._scrollY,m)
if c>0 then
r(a,t,s+h,u,c,e,e)
end
elseif u>0 then
r(a,o.scrollbarX,s,u,h+c,n,n)
end
if self.border then
b(x,y,f,w,p,self.border,n)
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
local e=I(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
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
local a,t,e=...
if self._dragging and a==self._dragButton then
local t,e=self:_cursorFromPoint(t,e)
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
local e=I(t,e.contentHeight,#self._lines,e.contentHeight,self._scrollY)
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
function f.create(a)
if a~=nil then
t(1,a,"table")
end
a=a or{}
local h=false
local i
local t=a.window
if t==nil then
i=C.current()
local e,a=i.getSize()
t=P.create(i,1,1,e,a,true)
t.setVisible(true)
h=true
end
local o=W.new(t)
o.profiler.start_frame()
o.profiler.start_region("user")
local c=o.add_pixel_layer(5,"pixelui_pixels")
local l=o.add_text_layer(10,"pixelui_ui")
local u,d=t.getSize()
local s=a.background or e.black
o.fill(s)
local r=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=t,
box=o,
layer=l,
pixelLayer=c,
background=s,
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
},n)
t.root=z:new(t,{
x=1,
y=1,
width=u,
height=d,
bg=s,
fg=e.white,
border=a.rootBorder,
z=-math.huge
})
return t
end
function n:getRoot()
return self.root
end
function n:setBackground(e)
t(1,e,"number")
self.background=e
self.box.fill(e)
end
function n:getLayer()
return self.layer
end
function n:getPixelLayer()
return self.pixelLayer
end
function n:createFrame(e)
return z:new(self,e)
end
function n:createButton(e)
return T:new(self,e)
end
function n:createLabel(e)
return k:new(self,e)
end
function n:createCheckBox(e)
return g:new(self,e)
end
function n:createToggle(e)
return q:new(self,e)
end
function n:createTextBox(e)
return o:new(self,e)
end
function n:createComboBox(e)
return p:new(self,e)
end
function n:createList(e)
return u:new(self,e)
end
function n:createTable(e)
return s:new(self,e)
end
function n:createTreeView(e)
return l:new(self,e)
end
function n:createChart(e)
return c:new(self,e)
end
function n:createRadioButton(e)
return w:new(self,e)
end
function n:createProgressBar(e)
return y:new(self,e)
end
function n:createNotificationToast(e)
return i:new(self,e)
end
function n:createLoadingRing(e)
return m:new(self,e)
end
function n:createSlider(e)
return d:new(self,e)
end
function n:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=x.startTimer(self._animationInterval)
end
end
function n:_updateAnimations()
local a=self._animations
if not a or#a==0 then
return
end
local o=x.clock()
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
function n:_clearAnimations(t)
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
function n:animate(e)
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
onComplete=o,
onCancel=i,
easing=t,
duration=e,
startTime=x.clock()
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
local j="completed"
local b="error"
local r="cancelled"
local E={}
local function A(e,t,...)
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
function v:getId()
return self.id
end
function v:getName()
return self.name
end
function v:setName(e)
t(1,e,"string")
self.name=e
end
function v:getStatus()
return self.status
end
function v:isRunning()
return self.status==a
end
function v:isFinished()
local e=self.status
return e==j or e==b or e==r
end
function v:isCancelled()
return self._cancelRequested or self.status==r
end
function v:cancel()
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
function v:getResult()
if not self.result then
return nil
end
return F(self.result,1,self.result.n or#self.result)
end
function v:getResults()
if not self.result then
return nil
end
local t={n=self.result.n}
local e=self.result.n or#self.result
for e=1,e do
t[e]=self.result[e]
end
return t
end
function v:getError()
return self.error
end
function v:setMetadata(e,a)
t(1,e,"string")
local t=self.metadata[e]
if t==a then
return
end
self.metadata[e]=a
self:_emitMetadata(e,a)
end
function v:getMetadata(e)
t(1,e,"string")
return self.metadata[e]
end
function v:getAllMetadata()
local e={}
for t,a in pairs(self.metadata)do
e[t]=a
end
return e
end
function v:onStatusChange(e)
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
function v:onMetadataChange(e)
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
function v:_emitMetadata(t,e)
A(self._metadataListeners,"Thread metadata listener error: ",self,t,e)
end
function v:_setStatus(e)
if self.status==e then
return
end
self.status=e
A(self._statusListeners,"Thread status listener error: ",self,e)
end
local function A(e)
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
local a=x.startTimer(a)
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
function n:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==a and e._ready then
self._threadTicker=x.startTimer(0)
return
end
end
end
function n:_cleanupThread(e)
if e.timerId and self._threadTimers then
self._threadTimers[e.timerId]=nil
e.timerId=nil
end
e.waiting=nil
e._ready=false
e._resumeValue=nil
end
function n:_resumeThread(e)
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
local a=M(coroutine.resume(e.co,t))
local t=a[1]
if not t then
local t=a[2]
if t==E then
e:_setStatus(r)
else
if type(t)=="string"and debug and debug.traceback then
t=debug.traceback(e.co,t)
end
e.error=t
print("PixelUI thread error: "..tostring(t))
e:_setStatus(b)
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
e:_setStatus(j)
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
function n:_serviceThreads()
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
function n:_shutdownThreads()
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
function n:spawnThread(o,e)
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
},v)
local a=coroutine.create(function()
local e=A(t)
t._context=e
local e=M(o(e,self))
return F(e,1,e.n)
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
function n:getThreads()
local e={}
if not self._threads then
return e
end
for t=1,#self._threads do
e[t]=self._threads[t]
end
return e
end
function n:_registerPopup(e)
if not e then
return
end
local t=self._popupLookup
if not t[e]then
t[e]=true
table.insert(self._popupWidgets,e)
end
end
function n:_unregisterPopup(e)
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
function n:_drawPopups()
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
function n:_registerRadioButton(e)
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
function n:_unregisterRadioButton(t)
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
function n:_selectRadioInGroup(o,t,a)
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
function n:setFocus(e)
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
function n:getFocus()
return self._focusWidget
end
function n:render()
self.box.fill(self.background)
self.pixelLayer.clear()
self.layer.clear()
self.root:draw(self.layer,self.pixelLayer)
self:_drawPopups()
self.box.render()
end
function n:step(e,...)
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
self._animationTimer=x.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or C.current()
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
function n:run()
self.running=true
self:render()
while self.running do
local e={V()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
self:_shutdownThreads()
end
function n:stop()
self.running=false
self:_clearAnimations(true)
self:_shutdownThreads()
end
f.widgets={
Frame=function(e,t)
return z:new(e,t)
end,
Button=function(t,e)
return T:new(t,e)
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
return p:new(e,t)
end,
List=function(t,e)
return u:new(t,e)
end,
Table=function(t,e)
return s:new(t,e)
end,
TreeView=function(e,t)
return l:new(e,t)
end,
Chart=function(e,t)
return c:new(e,t)
end,
RadioButton=function(e,t)
return w:new(e,t)
end,
ProgressBar=function(t,e)
return y:new(t,e)
end,
Slider=function(t,e)
return d:new(t,e)
end,
LoadingRing=function(t,e)
return m:new(t,e)
end,
NotificationToast=function(t,e)
return i:new(t,e)
end
}
f.Widget=h
f.Frame=z
f.Button=T
f.Label=k
f.CheckBox=g
f.Toggle=q
f.TextBox=o
f.ComboBox=p
f.List=u
f.Table=s
f.TreeView=l
f.Chart=c
f.RadioButton=w
f.ProgressBar=y
f.Slider=d
f.LoadingRing=m
f.NotificationToast=i
f.easings=R
f.ThreadHandle=v
f.ThreadContext=_
f.threadStatus={
running=a,
completed=j,
error=b,
cancelled=r
}
return f
