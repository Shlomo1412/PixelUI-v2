local S=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local _=assert(rawget(_G,"os"),"os API unavailable")
local L=assert(_.pullEvent,"os.pullEvent unavailable")
local U=assert(rawget(_G,"window"),"window API unavailable")
local t=assert(rawget(_G,"keys"),"keys API unavailable")
local H=table.pack or function(...)
return{n=select("#",...),...}
end
local R=table.unpack or unpack
local a=require("cc.expect").expect
local D=require("shrekbox")
local f={
version="0.1.0"
}
local A={
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
local r={}
r.__index=r
local k={}
k.__index=k
setmetatable(k,{__index=r})
local z={}
z.__index=z
setmetatable(z,{__index=r})
local b={}
b.__index=b
setmetatable(b,{__index=r})
local p={}
p.__index=p
setmetatable(p,{__index=r})
local v={}
v.__index=v
setmetatable(v,{__index=r})
local c={}
c.__index=c
setmetatable(c,{__index=r})
local s={}
s.__index=s
setmetatable(s,{__index=r})
local w={}
w.__index=w
local x={}
x.__index=x
local l={}
l.__index=l
setmetatable(l,{__index=r})
local n={}
n.__index=n
setmetatable(n,{__index=r})
local h={}
h.__index=h
setmetatable(h,{__index=r})
local d={}
d.__index=d
setmetatable(d,{__index=r})
local m={}
m.__index=m
setmetatable(m,{__index=r})
local y={}
y.__index=y
setmetatable(y,{__index=r})
local i={}
i.__index=i
local u={"top","right","bottom","left"}
local O=string.char(7)
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
local function j(t,e)
a(nil,t,"string")
a(nil,e,"number")
if e<1 or e~=math.floor(e)then
error(('%s must be a positive integer, got "%s"'):format(t,tostring(e)),3)
end
end
local function E(t)
if not t or t==false then
return nil
end
if t==true then
return{
color=e.lightGray,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
}
end
a(1,t,"table")
local e={
color=t.color or e.lightGray,
top=true,
right=true,
bottom=true,
left=true,
thickness=math.max(1,math.floor(t.thickness or 1))
}
local function a(a,t)
if t~=nil then
e[a]=not not t
end
end
if t.sides then
e.top=false
e.right=false
e.bottom=false
e.left=false
if#t.sides>0 then
for a=1,#t.sides do
local t=t.sides[a]
if e[t]~=nil then
e[t]=true
end
end
else
for t,a in pairs(t.sides)do
if e[t]~=nil then
e[t]=not not a
end
end
end
else
for e=1,#u do
a(u[e],t[u[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function u(h,n,s,e,t,i,o,a)
if e<=0 or t<=0 then
return
end
local a=a or" "
local e=a:rep(e)
for t=0,t-1 do
h.text(n,s+t,e,i,o)
end
end
local function q(t,e,i,o,a)
if o<=0 or a<=0 then
return
end
local n=D.transparent
for o=0,o-1 do
t.pixel(e+o,i,n)
if a>1 then
t.pixel(e+o,i+a-1,n)
end
end
for a=1,math.max(0,a-2)do
t.pixel(e,i+a,n)
if o>1 then
t.pixel(e+o-1,i+a,n)
end
end
end
local function g(s,t,i,o,h,e,a)
if o<=0 or h<=0 then
return
end
local n=e.color
local r=a or n
local a=(t-1)*2+1
local t=(i-1)*3+1
local i=o*2
local o=h*3
local l=3
local u=2
local h=math.min(e.thickness,o)
local d=math.min(e.thickness,i)
local l=math.min(o,math.max(h,l))
local u=math.min(i,math.max(d,u))
local function m(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+o then break end
for t=0,i-1 do
s.pixel(a+t,e,n)
end
end
end
local function w(e,h,n)
for h=0,h-1 do
local e=e+h
if e<t or e>=t+o then break end
for t=0,i-1 do
s.pixel(a+t,e,n)
end
end
end
local function f(e,n,h)
for n=0,n-1 do
local e=e+n
if e<a or e>=a+i then break end
for a=0,o-1 do
s.pixel(e,t+a,h)
end
end
end
local function c(n,e,h)
for e=0,e-1 do
local e=n+e
if e<a or e>=a+i then break end
for a=0,o-1 do
s.pixel(e,t+a,h)
end
end
end
if e.left then
f(a,u,r)
end
if e.right then
f(a+i-u,u,r)
end
if e.top then
m(t,l,r)
end
if e.bottom then
m(t+o-l,l,r)
end
if e.top then
w(t,h,n)
end
if e.bottom then
w(t+o-h,h,n)
end
if e.left then
c(a,d,n)
end
if e.right then
c(a+i-d,d,n)
end
end
local function T(e)
local t,a=e.x,e.y
local e=e.parent
while e do
t=t+e.x-1
a=a+e.y-1
e=e.parent
end
return t,a
end
function r:_init_base(o,t)
a(1,o,"table")
t=t or{}
a(2,t,"table","nil")
self.app=o
self.parent=nil
self.x=math.floor(t.x or 1)
self.y=math.floor(t.y or 1)
self.width=math.floor(t.width or 1)
self.height=math.floor(t.height or 1)
self.bg=t.bg or e.black
self.fg=t.fg or e.white
self.visible=t.visible~=false
self.z=t.z or 0
self.id=t.id
self.border=E(t.border)
self.focusable=t.focusable==true
self._focused=false
j("width",self.width)
j("height",self.height)
end
function r:setSize(e,t)
j("width",e)
j("height",t)
self.width=e
self.height=t
end
function r:setPosition(e,t)
a(1,e,"number")
a(2,t,"number")
self.x=math.floor(e)
self.y=math.floor(t)
end
function r:setZ(e)
a(1,e,"number")
self.z=e
end
function r:setBorder(e)
if e==nil then
self.border=nil
return
end
if e==false then
self.border=nil
return
end
if e==true then
self.border=E(true)
return
end
a(1,e,"table","boolean")
self.border=E(e)
end
function r:isFocused()
return self._focused
end
function r:setFocused(e)
e=not not e
if self._focused==e then
return
end
self._focused=e
self:onFocusChanged(e)
end
function r:onFocusChanged(e)
end
function r:getAbsoluteRect()
local t,e=T(self)
return t,e,self.width,self.height
end
function r:containsPoint(o,a)
local e,t,i,n=self:getAbsoluteRect()
return o>=e and o<e+i and a>=t and a<t+n
end
function r:draw(e,e)
error("draw needs implementation for widget",2)
end
function r:handleEvent(e,...)
return false
end
function k:new(a,t)
local e=setmetatable({},k)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function k:addChild(e)
a(1,e,"table")
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
function k:removeChild(e)
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
local function j(t)
local a={}
for e=1,#t do
a[e]=t[e]
end
return a
end
local function T(e)
table.sort(e,function(t,e)
if t.z==e.z then
return(t._orderIndex or 0)<(e._orderIndex or 0)
end
return t.z<e.z
end)
end
function k:getChildren()
return j(self._children)
end
function k:setTitle(e)
if e~=nil then
a(1,e,"string")
end
self.title=e
end
function k:draw(s,r)
if not self.visible then
return
end
local n,t,a,o=self:getAbsoluteRect()
local i=self.bg or self.app.background
local d,l=n+1,t+1
local e=math.max(0,a-2)
local h=math.max(0,o-2)
if e>0 and h>0 then
u(s,d,l,e,h,i,i)
elseif a>0 and o>0 then
u(s,n,t,a,o,i,i)
end
q(s,n,t,a,o)
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
g(r,n,t,a,o,self.border,i)
end
local e=j(self._children)
T(e)
for t=1,#e do
e[t]:draw(s,r)
end
end
function k:handleEvent(t,...)
if not self.visible then
return false
end
if r.handleEvent(self,t,...)then
return true
end
local e=j(self._children)
T(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function z:new(a,e)
local t=setmetatable({},z)
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
function z:setLabel(e)
a(1,e,"string")
self.label=e
end
function z:setOnClick(e)
if e~=nil then
a(1,e,"function")
end
self.onClick=e
end
function z:draw(s,l)
if not self.visible then
return
end
local i,n,a,t=self:getAbsoluteRect()
local o=self.bg or e.gray
local h=self.fg or e.white
local e=o
local r=h
if self.clickEffect and self._pressed then
e,r=r,e
end
local d,c=i+1,n+1
local o=math.max(0,a-2)
local h=math.max(0,t-2)
if o>0 and h>0 then
u(s,d,c,o,h,e,e)
else
u(s,i,n,a,t,e,e)
end
q(s,i,n,a,t)
if self.border then
g(l,i,n,a,t,self.border,e)
end
local t=self.label or""
local a=o>0 and o or a
if#t>a then
t=t:sub(1,a)
end
local l=0
if a>#t then
l=math.floor((a-#t)/2)
end
local t=string.rep(" ",l)..t
if#t<a then
t=t..string.rep(" ",a-#t)
end
local o=o>0 and d or i
local a
if h>0 then
a=c+math.floor((h-1)/2)
else
a=n
end
s.text(o,a,t,r,e)
end
function z:handleEvent(e,...)
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
function b:new(i,e)
e=e or{}
local a=o(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},b)
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
function b:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-o-a)
local n=math.max(0,self.height-t-e)
return o,a,t,e,i,n
end
function b:_wrapLine(e,a,t)
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
function b:_updateLines(e)
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
function b:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function b:getText()
return self.text
end
function b:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function b:isWrapping()
return self.wrap
end
function b:setHorizontalAlign(t)
if t==nil then
t="left"
else
a(1,t,"string")
end
local e=t:lower()
if e~="left"and e~="center"and e~="right"then
error("Invalid horizontal alignment '"..t.."'",2)
end
if self.align~=e then
self.align=e
end
end
function b:setVerticalAlign(t)
if t==nil then
t="top"
else
a(1,t,"string")
end
local e=t:lower()
if e=="center"then
e="middle"
end
if e~="top"and e~="middle"and e~="bottom"then
error("Invalid vertical alignment '"..t.."'",2)
end
if self.verticalAlign~=e then
self.verticalAlign=e
end
end
function b:setSize(t,e)
r.setSize(self,t,e)
self:_updateLines(true)
end
function b:setBorder(e)
r.setBorder(self,e)
self:_updateLines(true)
end
function b:draw(c,m)
if not self.visible then
return
end
local n,s,d,l=self:getAbsoluteRect()
local h=self.bg or self.app.background or e.black
local f=self.fg or e.white
u(c,n,s,d,l,h,h)
q(c,n,s,d,l)
local a,o,e,o,t,i=self:_getInnerMetrics()
local a=n+a
local u=s+e
self:_updateLines(false)
local r=self._lines or{""}
local o=#r
if o==0 then
r={""}
o=1
end
if t>0 and i>0 then
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
local i=u+o
for e=0,e-1 do
local e=r[n+e]or""
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
c.text(o,i,e,f,h)
end
i=i+1
end
end
if self.border then
g(m,n,s,d,l,self.border,h)
end
end
function p:new(n,t)
t=t or{}
local o=o(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},p)
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
function p:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function p:_setState(t,e,a)
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
function p:setLabel(e)
a(1,e,"string")
self.label=e
end
function p:setOnChange(e)
if e~=nil then
a(1,e,"function")
end
self.onChange=e
end
function p:setAllowIndeterminate(e)
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
function p:setChecked(e)
a(1,e,"boolean")
self:_setState(e,false,false)
end
function p:isChecked()
return self.checked
end
function p:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
a(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function p:isIndeterminate()
return self.indeterminate
end
function p:toggle()
self:_activate()
end
function p:_activate()
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
function p:draw(h,a)
if not self.visible then
return
end
local s,n,t,i=self:getAbsoluteRect()
local o=self.bg or e.black
local e=self.fg or e.white
local o=o
local r=e
if self:isFocused()then
o=self.focusBg or o
r=self.focusFg or r
end
u(h,s,n,t,i,o,o)
q(h,s,n,t,i)
if self.border then
g(a,s,n,t,i,self.border,o)
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
h.text(s,t,e,r,o)
end
function p:handleEvent(e,...)
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
if e==t.space or e==t.enter then
self:_activate()
return true
end
end
return false
end
function v:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},v)
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
function v:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function v:setOnChange(e)
if e~=nil then
a(1,e,"function")
end
self.onChange=e
end
function v:setValue(e,t)
e=not not e
if self.value==e then
return
end
self.value=e
if not t then
self:_emitChange()
end
end
function v:isOn()
return self.value
end
function v:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function v:setLabels(e,t)
if e~=nil then
a(1,e,"string")
self.labelOn=e
end
if t~=nil then
a(2,t,"string")
self.labelOff=t
end
end
function v:setShowLabel(e)
self.showLabel=not not e
end
function v:setDisabled(e)
e=not not e
if self.disabled==e then
return
end
self.disabled=e
end
function v:isDisabled()
return self.disabled
end
function v:setColors(o,t,e,i,n)
if o~=nil then
a(1,o,"number")
self.trackColorOn=o
end
if t~=nil then
a(2,t,"number")
self.trackColorOff=t
end
if e~=nil then
a(3,e,"number")
self.thumbColor=e
end
if i~=nil then
a(4,i,"number")
self.onLabelColor=i
end
if n~=nil then
a(5,n,"number")
self.offLabelColor=n
end
end
function v:draw(r,s)
if not self.visible then
return
end
local n,o,a,i=self:getAbsoluteRect()
local t=self.bg or e.black
local c=self.fg or e.white
u(r,n,o,a,i,t,t)
q(r,n,o,a,i)
if self.border then
g(s,n,o,a,i,self.border,t)
end
local t=self.border
local h=(t and t.left)and t.thickness or 0
local l=(t and t.right)and t.thickness or 0
local d=(t and t.top)and t.thickness or 0
local m=(t and t.bottom)and t.thickness or 0
local n=n+h
local f=o+d
local t=math.max(0,a-h-l)
local o=math.max(0,i-d-m)
if t<=0 or o<=0 then
return
end
local a=n
local n=f
local t=t
local i=o
local h=self.trackColorOff or e.gray
local o=self.trackColorOn or e.lightBlue
local l=self.value and o or h
u(r,a,n,t,i,l,l)
local o=math.max(1,math.floor(t/2))
if t>=4 then
o=math.max(2,o)
end
if o>t then
o=t
end
local h
if self.value then
h=a+t-o
else
h=a
end
if h<a then
h=a
end
if h+o>a+t then
h=a+t-o
end
local d=self.thumbColor or e.white
if self:isFocused()then
d=self.focusBg or d
end
u(r,h,n,o,i,d,d)
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
local s=c
if self.value then
s=self.onLabelColor or c
else
s=self.offLabelColor or c
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
r.text(e,i,o,s,l)
end
end
if self:isFocused()then
local e=self.focusFg or e.white
if t>1 then
for t=0,t-1 do
s.pixel(a+t,n,e)
if i>1 then
s.pixel(a+t,n+i-1,e)
end
end
end
if i>1 then
for o=0,i-1 do
s.pixel(a,n+o,e)
if t>1 then
s.pixel(a+t-1,n+o,e)
end
end
end
end
if self.disabled then
for t=0,t-1,2 do
local t=a+t
s.pixel(t,n,e.gray)
if i>1 then
s.pixel(t,n+i-1,e.gray)
end
end
end
end
function v:handleEvent(e,...)
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
if e==t.space or e==t.enter then
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
function m:new(n,a)
a=a or{}
local o=o(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},m)
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
t._dotChar=O
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
function m:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function m:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function m:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function m:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function m:setLabel(e)
a(1,e,"string")
self.label=e
end
function m:setValue(e)
self.value=e
end
function m:getValue()
return self.value
end
function m:setGroup(e)
a(1,e,"string","nil")
if self.group==e then
return
end
self:_unregisterFromGroup()
self.group=e
if self.group then
self:_registerWithGroup()
end
end
function m:getGroup()
return self.group
end
function m:setOnChange(e)
if e~=nil then
a(1,e,"function")
end
self.onChange=e
end
function m:setSelected(e)
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
function m:isSelected()
return self.selected
end
function m:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function m:draw(h,r)
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
u(h,o,n,t,i,a,a)
q(h,o,n,t,i)
if self.border then
g(r,o,n,t,i,self.border,a)
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
h.text(o,n,e,s,a)
end
end
function m:handleEvent(e,...)
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
if e==t.space or e==t.enter then
self:_activate()
return true
end
end
return false
end
function c:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},c)
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
t.border=E(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
end
return t
end
function c:_clampValue(e)
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
function c:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function c:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=A.linear,
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
function c:setRange(e,t)
a(1,e,"number")
a(2,t,"number")
if t<=e then
error("ProgressBar max must be greater than min",2)
end
self.min=e
self.max=t
self.value=self:_clampValue(self.value)
end
function c:getRange()
return self.min,self.max
end
function c:setValue(e)
if self.indeterminate then
return
end
a(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function c:getValue()
return self.value
end
function c:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function c:setIndeterminate(e)
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
function c:isIndeterminate()
return self.indeterminate
end
function c:setLabel(e)
if e~=nil then
a(1,e,"string")
end
self.label=e
end
function c:setShowPercent(e)
self.showPercent=not not e
end
function c:setColors(e,t,o)
if e~=nil then
a(1,e,"number")
self.trackColor=e
end
if t~=nil then
a(2,t,"number")
self.fillColor=t
end
if o~=nil then
a(3,o,"number")
self.textColor=o
end
end
function c:draw(n,a)
if not self.visible then
return
end
local t,o,r,i=self:getAbsoluteRect()
local s=self.trackColor or(self.bg or e.gray)
local h=self.fillColor or e.lightBlue
local f=self.textColor or(self.fg or e.white)
u(n,t,o,r,i,s,s)
q(n,t,o,r,i)
if self.border then
g(a,t,o,r,i,self.border,s)
end
local e=self.border
local c=(e and e.left)and 1 or 0
local m=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=t+c
local l=o+d
local t=math.max(0,r-c-m)
local o=math.max(0,i-d-e)
if t<=0 or o<=0 then
return
end
u(n,a,l,t,o,s,s)
local d=0
local r=0
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
r=math.floor(t*e+.5)
u(n,a+r,l,i,o,h,h)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
d=math.floor(t*e+.5)
if d>0 then
u(n,a,l,d,o,h,h)
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
local l=l+math.floor((o-1)/2)
local t=a+math.floor((t-#e)/2)
if t<a then
t=a
end
for o=1,#e do
local u=e:sub(o,o)
local a=(t-a)+(o-1)
local e=s
if self.indeterminate then
if a>=r and a<r+i then
e=h
end
else
if a<d then
e=h
end
end
n.text(t+o-1,l,u,f,e)
end
end
end
function c:handleEvent(e,...)
return false
end
function s:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(1,math.floor(o.width or 12))
local t=setmetatable({},s)
t:_init_base(i,o)
t.focusable=true
t.min=type(a.min)=="number"and a.min or 0
t.max=type(a.max)=="number"and a.max or 100
if t.max<=t.min then
t.max=t.min+1
end
if a and type(a.step)=="number"and a.step>0 then
t.step=a.step
else
t.step=0
end
t.range=not not(a and a.range)
t.trackColor=(a and a.trackColor)or e.gray
t.fillColor=(a and a.fillColor)or e.lightBlue
t.handleColor=(a and a.handleColor)or e.white
t.showValue=not not(a and a.showValue)
if a and a.formatValue~=nil then
if type(a.formatValue)~="function"then
error("Slider formatValue must be a function",2)
end
t.formatValue=a.formatValue
else
t.formatValue=nil
end
t.onChange=a and a.onChange or nil
t._activeHandle=nil
t._focusedHandle=t.range and"lower"or"single"
t._dragging=false
if t.range then
local e
local o
if a and type(a.value)=="table"then
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
local e=a and a.value
if type(e)~="number"then
e=t.min
end
t.value=t:_applyStep(e)
end
if not t.border then
t.border=E(true)
end
return t
end
function s:_clampValue(e)
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
function s:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function s:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local h,i=self:getAbsoluteRect()
local n=math.max(0,self.width-a-o)
local s=math.max(0,self.height-t-e)
local o=h+a
local i=i+t
return o,i,n,s,a,t,e
end
function s:_valueToPosition(o,t)
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
function s:_positionToValue(e,t)
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
function s:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function s:setOnChange(e)
if e~=nil then
a(1,e,"function")
end
self.onChange=e
end
function s:_setSingleValue(e,t)
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
function s:setValue(e)
if self.range then
return
end
a(1,e,"number")
self:_setSingleValue(e,false)
end
function s:getValue()
return self.value
end
function s:_setLowerValue(e,t)
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
function s:_setUpperValue(e,t)
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
function s:setRangeValues(e,t,o)
if not self.range then
return
end
if e==nil then
e=self.lowerValue or self.min
end
if t==nil then
t=self.upperValue or self.max
end
a(1,e,"number")
a(2,t,"number")
if e>t then
e,t=t,e
end
local a=false
a=self:_setLowerValue(e,true)or a
a=self:_setUpperValue(t,true)or a
if a and not o then
self:_notifyChange()
end
end
function s:getRangeValues()
return self.lowerValue,self.upperValue
end
function s:setRangeLimits(t,e)
a(1,t,"number")
a(2,e,"number")
if e<=t then
error("Slider max must be greater than min",2)
end
self.min=t
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
function s:setStep(e)
if e==nil then
e=0
else
a(1,e,"number")
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
function s:setShowValue(e)
self.showValue=not not e
end
function s:setColors(e,o,t)
if e~=nil then
a(1,e,"number")
self.trackColor=e
end
if o~=nil then
a(2,o,"number")
self.fillColor=o
end
if t~=nil then
a(3,t,"number")
self.handleColor=t
end
end
function s:_formatNumber(o)
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
function s:_formatDisplayValue()
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
function s:_getStepForNudge(t)
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
function s:_positionFromPoint(t)
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
function s:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local i=self:_valueToPosition(self.lowerValue,a)
local o=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local n=math.abs(t-i)
local s=math.abs(t-o)
if n==s then
if t>o then
e="upper"
elseif t<i then
e="lower"
end
elseif n<s then
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
function s:_updateInteraction(e)
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
function s:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function s:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function s:_nudgeValue(e)
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
function s:onFocusChanged(e)
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
function s:draw(i,f)
if not self.visible then
return
end
local l,d,r,s=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
u(i,l,d,r,s,n,n)
q(i,l,d,r,s)
local a,m,t,h=self:_getInnerMetrics()
if t<=0 or h<=0 then
if self.border then
g(f,l,d,r,s,self.border,n)
end
return
end
local o
local c=nil
if self.showValue and h>=2 then
c=m
o=m+h-1
else
o=m+math.floor((h-1)/2)
end
u(i,a,o,t,1,self.trackColor,self.trackColor)
local m
if self:isFocused()then
m=self._activeHandle or self._focusedHandle
end
local function h(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if m and s==m then
t=self.fg or e.white
end
i.text(a+n,o," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local n=t-e+1
if n>0 then
u(i,a+e,o,n,1,self.fillColor,self.fillColor)
end
h(e,"lower")
h(t,"upper")
else
local t=self:_valueToPosition(self.value,t)
local e=t+1
if e>0 then
u(i,a,o,e,1,self.fillColor,self.fillColor)
end
h(t,"single")
end
if self.showValue and c then
local o=self:_formatDisplayValue()
if o and o~=""then
if#o>t then
o=o:sub(1,t)
end
local t=a+math.floor((t-#o)/2)
if t<a then
t=a
end
i.text(t,c,o,self.fg or e.white,n)
end
end
if self.border then
g(f,l,d,r,s,self.border,n)
end
end
function s:handleEvent(a,...)
if not self.visible then
return false
end
if a=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self._dragging=true
return self:_beginInteraction(e)
end
elseif a=="mouse_drag"then
local a,e,t=...
if self._activeHandle then
return self:_updateInteraction(e)
elseif self._dragging and self:containsPoint(e,t)then
return self:_beginInteraction(e)
end
elseif a=="mouse_up"then
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
elseif a=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_beginInteraction(e)
self:_endInteraction()
return true
end
elseif a=="mouse_scroll"then
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
elseif a=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==t.left or e==t.down then
self:_nudgeValue(-1)
return true
elseif e==t.right or e==t.up then
self:_nudgeValue(1)
return true
elseif e==t.home then
if self.range then
self:setRangeValues(self.min,self.upperValue)
self._focusedHandle="lower"
else
self:setValue(self.min)
end
return true
elseif e==t["end"]then
if self.range then
self:setRangeValues(self.lowerValue,self.max)
self._focusedHandle="upper"
else
self:setValue(self.max)
end
return true
elseif e==t.tab then
if self.range then
self:_switchFocusedHandle()
return true
end
elseif e==t.pageUp then
self:_nudgeValue(-5)
return true
elseif e==t.pageDown then
self:_nudgeValue(5)
return true
end
elseif a=="key_up"then
if self._activeHandle then
self:_endInteraction()
end
end
return false
end
function n:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},n)
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
t.border=E(true)
end
t:_ensureSelectionVisible()
return t
end
function n:_normalizeColumns(e)
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
function n:_recomputeColumnMetrics()
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
function n:_ensureColumnsForData()
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
table.sort(e,function(e,t)
return e.id<t.id
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
function n:setColumns(e)
if e~=nil then
a(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function n:getColumns()
local t={}
for e=1,#self.columns do
t[e]=o(self.columns[e])
end
return t
end
function n:setData(e)
a(1,e,"table")
local t={}
for a=1,#e do
t[a]=e[a]
end
self.data=t
self:_ensureColumnsForData()
self:_refreshRows()
end
function n:getData()
local e={}
for t=1,#self.data do
e[t]=self.data[t]
end
return e
end
function n:_refreshRows()
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
function n:_getColumnById(t)
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
function n:_applySort(t,e,u)
local t=self:_getColumnById(t)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=e=="desc"and"desc"or"asc"
local l=self.sortDirection=="desc"
local s=t.comparator
table.sort(self._rows,function(h,d)
local r=self.data[h]
local i=self.data[d]
local o=n._resolveColumnValue(t,r)
local a=n._resolveColumnValue(t,i)
local e=0
if s then
local a,t=pcall(s,o,a,r,i,t)
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
return h<d
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
function n:setSort(e,a,t)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,a or self.sortDirection,t)
end
function n:getSort()
return self.sortColumn,self.sortDirection
end
function n:setOnSort(e)
if e~=nil then
a(1,e,"function")
end
self.onSort=e
end
function n:setOnSelect(e)
if e~=nil then
a(1,e,"function")
end
self.onSelect=e
end
function n:getSelectedIndex()
return self.selectedIndex
end
function n:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function n:setSelectedIndex(e,o)
if not self.allowRowSelection then
self.selectedIndex=0
return
end
if#self._rows==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
a(1,e,"number")
e=math.floor(e)
if e<1 then
e=1
elseif e>#self._rows then
e=#self._rows
end
local t=e~=self.selectedIndex
self.selectedIndex=e
self:_ensureSelectionVisible()
if t and not o then
self:_notifySelect()
end
end
function n:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function n:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n,i=self:getAbsoluteRect()
local o=math.max(0,self.width-t-o)
local e=math.max(0,self.height-a-e)
local t=n+t
local a=i+a
return t,a,o,e
end
function n:_getRowsVisible()
local a,a,t,e=self:_getInnerMetrics()
if t<=0 or e<=0 then
return 0
end
local e=e-1
if e<0 then
e=0
end
return e
end
function n:_clampScroll()
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
function n:_ensureSelectionVisible()
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
function n:_rowFromPoint(t,e)
if not self:containsPoint(t,e)then
return nil
end
local i,t,a,o=self:_getInnerMetrics()
if a<=0 or o<=0 then
return nil
end
if e<=t then
return nil
end
local a=self:_getRowsVisible()
if a<=0 then
return nil
end
local e=e-t-1
if e<0 or e>=a then
return nil
end
local e=self.scrollOffset+e
if e<1 or e>#self._rows then
return nil
end
return e
end
function n:_columnFromPoint(s,e)
if not self:containsPoint(s,e)then
return nil
end
local n,o,t,a=self:_getInnerMetrics()
if t<=0 or a<=0 then
return nil
end
if e~=o then
return nil
end
local i=t
local e=n
for a=1,#self.columns do
local o=math.max(1,math.min(self.columns[a].width,i))
if a==#self.columns then
o=n+t-e
end
if o<=0 then
break
end
if s>=e and s<e+o then
return self.columns[a],a
end
e=e+o
i=t-(e-n)
if i<=0 then
break
end
end
return nil
end
function n._resolveColumnValue(e,t)
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
function n:_formatCell(t,a,e)
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
function n:draw(s,m)
if not self.visible then
return
end
local c,l,d,r=self:getAbsoluteRect()
local h=self.bg or e.black
local f=self.fg or e.white
u(s,c,l,d,r,h,h)
q(s,c,l,d,r)
local a,u,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
if self.border then
g(m,c,l,d,r,self.border,h)
end
return
end
local p=self.headerBg or h
local y=self.headerFg or f
local i=a
local w=t
for e=1,#self.columns do
local n=self.columns[e]
local o=math.max(1,math.min(n.width,w))
if e==#self.columns then
o=a+t-i
end
if o<=0 then
break
end
local e=n.title or n.id
local h=""
if self.sortColumn==n.id then
h=self.sortDirection=="desc"and"v"or"^"
end
if h~=""and o>=2 then
if#e>=o then
e=e:sub(1,o-1)
end
e=e..h
elseif o>#e then
e=e..string.rep(" ",o-#e)
else
e=e:sub(1,o)
end
s.text(i,u,e,y,p)
i=i+o
w=t-(i-a)
if w<=0 then
break
end
end
local o=self:_getRowsVisible()
if o<=0 then
if self.border then
g(m,c,l,d,r,self.border,h)
end
return
end
if#self._rows==0 then
for e=1,o do
s.text(a,u+e,string.rep(" ",t),f,self.rowBg)
end
if self.placeholder and self.placeholder~=""then
local i=self.placeholder
if#i>t then
i=i:sub(1,t)
end
local o=u+math.min(o,math.floor(o/2)+1)
local t=a+math.floor((t-#i)/2)
if t<a then
t=a
end
s.text(t,o,i,e.lightGray,self.rowBg)
end
else
for o=0,o-1 do
local e=self.scrollOffset+o
local m=u+1+o
if e>#self._rows then
s.text(a,m,string.rep(" ",t),f,self.rowBg)
else
local o=self._rows[e]
local l=self.data[o]
local u=self.allowRowSelection and e==self.selectedIndex
local d=self.rowBg
local c=self.rowFg
if u then
d=self.highlightBg
c=self.highlightFg
elseif self.zebra and(e%2==0)then
d=self.zebraBg
end
local h=a
local r=t
for e=1,#self.columns do
local o=self.columns[e]
local i=math.max(1,math.min(o.width,r))
if e==#self.columns then
i=a+t-h
end
if i<=0 then
break
end
local e=n._resolveColumnValue(o,l)
e=self:_formatCell(o,l,e)
if#e>i then
e=e:sub(1,i)
end
if o.align=="right"then
if#e<i then
e=string.rep(" ",i-#e)..e
end
elseif o.align=="center"then
local t=i-#e
local a=math.floor(t/2)
local t=t-a
e=string.rep(" ",a)..e..string.rep(" ",t)
else
if#e<i then
e=e..string.rep(" ",i-#e)
end
end
local n=c
if o.color then
if type(o.color)=="number"then
n=o.color
elseif type(o.color)=="function"then
local t,e=pcall(o.color,e,l,o,u)
if t and type(e)=="number"then
n=e
end
end
end
s.text(h,m,e,n,d)
h=h+i
r=t-(h-a)
if r<=0 then
break
end
end
end
end
end
if self.border then
g(m,c,l,d,r,self.border,h)
end
end
function n:_handleTypeSearch(t)
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
function n:_searchForPrefix(e)
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
local a=n._resolveColumnValue(o,a)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function n:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function n:handleEvent(a,...)
if not self.visible then
return false
end
if a=="mouse_click"then
local e,a,o=...
if self:containsPoint(a,o)then
self.app:setFocus(self)
local e=self:_columnFromPoint(a,o)
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
local e=self:_rowFromPoint(a,o)
if e then
self:setSelectedIndex(e)
return true
end
end
elseif a=="mouse_scroll"then
local t,e,a=...
if self:containsPoint(e,a)then
self.scrollOffset=self.scrollOffset+t
self:_clampScroll()
return true
end
elseif a=="char"then
if self:isFocused()and self.allowRowSelection then
local e=...
self:_handleTypeSearch(e)
return true
end
elseif a=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==t.up then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(math.max(1,(self.selectedIndex>0)and(self.selectedIndex-1)or 1))
end
return true
elseif e==t.down then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(math.min(#self._rows,(self.selectedIndex>0 and self.selectedIndex or 0)+1))
end
return true
elseif e==t.home then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(1)
else
self.scrollOffset=1
end
return true
elseif e==t["end"]then
if self.allowRowSelection and#self._rows>0 then
self:setSelectedIndex(#self._rows)
else
self.scrollOffset=math.max(1,#self._rows-self:_getRowsVisible()+1)
self:_clampScroll()
end
return true
elseif e==t.pageUp then
local e=math.max(1,self:_getRowsVisible()-1)
self.scrollOffset=self.scrollOffset-e
self:_clampScroll()
if self.allowRowSelection and self.selectedIndex>0 then
self:setSelectedIndex(math.max(1,self.selectedIndex-e),true)
self:_notifySelect()
end
return true
elseif e==t.pageDown then
local e=math.max(1,self:_getRowsVisible()-1)
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
if self.allowRowSelection and self.selectedIndex>0 then
self:setSelectedIndex(math.min(#self._rows,self.selectedIndex+e),true)
self:_notifySelect()
end
return true
elseif e==t.enter then
if self.allowRowSelection then
self:_notifySelect()
end
return true
elseif e==t.space then
if self.allowRowSelection then
self:_notifySelect()
end
return true
end
elseif a=="monitor_touch"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e=self:_rowFromPoint(t,e)
if e then
self:setSelectedIndex(e)
end
return true
end
end
return false
end
function h:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local a=setmetatable({},h)
a:_init_base(i,o)
a.focusable=true
a.highlightBg=(t and t.highlightBg)or e.lightGray
a.highlightFg=(t and t.highlightFg)or e.black
a.placeholder=(t and t.placeholder)or nil
a.indentWidth=math.max(1,math.floor((t and t.indentWidth)or 2))
local e=(t and t.toggleSymbols)or{}
a.toggleSymbols={
expanded=tostring(e.expanded or"-"),
collapsed=tostring(e.collapsed or"+"),
leaf=tostring(e.leaf or" ")
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
a.border=E(true)
end
a:setNodes((t and t.nodes)or{})
return a
end
function h:setOnSelect(e)
if e~=nil then
a(1,e,"function")
end
self.onSelect=e
end
function h:setOnToggle(e)
if e~=nil then
a(1,e,"function")
end
self.onToggle=e
end
function h:_copyNodes(e,i)
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
function h:setNodes(e)
e=e or{}
a(1,e,"table")
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
function h:getSelectedNode()
return self.selectedNode
end
function h:setSelectedNode(e)
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
function h:expandNode(e)
self:_toggleNode(e,true)
end
function h:collapseNode(e)
self:_toggleNode(e,false)
end
function h:toggleNode(e)
self:_toggleNode(e,nil)
end
function h:_rebuildFlatNodes()
local e={}
local function a(t,o)
for i=1,#t do
local t=t[i]
e[#e+1]={node=t,depth=o}
if t.expanded and t.children and#t.children>0 then
a(t.children,o+1)
end
end
end
a(self.nodes,0)
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
function h:_findVisibleIndex(a)
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
function h:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-t)
local i=math.max(0,self.height-a-e)
return o,t,a,e,n,i
end
function h:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function h:_ensureSelectionVisible()
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
function h:_setSelectedIndex(e,a)
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
function h:_selectNode(t,a)
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
function h:_moveSelection(a)
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
function h:_scrollBy(e)
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
function h:_rowFromPoint(t,e)
if not self:containsPoint(t,e)then
return nil
end
local o,i=self:getAbsoluteRect()
local s,r,h,r,a,n=self:_getInnerMetrics()
if a<=0 or n<=0 then
return nil
end
local o=o+s
local i=i+h
if t<o or t>=o+a then
return nil
end
if e<i or e>=i+n then
return nil
end
local e=e-i
local e=self.scrollOffset+e
if e<1 or e>#self._flatNodes then
return nil
end
return e,o,a
end
function h:_toggleNode(e,a)
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
function h:_notifySelect()
if self.onSelect then
self.onSelect(self,self.selectedNode,self._selectedIndex)
end
end
function h:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function h:_searchForPrefix(e)
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
function h:_handleTypeSearch(t)
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
function h:draw(n,h)
if not self.visible then
return
end
local a,t,o,s=self:getAbsoluteRect()
local i=self.bg or e.black
local l=self.fg or e.white
u(n,a,t,o,s,i,i)
q(n,a,t,o,s)
if self.border then
g(h,a,t,o,s,self.border,i)
end
local s,d,r,d,o,h=self:_getInnerMetrics()
if o<=0 or h<=0 then
return
end
local s=a+s
local a=t+r
local u=self._flatNodes
local r=#u
if r==0 then
for e=0,h-1 do
n.text(s,a+e,string.rep(" ",o),l,i)
end
local t=self.placeholder
if type(t)=="string"and#t>0 then
local t=t
if#t>o then
t=t:sub(1,o)
end
local o=s+math.floor((o-#t)/2)
if o<s then
o=s
end
n.text(o,a,t,e.lightGray,i)
end
return
end
for t=0,h-1 do
local c=a+t
local d=self.scrollOffset+t
if d>r then
n.text(s,c,string.rep(" ",o),l,i)
else
local t=u[d]
local h=t.node
local t=t.depth or 0
local t=t*self.indentWidth
if t>o-1 then
t=o-1
end
if t<0 then
t=0
end
local a=t>0 and string.rep(" ",t)or""
local r
if h and h.children and#h.children>0 then
r=h.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
else
r=self.toggleSymbols.leaf
end
r=tostring(r or" ")
local t=o-t
local a=a
if t>0 then
local e=r:sub(1,1)
a=a..e
t=t-1
end
if t>0 then
a=a.." "
t=t-1
end
if t>0 then
local e=(h and h.label)or""
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
local t=i
local o=l
if d==self._selectedIndex then
t=self.highlightBg or e.lightGray
o=self.highlightFg or e.black
end
n.text(s,c,a,o,t)
end
end
end
function h:handleEvent(a,...)
if not self.visible then
return false
end
if a=="mouse_click"then
local t,o,e=...
local i,n,a=self:_rowFromPoint(o,e)
if i then
self.app:setFocus(self)
local e=self._flatNodes[i]
if e then
local t=e.depth*self.indentWidth
if t<0 then
t=0
end
if t>a-1 then
t=a-1
end
local i=n+t
if e.node and e.node.children and#e.node.children>0 and t<a then
local t=#tostring(self.toggleSymbols.collapsed or"+")
if t<1 then
t=1
end
if o>=i and o<i+t then
self:_toggleNode(e.node,nil)
return true
end
end
end
self:_setSelectedIndex(i,false)
return true
end
elseif a=="monitor_touch"then
local t,o,e=...
local a,n,i=self:_rowFromPoint(o,e)
if a then
self.app:setFocus(self)
local e=self._flatNodes[a]
if e then
local t=e.depth*self.indentWidth
if t<0 then
t=0
end
if t>i-1 then
t=i-1
end
local a=n+t
if e.node and e.node.children and#e.node.children>0 and t<i then
local t=#tostring(self.toggleSymbols.collapsed or"+")
if t<1 then
t=1
end
if o>=a and o<a+t then
self:_toggleNode(e.node,nil)
return true
end
end
end
self:_setSelectedIndex(a,false)
return true
end
elseif a=="mouse_scroll"then
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
elseif a=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==t.up then
self:_moveSelection(-1)
return true
elseif e==t.down then
self:_moveSelection(1)
return true
elseif e==t.pageUp then
self:_moveSelection(-self:_getInnerHeight())
return true
elseif e==t.pageDown then
self:_moveSelection(self:_getInnerHeight())
return true
elseif e==t.home then
self:_setSelectedIndex(1,false)
return true
elseif e==t["end"]then
self:_setSelectedIndex(#self._flatNodes,false)
return true
elseif e==t.left then
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
elseif e==t.right then
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
elseif e==t.enter or e==t.space then
local e=self.selectedNode
if e and e.children and#e.children>0 then
self:_toggleNode(e,nil)
else
self:_notifySelect()
end
return true
end
elseif a=="char"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
elseif a=="paste"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
end
return false
end
local function j(e,a,t)
if e<a then
return a
end
if e>t then
return t
end
return e
end
local function T(r,a,t,s,n,o)
if not r then
return
end
o=o or e.white
local h=math.abs(s-a)
local l=a<s and 1 or-1
local i=-math.abs(n-t)
local d=t<n and 1 or-1
local e=h+i
while true do
r.pixel(a,t,o)
if a==s and t==n then
break
end
local o=2*e
if o>=i then
e=e+i
a=a+l
end
if o<=h then
e=e+h
t=t+d
end
end
end
function d:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 8))
o.width=math.max(6,math.floor(o.width or 18))
local a=setmetatable({},d)
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
function d:_emitSelect()
if self.onSelect then
local e=self.selectedIndex
local t=e and self.data[e]or nil
self.onSelect(self,e,t)
end
end
function d:_clampSelection(a)
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
function d:setData(e)
a(1,e,"table")
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
function d:getData()
return self.data
end
function d:setLabels(e)
if e==nil then
self.labels={}
return
end
a(1,e,"table")
local t={}
for a=1,#e do
local e=e[a]
if e~=nil then
t[a]=tostring(e)
end
end
self.labels=t
end
function d:getLabels()
return self.labels
end
function d:getLabel(e)
if type(e)~="number"then
return nil
end
if not self.labels then
return nil
end
return self.labels[math.floor(e)]
end
function d:setChartType(e)
if e==nil then
return
end
a(1,e,"string")
local e=e:lower()
if e~="bar"and e~="line"then
error("Chart type must be 'bar' or 'line'",2)
end
self.chartType=e
end
function d:setShowAxis(e)
self.showAxis=not not e
end
function d:setShowLabels(e)
self.showLabels=not not e
end
function d:setPlaceholder(e)
if e~=nil then
a(1,e,"string")
end
self.placeholder=e or""
end
function d:setRange(e,t)
if e~=nil then
a(1,e,"number")
end
if t~=nil then
a(2,t,"number")
end
self.minValue=e
self.maxValue=t
end
function d:setRangePadding(e)
a(1,e,"number")
if e<0 then
e=0
end
self.rangePadding=e
end
function d:setOnSelect(e)
if e~=nil then
a(1,e,"function")
end
self.onSelect=e
end
function d:setSelectedIndex(e,o)
if e==nil then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not o then
self:_emitSelect()
end
end
return false
end
a(1,e,"number")
local t=#self.data
if t==0 then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not o then
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
if not o then
self:_emitSelect()
end
return true
end
function d:getSelectedIndex()
return self.selectedIndex
end
function d:getSelectedValue()
local e=self.selectedIndex
if not e then
return nil
end
return self.data[e]
end
function d:onFocusChanged(e)
if e then
self:_clampSelection(true)
end
end
function d:_indexFromPoint(t)
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
function d:_moveSelection(a)
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
function d:draw(r,p)
if not self.visible then
return
end
local i,a,s,h=self:getAbsoluteRect()
local o=self.bg or e.black
local w=self.fg or e.white
u(r,i,a,s,h,o,o)
q(r,i,a,s,h)
if self.border then
g(p,i,a,s,h,self.border,o)
end
local t=self.border
local n=(t and t.thickness)or 0
local d=(t and t.left)and n or 0
local c=(t and t.right)and n or 0
local l=(t and t.top)and n or 0
local t=(t and t.bottom)and n or 0
local n=i+d
local y=a+l
local a=math.max(0,s-d-c)
local t=math.max(0,h-l-t)
self._lastLayout=nil
if a<=0 or t<=0 then
return
end
local h=#self.data
if h==0 then
local i=self.placeholder or""
if i~=""then
local i=i
if#i>a then
i=i:sub(1,a)
end
local a=n+math.floor((a-#i)/2)
if a<n then
a=n
end
local t=y+math.floor((t-1)/2)
r.text(a,t,i,e.lightGray,o)
end
return
end
local i=(self.showLabels and t>=2)and 1 or 0
local s=(self.showAxis and(t-i)>=2)and 1 or 0
local d=t-s-i
if d<1 then
d=t
s=0
i=0
end
local m=y
local c=m+d-1
local f=s>0 and(c+1)or nil
local l
if i>0 then
if f then
l=f+1
else
l=c+1
end
if l>y+t-1 then
l=y+t-1
end
end
local t=math.huge
local i=-math.huge
for e=1,h do
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
local s=type(self.maxValue)=="number"and self.maxValue or i
if s==t then
s=s+1
t=t-1
end
local i=s-t
if i<=0 then
i=1
s=t+i
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
i=s-t
if i<=0 then
i=1
s=t+i
end
end
local s={}
for o=1,h do
local t=n+math.floor((o-1)*a/h)
local e=n+math.floor(o*a/h)-1
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
for a=1,h do
local o=self.data[a]or 0
local e=0
if i>0 then
e=(o-t)/i
end
e=j(e,0,1)
local e=math.floor(e*d+.5)
if d>0 and e<=0 and o>t then
e=1
end
if e>d then
e=d
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
u(r,s[a].left,o,s[a].width,e,t,t)
end
else
local a={}
for o=1,h do
local n=self.data[o]or 0
local e=0
if i>0 then
e=(n-t)/i
end
e=j(e,0,1)
local t=math.max(d-1,0)
local e=c-math.floor(e*t+.5)
if e<m then
e=m
end
if e>c then
e=c
end
a[o]={x=s[o].center,y=e}
end
for e=2,#a do
local t=a[e-1]
local e=a[e]
T(p,t.x,t.y,e.x,e.y,self.lineColor or w)
end
for i=1,#a do
local t=a[i]
local a=self.lineColor or w
local n="o"
if self.selectedIndex==i then
a=self.highlightColor or e.orange
n="O"
end
r.text(t.x,t.y,n,a,o)
end
end
if f then
u(r,n,f,a,1,o,o)
local e=string.rep("-",a)
r.text(n,f,e,self.axisColor or w,o)
end
if l then
u(r,n,l,a,1,o,o)
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
local e=(self.selectedIndex==n)and(self.highlightColor or e.orange)or(self.axisColor or w)
r.text(i,l,t,e,o)
end
end
end
self._lastLayout={
innerX=n,
innerWidth=a,
dataCount=h,
bars=s
}
end
function d:handleEvent(e,...)
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
if e==t.left then
self:_moveSelection(-1)
return true
elseif e==t.right then
self:_moveSelection(1)
return true
elseif e==t.home then
self:setSelectedIndex(1,false)
return true
elseif e==t["end"]then
local e=#self.data
if e>0 then
self:setSelectedIndex(e,false)
end
return true
elseif e==t.enter or e==t.space then
self:_emitSelect()
return true
end
end
return false
end
function l:new(i,a)
a=a or{}
local o=o(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local t=setmetatable({},l)
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
t.border=E(true)
end
t:_normalizeSelection(true)
return t
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
function l:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function l:_ensureSelectionVisible()
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
function l:_normalizeSelection(t)
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
function l:getItems()
local t={}
for e=1,#self.items do
t[e]=self.items[e]
end
return t
end
function l:setItems(t)
a(1,t,"table")
local e={}
for a=1,#t do
local t=t[a]
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
function l:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function l:setSelectedIndex(e,t)
if#self.items==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
a(1,e,"number")
e=math.floor(e)
if e<1 then
e=1
elseif e>#self.items then
e=#self.items
end
if self.selectedIndex~=e then
self.selectedIndex=e
self:_ensureSelectionVisible()
if not t then
self:_notifySelect()
end
else
self:_ensureSelectionVisible()
end
end
function l:getSelectedIndex()
return self.selectedIndex
end
function l:setOnSelect(e)
if e~=nil then
a(1,e,"function")
end
self.onSelect=e
end
function l:setPlaceholder(e)
if e~=nil then
a(1,e,"string")
end
self.placeholder=e
end
function l:setHighlightColors(e,t)
if e~=nil then
a(1,e,"number")
self.highlightBg=e
end
if t~=nil then
a(2,t,"number")
self.highlightFg=t
end
end
function l:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function l:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function l:_itemIndexFromPoint(t,e)
if not self:containsPoint(t,e)then
return nil
end
local o,h=self:getAbsoluteRect()
local a,r,s,r,n,i=self:_getInnerMetrics()
if n<=0 or i<=0 then
return nil
end
local o=o+a
local a=h+s
if t<o or t>=o+n then
return nil
end
if e<a or e>=a+i then
return nil
end
local e=e-a
local e=self.scrollOffset+e
if e<1 or e>#self.items then
return nil
end
return e
end
function l:_moveSelection(t)
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
function l:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
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
local a=_.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function l:_searchForPrefix(e)
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
function l:draw(o,h)
if not self.visible then
return
end
local a,i,s,t=self:getAbsoluteRect()
local n=self.bg or e.black
local r=self.fg or e.white
u(o,a,i,s,t,n,n)
q(o,a,i,s,t)
if self.border then
g(h,a,i,s,t,self.border,n)
end
local h,l,d,l,t,s=self:_getInnerMetrics()
if t<=0 or s<=0 then
return
end
local a=a+h
local h=i+d
local d=#self.items
local n=n
local l=self.highlightBg or e.lightGray
local u=self.highlightFg or e.black
if d==0 then
for e=0,s-1 do
o.text(a,h+e,string.rep(" ",t),r,n)
end
local i=self.placeholder
if type(i)=="string"and#i>0 then
local i=i
if#i>t then
i=i:sub(1,t)
end
local t=a+math.floor((t-#i)/2)
if t<a then
t=a
end
o.text(t,h,i,e.lightGray,n)
end
return
end
for e=0,s-1 do
local s=h+e
local i=self.scrollOffset+e
if i>d then
o.text(a,s,string.rep(" ",t),r,n)
else
local e=self.items[i]or""
if#e>t then
e=e:sub(1,t)
end
local e=e
if#e<t then
e=e..string.rep(" ",t-#e)
end
local t=n
local n=r
if i==self.selectedIndex then
t=l
n=u
end
o.text(a,s,e,n,t)
end
end
end
function l:handleEvent(a,...)
if not self.visible then
return false
end
if a=="mouse_click"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e=self:_itemIndexFromPoint(t,e)
if e then
self:setSelectedIndex(e)
end
return true
end
elseif a=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
local e=self:_itemIndexFromPoint(e,t)
if e then
self:setSelectedIndex(e)
end
return true
end
elseif a=="mouse_scroll"then
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
elseif a=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==t.up then
self:_moveSelection(-1)
return true
elseif e==t.down then
self:_moveSelection(1)
return true
elseif e==t.pageUp then
self:_moveSelection(-self:_getInnerHeight())
return true
elseif e==t.pageDown then
self:_moveSelection(self:_getInnerHeight())
return true
elseif e==t.home then
if#self.items>0 then
self:setSelectedIndex(1)
end
return true
elseif e==t["end"]then
if#self.items>0 then
self:setSelectedIndex(#self.items)
end
return true
elseif e==t.enter or e==t.space then
self:_notifySelect()
return true
end
elseif a=="char"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
elseif a=="paste"then
local e=...
if self:isFocused()and e and#e>0 then
self:_handleTypeSearch(e:sub(1,1))
return true
end
end
return false
end
function y:new(i,t)
t=t or{}
local o=o(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},y)
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
a.border=E(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function y:_normalizeSelection()
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
function y:setItems(t)
a(1,t,"table")
local e={}
for a=1,#t do
local t=t[a]
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
function y:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function y:setSelectedIndex(e,t)
if e==nil then
return
end
a(1,e,"number")
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
if not t then
self:_notifyChange()
end
end
if self._open then
self._hoverIndex=self.selectedIndex
end
end
function y:setOnChange(e)
if e~=nil then
a(1,e,"function")
end
self.onChange=e
end
function y:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function y:_setOpen(e)
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
function y:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function y:_isPointInDropdown(o,t)
if not self._open or#self.items==0 then
return false
end
local a,e,n,i=self:getAbsoluteRect()
local e=e+i
return o>=a and o<a+n and t>=e and t<e+#self.items
end
function y:_indexFromPoint(t,e)
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
function y:_handlePress(t,e)
local i,i,o,a=self:getAbsoluteRect()
if o<=0 or a<=0 then
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
function y:draw(n,h)
if not self.visible then
return
end
local i,t,o,s=self:getAbsoluteRect()
local a=self.bg or e.black
local l=self.fg or e.white
u(n,i,t,o,s,a,a)
q(n,i,t,o,s)
if self.border then
g(h,i,t,o,s,self.border,a)
end
local e=self.border
local h=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local r=i+h
local h=math.max(0,o-h-u)
local u=t+d
local e=math.max(0,s-d-e)
local s=h>0 and 1 or 0
local i=math.max(0,h-s)
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
n.text(r,o,e,l,a)
end
if s>0 then
local t=self._open and string.char(30)or string.char(31)
local e=r+h-1
n.text(e,o,t,l,a)
end
end
function y:_drawDropdown(s,c)
if not self._open or#self.items==0 or self.visible==false then
return
end
local t,e,i,a=self:getAbsoluteRect()
local a=e+a
local d=#self.items
local e=self.border
local n=(e and e.left)and 1 or 0
local h=(e and e.right)and 1 or 0
local l=t+n
local n=math.max(0,i-n-h)
local r=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local h=d+e
u(s,t,a,i,h,self.dropdownBg,self.dropdownBg)
q(s,t,a,i,h)
for e=1,d do
local t=a+e-1
local a=self.items[e]or""
local e=r~=nil and r==e
local o=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local i=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if n>0 then
local e=a
if#e>n then
e=e:sub(1,n)
end
local a=math.max(0,n-#e)
local e=e..string.rep(" ",a)
s.text(l,t,e,i,o)
end
end
if self.border then
local e=o(self.border)
if e then
e.top=false
g(c,t,a,i,h,e,self.dropdownBg)
end
end
end
function y:handleEvent(a,...)
if not self.visible then
return false
end
if a=="mouse_click"then
local a,e,t=...
return self:_handlePress(e,t)
elseif a=="monitor_touch"then
local a,e,t=...
return self:_handlePress(e,t)
elseif a=="mouse_scroll"then
local a,e,t=...
if self:containsPoint(e,t)or self:_isPointInDropdown(e,t)then
self.app:setFocus(self)
if a>0 then
self:setSelectedIndex(self.selectedIndex+1)
elseif a<0 then
self:setSelectedIndex(self.selectedIndex-1)
end
return true
end
elseif a=="mouse_move"then
local e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
end
elseif a=="mouse_drag"then
local a,e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
end
elseif a=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==t.down then
self:setSelectedIndex(self.selectedIndex+1)
return true
elseif e==t.up then
self:setSelectedIndex(self.selectedIndex-1)
return true
elseif e==t.home then
self:setSelectedIndex(1)
return true
elseif e==t["end"]then
self:setSelectedIndex(#self.items)
return true
elseif e==t.enter or e==t.space then
if self._open then
self:_setOpen(false)
else
self:_setOpen(true)
end
return true
elseif e==t.escape then
if self._open then
self:_setOpen(false)
return true
end
end
elseif a=="char"then
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
setmetatable(o,{__index=r})
local O={
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
local N={
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
local function I(t)
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
local function j(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function T(a,e,t,o)
if a<t then
return-1
end
if a>t then
return 1
end
if e<o then
return-1
end
if e>o then
return 1
end
return 0
end
local function C(e,t,o,a,i,n)
if T(e,t,o,a)<0 then
return false
end
if T(e,t,i,n)>=0 then
return false
end
return true
end
local function M(a)
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
keywords=O,
builtins=N,
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
t.keywords=t.keywords or O
t.builtins=t.builtins or N
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
t.syntax=M(a.syntax)
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
t.border=E(true)
end
t:_setTextInternal(a.text or"",true,true)
if a.cursorPos then
t:_moveCursorToIndex(a.cursorPos)
end
t:_ensureCursorVisible()
return t
end
function o:setOnCursorMove(e)
if e~=nil then
a(1,e,"function")
end
self.onCursorMove=e
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
function o:_setTextInternal(e,t,a)
e=tostring(e or"")
e=self:_applyMaxLength(e)
self._lines=I(e)
self:_syncTextFromLines()
if t then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=j(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=j(self._cursorCol,1,#e+1)
end
self._preferredCol=self._cursorCol
self._selectionAnchor=nil
self:_ensureCursorVisible()
if not a then
self:_notifyChange()
self:_notifyCursorChange()
end
end
function o:_indexToPosition(e)
e=j(e or 1,1,#self.text+1)
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
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n,i=self:getAbsoluteRect()
local s=n+a
local n=i+t
local i=math.max(0,self.width-a-o)
local o=math.max(0,self.height-t-e)
return s,n,i,o,a,t,e
end
function o:_getOverlayHeight(e)
if not self._find.visible then
return 0
end
return math.min(2,e)
end
function o:_getContentSize()
local a,a,t,e=self:_getInnerMetrics()
if t<=0 or e<=0 then
return math.max(1,self.width),math.max(1,self.height)
end
local a=self:_getOverlayHeight(e)
local e=math.max(1,e-a)
return math.max(1,t),e
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
local e=self._scrollX+1
local a=self._scrollX+t
if self._cursorCol<e then
self._scrollX=self._cursorCol-1
elseif self._cursorCol>a then
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
local a,o,e,t=self:_getSelectionRange()
local e=self:_collectRange(a,o,e,t)
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
local e,t=e.line,e.col
local a,o=self._cursorLine,self._cursorCol
if T(e,t,a,o)<=0 then
return e,t,a,o
else
return a,o,e,t
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
function o:_removeRange(e,o,t,a)
if e==t then
local t=self._lines[e]
self._lines[e]=t:sub(1,o-1)..t:sub(a)
else
local o=self._lines[e]:sub(1,o-1)
local a=self._lines[t]:sub(a)
for e=t,e+1,-1 do
table.remove(self._lines,e)
end
self._lines[e]=o..a
end
if#self._lines==0 then
self._lines[1]=""
end
end
function o:_insertAt(e,t,a)
if a==nil or a==""then
return e,t
end
local a=I(a)
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
t=j(t,1,#self._lines)
local o=self._lines[t]or""
a=j(a,1,#o+1)
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
function o:_moveCursorVertical(e,a)
local e=j(self._cursorLine+e,1,#self._lines)
local t=self._lines[e]or""
local t=j(self._preferredCol,1,#t+1)
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
self._scrollY=j(self._scrollY+e,0,t)
end
function o:_scrollColumns(e)
if e==0 then
return
end
local t=select(1,self:_getContentSize())
local a=self._lines[self._cursorLine]or""
local t=math.max(0,#a-t)
self._scrollX=j(self._scrollX+e,0,t)
end
function o:_cursorFromPoint(n,o)
local r,d=self:getAbsoluteRect()
local s,h,e,t=self:_getInnerMetrics()
local a=self:_getOverlayHeight(t)
local i=math.max(1,t-a)
local a=e>0 and s or r
local t=t>0 and h or d
local a=j(n-a,0,math.max(0,(e>0 and e or self.width)-1))
local e=j(o-t,0,i-1)
local e=j(self._scrollY+e+1,1,#self._lines)
local t=self._lines[e]or""
local t=j(self._scrollX+a+1,1,#t+1)
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
local function j(t,a,o,i)
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
function o:_buildLineSegments(n,i,r,h,t)
local a=self._lines[n]or""
local o=self:_computeSyntaxColors(a)
local e=self._scrollX+1
local s={}
for i=0,i-1 do
local e=e+i
local i
if e<=#a then
i=a:sub(e,e)
else
i=" "
end
local o=o and o[e]or r
local a=h
if t and C(n,e,t.startLine,t.startCol,t.endLine,t.endCol)then
a=self.selectionBg
o=self.selectionFg
end
j(s,i,o,a)
end
return s,a,o
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
local c=self.overlayActiveBg or e.orange
local u=self.overlayActiveFg or e.black
local i=n+i-o
for e=0,o-1 do
h.text(a,i+e,string.rep(" ",t),r,d)
end
local e=self._find
local n=#e.matches
local s=n>0 and string.format("%d/%d",math.max(1,e.index),n)or"0/0"
local n=e.matchCase and"CASE"or"case"
local s=string.format("Find: %s  %s  %s",e.findText,s,n)
local n="Replace: "..e.replaceText
local s=s
if#s>t then
s=s:sub(1,t)
end
local n=n
if#n>t then
n=n:sub(1,t)
end
h.text(a,i,s..string.rep(" ",math.max(0,t-#s)),r,d)
h.text(a,i+math.max(o-1,0),n..string.rep(" ",math.max(0,t-#n)),r,d)
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
h.text(a,i+o-1,e..string.rep(" ",math.max(0,t-#e)),r,d)
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
if T(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
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
function o:_handleKey(e,a)
if self._find.visible then
if e==t.tab then
self:_toggleFindField()
return true
elseif e==t.backspace then
return self:_handleOverlayBackspace()
elseif e==t.enter then
if self._find.activeField=="find"then
self:_gotoNextMatch()
else
self:_replaceCurrentMatch()
end
return true
elseif e==t.delete then
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
if e==t.a then
self:_selectAll()
return true
elseif e==t.f then
self:_toggleFindOverlay("find")
return true
elseif e==t.h then
self:_toggleFindOverlay("replace")
return true
elseif e==t.g then
if self._shiftDown then
self:_gotoPreviousMatch()
else
self:_gotoNextMatch()
end
return true
elseif e==t.space then
self:_updateAutocomplete("manual")
return true
elseif e==t.r and self._shiftDown then
self:_replaceAll()
return true
elseif e==t.f and self._shiftDown then
local e=self._find
e.matchCase=not e.matchCase
self:_updateFindMatches(true)
return true
end
end
if self._autocompleteState.visible then
if e==t.enter or e==t.tab then
return self:_acceptAutocomplete()
elseif e==t.up then
self:_moveAutocompleteSelection(-1)
return true
elseif e==t.down then
self:_moveAutocompleteSelection(1)
return true
elseif e==t.escape then
self:_hideAutocomplete()
return true
end
end
if e==t.left then
self:_moveCursorLeft(self._shiftDown)
return true
elseif e==t.right then
self:_moveCursorRight(self._shiftDown)
return true
elseif e==t.up then
self:_moveCursorUp(self._shiftDown)
return true
elseif e==t.down then
self:_moveCursorDown(self._shiftDown)
return true
elseif e==t.home then
if self._ctrlDown then
self:_moveCursorDocumentStart(self._shiftDown)
else
self:_moveCursorLineStart(self._shiftDown)
end
return true
elseif e==t["end"]then
if self._ctrlDown then
self:_moveCursorDocumentEnd(self._shiftDown)
else
self:_moveCursorLineEnd(self._shiftDown)
end
return true
elseif e==t.backspace then
return self:_deleteBackward()
elseif e==t.delete then
return self:_deleteForward()
elseif e==t.enter then
return self:_insertNewline()
elseif e==t.tab then
return self:_insertTab()
elseif e==t.pageUp then
self:_scrollLines(-math.max(1,select(2,self:_getContentSize())-1))
return true
elseif e==t.pageDown then
self:_scrollLines(math.max(1,select(2,self:_getContentSize())-1))
return true
elseif e==t.escape then
return self:_handleEscape()
end
return false
end
function o:draw(i,p)
if not self.visible then
return
end
local c,l,m,r=self:getAbsoluteRect()
local d=self.bg or e.black
local f=self.fg or e.white
u(i,c,l,m,r,d,d)
q(i,c,l,m,r)
local n,u,a,h=self:_getInnerMetrics()
if a<=0 or h<=0 then
n=c
u=l
a=m
h=r
end
local t=self:_getOverlayHeight(h)
local o=math.max(1,h-t)
local y
local w=false
if self:_hasSelection()then
local e,o,t,a=self:_getSelectionRange()
y={
startLine=e,
startCol=o,
endLine=t,
endCol=a
}
w=true
end
local t=self._autocompleteState
local s=d
for h=0,o-1 do
local o=self._scrollY+h+1
local h=u+h
if o>#self._lines then
i.text(n,h,string.rep(" ",a),f,s)
else
local r,d,l=self:_buildLineSegments(o,a,f,s,y)
self:_drawSegments(i,n,h,r)
if self:isFocused()and o==self._cursorLine then
local t=self._cursorCol-self._scrollX-1
if t>=0 and t<a then
local e
if self._cursorCol<=#d then
e=d:sub(self._cursorCol,self._cursorCol)
else
e=" "
end
local o=s
local a=f
i.text(n+t,h,e,o,a)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not w and o==t.anchorLine then
local r=t.anchorCol+#t.prefix
local o=r-self._scrollX-1
if o<a then
local t=t.ghost
local d=#d
if r<=d then
local e=d-r+1
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
if t~=""and o<a then
local a=a-o
if a>0 then
if#t>a then
t=t:sub(1,a)
end
if t~=""then
i.text(n+o,h,t,self.autocompleteGhostColor or e.lightGray,s)
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
if#t>a then
t=t:sub(1,a)
end
i.text(n,u,t..string.rep(" ",math.max(0,a-#t)),e.lightGray,s)
end
self:_drawFindOverlay(i,n,u,a,h)
if self.border then
g(p,c,l,m,r,self.border,d)
end
end
function o:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e,t=self:_cursorFromPoint(t,e)
if a==1 then
self:_setCursorPosition(e,t)
self._dragging=true
self._dragButton=a
self._dragAnchor={line=e,col=t}
elseif a==2 then
self:_setCursorPosition(e,t)
end
return true
end
elseif e=="mouse_drag"then
local e,t,a=...
if self._dragging and e==self._dragButton then
local e,t=self:_cursorFromPoint(t,a)
if not self._selectionAnchor and self._dragAnchor then
self._selectionAnchor={line=self._dragAnchor.line,col=self._dragAnchor.col}
end
self:_setCursorPosition(e,t,{extendSelection=true,keepAutocomplete=true})
return true
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
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
local e,t=self:_cursorFromPoint(e,t)
self:_setCursorPosition(e,t)
return true
end
elseif e=="mouse_scroll"then
local t,e,a=...
if self:containsPoint(e,a)then
self:_scrollLines(t)
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
local e,a=...
if e==t.leftShift or e==t.rightShift then
self._shiftDown=true
return true
elseif e==t.leftCtrl or e==t.rightCtrl then
self._ctrlDown=true
return true
end
if self:isFocused()then
return self:_handleKey(e,a)
end
elseif e=="key_up"then
local e=...
if e==t.leftShift or e==t.rightShift then
self._shiftDown=false
if not self:_hasSelection()then
self:_clearSelection()
end
return true
elseif e==t.leftCtrl or e==t.rightCtrl then
self._ctrlDown=false
return true
elseif e==t.escape then
if self:_handleEscape()then
return true
end
end
end
return false
end
function o:setText(e,t)
a(1,e,"string")
self:_setTextInternal(e,true,t)
end
function o:getText()
return self.text
end
function o:setOnChange(e)
if e~=nil then
a(1,e,"function")
end
self.onChange=e
end
function f.create(t)
if t~=nil then
a(1,t,"table")
end
t=t or{}
local h=false
local n
local a=t.window
if a==nil then
n=S.current()
local e,t=n.getSize()
a=U.create(n,1,1,e,t,true)
a.setVisible(true)
h=true
end
local o=D.new(a)
o.profiler.start_frame()
o.profiler.start_region("user")
local r=o.add_pixel_layer(5,"pixelui_pixels")
local u=o.add_text_layer(10,"pixelui_ui")
local c,d=a.getSize()
local s=t.background or e.black
o.fill(s)
local l=math.max(.01,t.animationInterval or .05)
local a=setmetatable({
window=a,
box=o,
layer=u,
pixelLayer=r,
background=s,
running=false,
_autoWindow=h,
_parentTerminal=n,
_focusWidget=nil,
_popupWidgets={},
_popupLookup={},
_animations={},
_animationTimer=nil,
_animationInterval=l,
_radioGroups={},
_threads={},
_threadTimers={},
_threadTicker=nil,
_threadIdCounter=0
},i)
a.root=k:new(a,{
x=1,
y=1,
width=c,
height=d,
bg=s,
fg=e.white,
border=t.rootBorder,
z=-math.huge
})
return a
end
function i:getRoot()
return self.root
end
function i:setBackground(e)
a(1,e,"number")
self.background=e
self.box.fill(e)
end
function i:getLayer()
return self.layer
end
function i:getPixelLayer()
return self.pixelLayer
end
function i:createFrame(e)
return k:new(self,e)
end
function i:createButton(e)
return z:new(self,e)
end
function i:createLabel(e)
return b:new(self,e)
end
function i:createCheckBox(e)
return p:new(self,e)
end
function i:createToggle(e)
return v:new(self,e)
end
function i:createTextBox(e)
return o:new(self,e)
end
function i:createComboBox(e)
return y:new(self,e)
end
function i:createList(e)
return l:new(self,e)
end
function i:createTable(e)
return n:new(self,e)
end
function i:createTreeView(e)
return h:new(self,e)
end
function i:createChart(e)
return d:new(self,e)
end
function i:createRadioButton(e)
return m:new(self,e)
end
function i:createProgressBar(e)
return c:new(self,e)
end
function i:createSlider(e)
return s:new(self,e)
end
function i:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=_.startTimer(self._animationInterval)
end
end
function i:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=_.clock()
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
function i:_clearAnimations(t)
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
function i:animate(e)
a(1,e,"table")
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
t=A.linear
elseif type(t)=="string"then
t=A[t]
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
local u="running"
local j="completed"
local q="error"
local g="cancelled"
local T={}
local function E(e,a,...)
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
function w:getId()
return self.id
end
function w:getName()
return self.name
end
function w:setName(e)
a(1,e,"string")
self.name=e
end
function w:getStatus()
return self.status
end
function w:isRunning()
return self.status==u
end
function w:isFinished()
local e=self.status
return e==j or e==q or e==g
end
function w:isCancelled()
return self._cancelRequested or self.status==g
end
function w:cancel()
if self.status~=u then
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
function w:getResult()
if not self.result then
return nil
end
return R(self.result,1,self.result.n or#self.result)
end
function w:getResults()
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
function w:getError()
return self.error
end
function w:setMetadata(e,t)
a(1,e,"string")
local a=self.metadata[e]
if a==t then
return
end
self.metadata[e]=t
self:_emitMetadata(e,t)
end
function w:getMetadata(e)
a(1,e,"string")
return self.metadata[e]
end
function w:getAllMetadata()
local e={}
for t,a in pairs(self.metadata)do
e[t]=a
end
return e
end
function w:onStatusChange(e)
if e==nil then
return
end
a(1,e,"function")
local t=self._statusListeners
t[#t+1]=e
local e,t=pcall(e,self,self.status)
if not e then
print("Thread status listener error: "..tostring(t))
end
end
function w:onMetadataChange(e)
if e==nil then
return
end
a(1,e,"function")
local t=self._metadataListeners
t[#t+1]=e
for t,a in pairs(self.metadata)do
local t,e=pcall(e,self,t,a)
if not t then
print("Thread metadata listener error: "..tostring(e))
end
end
end
function w:_emitMetadata(e,t)
E(self._metadataListeners,"Thread metadata listener error: ",self,e,t)
end
function w:_setStatus(e)
if self.status==e then
return
end
self.status=e
E(self._statusListeners,"Thread status listener error: ",self,e)
end
local function E(e)
return setmetatable({_handle=e},x)
end
function x:checkCancelled()
if self._handle._cancelRequested then
error(T,0)
end
end
function x:isCancelled()
return self._handle._cancelRequested==true
end
function x:sleep(t)
if t~=nil then
a(1,t,"number")
else
t=0
end
if t<0 then
t=0
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
local a=_.startTimer(t)
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
function x:yield()
self:checkCancelled()
self._handle.waiting="yield"
return coroutine.yield("yield")
end
function x:setMetadata(e,t)
self._handle:setMetadata(e,t)
end
function x:setStatus(e)
self._handle:setMetadata("status",e)
end
function x:setDetail(e)
self._handle:setMetadata("detail",e)
end
function x:setProgress(e)
if e~=nil then
a(1,e,"number")
end
self._handle:setMetadata("progress",e)
end
function x:getHandle()
return self._handle
end
function i:_ensureThreadPump()
if not self._threads or self._threadTicker then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==u and e._ready then
self._threadTicker=_.startTimer(0)
return
end
end
end
function i:_cleanupThread(e)
if e.timerId and self._threadTimers then
self._threadTimers[e.timerId]=nil
e.timerId=nil
end
e.waiting=nil
e._ready=false
e._resumeValue=nil
end
function i:_resumeThread(e)
if e.status~=u then
return
end
if e._cancelRequested then
e:_setStatus(g)
self:_cleanupThread(e)
return
end
local t=e._resumeValue
e._resumeValue=nil
local a=H(coroutine.resume(e.co,t))
local t=a[1]
if not t then
local t=a[2]
if t==T then
e:_setStatus(g)
else
if type(t)=="string"and debug and debug.traceback then
t=debug.traceback(e.co,t)
end
e.error=t
print("PixelUI thread error: "..tostring(t))
e:_setStatus(q)
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
function i:_serviceThreads()
if not self._threads or#self._threads==0 then
return
end
local t={}
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==u and e._ready then
e._ready=false
t[#t+1]=e
end
end
for e=1,#t do
self:_resumeThread(t[e])
end
self:_ensureThreadPump()
end
function i:_shutdownThreads()
if not self._threads then
return
end
for e=1,#self._threads do
local e=self._threads[e]
if e and e.status==u then
e._cancelRequested=true
e:_setStatus(g)
self:_cleanupThread(e)
end
end
self._threadTimers={}
self._threadTicker=nil
end
function i:spawnThread(o,e)
a(1,o,"function")
if e~=nil then
a(2,e,"table")
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
local a=e.name or("Thread "..tostring(t))
local t=setmetatable({
app=self,
id=t,
name=a,
status=u,
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
},w)
local a=coroutine.create(function()
local e=E(t)
t._context=e
local e=H(o(e,self))
return R(e,1,e.n)
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
function i:getThreads()
local e={}
if not self._threads then
return e
end
for t=1,#self._threads do
e[t]=self._threads[t]
end
return e
end
function i:_registerPopup(e)
if not e then
return
end
local t=self._popupLookup
if not t[e]then
t[e]=true
table.insert(self._popupWidgets,e)
end
end
function i:_unregisterPopup(e)
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
function i:_drawPopups()
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
function i:_registerRadioButton(e)
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
function i:_unregisterRadioButton(t)
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
function i:_selectRadioInGroup(o,t,a)
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
function i:setFocus(e)
if e~=nil then
a(1,e,"table")
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
function i:getFocus()
return self._focusWidget
end
function i:render()
self.box.fill(self.background)
self.pixelLayer.clear()
self.layer.clear()
self.root:draw(self.layer,self.pixelLayer)
self:_drawPopups()
self.box.render()
end
function i:step(e,...)
if not e then
return
end
local t=false
if e=="timer"then
local a=...
if self._threadTicker and a==self._threadTicker then
self._threadTicker=nil
self:_serviceThreads()
t=true
end
local o=self._threadTimers
if o then
local e=o[a]
if e then
o[a]=nil
if e.status==u and e.timerId==a then
e.timerId=nil
e.waiting=nil
e._ready=true
e._resumeValue=true
end
t=true
end
end
if self._animationTimer and a==self._animationTimer then
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
local e=self._parentTerminal or S.current()
local t,e=e.getSize()
if self.window.reposition then
self.window.reposition(1,1,t,e)
end
end
local e,t=self.window.getSize()
self.root:setSize(e,t)
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
function i:run()
self.running=true
self:render()
while self.running do
local e={L()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
self:_shutdownThreads()
end
function i:stop()
self.running=false
self:_clearAnimations(true)
self:_shutdownThreads()
end
f.widgets={
Frame=function(t,e)
return k:new(t,e)
end,
Button=function(t,e)
return z:new(t,e)
end,
Label=function(e,t)
return b:new(e,t)
end,
CheckBox=function(e,t)
return p:new(e,t)
end,
Toggle=function(t,e)
return v:new(t,e)
end,
TextBox=function(e,t)
return o:new(e,t)
end,
ComboBox=function(e,t)
return y:new(e,t)
end,
List=function(e,t)
return l:new(e,t)
end,
Table=function(e,t)
return n:new(e,t)
end,
TreeView=function(t,e)
return h:new(t,e)
end,
Chart=function(t,e)
return d:new(t,e)
end,
RadioButton=function(t,e)
return m:new(t,e)
end,
ProgressBar=function(e,t)
return c:new(e,t)
end,
Slider=function(t,e)
return s:new(t,e)
end
}
f.Widget=r
f.Frame=k
f.Button=z
f.Label=b
f.CheckBox=p
f.Toggle=v
f.TextBox=o
f.ComboBox=y
f.List=l
f.Table=n
f.TreeView=h
f.Chart=d
f.RadioButton=m
f.ProgressBar=c
f.Slider=s
f.easings=A
f.ThreadHandle=w
f.ThreadContext=x
f.threadStatus={
running=u,
completed=j,
error=q,
cancelled=g
}
return f
