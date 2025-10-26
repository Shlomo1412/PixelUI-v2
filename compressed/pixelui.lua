local x=assert(rawget(_G,"term"),"term API unavailable")
local t=assert(rawget(_G,"colors"),"colors API unavailable")
local k=assert(rawget(_G,"os"),"os API unavailable")
local A=assert(k.pullEvent,"os.pullEvent unavailable")
local T=assert(rawget(_G,"window"),"window API unavailable")
local a=assert(rawget(_G,"keys"),"keys API unavailable")
local e=require("cc.expect").expect
local _=require("shrekbox")
local w={
version="0.1.0"
}
local j={
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
local y={}
y.__index=y
setmetatable(y,{__index=h})
local v={}
v.__index=v
setmetatable(v,{__index=h})
local f={}
f.__index=f
setmetatable(f,{__index=h})
local m={}
m.__index=m
setmetatable(m,{__index=h})
local r={}
r.__index=r
setmetatable(r,{__index=h})
local o={}
o.__index=o
setmetatable(o,{__index=h})
local s={}
s.__index=s
setmetatable(s,{__index=h})
local i={}
i.__index=i
setmetatable(i,{__index=h})
local d={}
d.__index=d
setmetatable(d,{__index=h})
local u={}
u.__index=u
setmetatable(u,{__index=h})
local n={}
n.__index=n
local c={"top","right","bottom","left"}
local E=string.char(7)
local function l(t)
if not t then
return nil
end
local e={}
for t,a in pairs(t)do
e[t]=a
end
return e
end
local function q(a,t)
e(nil,a,"string")
e(nil,t,"number")
if t<1 or t~=math.floor(t)then
error(('%s must be a positive integer, got "%s"'):format(a,tostring(t)),3)
end
end
local function g(a)
if not a or a==false then
return nil
end
if a==true then
return{
color=t.lightGray,
top=true,
right=true,
bottom=true,
left=true,
thickness=1
}
end
e(1,a,"table")
local e={
color=a.color or t.lightGray,
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
for e=1,#c do
o(c[e],a[c[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function c(a,o,n,t,e,i,h,s)
if t<=0 or e<=0 then
return
end
local s=s or" "
local t=s:rep(t)
for e=0,e-1 do
a.text(o,n+e,t,i,h)
end
end
local function b(e,a,t,i,n)
if i<=0 or n<=0 then
return
end
local o=_.transparent
for i=0,i-1 do
e.pixel(a+i,t,o)
if n>1 then
e.pixel(a+i,t+n-1,o)
end
end
for n=1,math.max(0,n-2)do
e.pixel(a,t+n,o)
if i>1 then
e.pixel(a+i-1,t+n,o)
end
end
end
local function p(d,a,t,i,o,e,s)
if i<=0 or o<=0 then
return
end
local n=e.color
local h=s or n
local a=(a-1)*2+1
local t=(t-1)*3+1
local i=i*2
local o=o*3
local l=3
local c=2
local r=math.min(e.thickness,o)
local s=math.min(e.thickness,i)
local u=math.min(o,math.max(r,l))
local l=math.min(i,math.max(s,c))
local function c(e,s,n)
for s=0,s-1 do
local e=e+s
if e<t or e>=t+o then break end
for t=0,i-1 do
d.pixel(a+t,e,n)
end
end
end
local function m(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+o then break end
for t=0,i-1 do
d.pixel(a+t,e,n)
end
end
end
local function f(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+i then break end
for a=0,o-1 do
d.pixel(e,t+a,n)
end
end
end
local function w(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+i then break end
for a=0,o-1 do
d.pixel(e,t+a,n)
end
end
end
if e.left then
f(a,l,h)
end
if e.right then
f(a+i-l,l,h)
end
if e.top then
c(t,u,h)
end
if e.bottom then
c(t+o-u,u,h)
end
if e.top then
m(t,r,n)
end
if e.bottom then
m(t+o-r,r,n)
end
if e.left then
w(a,s,n)
end
if e.right then
w(a+i-s,s,n)
end
end
local function z(e)
local t,a=e.x,e.y
local e=e.parent
while e do
t=t+e.x-1
a=a+e.y-1
e=e.parent
end
return t,a
end
function h:_init_base(o,a)
e(1,o,"table")
a=a or{}
e(2,a,"table","nil")
self.app=o
self.parent=nil
self.x=math.floor(a.x or 1)
self.y=math.floor(a.y or 1)
self.width=math.floor(a.width or 1)
self.height=math.floor(a.height or 1)
self.bg=a.bg or t.black
self.fg=a.fg or t.white
self.visible=a.visible~=false
self.z=a.z or 0
self.id=a.id
self.border=g(a.border)
self.focusable=a.focusable==true
self._focused=false
q("width",self.width)
q("height",self.height)
end
function h:setSize(e,t)
q("width",e)
q("height",t)
self.width=e
self.height=t
end
function h:setPosition(a,t)
e(1,a,"number")
e(2,t,"number")
self.x=math.floor(a)
self.y=math.floor(t)
end
function h:setZ(t)
e(1,t,"number")
self.z=t
end
function h:setBorder(t)
if t==nil then
self.border=nil
return
end
if t==false then
self.border=nil
return
end
if t==true then
self.border=g(true)
return
end
e(1,t,"table","boolean")
self.border=g(t)
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
local e,t=z(self)
return e,t,self.width,self.height
end
function h:containsPoint(e,t)
local o,a,i,n=self:getAbsoluteRect()
return e>=o and e<o+i and t>=a and t<a+n
end
function h:draw(e,e)
error("draw needs implementation for widget",2)
end
function h:handleEvent(e,...)
return false
end
function y:new(a,t)
local e=setmetatable({},y)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function y:addChild(t)
e(1,t,"table")
if t.app~=self.app then
error("Cannot add widget from a different PixelUI app",2)
end
if t.parent and t.parent~=self then
local e=rawget(t.parent,"removeChild")
if type(e)=="function"then
e(t.parent,t)
end
end
t.parent=self
self._orderCounter=self._orderCounter+1
t._orderIndex=self._orderCounter
table.insert(self._children,t)
return t
end
function y:removeChild(e)
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
local function q(a)
local t={}
for e=1,#a do
t[e]=a[e]
end
return t
end
local function z(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function y:getChildren()
return q(self._children)
end
function y:setTitle(t)
if t~=nil then
e(1,t,"string")
end
self.title=t
end
function y:draw(n,r)
if not self.visible then
return
end
local s,i,o,a=self:getAbsoluteRect()
local t=self.bg or self.app.background
local d,l=s+1,i+1
local e=math.max(0,o-2)
local h=math.max(0,a-2)
if e>0 and h>0 then
c(n,d,l,e,h,t,t)
elseif o>0 and a>0 then
c(n,s,i,o,a,t,t)
end
b(n,s,i,o,a)
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
p(r,s,i,o,a,self.border,t)
end
local e=q(self._children)
z(e)
for t=1,#e do
e[t]:draw(n,r)
end
end
function y:handleEvent(t,...)
if not self.visible then
return false
end
if h.handleEvent(self,t,...)then
return true
end
local e=q(self._children)
z(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function v:new(a,e)
local t=setmetatable({},v)
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
function v:setLabel(t)
e(1,t,"string")
self.label=t
end
function v:setOnClick(t)
if t~=nil then
e(1,t,"function")
end
self.onClick=t
end
function v:draw(r,m)
if not self.visible then
return
end
local o,i,a,h=self:getAbsoluteRect()
local e=self.bg or t.gray
local t=self.fg or t.white
local e=e
local d=t
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=o+1,i+1
local n=math.max(0,a-2)
local s=math.max(0,h-2)
if n>0 and s>0 then
c(r,l,u,n,s,e,e)
else
c(r,o,i,a,h,e,e)
end
b(r,o,i,a,h)
if self.border then
p(m,o,i,a,h,self.border,e)
end
local t=self.label or""
local a=n>0 and n or a
if#t>a then
t=t:sub(1,a)
end
local h=0
if a>#t then
h=math.floor((a-#t)/2)
end
local t=string.rep(" ",h)..t
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
r.text(o,a,t,d,e)
end
function v:handleEvent(e,...)
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
function f:new(o,e)
e=e or{}
local a=l(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},f)
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
function f:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-t-o)
local i=math.max(0,self.height-a-e)
return t,o,a,e,n,i
end
function f:_wrapLine(t,a,e)
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
function f:_updateLines(e)
local t=tostring(self.text or"")
local a=not not self.wrap
local o,o,o,o,i=self:_getInnerMetrics()
if not e and self._lastText==t and self._lastWrap==a and self._lastInnerWidth==i then
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
if a then
self:_wrapLine(t,i,e)
else
e[#e+1]=t
end
break
end
local t=t:sub(o,n-1)
t=t:gsub("\r","")
if a then
self:_wrapLine(t,i,e)
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
self._lastWrap=a
self._lastInnerWidth=i
end
function f:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function f:getText()
return self.text
end
function f:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function f:isWrapping()
return self.wrap
end
function f:setHorizontalAlign(t)
if t==nil then
t="left"
else
e(1,t,"string")
end
local e=t:lower()
if e~="left"and e~="center"and e~="right"then
error("Invalid horizontal alignment '"..t.."'",2)
end
if self.align~=e then
self.align=e
end
end
function f:setVerticalAlign(t)
if t==nil then
t="top"
else
e(1,t,"string")
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
function f:setSize(e,t)
h.setSize(self,e,t)
self:_updateLines(true)
end
function f:setBorder(e)
h.setBorder(self,e)
self:_updateLines(true)
end
function f:draw(l,m)
if not self.visible then
return
end
local s,h,d,u=self:getAbsoluteRect()
local n=self.bg or self.app.background or t.black
local f=self.fg or t.white
c(l,s,h,d,u,n,n)
b(l,s,h,d,u)
local e,o,t,o,a,i=self:_getInnerMetrics()
local o=s+e
local c=h+t
self:_updateLines(false)
local r=self._lines or{""}
local t=#r
if t==0 then
r={""}
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
local i=c+t
for e=0,e-1 do
local e=r[s+e]or""
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
l.text(t,i,e,f,n)
end
i=i+1
end
end
if self.border then
p(m,s,h,d,u,self.border,n)
end
end
function m:new(n,e)
e=e or{}
local o=l(e)or{}
local i="Option"
if e and e.label~=nil then
i=tostring(e.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local a=setmetatable({},m)
a:_init_base(n,o)
a.focusable=true
a.label=i
a.allowIndeterminate=not not(e and e.allowIndeterminate)
a.indeterminate=not not(e and e.indeterminate)
if not a.allowIndeterminate then
a.indeterminate=false
end
a.checked=not a.indeterminate and not not(e and e.checked)
a.onChange=e and e.onChange or nil
a.focusBg=e and e.focusBg or t.lightGray
a.focusFg=e and e.focusFg or t.black
return a
end
function m:_notifyChange()
if self.onChange then
self.onChange(self,self.checked,self.indeterminate)
end
end
function m:_setState(t,e,o)
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
function m:setLabel(t)
e(1,t,"string")
self.label=t
end
function m:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function m:setAllowIndeterminate(e)
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
function m:setChecked(t)
e(1,t,"boolean")
self:_setState(t,false,false)
end
function m:isChecked()
return self.checked
end
function m:setIndeterminate(t)
if not self.allowIndeterminate then
if t then
error("Indeterminate state is disabled for this CheckBox",2)
end
return
end
e(1,t,"boolean")
self:_setState(self.checked,t,false)
end
function m:isIndeterminate()
return self.indeterminate
end
function m:toggle()
self:_activate()
end
function m:_activate()
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
function m:draw(h,a)
if not self.visible then
return
end
local s,n,e,i=self:getAbsoluteRect()
local o=self.bg or t.black
local t=self.fg or t.white
local o=o
local r=t
if self:isFocused()then
o=self.focusBg or o
r=self.focusFg or r
end
c(h,s,n,e,i,o,o)
b(h,s,n,e,i)
if self.border then
p(a,s,n,e,i,self.border,o)
end
if e<=0 or i<=0 then
return
end
local t=" "
if self.indeterminate then
t="-"
elseif self.checked then
t="x"
end
local t="["..t.."]"
local a={}
a[#a+1]=t
local t=#t
if e>t then
a[#a+1]=" "
t=t+1
end
if e>t then
local o=self.label or""
local e=e-t
if#o>e then
o=o:sub(1,e)
end
a[#a+1]=o
t=t+#o
end
local t=table.concat(a)
if#t<e then
t=t..string.rep(" ",e-#t)
elseif#t>e then
t=t:sub(1,e)
end
local e=n+math.floor((i-1)/2)
h.text(s,e,t,r,o)
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
if e==a.space or e==a.enter then
self:_activate()
return true
end
end
return false
end
function d:new(n,a)
a=a or{}
local o=l(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local e=setmetatable({},d)
e:_init_base(n,o)
e.focusable=true
e.label=i
if a and a.value~=nil then
e.value=a.value
else
e.value=i
end
if a and a.group~=nil then
if type(a.group)~="string"then
error("RadioButton group must be a string",2)
end
e.group=a.group
else
e.group=nil
end
e.selected=not not(a and a.selected)
e.onChange=a and a.onChange or nil
e.focusBg=a and a.focusBg or t.lightGray
e.focusFg=a and a.focusFg or t.black
e._registeredGroup=nil
e._dotChar=E
if e.group and e.app then
e:_registerWithGroup()
if e.selected then
e.app:_selectRadioInGroup(e.group,e,true)
else
local t=e.app._radioGroups
if t then
local t=t[e.group]
if t and t.selected and t.selected~=e then
e.selected=false
end
end
end
end
e:_applySelection(e.selected,true)
return e
end
function d:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function d:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function d:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function d:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function d:setLabel(t)
e(1,t,"string")
self.label=t
end
function d:setValue(e)
self.value=e
end
function d:getValue()
return self.value
end
function d:setGroup(t)
e(1,t,"string","nil")
if self.group==t then
return
end
self:_unregisterFromGroup()
self.group=t
if self.group then
self:_registerWithGroup()
end
end
function d:getGroup()
return self.group
end
function d:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function d:setSelected(e)
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
function d:isSelected()
return self.selected
end
function d:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function d:draw(n,h)
if not self.visible then
return
end
local o,i,a,e=self:getAbsoluteRect()
local r=self.bg or t.black
local s=self.fg or t.white
local t=r
local s=s
if self:isFocused()then
t=self.focusBg or t
s=self.focusFg or s
end
c(n,o,i,a,e,t,t)
b(n,o,i,a,e)
if self.border then
p(h,o,i,a,e,self.border,t)
end
local h=i+math.floor((e-1)/2)
local e=self.selected and(self._dotChar or"*")or" "
local e="("..e..")"
local i=self.label or""
local e=e
if#i>0 then
e=e.." "..i
end
if#e>a then
e=e:sub(1,a)
elseif#e<a then
e=e..string.rep(" ",a-#e)
end
if a>0 then
n.text(o,h,e,s,t)
end
end
function d:handleEvent(e,...)
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
function r:new(i,a)
a=a or{}
local o=l(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local e=setmetatable({},r)
e:_init_base(i,o)
e.focusable=false
e.min=type(a.min)=="number"and a.min or 0
e.max=type(a.max)=="number"and a.max or 1
if e.max<=e.min then
e.max=e.min+1
end
local o=a.value
if type(o)~="number"then
o=e.min
end
e.value=e:_clampValue(o)
e.trackColor=(a.trackColor)or t.gray
e.fillColor=(a.fillColor)or t.lightBlue
e.textColor=(a.textColor)or e.fg or t.white
e.label=a.label or nil
e.showPercent=not not a.showPercent
e.indeterminate=not not a.indeterminate
e.indeterminateSpeed=math.max(.1,a.indeterminateSpeed or 1.2)
e._indeterminateProgress=0
e._animationHandle=nil
if not e.border then
e.border=g(true)
end
if e.indeterminate then
e:_startIndeterminateAnimation()
end
return e
end
function r:_clampValue(e)
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
function r:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function r:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=j.linear,
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
function r:setRange(t,a)
e(1,t,"number")
e(2,a,"number")
if a<=t then
error("ProgressBar max must be greater than min",2)
end
self.min=t
self.max=a
self.value=self:_clampValue(self.value)
end
function r:getRange()
return self.min,self.max
end
function r:setValue(t)
if self.indeterminate then
return
end
e(1,t,"number")
t=self:_clampValue(t)
if t~=self.value then
self.value=t
end
end
function r:getValue()
return self.value
end
function r:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function r:setIndeterminate(e)
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
function r:isIndeterminate()
return self.indeterminate
end
function r:setLabel(t)
if t~=nil then
e(1,t,"string")
end
self.label=t
end
function r:setShowPercent(e)
self.showPercent=not not e
end
function r:setColors(o,a,t)
if o~=nil then
e(1,o,"number")
self.trackColor=o
end
if a~=nil then
e(2,a,"number")
self.fillColor=a
end
if t~=nil then
e(3,t,"number")
self.textColor=t
end
end
function r:draw(s,e)
if not self.visible then
return
end
local a,r,n,h=self:getAbsoluteRect()
local o=self.trackColor or(self.bg or t.gray)
local i=self.fillColor or t.lightBlue
local u=self.textColor or(self.fg or t.white)
c(s,a,r,n,h,o,o)
b(s,a,r,n,h)
if self.border then
p(e,a,r,n,h,self.border,o)
end
local e=self.border
local t=(e and e.left)and 1 or 0
local l=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+t
local r=r+d
local t=math.max(0,n-t-l)
local h=math.max(0,h-d-e)
if t<=0 or h<=0 then
return
end
c(s,a,r,t,h,o,o)
local d=0
local l=0
local n=0
if self.indeterminate then
n=math.max(1,math.floor(t/3))
if n>t then
n=t
end
local t=t-n
local e=self._indeterminateProgress or 0
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
c(s,a+l,r,n,h,i,i)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
d=math.floor(t*e+.5)
if d>0 then
c(s,a,r,d,h,i,i)
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
if e~=""and h>0 then
if#e>t then
e=e:sub(1,t)
end
local c=r+math.floor((h-1)/2)
local h=a+math.floor((t-#e)/2)
if h<a then
h=a
end
for t=1,#e do
local r=e:sub(t,t)
local e=(h-a)+(t-1)
local a=o
if self.indeterminate then
if e>=l and e<l+n then
a=i
end
else
if e<d then
a=i
end
end
s.text(h+t-1,c,r,u,a)
end
end
end
function r:handleEvent(e,...)
return false
end
function o:new(n,a)
a=a or{}
local i=l(a)or{}
i.focusable=true
i.height=math.max(1,math.floor(i.height or 3))
i.width=math.max(1,math.floor(i.width or 12))
local e=setmetatable({},o)
e:_init_base(n,i)
e.focusable=true
e.min=type(a.min)=="number"and a.min or 0
e.max=type(a.max)=="number"and a.max or 100
if e.max<=e.min then
e.max=e.min+1
end
if a and type(a.step)=="number"and a.step>0 then
e.step=a.step
else
e.step=0
end
e.range=not not(a and a.range)
e.trackColor=(a and a.trackColor)or t.gray
e.fillColor=(a and a.fillColor)or t.lightBlue
e.handleColor=(a and a.handleColor)or t.white
e.showValue=not not(a and a.showValue)
if a and a.formatValue~=nil then
if type(a.formatValue)~="function"then
error("Slider formatValue must be a function",2)
end
e.formatValue=a.formatValue
else
e.formatValue=nil
end
e.onChange=a and a.onChange or nil
e._activeHandle=nil
e._focusedHandle=e.range and"lower"or"single"
e._dragging=false
if e.range then
local o
local t
if a and type(a.value)=="table"then
o=a.value[1]
t=a.value[2]
end
if type(a.startValue)=="number"then
o=a.startValue
end
if type(a.endValue)=="number"then
t=a.endValue
end
if type(o)~="number"then
o=e.min
end
if type(t)~="number"then
t=e.max
end
if o>t then
o,t=t,o
end
e.lowerValue=e:_applyStep(o)
e.upperValue=e:_applyStep(t)
if e.lowerValue>e.upperValue then
e.lowerValue,e.upperValue=e.upperValue,e.lowerValue
end
else
local t=a and a.value
if type(t)~="number"then
t=e.min
end
e.value=e:_applyStep(t)
end
if not e.border then
e.border=g(true)
end
return e
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
local o=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i,h=self:getAbsoluteRect()
local n=math.max(0,self.width-a-o)
local s=math.max(0,self.height-t-e)
local i=i+a
local o=h+t
return i,o,n,s,a,t,e
end
function o:_valueToPosition(o,a)
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
function o:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
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
function o:setValue(t)
if self.range then
return
end
e(1,t,"number")
self:_setSingleValue(t,false)
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
function o:setRangeValues(a,t,o)
if not self.range then
return
end
if a==nil then
a=self.lowerValue or self.min
end
if t==nil then
t=self.upperValue or self.max
end
e(1,a,"number")
e(2,t,"number")
if a>t then
a,t=t,a
end
local e=false
e=self:_setLowerValue(a,true)or e
e=self:_setUpperValue(t,true)or e
if e and not o then
self:_notifyChange()
end
end
function o:getRangeValues()
return self.lowerValue,self.upperValue
end
function o:setRangeLimits(a,t)
e(1,a,"number")
e(2,t,"number")
if t<=a then
error("Slider max must be greater than min",2)
end
self.min=a
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
function o:setStep(t)
if t==nil then
t=0
else
e(1,t,"number")
end
if t<=0 then
self.step=0
else
self.step=t
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
function o:setColors(o,t,a)
if o~=nil then
e(1,o,"number")
self.trackColor=o
end
if t~=nil then
e(2,t,"number")
self.fillColor=t
end
if a~=nil then
e(3,a,"number")
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
function o:_positionFromPoint(a)
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
function o:_beginInteraction(e)
local e,a=self:_positionFromPoint(e)
if not e then
return false
end
if self.range then
local i=self:_valueToPosition(self.lowerValue,a)
local o=self:_valueToPosition(self.upperValue,a)
local t=self._focusedHandle or"lower"
local s=math.abs(e-i)
local n=math.abs(e-o)
if s==n then
if e>o then
t="upper"
elseif e<i then
t="lower"
end
elseif s<n then
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
function o:draw(i,f)
if not self.visible then
return
end
local d,h,l,s=self:getAbsoluteRect()
local n=self.bg or self.app.background or t.black
c(i,d,h,l,s,n,n)
b(i,d,h,l,s)
local a,u,e,r=self:_getInnerMetrics()
if e<=0 or r<=0 then
if self.border then
p(f,d,h,l,s,self.border,n)
end
return
end
local o
local m=nil
if self.showValue and r>=2 then
m=u
o=u+r-1
else
o=u+math.floor((r-1)/2)
end
c(i,a,o,e,1,self.trackColor,self.trackColor)
local u
if self:isFocused()then
u=self._activeHandle or self._focusedHandle
end
local function r(n,s)
if n<0 or n>=e then
return
end
local e=self.handleColor or t.white
if u and s==u then
e=self.fg or t.white
end
i.text(a+n,o," ",e,e)
end
if self.range then
local t=self:_valueToPosition(self.lowerValue,e)
local e=self:_valueToPosition(self.upperValue,e)
if e<t then
t,e=e,t
end
local n=e-t+1
if n>0 then
c(i,a+t,o,n,1,self.fillColor,self.fillColor)
end
r(t,"lower")
r(e,"upper")
else
local e=self:_valueToPosition(self.value,e)
local t=e+1
if t>0 then
c(i,a,o,t,1,self.fillColor,self.fillColor)
end
r(e,"single")
end
if self.showValue and m then
local o=self:_formatDisplayValue()
if o and o~=""then
if#o>e then
o=o:sub(1,e)
end
local e=a+math.floor((e-#o)/2)
if e<a then
e=a
end
i.text(e,m,o,self.fg or t.white,n)
end
end
if self.border then
p(f,d,h,l,s,self.border,n)
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
function i:new(n,e)
e=e or{}
local o=l(e)or{}
o.focusable=true
o.height=math.max(3,math.floor(o.height or 7))
o.width=math.max(6,math.floor(o.width or 20))
local a=setmetatable({},i)
a:_init_base(n,o)
a.focusable=true
a.highlightBg=(e and e.highlightBg)or t.lightGray
a.highlightFg=(e and e.highlightFg)or t.black
a.placeholder=(e and e.placeholder)or nil
a.indentWidth=math.max(1,math.floor((e and e.indentWidth)or 2))
local t=(e and e.toggleSymbols)or{}
a.toggleSymbols={
expanded=tostring(t.expanded or"-"),
collapsed=tostring(t.collapsed or"+"),
leaf=tostring(t.leaf or" ")
}
a.onSelect=e and e.onSelect or nil
a.onToggle=e and e.onToggle or nil
a.nodes={}
a._flatNodes={}
a.scrollOffset=1
a.selectedNode=nil
a._selectedIndex=0
a.typeSearchTimeout=(e and e.typeSearchTimeout)or .75
a._typeSearch={buffer="",lastTime=0}
if not a.border then
a.border=g(true)
end
a:setNodes((e and e.nodes)or{})
return a
end
function i:setOnSelect(t)
if t~=nil then
e(1,t,"function")
end
self.onSelect=t
end
function i:setOnToggle(t)
if t~=nil then
e(1,t,"function")
end
self.onToggle=t
end
function i:_copyNodes(e,i)
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
function i:setNodes(t)
t=t or{}
e(1,t,"table")
local o=self.selectedNode
local a=self._selectedIndex
self.nodes=self:_copyNodes(t,nil)
self.scrollOffset=1
self.selectedNode=nil
self._selectedIndex=0
self:_rebuildFlatNodes()
local e=self.selectedNode
if o~=e or self._selectedIndex~=a then
self:_notifySelect()
end
end
function i:getSelectedNode()
return self.selectedNode
end
function i:setSelectedNode(e)
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
function i:expandNode(e)
self:_toggleNode(e,true)
end
function i:collapseNode(e)
self:_toggleNode(e,false)
end
function i:toggleNode(e)
self:_toggleNode(e,nil)
end
function i:_rebuildFlatNodes()
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
function i:_findVisibleIndex(a)
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
function i:_getInnerMetrics()
local e=self.border
local a=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-a-t)
local n=math.max(0,self.height-o-e)
return a,t,o,e,i,n
end
function i:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function i:_ensureSelectionVisible()
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
function i:_setSelectedIndex(e,a)
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
function i:_selectNode(t,a)
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
function i:_moveSelection(a)
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
function i:_scrollBy(e)
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
function i:_rowFromPoint(i,e)
if not self:containsPoint(i,e)then
return nil
end
local t,s=self:getAbsoluteRect()
local h,r,o,r,a,n=self:_getInnerMetrics()
if a<=0 or n<=0 then
return nil
end
local t=t+h
local o=s+o
if i<t or i>=t+a then
return nil
end
if e<o or e>=o+n then
return nil
end
local e=e-o
local e=self.scrollOffset+e
if e<1 or e>#self._flatNodes then
return nil
end
return e,t,a
end
function i:_toggleNode(e,a)
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
function i:_notifySelect()
if self.onSelect then
self.onSelect(self,self.selectedNode,self._selectedIndex)
end
end
function i:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function i:_searchForPrefix(e)
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
function i:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=k.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function i:draw(n,h)
if not self.visible then
return
end
local a,e,o,s=self:getAbsoluteRect()
local i=self.bg or t.black
local l=self.fg or t.white
c(n,a,e,o,s,i,i)
b(n,a,e,o,s)
if self.border then
p(h,a,e,o,s,self.border,i)
end
local s,h,d,h,o,r=self:_getInnerMetrics()
if o<=0 or r<=0 then
return
end
local h=a+s
local s=e+d
local c=self._flatNodes
local u=#c
if u==0 then
for e=0,r-1 do
n.text(h,s+e,string.rep(" ",o),l,i)
end
local e=self.placeholder
if type(e)=="string"and#e>0 then
local e=e
if#e>o then
e=e:sub(1,o)
end
local a=h+math.floor((o-#e)/2)
if a<h then
a=h
end
n.text(a,s,e,t.lightGray,i)
end
return
end
for e=0,r-1 do
local m=s+e
local d=self.scrollOffset+e
if d>u then
n.text(h,m,string.rep(" ",o),l,i)
else
local e=c[d]
local s=e.node
local e=e.depth or 0
local e=e*self.indentWidth
if e>o-1 then
e=o-1
end
if e<0 then
e=0
end
local a=e>0 and string.rep(" ",e)or""
local r
if s and s.children and#s.children>0 then
r=s.expanded and self.toggleSymbols.expanded or self.toggleSymbols.collapsed
else
r=self.toggleSymbols.leaf
end
r=tostring(r or" ")
local e=o-e
local a=a
if e>0 then
local t=r:sub(1,1)
a=a..t
e=e-1
end
if e>0 then
a=a.." "
e=e-1
end
if e>0 then
local t=(s and s.label)or""
if#t>e then
t=t:sub(1,e)
end
a=a..t
e=e-#t
end
if e>0 then
a=a..string.rep(" ",e)
elseif#a>o then
a=a:sub(1,o)
end
local e=i
local o=l
if d==self._selectedIndex then
e=self.highlightBg or t.lightGray
o=self.highlightFg or t.black
end
n.text(h,m,a,o,e)
end
end
end
function i:handleEvent(o,...)
if not self.visible then
return false
end
if o=="mouse_click"then
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
elseif o=="monitor_touch"then
local t,o,e=...
local a,n,i=self:_rowFromPoint(o,e)
if a then
self.app:setFocus(self)
local t=self._flatNodes[a]
if t then
local e=t.depth*self.indentWidth
if e<0 then
e=0
end
if e>i-1 then
e=i-1
end
local a=n+e
if t.node and t.node.children and#t.node.children>0 and e<i then
local e=#tostring(self.toggleSymbols.collapsed or"+")
if e<1 then
e=1
end
if o>=a and o<a+e then
self:_toggleNode(t.node,nil)
return true
end
end
end
self:_setSelectedIndex(a,false)
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
function s:new(i,a)
a=a or{}
local o=l(a)or{}
o.focusable=true
o.height=o.height or 5
o.width=o.width or 16
local e=setmetatable({},s)
e:_init_base(i,o)
e.focusable=true
e.items={}
if a and type(a.items)=="table"then
for t=1,#a.items do
local t=a.items[t]
if t~=nil then
e.items[#e.items+1]=tostring(t)
end
end
end
if type(a.selectedIndex)=="number"then
e.selectedIndex=math.floor(a.selectedIndex)
elseif#e.items>0 then
e.selectedIndex=1
else
e.selectedIndex=0
end
e.highlightBg=(a and a.highlightBg)or t.lightGray
e.highlightFg=(a and a.highlightFg)or t.black
e.placeholder=(a and a.placeholder)or nil
e.onSelect=a and a.onSelect or nil
e.scrollOffset=1
e.typeSearchTimeout=(a and a.typeSearchTimeout)or .75
e._typeSearch={buffer="",lastTime=0}
if not e.border then
e.border=g(true)
end
e:_normalizeSelection(true)
return e
end
function s:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local t=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-o-a)
local n=math.max(0,self.height-t-e)
return o,a,t,e,i,n
end
function s:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function s:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function s:_ensureSelectionVisible()
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
function s:_normalizeSelection(t)
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
function s:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function s:setItems(t)
e(1,t,"table")
local e={}
for a=1,#t do
local t=t[a]
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
function s:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function s:setSelectedIndex(t,a)
if#self.items==0 then
self.selectedIndex=0
self.scrollOffset=1
return
end
e(1,t,"number")
t=math.floor(t)
if t<1 then
t=1
elseif t>#self.items then
t=#self.items
end
if self.selectedIndex~=t then
self.selectedIndex=t
self:_ensureSelectionVisible()
if not a then
self:_notifySelect()
end
else
self:_ensureSelectionVisible()
end
end
function s:getSelectedIndex()
return self.selectedIndex
end
function s:setOnSelect(t)
if t~=nil then
e(1,t,"function")
end
self.onSelect=t
end
function s:setPlaceholder(t)
if t~=nil then
e(1,t,"string")
end
self.placeholder=t
end
function s:setHighlightColors(a,t)
if a~=nil then
e(1,a,"number")
self.highlightBg=a
end
if t~=nil then
e(2,t,"number")
self.highlightFg=t
end
end
function s:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function s:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function s:_itemIndexFromPoint(t,e)
if not self:containsPoint(t,e)then
return nil
end
local a,s=self:getAbsoluteRect()
local i,r,h,r,o,n=self:_getInnerMetrics()
if o<=0 or n<=0 then
return nil
end
local i=a+i
local a=s+h
if t<i or t>=i+o then
return nil
end
if e<a or e>=a+n then
return nil
end
local e=e-a
local e=self.scrollOffset+e
if e<1 or e>#self.items then
return nil
end
return e
end
function s:_moveSelection(t)
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
function s:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
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
local a=k.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function s:_searchForPrefix(e)
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
function s:draw(o,r)
if not self.visible then
return
end
local a,n,s,e=self:getAbsoluteRect()
local i=self.bg or t.black
local h=self.fg or t.white
c(o,a,n,s,e,i,i)
b(o,a,n,s,e)
if self.border then
p(r,a,n,s,e,self.border,i)
end
local d,l,r,l,e,s=self:_getInnerMetrics()
if e<=0 or s<=0 then
return
end
local a=a+d
local r=n+r
local d=#self.items
local n=i
local u=self.highlightBg or t.lightGray
local l=self.highlightFg or t.black
if d==0 then
for t=0,s-1 do
o.text(a,r+t,string.rep(" ",e),h,n)
end
local i=self.placeholder
if type(i)=="string"and#i>0 then
local i=i
if#i>e then
i=i:sub(1,e)
end
local e=a+math.floor((e-#i)/2)
if e<a then
e=a
end
o.text(e,r,i,t.lightGray,n)
end
return
end
for t=0,s-1 do
local s=r+t
local i=self.scrollOffset+t
if i>d then
o.text(a,s,string.rep(" ",e),h,n)
else
local t=self.items[i]or""
if#t>e then
t=t:sub(1,e)
end
local t=t
if#t<e then
t=t..string.rep(" ",e-#t)
end
local e=n
local n=h
if i==self.selectedIndex then
e=u
n=l
end
o.text(a,s,t,n,e)
end
end
end
function s:handleEvent(t,...)
if not self.visible then
return false
end
if t=="mouse_click"then
local a,t,e=...
if self:containsPoint(t,e)then
self.app:setFocus(self)
local e=self:_itemIndexFromPoint(t,e)
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
function u:new(i,e)
e=e or{}
local o=l(e)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},u)
a:_init_base(i,o)
a.focusable=true
a.items={}
if e and type(e.items)=="table"then
for t=1,#e.items do
local e=e.items[t]
if e~=nil then
a.items[#a.items+1]=tostring(e)
end
end
end
a.dropdownBg=(e and e.dropdownBg)or t.black
a.dropdownFg=(e and e.dropdownFg)or t.white
a.highlightBg=(e and e.highlightBg)or t.lightBlue
a.highlightFg=(e and e.highlightFg)or t.black
a.placeholder=(e and e.placeholder)or"Select..."
a.onChange=e and e.onChange or nil
if e and type(e.selectedIndex)=="number"then
a.selectedIndex=math.floor(e.selectedIndex)
elseif#a.items>0 then
a.selectedIndex=1
else
a.selectedIndex=0
end
a:_normalizeSelection()
if not a.border then
a.border=g(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function u:_normalizeSelection()
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
function u:setItems(t)
e(1,t,"table")
local e={}
for a=1,#t do
local t=t[a]
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
function u:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function u:setSelectedIndex(t,a)
if t==nil then
return
end
e(1,t,"number")
if#self.items==0 then
self.selectedIndex=0
return
end
t=math.floor(t)
if t<1 then
t=1
elseif t>#self.items then
t=#self.items
end
if self.selectedIndex~=t then
self.selectedIndex=t
if not a then
self:_notifyChange()
end
end
if self._open then
self._hoverIndex=self.selectedIndex
end
end
function u:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function u:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function u:_setOpen(e)
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
function u:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function u:_isPointInDropdown(t,e)
if not self._open or#self.items==0 then
return false
end
local a,o,i,n=self:getAbsoluteRect()
local o=o+n
return t>=a and t<a+i and e>=o and e<o+#self.items
end
function u:_indexFromPoint(t,e)
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
function u:_handlePress(e,t)
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
function u:draw(n,e)
if not self.visible then
return
end
local i,a,s,h=self:getAbsoluteRect()
local o=self.bg or t.black
local d=self.fg or t.white
c(n,i,a,s,h,o,o)
b(n,i,a,s,h)
if self.border then
p(e,i,a,s,h,self.border,o)
end
local e=self.border
local t=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local r=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local l=i+t
local s=math.max(0,s-t-u)
local u=a+r
local e=math.max(0,h-r-e)
local h=s>0 and 1 or 0
local t=math.max(0,s-h)
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
if t>0 then
if#e>t then
e=e:sub(1,t)
end
local t=math.max(0,t-#e)
local e=e..string.rep(" ",t)
n.text(l,i,e,d,o)
end
if h>0 then
local t=self._open and string.char(30)or string.char(31)
local e=l+s-1
n.text(e,i,t,d,o)
end
end
function u:_drawDropdown(s,d)
if not self._open or#self.items==0 or self.visible==false then
return
end
local i,e,a,t=self:getAbsoluteRect()
local o=e+t
local h=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local u=i+t
local t=math.max(0,a-t-n)
local r=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local n=h+e
c(s,i,o,a,n,self.dropdownBg,self.dropdownBg)
b(s,i,o,a,n)
for e=1,h do
local a=o+e-1
local o=self.items[e]or""
local e=r~=nil and r==e
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
p(d,i,o,a,n,e,self.dropdownBg)
end
end
end
function u:handleEvent(e,...)
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
local e,a,t=...
if self:containsPoint(a,t)or self:_isPointInDropdown(a,t)then
self.app:setFocus(self)
if e>0 then
self:setSelectedIndex(self.selectedIndex+1)
elseif e<0 then
self:setSelectedIndex(self.selectedIndex-1)
end
return true
end
elseif e=="mouse_move"then
local e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
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
local l={}
l.__index=l
setmetatable(l,{__index=h})
function l:new(o,t)
local a={}
if t then
for e,t in pairs(t)do
a[e]=t
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
e.border=g(true)
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
local t=self.text:sub(1,self._cursorPos-2)
local e=self.text:sub(self._cursorPos)
self.text=t..e
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
function l:_cursorFromPoint(a)
local t,o,e=self:getAbsoluteRect()
local o=t+(e>2 and 1 or 0)
local t=e>2 and(e-2)or e
local e=math.floor(a-o)
if e<0 then e=0 end
if e>t then e=t end
return self._viewOffset+e
end
function l:draw(s,w)
if not self.visible then
return
end
local n,h,r,l=self:getAbsoluteRect()
local o=self.bg or t.black
local m=self.fg or t.white
local d,u=n+1,h+1
local a=math.max(0,r-2)
local i=math.max(0,l-2)
if a>0 and i>0 then
c(s,d,u,a,i,o,o)
else
c(s,n,h,r,l,o,o)
end
b(s,n,h,r,l)
local e=a>0 and a or r
local c=a>0 and d or n
local d
if i>0 then
d=u+math.floor((i-1)/2)
else
d=h
end
local a=self._viewOffset
local i=a+e-1
local i=self.text:sub(a,i)
if#i<e then
i=i..string.rep(" ",e-#i)
end
local a=i
local u=m
local f=(not self:isFocused())and self.text==""and type(self.placeholder)=="string"and#self.placeholder>0
if f then
a=self.placeholder
if#a>e then
a=a:sub(1,e)
end
if#a<e then
a=a..string.rep(" ",e-#a)
end
u=t.lightGray
end
if e>0 then
s.text(c,d,a,u,o)
end
if self:isFocused()then
local t=self._cursorPos-self._viewOffset+1
if t>=1 and t<=e then
local e=i:sub(t,t)
if e==""then
e=" "
end
s.text(c+t-1,d,e,o,m)
end
end
if self.border then
p(w,n,h,r,l,self.border,o)
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
function l:setText(t)
e(1,t,"string")
self.text=self:_applyMaxLength(t)
self._cursorPos=math.min(self._cursorPos,#self.text+1)
self:_ensureCursorVisible()
self:_notifyChange()
end
function l:getText()
return self.text
end
function l:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function w.create(a)
if a~=nil then
e(1,a,"table")
end
a=a or{}
local h=false
local i
local e=a.window
if e==nil then
i=x.current()
local a,t=i.getSize()
e=T.create(i,1,1,a,t,true)
e.setVisible(true)
h=true
end
local o=_.new(e)
o.profiler.start_frame()
o.profiler.start_region("user")
local c=o.add_pixel_layer(5,"pixelui_pixels")
local u=o.add_text_layer(10,"pixelui_ui")
local l,d=e.getSize()
local s=a.background or t.black
o.fill(s)
local r=math.max(.01,a.animationInterval or .05)
local e=setmetatable({
window=e,
box=o,
layer=u,
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
_radioGroups={}
},n)
e.root=y:new(e,{
x=1,
y=1,
width=l,
height=d,
bg=s,
fg=t.white,
border=a.rootBorder,
z=-math.huge
})
return e
end
function n:getRoot()
return self.root
end
function n:setBackground(t)
e(1,t,"number")
self.background=t
self.box.fill(t)
end
function n:getLayer()
return self.layer
end
function n:getPixelLayer()
return self.pixelLayer
end
function n:createFrame(e)
return y:new(self,e)
end
function n:createButton(e)
return v:new(self,e)
end
function n:createLabel(e)
return f:new(self,e)
end
function n:createCheckBox(e)
return m:new(self,e)
end
function n:createTextBox(e)
return l:new(self,e)
end
function n:createComboBox(e)
return u:new(self,e)
end
function n:createList(e)
return s:new(self,e)
end
function n:createTreeView(e)
return i:new(self,e)
end
function n:createRadioButton(e)
return d:new(self,e)
end
function n:createProgressBar(e)
return r:new(self,e)
end
function n:createSlider(e)
return o:new(self,e)
end
function n:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=k.startTimer(self._animationInterval)
end
end
function n:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=k.clock()
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
function n:animate(t)
e(1,t,"table")
local a=t.update
if a~=nil and type(a)~="function"then
error("options.update must be a function",2)
end
local o=t.onComplete
if o~=nil and type(o)~="function"then
error("options.onComplete must be a function",2)
end
local i=t.onCancel
if i~=nil and type(i)~="function"then
error("options.onCancel must be a function",2)
end
local e=t.easing
if e==nil then
e=j.linear
elseif type(e)=="string"then
e=j[e]
if not e then
error("Unknown easing '"..t.easing.."'",2)
end
elseif type(e)~="function"then
error("options.easing must be a function or easing name",2)
end
if t.duration~=nil and type(t.duration)~="number"then
error("options.duration must be a number",2)
end
local t=math.max(.01,t.duration or .3)
local e={
update=a,
onComplete=o,
onCancel=i,
easing=e,
duration=t,
startTime=k.clock()
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
function n:_selectRadioInGroup(a,t,o)
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
function n:setFocus(t)
if t~=nil then
e(1,t,"table")
if t.app~=self then
error("Cannot focus widget from a different PixelUI app",2)
end
if not t.focusable then
t=nil
end
end
if self._focusWidget==t then
return
end
if self._focusWidget then
local e=self._focusWidget
e:setFocused(false)
end
self._focusWidget=t
if t then
t:setFocused(true)
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
local e=...
if self._animationTimer and e==self._animationTimer then
self:_updateAnimations()
if self._animations and#self._animations>0 then
self._animationTimer=k.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or x.current()
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
function n:run()
self.running=true
self:render()
while self.running do
local e={A()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
end
function n:stop()
self.running=false
self:_clearAnimations(true)
end
w.widgets={
Frame=function(e,t)
return y:new(e,t)
end,
Button=function(t,e)
return v:new(t,e)
end,
Label=function(e,t)
return f:new(e,t)
end,
CheckBox=function(t,e)
return m:new(t,e)
end,
TextBox=function(e,t)
return l:new(e,t)
end,
ComboBox=function(t,e)
return u:new(t,e)
end,
List=function(e,t)
return s:new(e,t)
end,
TreeView=function(t,e)
return i:new(t,e)
end,
RadioButton=function(e,t)
return d:new(e,t)
end,
ProgressBar=function(t,e)
return r:new(t,e)
end,
Slider=function(e,t)
return o:new(e,t)
end
}
w.Widget=h
w.Frame=y
w.Button=v
w.Label=f
w.CheckBox=m
w.TextBox=l
w.ComboBox=u
w.List=s
w.TreeView=i
w.RadioButton=d
w.ProgressBar=r
w.Slider=o
w.easings=j
return w
