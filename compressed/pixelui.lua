local _=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local j=assert(rawget(_G,"os"),"os API unavailable")
local O=assert(j.pullEvent,"os.pullEvent unavailable")
local I=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local t=require("cc.expect").expect
local T=require("shrekbox")
local p={
version="0.1.0"
}
local x={
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
local k={}
k.__index=k
setmetatable(k,{__index=s})
local y={}
y.__index=y
setmetatable(y,{__index=s})
local f={}
f.__index=f
setmetatable(f,{__index=s})
local w={}
w.__index=w
setmetatable(w,{__index=s})
local u={}
u.__index=u
setmetatable(u,{__index=s})
local o={}
o.__index=o
setmetatable(o,{__index=s})
local r={}
r.__index=r
setmetatable(r,{__index=s})
local n={}
n.__index=n
setmetatable(n,{__index=s})
local h={}
h.__index=h
setmetatable(h,{__index=s})
local c={}
c.__index=c
setmetatable(c,{__index=s})
local m={}
m.__index=m
setmetatable(m,{__index=s})
local i={}
i.__index=i
local d={"top","right","bottom","left"}
local A=string.char(7)
local function l(e)
if not e then
return nil
end
local t={}
for a,e in pairs(e)do
t[a]=e
end
return t
end
local function z(a,e)
t(nil,a,"string")
t(nil,e,"number")
if e<1 or e~=math.floor(e)then
error(('%s must be a positive integer, got "%s"'):format(a,tostring(e)),3)
end
end
local function q(a)
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
for e=1,#d do
o(d[e],a[d[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function d(a,o,s,t,e,h,n,i)
if t<=0 or e<=0 then
return
end
local i=i or" "
local t=i:rep(t)
for e=0,e-1 do
a.text(o,s+e,t,h,n)
end
end
local function g(e,t,a,o,i)
if o<=0 or i<=0 then
return
end
local n=T.transparent
for o=0,o-1 do
e.pixel(t+o,a,n)
if i>1 then
e.pixel(t+o,a+i-1,n)
end
end
for i=1,math.max(0,i-2)do
e.pixel(t,a+i,n)
if o>1 then
e.pixel(t+o-1,a+i,n)
end
end
end
local function v(d,t,a,i,o,e,s)
if i<=0 or o<=0 then
return
end
local n=e.color
local h=s or n
local t=(t-1)*2+1
local a=(a-1)*3+1
local i=i*2
local o=o*3
local u=3
local l=2
local s=math.min(e.thickness,o)
local r=math.min(e.thickness,i)
local u=math.min(o,math.max(s,u))
local l=math.min(i,math.max(r,l))
local function f(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+o then break end
for a=0,i-1 do
d.pixel(t+a,e,n)
end
end
end
local function m(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+o then break end
for a=0,i-1 do
d.pixel(t+a,e,n)
end
end
end
local function w(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
d.pixel(e,a+t,n)
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
if e.left then
w(t,l,h)
end
if e.right then
w(t+i-l,l,h)
end
if e.top then
f(a,u,h)
end
if e.bottom then
f(a+o-u,u,h)
end
if e.top then
m(a,s,n)
end
if e.bottom then
m(a+o-s,s,n)
end
if e.left then
c(t,r,n)
end
if e.right then
c(t+i-r,r,n)
end
end
local function E(e)
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
self.border=q(a.border)
self.focusable=a.focusable==true
self._focused=false
z("width",self.width)
z("height",self.height)
end
function s:setSize(e,t)
z("width",e)
z("height",t)
self.width=e
self.height=t
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
self.border=q(true)
return
end
t(1,e,"table","boolean")
self.border=q(e)
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
local e,t=E(self)
return e,t,self.width,self.height
end
function s:containsPoint(o,a)
local t,e,n,i=self:getAbsoluteRect()
return o>=t and o<t+n and a>=e and a<e+i
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
return e
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
local function z(a)
local t={}
for e=1,#a do
t[e]=a[e]
end
return t
end
local function E(e)
table.sort(e,function(t,e)
if t.z==e.z then
return(t._orderIndex or 0)<(e._orderIndex or 0)
end
return t.z<e.z
end)
end
function b:getChildren()
return z(self._children)
end
function b:setTitle(e)
if e~=nil then
t(1,e,"string")
end
self.title=e
end
function b:draw(s,l)
if not self.visible then
return
end
local n,a,t,i=self:getAbsoluteRect()
local o=self.bg or self.app.background
local r,u=n+1,a+1
local e=math.max(0,t-2)
local h=math.max(0,i-2)
if e>0 and h>0 then
d(s,r,u,e,h,o,o)
elseif t>0 and i>0 then
d(s,n,a,t,i,o,o)
end
g(s,n,a,t,i)
local h=self.title
if type(h)=="string"and#h>0 then
local t=e>0 and e or t
local n=e>0 and r or n
local a=(i>2)and(a+1)or a
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
v(l,n,a,t,i,self.border,o)
end
local e=z(self._children)
E(e)
for t=1,#e do
e[t]:draw(s,l)
end
end
function b:handleEvent(t,...)
if not self.visible then
return false
end
if s.handleEvent(self,t,...)then
return true
end
local e=z(self._children)
E(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function k:new(a,e)
local t=setmetatable({},k)
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
function k:setLabel(e)
t(1,e,"string")
self.label=e
end
function k:setOnClick(e)
if e~=nil then
t(1,e,"function")
end
self.onClick=e
end
function k:draw(s,c)
if not self.visible then
return
end
local n,i,t,a=self:getAbsoluteRect()
local h=self.bg or e.gray
local o=self.fg or e.white
local e=h
local r=o
if self.clickEffect and self._pressed then
e,r=r,e
end
local l,u=n+1,i+1
local o=math.max(0,t-2)
local h=math.max(0,a-2)
if o>0 and h>0 then
d(s,l,u,o,h,e,e)
else
d(s,n,i,t,a,e,e)
end
g(s,n,i,t,a)
if self.border then
v(c,n,i,t,a,self.border,e)
end
local a=self.label or""
local t=o>0 and o or t
if#a>t then
a=a:sub(1,t)
end
local d=0
if t>#a then
d=math.floor((t-#a)/2)
end
local a=string.rep(" ",d)..a
if#a<t then
a=a..string.rep(" ",t-#a)
end
local o=o>0 and l or n
local t
if h>0 then
t=u+math.floor((h-1)/2)
else
t=i
end
s.text(o,t,a,r,e)
end
function k:handleEvent(e,...)
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
function y:new(o,e)
e=e or{}
local a=l(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},y)
t:_init_base(o,a)
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
function y:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-a)
local i=math.max(0,self.height-t-e)
return o,a,t,e,n,i
end
function y:_wrapLine(t,a,e)
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
function y:_updateLines(e)
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
function y:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function y:getText()
return self.text
end
function y:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function y:isWrapping()
return self.wrap
end
function y:setHorizontalAlign(e)
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
function y:setVerticalAlign(a)
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
function y:setSize(e,t)
s.setSize(self,e,t)
self:_updateLines(true)
end
function y:setBorder(e)
s.setBorder(self,e)
self:_updateLines(true)
end
function y:draw(u,c)
if not self.visible then
return
end
local h,s,l,r=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
local m=self.fg or e.white
d(u,h,s,l,r,n,n)
g(u,h,s,l,r)
local e,o,t,o,a,i=self:_getInnerMetrics()
local o=h+e
local f=s+t
self:_updateLines(false)
local d=self._lines or{""}
local t=#d
if t==0 then
d={""}
t=1
end
if a>0 and i>0 then
local e=math.min(t,i)
local s=1
if t>e then
if self.verticalAlign=="bottom"then
s=t-e+1
elseif self.verticalAlign=="middle"then
s=math.floor((t-e)/2)+1
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
local e=d[s+e]or""
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
u.text(t,i,e,m,n)
end
i=i+1
end
end
if self.border then
v(c,h,s,l,r,self.border,n)
end
end
function f:new(n,t)
t=t or{}
local o=l(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},f)
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
function f:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function f:_setState(t,e,a)
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
function f:setLabel(e)
t(1,e,"string")
self.label=e
end
function f:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function f:setAllowIndeterminate(e)
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
function f:setChecked(e)
t(1,e,"boolean")
self:_setState(e,false,false)
end
function f:isChecked()
return self.checked
end
function f:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
t(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function f:isIndeterminate()
return self.indeterminate
end
function f:toggle()
self:_activate()
end
function f:_activate()
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
function f:draw(r,l)
if not self.visible then
return
end
local s,n,t,i=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local o=a
local h=e
if self:isFocused()then
o=self.focusBg or o
h=self.focusFg or h
end
d(r,s,n,t,i,o,o)
g(r,s,n,t,i)
if self.border then
v(l,s,n,t,i,self.border,o)
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
local t=n+math.floor((i-1)/2)
r.text(s,t,e,h,o)
end
function f:handleEvent(e,...)
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
function w:new(i,t)
t=t or{}
local o=l(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},w)
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
function w:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function w:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function w:setValue(e,t)
e=not not e
if self.value==e then
return
end
self.value=e
if not t then
self:_emitChange()
end
end
function w:isOn()
return self.value
end
function w:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function w:setLabels(a,e)
if a~=nil then
t(1,a,"string")
self.labelOn=a
end
if e~=nil then
t(2,e,"string")
self.labelOff=e
end
end
function w:setShowLabel(e)
self.showLabel=not not e
end
function w:setDisabled(e)
e=not not e
if self.disabled==e then
return
end
self.disabled=e
end
function w:isDisabled()
return self.disabled
end
function w:setColors(n,i,o,a,e)
if n~=nil then
t(1,n,"number")
self.trackColorOn=n
end
if i~=nil then
t(2,i,"number")
self.trackColorOff=i
end
if o~=nil then
t(3,o,"number")
self.thumbColor=o
end
if a~=nil then
t(4,a,"number")
self.onLabelColor=a
end
if e~=nil then
t(5,e,"number")
self.offLabelColor=e
end
end
function w:draw(r,s)
if not self.visible then
return
end
local o,a,n,i=self:getAbsoluteRect()
local t=self.bg or e.black
local c=self.fg or e.white
d(r,o,a,n,i,t,t)
g(r,o,a,n,i)
if self.border then
v(s,o,a,n,i,self.border,t)
end
local t=self.border
local l=(t and t.left)and t.thickness or 0
local w=(t and t.right)and t.thickness or 0
local h=(t and t.top)and t.thickness or 0
local f=(t and t.bottom)and t.thickness or 0
local u=o+l
local m=a+h
local t=math.max(0,n-l-w)
local o=math.max(0,i-h-f)
if t<=0 or o<=0 then
return
end
local a=u
local n=m
local t=t
local i=o
local o=self.trackColorOff or e.gray
local h=self.trackColorOn or e.lightBlue
local u=self.value and h or o
d(r,a,n,t,i,u,u)
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
local l=self.thumbColor or e.white
if self:isFocused()then
l=self.focusBg or l
end
d(r,h,n,o,i,l,l)
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
r.text(e,i,o,s,u)
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
function w:handleEvent(e,...)
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
function c:new(n,a)
a=a or{}
local o=l(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local t=setmetatable({},c)
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
t._dotChar=A
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
function c:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function c:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function c:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function c:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function c:setLabel(e)
t(1,e,"string")
self.label=e
end
function c:setValue(e)
self.value=e
end
function c:getValue()
return self.value
end
function c:setGroup(e)
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
function c:getGroup()
return self.group
end
function c:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function c:setSelected(e)
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
function c:isSelected()
return self.selected
end
function c:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function c:draw(h,r)
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
d(h,i,n,t,o,a,a)
g(h,i,n,t,o)
if self.border then
v(r,i,n,t,o,self.border,a)
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
function c:handleEvent(e,...)
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
function u:new(i,a)
a=a or{}
local o=l(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},u)
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
t.border=q(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
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
function u:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function u:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=x.linear,
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
function u:setRange(a,e)
t(1,a,"number")
t(2,e,"number")
if e<=a then
error("ProgressBar max must be greater than min",2)
end
self.min=a
self.max=e
self.value=self:_clampValue(self.value)
end
function u:getRange()
return self.min,self.max
end
function u:setValue(e)
if self.indeterminate then
return
end
t(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function u:getValue()
return self.value
end
function u:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function u:setIndeterminate(e)
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
function u:isIndeterminate()
return self.indeterminate
end
function u:setLabel(e)
if e~=nil then
t(1,e,"string")
end
self.label=e
end
function u:setShowPercent(e)
self.showPercent=not not e
end
function u:setColors(e,a,o)
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
function u:draw(n,r)
if not self.visible then
return
end
local a,h,t,s=self:getAbsoluteRect()
local i=self.trackColor or(self.bg or e.gray)
local o=self.fillColor or e.lightBlue
local m=self.textColor or(self.fg or e.white)
d(n,a,h,t,s,i,i)
g(n,a,h,t,s)
if self.border then
v(r,a,h,t,s,self.border,i)
end
local e=self.border
local l=(e and e.left)and 1 or 0
local c=(e and e.right)and 1 or 0
local r=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+l
local u=h+r
local t=math.max(0,t-l-c)
local s=math.max(0,s-r-e)
if t<=0 or s<=0 then
return
end
d(n,a,u,t,s,i,i)
local l=0
local r=0
local h=0
if self.indeterminate then
h=math.max(1,math.floor(t/3))
if h>t then
h=t
end
local t=t-h
local e=self._indeterminateProgress or 0
if e<0 then e=0 end
if e>1 then e=1 end
r=math.floor(t*e+.5)
d(n,a+r,u,h,s,o,o)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
d(n,a,u,l,s,o,o)
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
local d=u+math.floor((s-1)/2)
local t=a+math.floor((t-#e)/2)
if t<a then
t=a
end
for s=1,#e do
local u=e:sub(s,s)
local e=(t-a)+(s-1)
local a=i
if self.indeterminate then
if e>=r and e<r+h then
a=o
end
else
if e<l then
a=o
end
end
n.text(t+s-1,d,u,m,a)
end
end
end
function u:handleEvent(e,...)
return false
end
function o:new(n,a)
a=a or{}
local i=l(a)or{}
i.focusable=true
i.height=math.max(1,math.floor(i.height or 3))
i.width=math.max(1,math.floor(i.width or 12))
local t=setmetatable({},o)
t:_init_base(n,i)
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
local o
local e
if a and type(a.value)=="table"then
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
local e=a and a.value
if type(e)~="number"then
e=t.min
end
t.value=t:_applyStep(e)
end
if not t.border then
t.border=q(true)
end
return t
end
function o:_clampValue(e)
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
function o:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function o:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local o,i=self:getAbsoluteRect()
local n=math.max(0,self.width-a-n)
local s=math.max(0,self.height-t-e)
local h=o+a
local o=i+t
return h,o,n,s,a,t,e
end
function o:_valueToPosition(o,t)
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
function o:_positionToValue(e,t)
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
function o:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function o:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function o:_setSingleValue(e,t)
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
function o:setValue(e)
if self.range then
return
end
t(1,e,"number")
self:_setSingleValue(e,false)
end
function o:getValue()
return self.value
end
function o:_setLowerValue(e,t)
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
function o:_setUpperValue(e,t)
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
function o:setRangeValues(a,e,o)
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
function o:getRangeValues()
return self.lowerValue,self.upperValue
end
function o:setRangeLimits(a,e)
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
function o:setStep(e)
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
function o:setShowValue(e)
self.showValue=not not e
end
function o:setColors(e,o,a)
if e~=nil then
t(1,e,"number")
self.trackColor=e
end
if o~=nil then
t(2,o,"number")
self.fillColor=o
end
if a~=nil then
t(3,a,"number")
self.handleColor=a
end
end
function o:_formatNumber(o)
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
function o:_formatDisplayValue()
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
function o:_getStepForNudge(t)
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
function o:_positionFromPoint(e)
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
function o:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local o=self:_valueToPosition(self.lowerValue,a)
local s=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local n=math.abs(t-o)
local i=math.abs(t-s)
if n==i then
if t>s then
e="upper"
elseif t<o then
e="lower"
end
elseif n<i then
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
function o:_updateInteraction(e)
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
function o:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function o:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function o:_nudgeValue(e)
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
function o:onFocusChanged(e)
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
function o:draw(a,f)
if not self.visible then
return
end
local l,u,r,h=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
d(a,l,u,r,h,n,n)
g(a,l,u,r,h)
local i,c,t,s=self:_getInnerMetrics()
if t<=0 or s<=0 then
if self.border then
v(f,l,u,r,h,self.border,n)
end
return
end
local o
local m=nil
if self.showValue and s>=2 then
m=c
o=c+s-1
else
o=c+math.floor((s-1)/2)
end
d(a,i,o,t,1,self.trackColor,self.trackColor)
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
a.text(i+n,o," ",t,t)
end
if self.range then
local e=self:_valueToPosition(self.lowerValue,t)
local t=self:_valueToPosition(self.upperValue,t)
if t<e then
e,t=t,e
end
local n=t-e+1
if n>0 then
d(a,i+e,o,n,1,self.fillColor,self.fillColor)
end
s(e,"lower")
s(t,"upper")
else
local t=self:_valueToPosition(self.value,t)
local e=t+1
if e>0 then
d(a,i,o,e,1,self.fillColor,self.fillColor)
end
s(t,"single")
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
a.text(t,m,o,self.fg or e.white,n)
end
end
if self.border then
v(f,l,u,r,h,self.border,n)
end
end
function o:handleEvent(t,...)
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
function n:new(i,t)
t=t or{}
local o=l(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local a=setmetatable({},n)
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
a.border=q(true)
end
a:setNodes((t and t.nodes)or{})
return a
end
function n:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function n:setOnToggle(e)
if e~=nil then
t(1,e,"function")
end
self.onToggle=e
end
function n:_copyNodes(e,i)
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
function n:setNodes(e)
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
function n:getSelectedNode()
return self.selectedNode
end
function n:setSelectedNode(e)
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
function n:expandNode(e)
self:_toggleNode(e,true)
end
function n:collapseNode(e)
self:_toggleNode(e,false)
end
function n:toggleNode(e)
self:_toggleNode(e,nil)
end
function n:_rebuildFlatNodes()
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
function n:_findVisibleIndex(a)
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
function n:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-t-o)
local i=math.max(0,self.height-a-e)
return t,o,a,e,n,i
end
function n:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function n:_ensureSelectionVisible()
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
function n:_setSelectedIndex(e,a)
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
function n:_selectNode(t,a)
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
function n:_moveSelection(a)
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
function n:_scrollBy(e)
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
function n:_rowFromPoint(i,e)
if not self:containsPoint(i,e)then
return nil
end
local a,h=self:getAbsoluteRect()
local o,r,s,r,t,n=self:_getInnerMetrics()
if t<=0 or n<=0 then
return nil
end
local o=a+o
local a=h+s
if i<o or i>=o+t then
return nil
end
if e<a or e>=a+n then
return nil
end
local e=e-a
local e=self.scrollOffset+e
if e<1 or e>#self._flatNodes then
return nil
end
return e,o,t
end
function n:_toggleNode(e,a)
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
function n:_notifySelect()
if self.onSelect then
self.onSelect(self,self.selectedNode,self._selectedIndex)
end
end
function n:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function n:_searchForPrefix(e)
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
function n:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=j.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function n:draw(n,h)
if not self.visible then
return
end
local t,a,s,o=self:getAbsoluteRect()
local i=self.bg or e.black
local l=self.fg or e.white
d(n,t,a,s,o,i,i)
g(n,t,a,s,o)
if self.border then
v(h,t,a,s,o,self.border,i)
end
local s,d,r,d,o,h=self:_getInnerMetrics()
if o<=0 or h<=0 then
return
end
local s=t+s
local r=a+r
local m=self._flatNodes
local c=#m
if c==0 then
for e=0,h-1 do
n.text(s,r+e,string.rep(" ",o),l,i)
end
local t=self.placeholder
if type(t)=="string"and#t>0 then
local t=t
if#t>o then
t=t:sub(1,o)
end
local a=s+math.floor((o-#t)/2)
if a<s then
a=s
end
n.text(a,r,t,e.lightGray,i)
end
return
end
for t=0,h-1 do
local u=r+t
local d=self.scrollOffset+t
if d>c then
n.text(s,u,string.rep(" ",o),l,i)
else
local t=m[d]
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
local o=i
local t=l
if d==self._selectedIndex then
o=self.highlightBg or e.lightGray
t=self.highlightFg or e.black
end
n.text(s,u,a,t,o)
end
end
end
function n:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local t,i,e=...
local a,n,o=self:_rowFromPoint(i,e)
if a then
self.app:setFocus(self)
local t=self._flatNodes[a]
if t then
local e=t.depth*self.indentWidth
if e<0 then
e=0
end
if e>o-1 then
e=o-1
end
local a=n+e
if t.node and t.node.children and#t.node.children>0 and e<o then
local e=#tostring(self.toggleSymbols.collapsed or"+")
if e<1 then
e=1
end
if i>=a and i<a+e then
self:_toggleNode(t.node,nil)
return true
end
end
end
self:_setSelectedIndex(a,false)
return true
end
elseif t=="monitor_touch"then
local t,i,e=...
local o,n,a=self:_rowFromPoint(i,e)
if o then
self.app:setFocus(self)
local t=self._flatNodes[o]
if t then
local e=t.depth*self.indentWidth
if e<0 then
e=0
end
if e>a-1 then
e=a-1
end
local o=n+e
if t.node and t.node.children and#t.node.children>0 and e<a then
local e=#tostring(self.toggleSymbols.collapsed or"+")
if e<1 then
e=1
end
if i>=o and i<o+e then
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
local function z(e,t,a)
if e<t then
return t
end
if e>a then
return a
end
return e
end
local function E(r,t,a,i,o,n)
if not r then
return
end
n=n or e.white
local s=math.abs(i-t)
local l=t<i and 1 or-1
local h=-math.abs(o-a)
local d=a<o and 1 or-1
local e=s+h
while true do
r.pixel(t,a,n)
if t==i and a==o then
break
end
local o=2*e
if o>=h then
e=e+h
t=t+l
end
if o<=s then
e=e+s
a=a+d
end
end
end
function h:new(i,t)
t=t or{}
local o=l(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 8))
o.width=math.max(6,math.floor(o.width or 18))
local a=setmetatable({},h)
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
function h:_emitSelect()
if self.onSelect then
local e=self.selectedIndex
local t=e and self.data[e]or nil
self.onSelect(self,e,t)
end
end
function h:_clampSelection(a)
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
function h:setData(e)
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
function h:getData()
return self.data
end
function h:setLabels(e)
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
function h:getLabels()
return self.labels
end
function h:getLabel(e)
if type(e)~="number"then
return nil
end
if not self.labels then
return nil
end
return self.labels[math.floor(e)]
end
function h:setChartType(e)
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
function h:setShowAxis(e)
self.showAxis=not not e
end
function h:setShowLabels(e)
self.showLabels=not not e
end
function h:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e or""
end
function h:setRange(a,e)
if a~=nil then
t(1,a,"number")
end
if e~=nil then
t(2,e,"number")
end
self.minValue=a
self.maxValue=e
end
function h:setRangePadding(e)
t(1,e,"number")
if e<0 then
e=0
end
self.rangePadding=e
end
function h:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function h:setSelectedIndex(e,a)
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
function h:getSelectedIndex()
return self.selectedIndex
end
function h:getSelectedValue()
local e=self.selectedIndex
if not e then
return nil
end
return self.data[e]
end
function h:onFocusChanged(e)
if e then
self:_clampSelection(true)
end
end
function h:_indexFromPoint(t)
local e=self._lastLayout
if not e or not e.bars then
return nil
end
local o=e.bars
for a=1,#o do
local e=o[a]
if t>=e.left and t<=e.right then
return a
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
function h:_moveSelection(a)
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
function h:draw(h,p)
if not self.visible then
return
end
local i,s,r,o=self:getAbsoluteRect()
local n=self.bg or e.black
local f=self.fg or e.white
d(h,i,s,r,o,n,n)
g(h,i,s,r,o)
if self.border then
v(p,i,s,r,o,self.border,n)
end
local t=self.border
local a=(t and t.thickness)or 0
local u=(t and t.left)and a or 0
local c=(t and t.right)and a or 0
local l=(t and t.top)and a or 0
local t=(t and t.bottom)and a or 0
local i=i+u
local s=s+l
local a=math.max(0,r-u-c)
local t=math.max(0,o-l-t)
self._lastLayout=nil
if a<=0 or t<=0 then
return
end
local r=#self.data
if r==0 then
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
local u=(self.showAxis and(t-o)>=2)and 1 or 0
local l=t-u-o
if l<1 then
l=t
u=0
o=0
end
local m=s
local c=m+l-1
local w=u>0 and(c+1)or nil
local u
if o>0 then
if w then
u=w+1
else
u=c+1
end
if u>s+t-1 then
u=s+t-1
end
end
local t=math.huge
local o=-math.huge
for e=1,r do
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
for o=1,r do
local t=i+math.floor((o-1)*a/r)
local e=i+math.floor(o*a/r)-1
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
for a=1,r do
local i=self.data[a]or 0
local e=0
if o>0 then
e=(i-t)/o
end
e=z(e,0,1)
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
local o=c-e+1
if o<m then
o=m
e=c-m+1
end
local t=self.barColor or f
if self.selectedIndex==a then
t=self.highlightColor or t
end
d(h,s[a].left,o,s[a].width,e,t,t)
end
else
local a={}
for i=1,r do
local n=self.data[i]or 0
local e=0
if o>0 then
e=(n-t)/o
end
e=z(e,0,1)
local t=math.max(l-1,0)
local e=c-math.floor(e*t+.5)
if e<m then
e=m
end
if e>c then
e=c
end
a[i]={x=s[i].center,y=e}
end
for t=2,#a do
local e=a[t-1]
local t=a[t]
E(p,e.x,e.y,t.x,t.y,self.lineColor or f)
end
for t=1,#a do
local o=a[t]
local a=self.lineColor or f
local i="o"
if self.selectedIndex==t then
a=self.highlightColor or e.orange
i="O"
end
h.text(o.x,o.y,i,a,n)
end
end
if w then
d(h,i,w,a,1,n,n)
local e=string.rep("-",a)
h.text(i,w,e,self.axisColor or f,n)
end
if u then
d(h,i,u,a,1,n,n)
local t=self.labels or{}
for i=1,r do
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
local e=(self.selectedIndex==i)and(self.highlightColor or e.orange)or(self.axisColor or f)
h.text(o,u,t,e,n)
end
end
end
self._lastLayout={
innerX=i,
innerWidth=a,
dataCount=r,
bars=s
}
end
function h:handleEvent(e,...)
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
function r:new(i,a)
a=a or{}
local o=l(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local t=setmetatable({},r)
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
t.border=q(true)
end
t:_normalizeSelection(true)
return t
end
function r:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-a-o)
local i=math.max(0,self.height-t-e)
return a,o,t,e,n,i
end
function r:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function r:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function r:_ensureSelectionVisible()
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
function r:_normalizeSelection(t)
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
function r:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function r:setItems(a)
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
function r:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function r:setSelectedIndex(e,a)
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
function r:getSelectedIndex()
return self.selectedIndex
end
function r:setOnSelect(e)
if e~=nil then
t(1,e,"function")
end
self.onSelect=e
end
function r:setPlaceholder(e)
if e~=nil then
t(1,e,"string")
end
self.placeholder=e
end
function r:setHighlightColors(e,a)
if e~=nil then
t(1,e,"number")
self.highlightBg=e
end
if a~=nil then
t(2,a,"number")
self.highlightFg=a
end
end
function r:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function r:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function r:_itemIndexFromPoint(a,e)
if not self:containsPoint(a,e)then
return nil
end
local h,s=self:getAbsoluteRect()
local i,r,t,r,o,n=self:_getInnerMetrics()
if o<=0 or n<=0 then
return nil
end
local i=h+i
local t=s+t
if a<i or a>=i+o then
return nil
end
if e<t or e>=t+n then
return nil
end
local e=e-t
local e=self.scrollOffset+e
if e<1 or e>#self.items then
return nil
end
return e
end
function r:_moveSelection(t)
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
function r:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
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
local a=j.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function r:_searchForPrefix(e)
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
function r:draw(a,h)
if not self.visible then
return
end
local o,i,s,t=self:getAbsoluteRect()
local n=self.bg or e.black
local r=self.fg or e.white
d(a,o,i,s,t,n,n)
g(a,o,i,s,t)
if self.border then
v(h,o,i,s,t,self.border,n)
end
local d,l,s,l,t,h=self:_getInnerMetrics()
if t<=0 or h<=0 then
return
end
local o=o+d
local s=i+s
local d=#self.items
local n=n
local u=self.highlightBg or e.lightGray
local l=self.highlightFg or e.black
if d==0 then
for e=0,h-1 do
a.text(o,s+e,string.rep(" ",t),r,n)
end
local i=self.placeholder
if type(i)=="string"and#i>0 then
local i=i
if#i>t then
i=i:sub(1,t)
end
local t=o+math.floor((t-#i)/2)
if t<o then
t=o
end
a.text(t,s,i,e.lightGray,n)
end
return
end
for e=0,h-1 do
local s=s+e
local i=self.scrollOffset+e
if i>d then
a.text(o,s,string.rep(" ",t),r,n)
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
t=u
n=l
end
a.text(o,s,e,n,t)
end
end
end
function r:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
local e=self:_itemIndexFromPoint(e,t)
if e then
self:setSelectedIndex(e)
end
return true
end
elseif t=="monitor_touch"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e=self:_itemIndexFromPoint(t,e)
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
function m:new(i,t)
t=t or{}
local o=l(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},m)
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
a.border=q(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function m:_normalizeSelection()
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
function m:setItems(a)
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
function m:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function m:setSelectedIndex(e,a)
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
function m:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function m:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function m:_setOpen(e)
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
function m:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function m:_isPointInDropdown(t,a)
if not self._open or#self.items==0 then
return false
end
local e,i,n,o=self:getAbsoluteRect()
local o=i+o
return t>=e and t<e+n and a>=o and a<o+#self.items
end
function m:_indexFromPoint(t,e)
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
function m:_handlePress(t,e)
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
function m:draw(s,h)
if not self.visible then
return
end
local o,a,n,i=self:getAbsoluteRect()
local t=self.bg or e.black
local l=self.fg or e.white
d(s,o,a,n,i,t,t)
g(s,o,a,n,i)
if self.border then
v(h,o,a,n,i,self.border,t)
end
local e=self.border
local r=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local h=o+r
local n=math.max(0,n-r-u)
local u=a+d
local e=math.max(0,i-d-e)
local r=n>0 and 1 or 0
local o=math.max(0,n-r)
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
s.text(h,i,e,l,t)
end
if r>0 then
local e=self._open and string.char(30)or string.char(31)
local a=h+n-1
s.text(a,i,e,l,t)
end
end
function m:_drawDropdown(s,c)
if not self._open or#self.items==0 or self.visible==false then
return
end
local i,t,a,e=self:getAbsoluteRect()
local o=t+e
local r=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local u=i+t
local t=math.max(0,a-t-n)
local h=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local n=r+e
d(s,i,o,a,n,self.dropdownBg,self.dropdownBg)
g(s,i,o,a,n)
for e=1,r do
local a=o+e-1
local o=self.items[e]or""
local e=h~=nil and h==e
local i=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local n=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if t>0 then
local e=o
if#e>t then
e=e:sub(1,t)
end
local t=math.max(0,t-#e)
local e=e..string.rep(" ",t)
s.text(u,a,e,n,i)
end
end
if self.border then
local e=l(self.border)
if e then
e.top=false
v(c,i,o,a,n,e,self.dropdownBg)
end
end
end
function m:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,t,e=...
return self:_handlePress(t,e)
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
local t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
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
local l={}
l.__index=l
setmetatable(l,{__index=s})
function l:new(o,t)
local a={}
if t then
for t,e in pairs(t)do
a[t]=e
end
end
a.focusable=true
a.height=a.height or 1
local e=setmetatable({},l)
e:_init_base(o,a)
e.focusable=true
e.text=(t and t.text)or""
e.placeholder=(t and t.placeholder)or""
e.onChange=t and t.onChange or nil
e.maxLength=t and t.maxLength or nil
if e.maxLength and#e.text>e.maxLength then
e.text=e.text:sub(1,e.maxLength)
end
local t=(t and t.cursorPos)or(#e.text+1)
e._cursorPos=math.min(math.max(1,t),#e.text+1)
e._viewOffset=1
if not e.border then
e.border=q(true)
end
e:_ensureCursorVisible()
return e
end
function l:onFocusChanged(e)
self:_ensureCursorVisible()
end
function l:_applyMaxLength(e)
if not self.maxLength then
return e
end
if#e<=self.maxLength then
return e
end
return e:sub(1,self.maxLength)
end
function l:_setCursor(e)
local t=#self.text
e=math.max(1,math.min(e,t+1))
self._cursorPos=e
self:_ensureCursorVisible()
end
function l:_moveCursor(e)
self:_setCursor(self._cursorPos+e)
end
function l:_ensureCursorVisible()
local e=self.width
local t=e>2 and(e-2)or e
if t<1 then t=1 end
local o=#self.text
local e=self._viewOffset
local a=self._cursorPos
if a<e then
e=a
elseif a>e+t-1 then
e=a-t+1
end
if o<t then
e=1
end
if e<1 then e=1 end
local t=math.max(1,o-t+1)
if e>t then
e=t
end
self._viewOffset=e
end
function l:_notifyChange()
if self.onChange then
self.onChange(self,self.text)
end
end
function l:_insertText(e)
if not e or e==""then
return false
end
if self.maxLength then
local t=self.maxLength-#self.text
if t<=0 then
return false
end
if#e>t then
e=e:sub(1,t)
end
end
local a=self.text:sub(1,self._cursorPos-1)
local t=self.text:sub(self._cursorPos)
self.text=a..e..t
self._cursorPos=self._cursorPos+#e
self:_ensureCursorVisible()
self:_notifyChange()
return true
end
function l:_backspace()
if self._cursorPos<=1 then
return false
end
local e=self.text:sub(1,self._cursorPos-2)
local t=self.text:sub(self._cursorPos)
self.text=e..t
self._cursorPos=self._cursorPos-1
self:_ensureCursorVisible()
self:_notifyChange()
return true
end
function l:_delete()
if self._cursorPos>#self.text then
return false
end
local t=self.text:sub(1,self._cursorPos-1)
local e=self.text:sub(self._cursorPos+1)
self.text=t..e
self:_ensureCursorVisible()
self:_notifyChange()
return true
end
function l:_cursorFromPoint(o)
local t,a,e=self:getAbsoluteRect()
local a=t+(e>2 and 1 or 0)
local t=e>2 and(e-2)or e
local e=math.floor(o-a)
if e<0 then e=0 end
if e>t then e=t end
return self._viewOffset+e
end
function l:draw(n,w)
if not self.visible then
return
end
local s,h,r,l=self:getAbsoluteRect()
local o=self.bg or e.black
local u=self.fg or e.white
local c,m=s+1,h+1
local t=math.max(0,r-2)
local i=math.max(0,l-2)
if t>0 and i>0 then
d(n,c,m,t,i,o,o)
else
d(n,s,h,r,l,o,o)
end
g(n,s,h,r,l)
local a=t>0 and t or r
local f=t>0 and c or s
local d
if i>0 then
d=m+math.floor((i-1)/2)
else
d=h
end
local t=self._viewOffset
local i=t+a-1
local i=self.text:sub(t,i)
if#i<a then
i=i..string.rep(" ",a-#i)
end
local t=i
local c=u
local m=(not self:isFocused())and self.text==""and type(self.placeholder)=="string"and#self.placeholder>0
if m then
t=self.placeholder
if#t>a then
t=t:sub(1,a)
end
if#t<a then
t=t..string.rep(" ",a-#t)
end
c=e.lightGray
end
if a>0 then
n.text(f,d,t,c,o)
end
if self:isFocused()then
local e=self._cursorPos-self._viewOffset+1
if e>=1 and e<=a then
local t=i:sub(e,e)
if t==""then
t=" "
end
n.text(f+e-1,d,t,o,u)
end
end
if self.border then
v(w,s,h,r,l,self.border,o)
end
end
function l:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_setCursor(self:_cursorFromPoint(e))
return true
end
elseif e=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
self:_setCursor(self:_cursorFromPoint(e))
return true
end
elseif e=="mouse_drag"then
local a,e,t=...
if self:isFocused()and self:containsPoint(e,t)then
self:_setCursor(self:_cursorFromPoint(e))
return true
end
elseif e=="char"then
local e=...
if self:isFocused()then
return self:_insertText(e)
end
elseif e=="paste"then
local e=...
if self:isFocused()then
return self:_insertText(e)
end
elseif e=="key"then
local e=...
if self:isFocused()then
if e==a.left then
self:_moveCursor(-1)
return true
elseif e==a.right then
self:_moveCursor(1)
return true
elseif e==a.home then
self:_setCursor(1)
return true
elseif e==a["end"]then
self:_setCursor(#self.text+1)
return true
elseif e==a.backspace then
return self:_backspace()
elseif e==a.delete then
return self:_delete()
end
end
end
return false
end
function l:setText(e)
t(1,e,"string")
self.text=self:_applyMaxLength(e)
self._cursorPos=math.min(self._cursorPos,#self.text+1)
self:_ensureCursorVisible()
self:_notifyChange()
end
function l:getText()
return self.text
end
function l:setOnChange(e)
if e~=nil then
t(1,e,"function")
end
self.onChange=e
end
function p.create(a)
if a~=nil then
t(1,a,"table")
end
a=a or{}
local h=false
local n
local o=a.window
if o==nil then
n=_.current()
local e,t=n.getSize()
o=I.create(n,1,1,e,t,true)
o.setVisible(true)
h=true
end
local t=T.new(o)
t.profiler.start_frame()
t.profiler.start_region("user")
local r=t.add_pixel_layer(5,"pixelui_pixels")
local d=t.add_text_layer(10,"pixelui_ui")
local u,l=o.getSize()
local s=a.background or e.black
t.fill(s)
local c=math.max(.01,a.animationInterval or .05)
local t=setmetatable({
window=o,
box=t,
layer=d,
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
_animationInterval=c,
_radioGroups={}
},i)
t.root=b:new(t,{
x=1,
y=1,
width=u,
height=l,
bg=s,
fg=e.white,
border=a.rootBorder,
z=-math.huge
})
return t
end
function i:getRoot()
return self.root
end
function i:setBackground(e)
t(1,e,"number")
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
return b:new(self,e)
end
function i:createButton(e)
return k:new(self,e)
end
function i:createLabel(e)
return y:new(self,e)
end
function i:createCheckBox(e)
return f:new(self,e)
end
function i:createToggle(e)
return w:new(self,e)
end
function i:createTextBox(e)
return l:new(self,e)
end
function i:createComboBox(e)
return m:new(self,e)
end
function i:createList(e)
return r:new(self,e)
end
function i:createTreeView(e)
return n:new(self,e)
end
function i:createChart(e)
return h:new(self,e)
end
function i:createRadioButton(e)
return c:new(self,e)
end
function i:createProgressBar(e)
return u:new(self,e)
end
function i:createSlider(e)
return o:new(self,e)
end
function i:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=j.startTimer(self._animationInterval)
end
end
function i:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=j.clock()
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
t=x.linear
elseif type(t)=="string"then
t=x[t]
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
startTime=j.clock()
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
function i:_selectRadioInGroup(a,t,o)
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
function i:setFocus(e)
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
local e=...
if self._animationTimer and e==self._animationTimer then
self:_updateAnimations()
if self._animations and#self._animations>0 then
self._animationTimer=j.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or _.current()
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
self:render()
end
function i:run()
self.running=true
self:render()
while self.running do
local e={O()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
end
function i:stop()
self.running=false
self:_clearAnimations(true)
end
p.widgets={
Frame=function(t,e)
return b:new(t,e)
end,
Button=function(e,t)
return k:new(e,t)
end,
Label=function(e,t)
return y:new(e,t)
end,
CheckBox=function(e,t)
return f:new(e,t)
end,
Toggle=function(e,t)
return w:new(e,t)
end,
TextBox=function(e,t)
return l:new(e,t)
end,
ComboBox=function(t,e)
return m:new(t,e)
end,
List=function(t,e)
return r:new(t,e)
end,
TreeView=function(t,e)
return n:new(t,e)
end,
Chart=function(e,t)
return h:new(e,t)
end,
RadioButton=function(e,t)
return c:new(e,t)
end,
ProgressBar=function(t,e)
return u:new(t,e)
end,
Slider=function(t,e)
return o:new(t,e)
end
}
p.Widget=s
p.Frame=b
p.Button=k
p.Label=y
p.CheckBox=f
p.Toggle=w
p.TextBox=l
p.ComboBox=m
p.List=r
p.TreeView=n
p.Chart=h
p.RadioButton=c
p.ProgressBar=u
p.Slider=o
p.easings=x
return p
