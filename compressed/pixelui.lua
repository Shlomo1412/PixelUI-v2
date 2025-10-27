local I=assert(rawget(_G,"term"),"term API unavailable")
local e=assert(rawget(_G,"colors"),"colors API unavailable")
local z=assert(rawget(_G,"os"),"os API unavailable")
local S=assert(z.pullEvent,"os.pullEvent unavailable")
local H=assert(rawget(_G,"window"),"window API unavailable")
local t=assert(rawget(_G,"keys"),"keys API unavailable")
local o=require("cc.expect").expect
local N=require("shrekbox")
local v={
version="0.1.0"
}
local E={
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
local g={}
g.__index=g
setmetatable(g,{__index=r})
local j={}
j.__index=j
setmetatable(j,{__index=r})
local y={}
y.__index=y
setmetatable(y,{__index=r})
local w={}
w.__index=w
setmetatable(w,{__index=r})
local p={}
p.__index=p
setmetatable(p,{__index=r})
local m={}
m.__index=m
setmetatable(m,{__index=r})
local n={}
n.__index=n
setmetatable(n,{__index=r})
local d={}
d.__index=d
setmetatable(d,{__index=r})
local i={}
i.__index=i
setmetatable(i,{__index=r})
local h={}
h.__index=h
setmetatable(h,{__index=r})
local l={}
l.__index=l
setmetatable(l,{__index=r})
local c={}
c.__index=c
setmetatable(c,{__index=r})
local f={}
f.__index=f
setmetatable(f,{__index=r})
local s={}
s.__index=s
local a={"top","right","bottom","left"}
local A=string.char(7)
local function q(t)
if not t then
return nil
end
local e={}
for t,a in pairs(t)do
e[t]=a
end
return e
end
local function _(t,e)
o(nil,t,"string")
o(nil,e,"number")
if e<1 or e~=math.floor(e)then
error(('%s must be a positive integer, got "%s"'):format(t,tostring(e)),3)
end
end
local function x(t)
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
o(1,t,"table")
local e={
color=t.color or e.lightGray,
top=true,
right=true,
bottom=true,
left=true,
thickness=math.max(1,math.floor(t.thickness or 1))
}
local function o(a,t)
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
for e=1,#a do
o(a[e],t[a[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function u(s,h,o,t,e,n,i,a)
if t<=0 or e<=0 then
return
end
local a=a or" "
local t=a:rep(t)
for e=0,e-1 do
s.text(h,o+e,t,n,i)
end
end
local function k(n,o,i,a,e)
if a<=0 or e<=0 then
return
end
local t=N.transparent
for a=0,a-1 do
n.pixel(o+a,i,t)
if e>1 then
n.pixel(o+a,i+e-1,t)
end
end
for e=1,math.max(0,e-2)do
n.pixel(o,i+e,t)
if a>1 then
n.pixel(o+a-1,i+e,t)
end
end
end
local function b(s,h,a,i,o,e,t)
if i<=0 or o<=0 then
return
end
local n=e.color
local d=t or n
local t=(h-1)*2+1
local a=(a-1)*3+1
local i=i*2
local o=o*3
local u=3
local l=2
local h=math.min(e.thickness,o)
local r=math.min(e.thickness,i)
local u=math.min(o,math.max(h,u))
local l=math.min(i,math.max(r,l))
local function f(e,n,h)
for n=0,n-1 do
local e=e+n
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(t+a,e,h)
end
end
end
local function w(e,h,n)
for h=0,h-1 do
local e=e+h
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(t+a,e,n)
end
end
end
local function m(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(e,a+t,n)
end
end
end
local function c(n,e,h)
for e=0,e-1 do
local e=n+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(e,a+t,h)
end
end
end
if e.left then
m(t,l,d)
end
if e.right then
m(t+i-l,l,d)
end
if e.top then
f(a,u,d)
end
if e.bottom then
f(a+o-u,u,d)
end
if e.top then
w(a,h,n)
end
if e.bottom then
w(a+o-h,h,n)
end
if e.left then
c(t,r,n)
end
if e.right then
c(t+i-r,r,n)
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
function r:_init_base(a,t)
o(1,a,"table")
t=t or{}
o(2,t,"table","nil")
self.app=a
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
self.border=x(t.border)
self.focusable=t.focusable==true
self._focused=false
_("width",self.width)
_("height",self.height)
end
function r:setSize(t,e)
_("width",t)
_("height",e)
self.width=t
self.height=e
end
function r:setPosition(e,t)
o(1,e,"number")
o(2,t,"number")
self.x=math.floor(e)
self.y=math.floor(t)
end
function r:setZ(e)
o(1,e,"number")
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
self.border=x(true)
return
end
o(1,e,"table","boolean")
self.border=x(e)
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
local e,t=T(self)
return e,t,self.width,self.height
end
function r:containsPoint(e,t)
local o,a,n,i=self:getAbsoluteRect()
return e>=o and e<o+n and t>=a and t<a+i
end
function r:draw(e,e)
error("draw needs implementation for widget",2)
end
function r:handleEvent(e,...)
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
o(1,e,"table")
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
local function _(a)
local t={}
for e=1,#a do
t[e]=a[e]
end
return t
end
local function T(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function g:getChildren()
return _(self._children)
end
function g:setTitle(e)
if e~=nil then
o(1,e,"string")
end
self.title=e
end
function g:draw(s,r)
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
k(s,n,t,a,o)
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
b(r,n,t,a,o,self.border,i)
end
local e=_(self._children)
T(e)
for t=1,#e do
e[t]:draw(s,r)
end
end
function g:handleEvent(t,...)
if not self.visible then
return false
end
if r.handleEvent(self,t,...)then
return true
end
local e=_(self._children)
T(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function j:new(a,e)
local t=setmetatable({},j)
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
function j:setLabel(e)
o(1,e,"string")
self.label=e
end
function j:setOnClick(e)
if e~=nil then
o(1,e,"function")
end
self.onClick=e
end
function j:draw(h,c)
if not self.visible then
return
end
local o,n,a,t=self:getAbsoluteRect()
local i=self.bg or e.gray
local s=self.fg or e.white
local e=i
local r=s
if self.clickEffect and self._pressed then
e,r=r,e
end
local d,l=o+1,n+1
local i=math.max(0,a-2)
local s=math.max(0,t-2)
if i>0 and s>0 then
u(h,d,l,i,s,e,e)
else
u(h,o,n,a,t,e,e)
end
k(h,o,n,a,t)
if self.border then
b(c,o,n,a,t,self.border,e)
end
local t=self.label or""
local a=i>0 and i or a
if#t>a then
t=t:sub(1,a)
end
local u=0
if a>#t then
u=math.floor((a-#t)/2)
end
local t=string.rep(" ",u)..t
if#t<a then
t=t..string.rep(" ",a-#t)
end
local o=i>0 and d or o
local a
if s>0 then
a=l+math.floor((s-1)/2)
else
a=n
end
h.text(o,a,t,r,e)
end
function j:handleEvent(e,...)
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
function y:new(o,e)
e=e or{}
local a=q(e)or{}
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
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-t-o)
local i=math.max(0,self.height-a-e)
return t,o,a,e,n,i
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
o(1,e,"string")
end
local t=e:lower()
if t~="left"and t~="center"and t~="right"then
error("Invalid horizontal alignment '"..e.."'",2)
end
if self.align~=t then
self.align=t
end
end
function y:setVerticalAlign(t)
if t==nil then
t="top"
else
o(1,t,"string")
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
function y:setSize(t,e)
r.setSize(self,t,e)
self:_updateLines(true)
end
function y:setBorder(e)
r.setBorder(self,e)
self:_updateLines(true)
end
function y:draw(r,f)
if not self.visible then
return
end
local n,h,l,d=self:getAbsoluteRect()
local s=self.bg or self.app.background or e.black
local m=self.fg or e.white
u(r,n,h,l,d,s,s)
k(r,n,h,l,d)
local t,a,e,a,o,i=self:_getInnerMetrics()
local a=n+t
local c=h+e
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
local i=c+t
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
r.text(t,i,e,m,s)
end
i=i+1
end
end
if self.border then
b(f,n,h,l,d,self.border,s)
end
end
function w:new(n,t)
t=t or{}
local o=q(t)or{}
local i="Option"
if t and t.label~=nil then
i=tostring(t.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},w)
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
function w:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function w:_setState(t,e,a)
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
function w:setLabel(e)
o(1,e,"string")
self.label=e
end
function w:setOnChange(e)
if e~=nil then
o(1,e,"function")
end
self.onChange=e
end
function w:setAllowIndeterminate(e)
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
function w:setChecked(e)
o(1,e,"boolean")
self:_setState(e,false,false)
end
function w:isChecked()
return self.checked
end
function w:setIndeterminate(e)
if not self.allowIndeterminate then
if e then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
o(1,e,"boolean")
self:_setState(self.checked,e,false)
end
function w:isIndeterminate()
return self.indeterminate
end
function w:toggle()
self:_activate()
end
function w:_activate()
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
function w:draw(r,d)
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
u(r,s,n,t,i,o,o)
k(r,s,n,t,i)
if self.border then
b(d,s,n,t,i,self.border,o)
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
r.text(s,t,e,h,o)
end
function w:handleEvent(e,...)
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
if e==t.space or e==t.enter then
self:_activate()
return true
end
end
return false
end
function p:new(i,t)
t=t or{}
local o=q(t)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(4,math.floor(o.width or 10))
local a=setmetatable({},p)
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
function p:_emitChange()
if self.onChange then
self.onChange(self,self.value)
end
end
function p:setOnChange(e)
if e~=nil then
o(1,e,"function")
end
self.onChange=e
end
function p:setValue(e,t)
e=not not e
if self.value==e then
return
end
self.value=e
if not t then
self:_emitChange()
end
end
function p:isOn()
return self.value
end
function p:toggle()
if self.disabled then
return
end
self:setValue(not self.value)
end
function p:setLabels(t,e)
if t~=nil then
o(1,t,"string")
self.labelOn=t
end
if e~=nil then
o(2,e,"string")
self.labelOff=e
end
end
function p:setShowLabel(e)
self.showLabel=not not e
end
function p:setDisabled(e)
e=not not e
if self.disabled==e then
return
end
self.disabled=e
end
function p:isDisabled()
return self.disabled
end
function p:setColors(n,a,i,t,e)
if n~=nil then
o(1,n,"number")
self.trackColorOn=n
end
if a~=nil then
o(2,a,"number")
self.trackColorOff=a
end
if i~=nil then
o(3,i,"number")
self.thumbColor=i
end
if t~=nil then
o(4,t,"number")
self.onLabelColor=t
end
if e~=nil then
o(5,e,"number")
self.offLabelColor=e
end
end
function p:draw(r,s)
if not self.visible then
return
end
local i,n,o,a=self:getAbsoluteRect()
local t=self.bg or e.black
local c=self.fg or e.white
u(r,i,n,o,a,t,t)
k(r,i,n,o,a)
if self.border then
b(s,i,n,o,a,self.border,t)
end
local t=self.border
local d=(t and t.left)and t.thickness or 0
local m=(t and t.right)and t.thickness or 0
local h=(t and t.top)and t.thickness or 0
local l=(t and t.bottom)and t.thickness or 0
local t=i+d
local n=n+h
local i=math.max(0,o-d-m)
local o=math.max(0,a-h-l)
if i<=0 or o<=0 then
return
end
local t=t
local n=n
local a=i
local i=o
local h=self.trackColorOff or e.gray
local o=self.trackColorOn or e.lightBlue
local l=self.value and o or h
u(r,t,n,a,i,l,l)
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
local e=math.max(0,a-2)
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
local e=t+math.floor((a-#o)/2)
if e<t then
e=t
end
if e+#o-1>t+a-1 then
e=t+a-#o
end
if#o>0 then
r.text(e,i,o,s,l)
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
function p:handleEvent(e,...)
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
function c:new(n,a)
a=a or{}
local o=q(a)or{}
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
o(1,e,"string")
self.label=e
end
function c:setValue(e)
self.value=e
end
function c:getValue()
return self.value
end
function c:setGroup(e)
o(1,e,"string","nil")
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
o(1,e,"function")
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
local n,i,t,o=self:getAbsoluteRect()
local a=self.bg or e.black
local e=self.fg or e.white
local a=a
local s=e
if self:isFocused()then
a=self.focusBg or a
s=self.focusFg or s
end
u(h,n,i,t,o,a,a)
k(h,n,i,t,o)
if self.border then
b(r,n,i,t,o,self.border,a)
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
h.text(n,i,e,s,a)
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
function m:new(i,a)
a=a or{}
local o=q(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local t=setmetatable({},m)
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
t.border=x(true)
end
if t.indeterminate then
t:_startIndeterminateAnimation()
end
return t
end
function m:_clampValue(e)
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
function m:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function m:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=E.linear,
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
function m:setRange(e,t)
o(1,e,"number")
o(2,t,"number")
if t<=e then
error("ProgressBar max must be greater than min",2)
end
self.min=e
self.max=t
self.value=self:_clampValue(self.value)
end
function m:getRange()
return self.min,self.max
end
function m:setValue(e)
if self.indeterminate then
return
end
o(1,e,"number")
e=self:_clampValue(e)
if e~=self.value then
self.value=e
end
end
function m:getValue()
return self.value
end
function m:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function m:setIndeterminate(e)
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
function m:isIndeterminate()
return self.indeterminate
end
function m:setLabel(e)
if e~=nil then
o(1,e,"string")
end
self.label=e
end
function m:setShowPercent(e)
self.showPercent=not not e
end
function m:setColors(a,e,t)
if a~=nil then
o(1,a,"number")
self.trackColor=a
end
if e~=nil then
o(2,e,"number")
self.fillColor=e
end
if t~=nil then
o(3,t,"number")
self.textColor=t
end
end
function m:draw(n,r)
if not self.visible then
return
end
local a,t,s,h=self:getAbsoluteRect()
local o=self.trackColor or(self.bg or e.gray)
local i=self.fillColor or e.lightBlue
local m=self.textColor or(self.fg or e.white)
u(n,a,t,s,h,o,o)
k(n,a,t,s,h)
if self.border then
b(r,a,t,s,h,self.border,o)
end
local e=self.border
local r=(e and e.left)and 1 or 0
local c=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+r
local l=t+d
local t=math.max(0,s-r-c)
local s=math.max(0,h-d-e)
if t<=0 or s<=0 then
return
end
u(n,a,l,t,s,o,o)
local d=0
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
u(n,a+r,l,h,s,i,i)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
d=math.floor(t*e+.5)
if d>0 then
u(n,a,l,d,s,i,i)
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
local l=l+math.floor((s-1)/2)
local s=a+math.floor((t-#e)/2)
if s<a then
s=a
end
for t=1,#e do
local u=e:sub(t,t)
local e=(s-a)+(t-1)
local a=o
if self.indeterminate then
if e>=r and e<r+h then
a=i
end
else
if e<d then
a=i
end
end
n.text(s+t-1,l,u,m,a)
end
end
end
function m:handleEvent(e,...)
return false
end
function n:new(i,a)
a=a or{}
local o=q(a)or{}
o.focusable=true
o.height=math.max(1,math.floor(o.height or 3))
o.width=math.max(1,math.floor(o.width or 12))
local t=setmetatable({},n)
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
t.border=x(true)
end
return t
end
function n:_clampValue(e)
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
function n:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function n:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local s,n=self:getAbsoluteRect()
local i=math.max(0,self.width-a-o)
local o=math.max(0,self.height-t-e)
local s=s+a
local n=n+t
return s,n,i,o,a,t,e
end
function n:_valueToPosition(o,a)
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
function n:_positionToValue(e,t)
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
function n:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function n:setOnChange(e)
if e~=nil then
o(1,e,"function")
end
self.onChange=e
end
function n:_setSingleValue(e,t)
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
function n:setValue(e)
if self.range then
return
end
o(1,e,"number")
self:_setSingleValue(e,false)
end
function n:getValue()
return self.value
end
function n:_setLowerValue(e,t)
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
function n:_setUpperValue(e,t)
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
function n:setRangeValues(t,e,i)
if not self.range then
return
end
if t==nil then
t=self.lowerValue or self.min
end
if e==nil then
e=self.upperValue or self.max
end
o(1,t,"number")
o(2,e,"number")
if t>e then
t,e=e,t
end
local a=false
a=self:_setLowerValue(t,true)or a
a=self:_setUpperValue(e,true)or a
if a and not i then
self:_notifyChange()
end
end
function n:getRangeValues()
return self.lowerValue,self.upperValue
end
function n:setRangeLimits(e,t)
o(1,e,"number")
o(2,t,"number")
if t<=e then
error("Slider max must be greater than min",2)
end
self.min=e
self.max=t
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
function n:setStep(e)
if e==nil then
e=0
else
o(1,e,"number")
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
function n:setShowValue(e)
self.showValue=not not e
end
function n:setColors(a,e,t)
if a~=nil then
o(1,a,"number")
self.trackColor=a
end
if e~=nil then
o(2,e,"number")
self.fillColor=e
end
if t~=nil then
o(3,t,"number")
self.handleColor=t
end
end
function n:_formatNumber(o)
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
function n:_formatDisplayValue()
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
function n:_getStepForNudge(t)
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
function n:_positionFromPoint(e)
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
function n:_beginInteraction(e)
local t,a=self:_positionFromPoint(e)
if not t then
return false
end
if self.range then
local s=self:_valueToPosition(self.lowerValue,a)
local n=self:_valueToPosition(self.upperValue,a)
local e=self._focusedHandle or"lower"
local o=math.abs(t-s)
local i=math.abs(t-n)
if o==i then
if t>n then
e="upper"
elseif t<s then
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
function n:_updateInteraction(e)
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
function n:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function n:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function n:_nudgeValue(e)
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
function n:onFocusChanged(e)
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
function n:draw(i,f)
if not self.visible then
return
end
local h,s,r,l=self:getAbsoluteRect()
local n=self.bg or self.app.background or e.black
u(i,h,s,r,l,n,n)
k(i,h,s,r,l)
local o,m,t,d=self:_getInnerMetrics()
if t<=0 or d<=0 then
if self.border then
b(f,h,s,r,l,self.border,n)
end
return
end
local a
local c=nil
if self.showValue and d>=2 then
c=m
a=m+d-1
else
a=m+math.floor((d-1)/2)
end
u(i,o,a,t,1,self.trackColor,self.trackColor)
local d
if self:isFocused()then
d=self._activeHandle or self._focusedHandle
end
local function m(n,s)
if n<0 or n>=t then
return
end
local t=self.handleColor or e.white
if d and s==d then
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
u(i,o+e,a,n,1,self.fillColor,self.fillColor)
end
m(e,"lower")
m(t,"upper")
else
local e=self:_valueToPosition(self.value,t)
local t=e+1
if t>0 then
u(i,o,a,t,1,self.fillColor,self.fillColor)
end
m(e,"single")
end
if self.showValue and c then
local a=self:_formatDisplayValue()
if a and a~=""then
if#a>t then
a=a:sub(1,t)
end
local t=o+math.floor((t-#a)/2)
if t<o then
t=o
end
i.text(t,c,a,self.fg or e.white,n)
end
end
if self.border then
b(f,h,s,r,l,self.border,n)
end
end
function n:handleEvent(a,...)
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
function i:new(n,a)
a=a or{}
local o=q(a)or{}
o.focusable=true
o.width=math.max(8,math.floor(o.width or 24))
o.height=math.max(3,math.floor(o.height or 7))
local t=setmetatable({},i)
t:_init_base(n,o)
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
t.border=x(true)
end
t:_ensureSelectionVisible()
return t
end
function i:_normalizeColumns(e)
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
function i:_recomputeColumnMetrics()
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
function i:_ensureColumnsForData()
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
function i:setColumns(e)
if e~=nil then
o(1,e,"table")
end
self.columns=self:_normalizeColumns(e or{})
self:_recomputeColumnMetrics()
self:_ensureColumnsForData()
self:_refreshRows()
end
function i:getColumns()
local t={}
for e=1,#self.columns do
t[e]=q(self.columns[e])
end
return t
end
function i:setData(e)
o(1,e,"table")
local a={}
for t=1,#e do
a[t]=e[t]
end
self.data=a
self:_ensureColumnsForData()
self:_refreshRows()
end
function i:getData()
local e={}
for t=1,#self.data do
e[t]=self.data[t]
end
return e
end
function i:_refreshRows()
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
function i:_getColumnById(e)
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
function i:_applySort(t,e,u)
local t=self:_getColumnById(t)
if not t or t.sortable==false then
return
end
self.sortColumn=t.id
self.sortDirection=e=="desc"and"desc"or"asc"
local l=self.sortDirection=="desc"
local n=t.comparator
table.sort(self._rows,function(s,r)
local h=self.data[s]
local d=self.data[r]
local a=i._resolveColumnValue(t,h)
local o=i._resolveColumnValue(t,d)
local e=0
if n then
local a,t=pcall(n,a,o,h,d,t)
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
return s<r
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
function i:setSort(e,t,a)
if e==nil then
self.sortColumn=nil
self.sortDirection="asc"
self:_refreshRows()
return
end
self:_applySort(e,t or self.sortDirection,a)
end
function i:getSort()
return self.sortColumn,self.sortDirection
end
function i:setOnSort(e)
if e~=nil then
o(1,e,"function")
end
self.onSort=e
end
function i:setOnSelect(e)
if e~=nil then
o(1,e,"function")
end
self.onSelect=e
end
function i:getSelectedIndex()
return self.selectedIndex
end
function i:getSelectedRow()
if self.selectedIndex>=1 and self.selectedIndex<=#self._rows then
return self.data[self._rows[self.selectedIndex]]
end
return nil
end
function i:setSelectedIndex(e,t)
if not self.allowRowSelection then
self.selectedIndex=0
return
end
if#self._rows==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
o(1,e,"number")
e=math.floor(e)
if e<1 then
e=1
elseif e>#self._rows then
e=#self._rows
end
local a=e~=self.selectedIndex
self.selectedIndex=e
self:_ensureSelectionVisible()
if a and not t then
self:_notifySelect()
end
end
function i:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedRow(),self.selectedIndex)
end
end
function i:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n,i=self:getAbsoluteRect()
local o=math.max(0,self.width-a-o)
local e=math.max(0,self.height-t-e)
local a=n+a
local t=i+t
return a,t,o,e
end
function i:_getRowsVisible()
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
function i:_clampScroll()
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
function i:_ensureSelectionVisible()
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
function i:_rowFromPoint(t,e)
if not self:containsPoint(t,e)then
return nil
end
local i,t,o,a=self:_getInnerMetrics()
if o<=0 or a<=0 then
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
function i:_columnFromPoint(n,e)
if not self:containsPoint(n,e)then
return nil
end
local i,o,a,t=self:_getInnerMetrics()
if a<=0 or t<=0 then
return nil
end
if e~=o then
return nil
end
local s=a
local e=i
for o=1,#self.columns do
local t=math.max(1,math.min(self.columns[o].width,s))
if o==#self.columns then
t=i+a-e
end
if t<=0 then
break
end
if n>=e and n<e+t then
return self.columns[o],o
end
e=e+t
s=a-(e-i)
if s<=0 then
break
end
end
return nil
end
function i._resolveColumnValue(e,t)
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
function i:_formatCell(t,a,e)
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
function i:draw(s,f)
if not self.visible then
return
end
local c,d,l,r=self:getAbsoluteRect()
local h=self.bg or e.black
local m=self.fg or e.white
u(s,c,d,l,r,h,h)
k(s,c,d,l,r)
local a,u,t,o=self:_getInnerMetrics()
if t<=0 or o<=0 then
if self.border then
b(f,c,d,l,r,self.border,h)
end
return
end
local p=self.headerBg or h
local y=self.headerFg or m
local n=a
local w=t
for e=1,#self.columns do
local i=self.columns[e]
local o=math.max(1,math.min(i.width,w))
if e==#self.columns then
o=a+t-n
end
if o<=0 then
break
end
local e=i.title or i.id
local h=""
if self.sortColumn==i.id then
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
s.text(n,u,e,y,p)
n=n+o
w=t-(n-a)
if w<=0 then
break
end
end
local o=self:_getRowsVisible()
if o<=0 then
if self.border then
b(f,c,d,l,r,self.border,h)
end
return
end
if#self._rows==0 then
for e=1,o do
s.text(a,u+e,string.rep(" ",t),m,self.rowBg)
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
local c=u+1+o
if e>#self._rows then
s.text(a,c,string.rep(" ",t),m,self.rowBg)
else
local o=self._rows[e]
local d=self.data[o]
local m=self.allowRowSelection and e==self.selectedIndex
local l=self.rowBg
local u=self.rowFg
if m then
l=self.highlightBg
u=self.highlightFg
elseif self.zebra and(e%2==0)then
l=self.zebraBg
end
local h=a
local r=t
for e=1,#self.columns do
local o=self.columns[e]
local n=math.max(1,math.min(o.width,r))
if e==#self.columns then
n=a+t-h
end
if n<=0 then
break
end
local e=i._resolveColumnValue(o,d)
e=self:_formatCell(o,d,e)
if#e>n then
e=e:sub(1,n)
end
if o.align=="right"then
if#e<n then
e=string.rep(" ",n-#e)..e
end
elseif o.align=="center"then
local a=n-#e
local t=math.floor(a/2)
local a=a-t
e=string.rep(" ",t)..e..string.rep(" ",a)
else
if#e<n then
e=e..string.rep(" ",n-#e)
end
end
local i=u
if o.color then
if type(o.color)=="number"then
i=o.color
elseif type(o.color)=="function"then
local t,e=pcall(o.color,e,d,o,m)
if t and type(e)=="number"then
i=e
end
end
end
s.text(h,c,e,i,l)
h=h+n
r=t-(h-a)
if r<=0 then
break
end
end
end
end
end
if self.border then
b(f,c,d,l,r,self.border,h)
end
end
function i:_handleTypeSearch(t)
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
function i:_searchForPrefix(e)
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
local a=i._resolveColumnValue(a,o)
local a=tostring(a or""):lower()
if a:sub(1,#e)==e then
self:setSelectedIndex(t)
return
end
end
end
function i:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function i:handleEvent(a,...)
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
local e,t,a=...
if self:containsPoint(t,a)then
self.scrollOffset=self.scrollOffset+e
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
local o=q(t)or{}
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
a.border=x(true)
end
a:setNodes((t and t.nodes)or{})
return a
end
function h:setOnSelect(e)
if e~=nil then
o(1,e,"function")
end
self.onSelect=e
end
function h:setOnToggle(e)
if e~=nil then
o(1,e,"function")
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
o(1,e,"table")
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
function h:_findVisibleIndex(t)
if t==nil then
return nil
end
local a=self._flatNodes
for e=1,#a do
if a[e].node==t then
return e
end
end
return nil
end
function h:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-a-t)
local n=math.max(0,self.height-o-e)
return a,t,o,e,i,n
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
function h:_rowFromPoint(i,e)
if not self:containsPoint(i,e)then
return nil
end
local a,t=self:getAbsoluteRect()
local h,r,s,r,o,n=self:_getInnerMetrics()
if o<=0 or n<=0 then
return nil
end
local a=a+h
local t=t+s
if i<a or i>=a+o then
return nil
end
if e<t or e>=t+n then
return nil
end
local e=e-t
local e=self.scrollOffset+e
if e<1 or e>#self._flatNodes then
return nil
end
return e,a,o
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
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function h:draw(s,h)
if not self.visible then
return
end
local t,a,o,n=self:getAbsoluteRect()
local i=self.bg or e.black
local l=self.fg or e.white
u(s,t,a,o,n,i,i)
k(s,t,a,o,n)
if self.border then
b(h,t,a,o,n,self.border,i)
end
local n,d,r,d,o,h=self:_getInnerMetrics()
if o<=0 or h<=0 then
return
end
local n=t+n
local r=a+r
local u=self._flatNodes
local c=#u
if c==0 then
for e=0,h-1 do
s.text(n,r+e,string.rep(" ",o),l,i)
end
local t=self.placeholder
if type(t)=="string"and#t>0 then
local t=t
if#t>o then
t=t:sub(1,o)
end
local a=n+math.floor((o-#t)/2)
if a<n then
a=n
end
s.text(a,r,t,e.lightGray,i)
end
return
end
for t=0,h-1 do
local m=r+t
local d=self.scrollOffset+t
if d>c then
s.text(n,m,string.rep(" ",o),l,i)
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
s.text(n,m,a,o,t)
end
end
end
function h:handleEvent(a,...)
if not self.visible then
return false
end
if a=="mouse_click"then
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
elseif a=="monitor_touch"then
local t,a,e=...
local o,n,i=self:_rowFromPoint(a,e)
if o then
self.app:setFocus(self)
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
local function _(e,a,t)
if e<a then
return a
end
if e>t then
return t
end
return e
end
local function T(r,a,t,o,s,n)
if not r then
return
end
n=n or e.white
local i=math.abs(o-a)
local l=a<o and 1 or-1
local h=-math.abs(s-t)
local d=t<s and 1 or-1
local e=i+h
while true do
r.pixel(a,t,n)
if a==o and t==s then
break
end
local o=2*e
if o>=h then
e=e+h
a=a+l
end
if o<=i then
e=e+i
t=t+d
end
end
end
function l:new(i,t)
t=t or{}
local o=q(t)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 8))
o.width=math.max(6,math.floor(o.width or 18))
local a=setmetatable({},l)
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
function l:_emitSelect()
if self.onSelect then
local e=self.selectedIndex
local t=e and self.data[e]or nil
self.onSelect(self,e,t)
end
end
function l:_clampSelection(a)
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
function l:setData(e)
o(1,e,"table")
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
function l:getData()
return self.data
end
function l:setLabels(e)
if e==nil then
self.labels={}
return
end
o(1,e,"table")
local a={}
for t=1,#e do
local e=e[t]
if e~=nil then
a[t]=tostring(e)
end
end
self.labels=a
end
function l:getLabels()
return self.labels
end
function l:getLabel(e)
if type(e)~="number"then
return nil
end
if not self.labels then
return nil
end
return self.labels[math.floor(e)]
end
function l:setChartType(e)
if e==nil then
return
end
o(1,e,"string")
local e=e:lower()
if e~="bar"and e~="line"then
error("Chart type must be 'bar' or 'line'",2)
end
self.chartType=e
end
function l:setShowAxis(e)
self.showAxis=not not e
end
function l:setShowLabels(e)
self.showLabels=not not e
end
function l:setPlaceholder(e)
if e~=nil then
o(1,e,"string")
end
self.placeholder=e or""
end
function l:setRange(e,t)
if e~=nil then
o(1,e,"number")
end
if t~=nil then
o(2,t,"number")
end
self.minValue=e
self.maxValue=t
end
function l:setRangePadding(e)
o(1,e,"number")
if e<0 then
e=0
end
self.rangePadding=e
end
function l:setOnSelect(e)
if e~=nil then
o(1,e,"function")
end
self.onSelect=e
end
function l:setSelectedIndex(e,a)
if e==nil then
if self.selectedIndex~=nil then
self.selectedIndex=nil
if not a then
self:_emitSelect()
end
end
return false
end
o(1,e,"number")
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
function l:getSelectedIndex()
return self.selectedIndex
end
function l:getSelectedValue()
local e=self.selectedIndex
if not e then
return nil
end
return self.data[e]
end
function l:onFocusChanged(e)
if e then
self:_clampSelection(true)
end
end
function l:_indexFromPoint(t)
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
function l:_moveSelection(a)
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
function l:draw(h,p)
if not self.visible then
return
end
local o,a,i,s=self:getAbsoluteRect()
local n=self.bg or e.black
local f=self.fg or e.white
u(h,o,a,i,s,n,n)
k(h,o,a,i,s)
if self.border then
b(p,o,a,i,s,self.border,n)
end
local t=self.border
local r=(t and t.thickness)or 0
local d=(t and t.left)and r or 0
local c=(t and t.right)and r or 0
local l=(t and t.top)and r or 0
local t=(t and t.bottom)and r or 0
local o=o+d
local y=a+l
local a=math.max(0,i-d-c)
local t=math.max(0,s-l-t)
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
local t=y+math.floor((t-1)/2)
h.text(a,t,i,e.lightGray,n)
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
local w=s>0 and(c+1)or nil
local l
if i>0 then
if w then
l=w+1
else
l=c+1
end
if l>y+t-1 then
l=y+t-1
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
s[i]={
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
e=_(e,0,1)
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
local t=self.barColor or f
if self.selectedIndex==a then
t=self.highlightColor or t
end
u(h,s[a].left,o,s[a].width,e,t,t)
end
else
local a={}
for o=1,r do
local n=self.data[o]or 0
local e=0
if i>0 then
e=(n-t)/i
end
e=_(e,0,1)
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
T(p,t.x,t.y,e.x,e.y,self.lineColor or f)
end
for i=1,#a do
local t=a[i]
local a=self.lineColor or f
local o="o"
if self.selectedIndex==i then
a=self.highlightColor or e.orange
o="O"
end
h.text(t.x,t.y,o,a,n)
end
end
if w then
u(h,o,w,a,1,n,n)
local e=string.rep("-",a)
h.text(o,w,e,self.axisColor or f,n)
end
if l then
u(h,o,l,a,1,n,n)
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
h.text(o,l,t,e,n)
end
end
end
self._lastLayout={
innerX=o,
innerWidth=a,
dataCount=r,
bars=s
}
end
function l:handleEvent(e,...)
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
function d:new(i,a)
a=a or{}
local o=q(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local t=setmetatable({},d)
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
t.border=x(true)
end
t:_normalizeSelection(true)
return t
end
function d:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-a-o)
local n=math.max(0,self.height-t-e)
return a,o,t,e,i,n
end
function d:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function d:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function d:_ensureSelectionVisible()
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
function d:_normalizeSelection(t)
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
function d:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function d:setItems(t)
o(1,t,"table")
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
function d:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function d:setSelectedIndex(e,t)
if#self.items==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
o(1,e,"number")
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
function d:getSelectedIndex()
return self.selectedIndex
end
function d:setOnSelect(e)
if e~=nil then
o(1,e,"function")
end
self.onSelect=e
end
function d:setPlaceholder(e)
if e~=nil then
o(1,e,"string")
end
self.placeholder=e
end
function d:setHighlightColors(e,t)
if e~=nil then
o(1,e,"number")
self.highlightBg=e
end
if t~=nil then
o(2,t,"number")
self.highlightFg=t
end
end
function d:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function d:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function d:_itemIndexFromPoint(t,e)
if not self:containsPoint(t,e)then
return nil
end
local a,s=self:getAbsoluteRect()
local n,r,h,r,o,i=self:_getInnerMetrics()
if o<=0 or i<=0 then
return nil
end
local n=a+n
local a=s+h
if t<n or t>=n+o then
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
function d:_moveSelection(t)
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
function d:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
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
local a=z.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function d:_searchForPrefix(e)
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
function d:draw(o,h)
if not self.visible then
return
end
local a,n,s,t=self:getAbsoluteRect()
local i=self.bg or e.black
local r=self.fg or e.white
u(o,a,n,s,t,i,i)
k(o,a,n,s,t)
if self.border then
b(h,a,n,s,t,self.border,i)
end
local s,l,d,l,t,h=self:_getInnerMetrics()
if t<=0 or h<=0 then
return
end
local a=a+s
local s=n+d
local d=#self.items
local n=i
local l=self.highlightBg or e.lightGray
local u=self.highlightFg or e.black
if d==0 then
for e=0,h-1 do
o.text(a,s+e,string.rep(" ",t),r,n)
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
o.text(t,s,i,e.lightGray,n)
end
return
end
for e=0,h-1 do
local s=s+e
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
local n=n
local t=r
if i==self.selectedIndex then
n=l
t=u
end
o.text(a,s,e,t,n)
end
end
end
function d:handleEvent(a,...)
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
function f:new(i,t)
t=t or{}
local o=q(t)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},f)
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
a.border=x(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function f:_normalizeSelection()
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
function f:setItems(t)
o(1,t,"table")
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
function f:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function f:setSelectedIndex(e,t)
if e==nil then
return
end
o(1,e,"number")
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
function f:setOnChange(e)
if e~=nil then
o(1,e,"function")
end
self.onChange=e
end
function f:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function f:_setOpen(e)
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
function f:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function f:_isPointInDropdown(e,t)
if not self._open or#self.items==0 then
return false
end
local o,n,i,a=self:getAbsoluteRect()
local a=n+a
return e>=o and e<o+i and t>=a and t<a+#self.items
end
function f:_indexFromPoint(t,e)
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
function f:_handlePress(e,t)
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
function f:draw(o,h)
if not self.visible then
return
end
local i,a,s,n=self:getAbsoluteRect()
local t=self.bg or e.black
local l=self.fg or e.white
u(o,i,a,s,n,t,t)
k(o,i,a,s,n)
if self.border then
b(h,i,a,s,n,self.border,t)
end
local e=self.border
local d=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local h=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local r=i+d
local s=math.max(0,s-d-u)
local d=a+h
local e=math.max(0,n-h-e)
local h=s>0 and 1 or 0
local i=math.max(0,s-h)
local n
if e>0 then
n=d+math.floor((e-1)/2)
else
n=a
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
o.text(r,n,e,l,t)
end
if h>0 then
local a=self._open and string.char(30)or string.char(31)
local e=r+s-1
o.text(e,n,a,l,t)
end
end
function f:_drawDropdown(s,d)
if not self._open or#self.items==0 or self.visible==false then
return
end
local i,e,o,t=self:getAbsoluteRect()
local a=e+t
local h=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local l=i+t
local t=math.max(0,o-t-n)
local r=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local n=h+e
u(s,i,a,o,n,self.dropdownBg,self.dropdownBg)
k(s,i,a,o,n)
for e=1,h do
local n=a+e-1
local a=self.items[e]or""
local e=r~=nil and r==e
local o=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local i=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if t>0 then
local e=a
if#e>t then
e=e:sub(1,t)
end
local t=math.max(0,t-#e)
local e=e..string.rep(" ",t)
s.text(l,n,e,i,o)
end
end
if self.border then
local e=q(self.border)
if e then
e.top=false
b(d,i,a,o,n,e,self.dropdownBg)
end
end
end
function f:handleEvent(e,...)
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
local a,t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
end
elseif e=="key"then
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
elseif e=="char"then
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
local a={}
a.__index=a
setmetatable(a,{__index=r})
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
local T={
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
local function A(a)
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
local function R(e)
return table.concat(e,"\n")
end
local function q(e,a,t)
if e<a then
return a
end
if e>t then
return t
end
return e
end
local function _(a,o,t,e)
if a<t then
return-1
end
if a>t then
return 1
end
if o<e then
return-1
end
if o>e then
return 1
end
return 0
end
local function D(e,t,a,i,o,n)
if _(e,t,a,i)<0 then
return false
end
if _(e,t,o,n)>=0 then
return false
end
return true
end
local function L(a)
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
builtins=T,
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
t.builtins=t.builtins or T
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
function a:new(n,o)
o=o or{}
local i={}
for e,t in pairs(o)do
i[e]=t
end
i.focusable=true
i.width=math.max(4,math.floor(i.width or 16))
i.height=math.max(1,math.floor(i.height or(o.multiline~=false and 5 or 1)))
local t=setmetatable({},a)
t:_init_base(n,i)
t.focusable=true
t.placeholder=o.placeholder or""
t.onChange=o.onChange or nil
t.onCursorMove=o.onCursorMove or nil
t.maxLength=o.maxLength or nil
t.multiline=o.multiline~=false
t.tabWidth=math.max(1,math.floor(o.tabWidth or 4))
t.selectionBg=o.selectionBg or e.lightGray
t.selectionFg=o.selectionFg or e.black
t.overlayBg=o.overlayBg or e.gray
t.overlayFg=o.overlayFg or e.white
t.overlayActiveBg=o.overlayActiveBg or e.orange
t.overlayActiveFg=o.overlayActiveFg or e.black
t.autocomplete=o.autocomplete
t.autocompleteAuto=not not o.autocompleteAuto
t.autocompleteMaxItems=math.max(1,math.floor(o.autocompleteMaxItems or 5))
t.autocompleteBg=o.autocompleteBg or e.gray
t.autocompleteFg=o.autocompleteFg or e.white
t.autocompleteGhostColor=o.autocompleteGhostColor or e.lightGray
t.syntax=L(o.syntax)
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
t.border=x(true)
end
t:_setTextInternal(o.text or"",true,true)
if o.cursorPos then
t:_moveCursorToIndex(o.cursorPos)
end
t:_ensureCursorVisible()
return t
end
function a:setOnCursorMove(e)
if e~=nil then
o(1,e,"function")
end
self.onCursorMove=e
end
function a:onFocusChanged(e)
self:_ensureCursorVisible()
end
function a:_applyMaxLength(e)
if not self.maxLength then
return e
end
if#e<=self.maxLength then
return e
end
return e:sub(1,self.maxLength)
end
function a:_syncTextFromLines()
self.text=R(self._lines)
end
function a:_setTextInternal(e,t,a)
e=tostring(e or"")
e=self:_applyMaxLength(e)
self._lines=A(e)
self:_syncTextFromLines()
if t then
self._cursorLine=#self._lines
self._cursorCol=(#self._lines[#self._lines]or 0)+1
else
self._cursorLine=q(self._cursorLine,1,#self._lines)
local e=self._lines[self._cursorLine]or""
self._cursorCol=q(self._cursorCol,1,#e+1)
end
self._preferredCol=self._cursorCol
self._selectionAnchor=nil
self:_ensureCursorVisible()
if not a then
self:_notifyChange()
self:_notifyCursorChange()
end
end
function a:_indexToPosition(e)
e=q(e or 1,1,#self.text+1)
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
function a:_moveCursorToIndex(e)
local t,e=self:_indexToPosition(e)
self:_setCursorPosition(t,e)
end
function a:getCursorPosition()
return self._cursorLine,self._cursorCol
end
function a:getLineCount()
return#self._lines
end
function a:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n,i=self:getAbsoluteRect()
local s=n+t
local i=i+a
local n=math.max(0,self.width-t-o)
local o=math.max(0,self.height-a-e)
return s,i,n,o,t,a,e
end
function a:_getOverlayHeight(e)
if not self._find.visible then
return 0
end
return math.min(2,e)
end
function a:_getContentSize()
local a,a,t,e=self:_getInnerMetrics()
if t<=0 or e<=0 then
return math.max(1,self.width),math.max(1,self.height)
end
local a=self:_getOverlayHeight(e)
local e=math.max(1,e-a)
return math.max(1,t),e
end
function a:_ensureCursorVisible()
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
function a:_notifyChange()
if self.onChange then
self.onChange(self,self.text)
end
end
function a:_notifyCursorChange()
if self.onCursorMove then
self.onCursorMove(self,self._cursorLine,self._cursorCol,self:getSelectionLength())
end
end
function a:_hasSelection()
if not self._selectionAnchor then
return false
end
if self._selectionAnchor.line~=self._cursorLine then
return true
end
return self._selectionAnchor.col~=self._cursorCol
end
function a:getSelectionLength()
if not self:_hasSelection()then
return 0
end
local a,o,e,t=self:_getSelectionRange()
local e=self:_collectRange(a,o,e,t)
return#e
end
function a:getSelectionText()
if not self:_hasSelection()then
return""
end
local o,a,e,t=self:_getSelectionRange()
return self:_collectRange(o,a,e,t)
end
function a:_getSelectionRange()
if not self:_hasSelection()then
return nil
end
local e=self._selectionAnchor
local t,a=e.line,e.col
local e,o=self._cursorLine,self._cursorCol
if _(t,a,e,o)<=0 then
return t,a,e,o
else
return e,o,t,a
end
end
function a:_collectRange(t,o,a,i)
if t==a then
return(self._lines[t]or""):sub(o,i-1)
end
local e={}
e[#e+1]=(self._lines[t]or""):sub(o)
for t=t+1,a-1 do
e[#e+1]=self._lines[t]or""
end
e[#e+1]=(self._lines[a]or""):sub(1,i-1)
return table.concat(e,"\n")
end
function a:_clearSelection()
self._selectionAnchor=nil
end
function a:_removeRange(e,a,t,o)
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
function a:_insertAt(e,t,a)
if a==nil or a==""then
return e,t
end
local a=A(a)
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
function a:_deleteSelection(i)
local e,t,o,a=self:_getSelectionRange()
if not e then
return 0
end
local n=self:_collectRange(e,t,o,a)
self:_removeRange(e,t,o,a)
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
function a:_replaceSelection(e,a)
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
function a:_insertTextAtCursor(e)
if not e or e==""then
return false
end
return self:_replaceSelection(e,false)
end
function a:_insertCharacter(e)
if not e or e==""then
return false
end
return self:_insertTextAtCursor(e)
end
function a:_insertNewline()
if not self.multiline then
return false
end
return self:_insertTextAtCursor("\n")
end
function a:_insertTab()
local e=string.rep(" ",self.tabWidth)
return self:_insertTextAtCursor(e)
end
function a:_deleteBackward()
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
function a:_deleteForward()
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
function a:_setCursorPosition(t,a,e)
e=e or{}
t=q(t,1,#self._lines)
local o=self._lines[t]or""
a=q(a,1,#o+1)
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
function a:_moveCursorLeft(e)
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
function a:_moveCursorRight(e)
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
function a:_moveCursorVertical(e,t)
local e=q(self._cursorLine+e,1,#self._lines)
local a=self._lines[e]or""
local a=q(self._preferredCol,1,#a+1)
self:_setCursorPosition(e,a,{extendSelection=t,preservePreferred=true})
end
function a:_moveCursorUp(e)
self:_moveCursorVertical(-1,e)
end
function a:_moveCursorDown(e)
self:_moveCursorVertical(1,e)
end
function a:_moveCursorLineStart(e)
self:_setCursorPosition(self._cursorLine,1,{extendSelection=e})
end
function a:_moveCursorLineEnd(e)
local t=self._lines[self._cursorLine]
self:_setCursorPosition(self._cursorLine,#t+1,{extendSelection=e})
end
function a:_moveCursorDocumentStart(e)
self:_setCursorPosition(1,1,{extendSelection=e})
end
function a:_moveCursorDocumentEnd(a)
local e=#self._lines
local t=#self._lines[e]
self:_setCursorPosition(e,t+1,{extendSelection=a})
end
function a:_selectAll()
self._selectionAnchor={line=1,col=1}
self:_setCursorPosition(#self._lines,(#self._lines[#self._lines]or 0)+1,{extendSelection=true,keepAutocomplete=true})
end
function a:_scrollLines(e)
if e==0 then
return
end
local a,t=self:_getContentSize()
local t=math.max(0,#self._lines-t)
self._scrollY=q(self._scrollY+e,0,t)
end
function a:_scrollColumns(e)
if e==0 then
return
end
local t=select(1,self:_getContentSize())
local a=self._lines[self._cursorLine]or""
local t=math.max(0,#a-t)
self._scrollX=q(self._scrollX+e,0,t)
end
function a:_cursorFromPoint(s,h)
local n,a=self:getAbsoluteRect()
local o,i,e,t=self:_getInnerMetrics()
local r=self:_getOverlayHeight(t)
local r=math.max(1,t-r)
local o=e>0 and o or n
local t=t>0 and i or a
local a=q(s-o,0,math.max(0,(e>0 and e or self.width)-1))
local e=q(h-t,0,r-1)
local e=q(self._scrollY+e+1,1,#self._lines)
local t=self._lines[e]or""
local t=q(self._scrollX+a+1,1,#t+1)
return e,t
end
function a:_computeSyntaxColors(o)
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
for n,o,e in o:gmatch("()([%a_][%w_]*)()")do
local s=o:lower()
if t.keywords and t.keywords[s]then
if t.keywordColor then
for e=n,e-1 do
if a[e]==i then
a[e]=t.keywordColor
end
end
end
elseif t.builtins and t.builtins[o]then
if t.builtinColor then
for e=n,e-1 do
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
local function q(t,a,i,o)
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
function a:_buildLineSegments(s,t,h,r,e)
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
local o=o and o[t]or h
local a=r
if e and D(s,t,e.startLine,e.startCol,e.endLine,e.endCol)then
a=self.selectionBg
o=self.selectionFg
end
q(n,i,o,a)
end
return n,a,o
end
function a:_drawSegments(a,t,i,e)
local t=t
for o=1,#e do
local e=e[o]
if e.text~=""then
a.text(t,i,e.text,e.fg,e.bg)
t=t+#e.text
end
end
end
function a:_drawFindOverlay(s,a,n,t,i)
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
local n=n+i-o
for e=0,o-1 do
s.text(a,n+e,string.rep(" ",t),r,d)
end
local e=self._find
local i=#e.matches
local h=i>0 and string.format("%d/%d",math.max(1,e.index),i)or"0/0"
local i=e.matchCase and"CASE"or"case"
local i=string.format("Find: %s  %s  %s",e.findText,h,i)
local l="Replace: "..e.replaceText
local h=i
if#h>t then
h=h:sub(1,t)
end
local i=l
if#i>t then
i=i:sub(1,t)
end
s.text(a,n,h..string.rep(" ",math.max(0,t-#h)),r,d)
s.text(a,n+math.max(o-1,0),i..string.rep(" ",math.max(0,t-#i)),r,d)
local i,h,l
if e.activeField=="find"then
i=a+6
h=n
l=e.findText
else
i=a+9
h=n+math.max(o-1,0)
l=e.replaceText
end
local e=l
if#e>t-(i-a)then
e=e:sub(1,t-(i-a))
end
s.text(i,h,e..string.rep(" ",math.max(0,t-(i-a)-#e)),u,c)
if o>=2 then
local e="Ctrl+G next | Ctrl+Shift+G prev | Tab switch | Enter apply | Esc close"
if#e>t then
e=e:sub(1,t)
end
s.text(a,n+o-1,e..string.rep(" ",math.max(0,t-#e)),r,d)
end
end
function a:_hideAutocomplete()
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
function a:_updateAutocomplete(n)
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
function a:_computeAutocompleteGhost(e,t,a)
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
function a:_acceptAutocomplete()
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
function a:_moveAutocompleteSelection(a)
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
function a:_toggleFindOverlay(e)
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
function a:_closeFindOverlay()
local e=self._find
if e.visible then
e.visible=false
e.matches={}
e.index=0
end
end
function a:_toggleFindField()
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
function a:_editFindFieldText(t)
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
function a:_handleOverlayBackspace()
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
function a:_updateFindMatches(t)
local e=self._find
e.matches={}
e.index=t and 0 or e.index
if not e.visible or e.findText==""then
return
end
local o=e.findText
local t=e.matchCase
for a=1,#self._lines do
local i=self._lines[a]
local i=t and i or i:lower()
local t=t and o or o:lower()
local o=1
while true do
local t,i=i:find(t,o,true)
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
function a:_selectMatch(e)
if not e then
return
end
self._selectionAnchor={line=e.line,col=e.col}
self:_setCursorPosition(e.line,e.col+e.length,{extendSelection=true,keepAutocomplete=true})
self:_ensureCursorVisible()
self:_notifyCursorChange()
end
function a:_gotoMatch(o)
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
if _(e.line,e.col,self._cursorLine,self._cursorCol)>=0 then
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
function a:_gotoNextMatch()
return self:_gotoMatch(1)
end
function a:_gotoPreviousMatch()
return self:_gotoMatch(-1)
end
function a:_replaceCurrentMatch()
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
function a:_replaceAll()
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
function a:_handleEscape()
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
function a:_handleKey(e,a)
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
function a:draw(i,p)
if not self.visible then
return
end
local l,c,m,f=self:getAbsoluteRect()
local d=self.bg or e.black
local w=self.fg or e.white
u(i,l,c,m,f,d,d)
k(i,l,c,m,f)
local n,r,a,h=self:_getInnerMetrics()
if a<=0 or h<=0 then
n=l
r=c
a=m
h=f
end
local t=self:_getOverlayHeight(h)
local o=math.max(1,h-t)
local y
local u=false
if self:_hasSelection()then
local a,t,e,o=self:_getSelectionRange()
y={
startLine=a,
startCol=t,
endLine=e,
endCol=o
}
u=true
end
local t=self._autocompleteState
local s=d
for h=0,o-1 do
local o=self._scrollY+h+1
local h=r+h
if o>#self._lines then
i.text(n,h,string.rep(" ",a),w,s)
else
local d,r,l=self:_buildLineSegments(o,a,w,s,y)
self:_drawSegments(i,n,h,d)
if self:isFocused()and o==self._cursorLine then
local t=self._cursorCol-self._scrollX-1
if t>=0 and t<a then
local e
if self._cursorCol<=#r then
e=r:sub(self._cursorCol,self._cursorCol)
else
e=" "
end
local a=s
local o=w
i.text(n+t,h,e,a,o)
end
end
if self:isFocused()and t.visible and t.ghost~=""and not u and o==t.anchorLine then
local d=t.anchorCol+#t.prefix
local o=d-self._scrollX-1
if o<a then
local t=t.ghost
local r=#r
if d<=r then
local e=r-d+1
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
i.text(n,r,t..string.rep(" ",math.max(0,a-#t)),e.lightGray,s)
end
self:_drawFindOverlay(i,n,r,a,h)
if self.border then
b(p,l,c,m,f,self.border,d)
end
end
function a:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local e,t,a=...
if self:containsPoint(t,a)then
self.app:setFocus(self)
local a,t=self:_cursorFromPoint(t,a)
if e==1 then
self:_setCursorPosition(a,t)
self._dragging=true
self._dragButton=e
self._dragAnchor={line=a,col=t}
elseif e==2 then
self:_setCursorPosition(a,t)
end
return true
end
elseif e=="mouse_drag"then
local t,a,e=...
if self._dragging and t==self._dragButton then
local t,e=self:_cursorFromPoint(a,e)
if not self._selectionAnchor and self._dragAnchor then
self._selectionAnchor={line=self._dragAnchor.line,col=self._dragAnchor.col}
end
self:_setCursorPosition(t,e,{extendSelection=true,keepAutocomplete=true})
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
local e,a,t=...
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
function a:setText(e,t)
o(1,e,"string")
self:_setTextInternal(e,true,t)
end
function a:getText()
return self.text
end
function a:setOnChange(e)
if e~=nil then
o(1,e,"function")
end
self.onChange=e
end
function v.create(t)
if t~=nil then
o(1,t,"table")
end
t=t or{}
local h=false
local i
local o=t.window
if o==nil then
i=I.current()
local t,e=i.getSize()
o=H.create(i,1,1,t,e,true)
o.setVisible(true)
h=true
end
local a=N.new(o)
a.profiler.start_frame()
a.profiler.start_region("user")
local l=a.add_pixel_layer(5,"pixelui_pixels")
local u=a.add_text_layer(10,"pixelui_ui")
local r,d=o.getSize()
local n=t.background or e.black
a.fill(n)
local c=math.max(.01,t.animationInterval or .05)
local a=setmetatable({
window=o,
box=a,
layer=u,
pixelLayer=l,
background=n,
running=false,
_autoWindow=h,
_parentTerminal=i,
_focusWidget=nil,
_popupWidgets={},
_popupLookup={},
_animations={},
_animationTimer=nil,
_animationInterval=c,
_radioGroups={}
},s)
a.root=g:new(a,{
x=1,
y=1,
width=r,
height=d,
bg=n,
fg=e.white,
border=t.rootBorder,
z=-math.huge
})
return a
end
function s:getRoot()
return self.root
end
function s:setBackground(e)
o(1,e,"number")
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
return g:new(self,e)
end
function s:createButton(e)
return j:new(self,e)
end
function s:createLabel(e)
return y:new(self,e)
end
function s:createCheckBox(e)
return w:new(self,e)
end
function s:createToggle(e)
return p:new(self,e)
end
function s:createTextBox(e)
return a:new(self,e)
end
function s:createComboBox(e)
return f:new(self,e)
end
function s:createList(e)
return d:new(self,e)
end
function s:createTable(e)
return i:new(self,e)
end
function s:createTreeView(e)
return h:new(self,e)
end
function s:createChart(e)
return l:new(self,e)
end
function s:createRadioButton(e)
return c:new(self,e)
end
function s:createProgressBar(e)
return m:new(self,e)
end
function s:createSlider(e)
return n:new(self,e)
end
function s:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=z.startTimer(self._animationInterval)
end
end
function s:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=z.clock()
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
o(1,e,"table")
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
t=E.linear
elseif type(t)=="string"then
t=E[t]
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
local i=self.layer
local o=self.pixelLayer
local a=1
while a<=#t do
local e=t[a]
if e and e._open and e.visible~=false then
e:_drawDropdown(i,o)
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
o(1,e,"table")
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
local e=...
if self._animationTimer and e==self._animationTimer then
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
local e=self._parentTerminal or I.current()
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
self:render()
end
function s:run()
self.running=true
self:render()
while self.running do
local e={S()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
end
function s:stop()
self.running=false
self:_clearAnimations(true)
end
v.widgets={
Frame=function(t,e)
return g:new(t,e)
end,
Button=function(e,t)
return j:new(e,t)
end,
Label=function(t,e)
return y:new(t,e)
end,
CheckBox=function(t,e)
return w:new(t,e)
end,
Toggle=function(t,e)
return p:new(t,e)
end,
TextBox=function(e,t)
return a:new(e,t)
end,
ComboBox=function(e,t)
return f:new(e,t)
end,
List=function(e,t)
return d:new(e,t)
end,
Table=function(t,e)
return i:new(t,e)
end,
TreeView=function(t,e)
return h:new(t,e)
end,
Chart=function(t,e)
return l:new(t,e)
end,
RadioButton=function(t,e)
return c:new(t,e)
end,
ProgressBar=function(e,t)
return m:new(e,t)
end,
Slider=function(t,e)
return n:new(t,e)
end
}
v.Widget=r
v.Frame=g
v.Button=j
v.Label=y
v.CheckBox=w
v.Toggle=p
v.TextBox=a
v.ComboBox=f
v.List=d
v.Table=i
v.TreeView=h
v.Chart=l
v.RadioButton=c
v.ProgressBar=m
v.Slider=n
v.easings=E
return v
