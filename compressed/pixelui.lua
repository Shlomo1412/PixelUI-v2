local j=assert(rawget(_G,"term"),"term API unavailable")
local t=assert(rawget(_G,"colors"),"colors API unavailable")
local g=assert(rawget(_G,"os"),"os API unavailable")
local T=assert(g.pullEvent,"os.pullEvent unavailable")
local E=assert(rawget(_G,"window"),"window API unavailable")
local n=assert(rawget(_G,"keys"),"keys API unavailable")
local e=require("cc.expect").expect
local z=require("shrekbox")
local f={
version="0.1.0"
}
local k={
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
local m={}
m.__index=m
setmetatable(m,{__index=h})
local w={}
w.__index=w
setmetatable(w,{__index=h})
local u={}
u.__index=u
setmetatable(u,{__index=h})
local r={}
r.__index=r
setmetatable(r,{__index=h})
local a={}
a.__index=a
setmetatable(a,{__index=h})
local s={}
s.__index=s
setmetatable(s,{__index=h})
local d={}
d.__index=d
setmetatable(d,{__index=h})
local l={}
l.__index=l
setmetatable(l,{__index=h})
local i={}
i.__index=i
local o={"top","right","bottom","left"}
local _=string.char(7)
local function b(t)
if not t then
return nil
end
local e={}
for a,t in pairs(t)do
e[a]=t
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
local function v(a)
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
local function i(a,t)
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
for e=1,#o do
i(o[e],a[o[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function c(s,h,i,t,e,n,a,o)
if t<=0 or e<=0 then
return
end
local o=o or" "
local t=o:rep(t)
for e=0,e-1 do
s.text(h,i+e,t,n,a)
end
end
local function p(i,n,o,e,t)
if e<=0 or t<=0 then
return
end
local a=z.transparent
for e=0,e-1 do
i.pixel(n+e,o,a)
if t>1 then
i.pixel(n+e,o+t-1,a)
end
end
for t=1,math.max(0,t-2)do
i.pixel(n,o+t,a)
if e>1 then
i.pixel(n+e-1,o+t,a)
end
end
end
local function y(d,a,t,o,i,e,s)
if o<=0 or i<=0 then
return
end
local n=e.color
local s=s or n
local a=(a-1)*2+1
local t=(t-1)*3+1
local o=o*2
local i=i*3
local l=3
local c=2
local h=math.min(e.thickness,i)
local r=math.min(e.thickness,o)
local u=math.min(i,math.max(h,l))
local l=math.min(o,math.max(r,c))
local function c(s,e,n)
for e=0,e-1 do
local e=s+e
if e<t or e>=t+i then break end
for t=0,o-1 do
d.pixel(a+t,e,n)
end
end
end
local function m(e,s,n)
for s=0,s-1 do
local e=e+s
if e<t or e>=t+i then break end
for t=0,o-1 do
d.pixel(a+t,e,n)
end
end
end
local function w(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+o then break end
for a=0,i-1 do
d.pixel(e,t+a,n)
end
end
end
local function f(s,e,n)
for e=0,e-1 do
local e=s+e
if e<a or e>=a+o then break end
for a=0,i-1 do
d.pixel(e,t+a,n)
end
end
end
if e.left then
w(a,l,s)
end
if e.right then
w(a+o-l,l,s)
end
if e.top then
c(t,u,s)
end
if e.bottom then
c(t+i-u,u,s)
end
if e.top then
m(t,h,n)
end
if e.bottom then
m(t+i-h,h,n)
end
if e.left then
f(a,r,n)
end
if e.right then
f(a+o-r,r,n)
end
end
local function x(e)
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
self.border=v(a.border)
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
function h:setPosition(t,a)
e(1,t,"number")
e(2,a,"number")
self.x=math.floor(t)
self.y=math.floor(a)
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
self.border=v(true)
return
end
e(1,t,"table","boolean")
self.border=v(t)
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
local e,t=x(self)
return e,t,self.width,self.height
end
function h:containsPoint(o,e)
local t,a,i,n=self:getAbsoluteRect()
return o>=t and o<t+i and e>=a and e<a+n
end
function h:draw(e,e)
error("draw needs implementation for widget",2)
end
function h:handleEvent(e,...)
return false
end
function m:new(a,t)
local e=setmetatable({},m)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function m:addChild(t)
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
function m:removeChild(e)
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
local function q(e)
local t={}
for a=1,#e do
t[a]=e[a]
end
return t
end
local function x(e)
table.sort(e,function(e,t)
if e.z==t.z then
return(e._orderIndex or 0)<(t._orderIndex or 0)
end
return e.z<t.z
end)
end
function m:getChildren()
return q(self._children)
end
function m:setTitle(t)
if t~=nil then
e(1,t,"string")
end
self.title=t
end
function m:draw(s,r)
if not self.visible then
return
end
local n,t,o,i=self:getAbsoluteRect()
local a=self.bg or self.app.background
local d,l=n+1,t+1
local e=math.max(0,o-2)
local h=math.max(0,i-2)
if e>0 and h>0 then
c(s,d,l,e,h,a,a)
elseif o>0 and i>0 then
c(s,n,t,o,i,a,a)
end
p(s,n,t,o,i)
local h=self.title
if type(h)=="string"and#h>0 then
local o=e>0 and e or o
local n=e>0 and d or n
local t=(i>2)and(t+1)or t
if o>0 then
local e=h
if#e>o then
e=e:sub(1,o)
end
if#e<o then
e=e..string.rep(" ",o-#e)
end
s.text(n,t,e,self.fg,a)
end
end
if self.border then
y(r,n,t,o,i,self.border,a)
end
local e=q(self._children)
x(e)
for t=1,#e do
e[t]:draw(s,r)
end
end
function m:handleEvent(t,...)
if not self.visible then
return false
end
if h.handleEvent(self,t,...)then
return true
end
local e=q(self._children)
x(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function w:new(a,e)
local t=setmetatable({},w)
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
function w:setLabel(t)
e(1,t,"string")
self.label=t
end
function w:setOnClick(t)
if t~=nil then
e(1,t,"function")
end
self.onClick=t
end
function w:draw(r,m)
if not self.visible then
return
end
local n,i,a,h=self:getAbsoluteRect()
local e=self.bg or t.gray
local t=self.fg or t.white
local e=e
local d=t
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,u=n+1,i+1
local o=math.max(0,a-2)
local s=math.max(0,h-2)
if o>0 and s>0 then
c(r,l,u,o,s,e,e)
else
c(r,n,i,a,h,e,e)
end
p(r,n,i,a,h)
if self.border then
y(m,n,i,a,h,self.border,e)
end
local t=self.label or""
local a=o>0 and o or a
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
local o=o>0 and l or n
local a
if s>0 then
a=u+math.floor((s-1)/2)
else
a=i
end
r.text(o,a,t,d,e)
end
function w:handleEvent(e,...)
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
function u:new(o,e)
e=e or{}
local a=b(e)or{}
a.focusable=false
a.height=math.max(1,math.floor(a.height or 1))
a.width=math.max(1,math.floor(a.width or 1))
local t=setmetatable({},u)
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
function u:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-t-o)
local i=math.max(0,self.height-a-e)
return t,o,a,e,n,i
end
function u:_wrapLine(t,a,e)
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
function u:_updateLines(e)
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
function u:setText(e)
if e==nil then
e=""
end
e=tostring(e)
if self.text~=e then
self.text=e
self:_updateLines(true)
end
end
function u:getText()
return self.text
end
function u:setWrap(e)
e=not not e
if self.wrap~=e then
self.wrap=e
self:_updateLines(true)
end
end
function u:isWrapping()
return self.wrap
end
function u:setHorizontalAlign(t)
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
function u:setVerticalAlign(t)
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
function u:setSize(t,e)
h.setSize(self,t,e)
self:_updateLines(true)
end
function u:setBorder(e)
h.setBorder(self,e)
self:_updateLines(true)
end
function u:draw(l,f)
if not self.visible then
return
end
local h,s,d,r=self:getAbsoluteRect()
local n=self.bg or self.app.background or t.black
local m=self.fg or t.white
c(l,h,s,d,r,n,n)
p(l,h,s,d,r)
local e,t,o,t,a,i=self:_getInnerMetrics()
local t=h+e
local c=s+o
self:_updateLines(false)
local u=self._lines or{""}
local o=#u
if o==0 then
u={""}
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
local i=c+o
for e=0,e-1 do
local e=u[s+e]or""
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
l.text(o,i,e,m,n)
end
i=i+1
end
end
if self.border then
y(f,h,s,d,r,self.border,n)
end
end
function d:new(n,a)
a=a or{}
local o=b(a)or{}
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
e._dotChar=_
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
function d:draw(s,r)
if not self.visible then
return
end
local o,i,a,e=self:getAbsoluteRect()
local h=self.bg or t.black
local n=self.fg or t.white
local t=h
local n=n
if self:isFocused()then
t=self.focusBg or t
n=self.focusFg or n
end
c(s,o,i,a,e,t,t)
p(s,o,i,a,e)
if self.border then
y(r,o,i,a,e,self.border,t)
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
s.text(o,h,e,n,t)
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
if e==n.space or e==n.enter then
self:_activate()
return true
end
end
return false
end
function r:new(i,a)
a=a or{}
local o=b(a)or{}
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
e.border=v(true)
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
easing=k.linear,
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
function r:draw(i,e)
if not self.visible then
return
end
local a,r,h,n=self:getAbsoluteRect()
local o=self.trackColor or(self.bg or t.gray)
local s=self.fillColor or t.lightBlue
local m=self.textColor or(self.fg or t.white)
c(i,a,r,h,n,o,o)
p(i,a,r,h,n)
if self.border then
y(e,a,r,h,n,self.border,o)
end
local e=self.border
local t=(e and e.left)and 1 or 0
local l=(e and e.right)and 1 or 0
local d=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+t
local r=r+d
local t=math.max(0,h-t-l)
local n=math.max(0,n-d-e)
if t<=0 or n<=0 then
return
end
c(i,a,r,t,n,o,o)
local l=0
local d=0
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
d=math.floor(t*e+.5)
c(i,a+d,r,h,n,s,s)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
c(i,a,r,l,n,s,s)
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
if e~=""and n>0 then
if#e>t then
e=e:sub(1,t)
end
local u=r+math.floor((n-1)/2)
local n=a+math.floor((t-#e)/2)
if n<a then
n=a
end
for t=1,#e do
local r=e:sub(t,t)
local a=(n-a)+(t-1)
local e=o
if self.indeterminate then
if a>=d and a<d+h then
e=s
end
else
if a<l then
e=s
end
end
i.text(n+t-1,u,r,m,e)
end
end
end
function r:handleEvent(e,...)
return false
end
function a:new(n,o)
o=o or{}
local i=b(o)or{}
i.focusable=true
i.height=math.max(1,math.floor(i.height or 3))
i.width=math.max(1,math.floor(i.width or 12))
local e=setmetatable({},a)
e:_init_base(n,i)
e.focusable=true
e.min=type(o.min)=="number"and o.min or 0
e.max=type(o.max)=="number"and o.max or 100
if e.max<=e.min then
e.max=e.min+1
end
if o and type(o.step)=="number"and o.step>0 then
e.step=o.step
else
e.step=0
end
e.range=not not(o and o.range)
e.trackColor=(o and o.trackColor)or t.gray
e.fillColor=(o and o.fillColor)or t.lightBlue
e.handleColor=(o and o.handleColor)or t.white
e.showValue=not not(o and o.showValue)
if o and o.formatValue~=nil then
if type(o.formatValue)~="function"then
error("Slider formatValue must be a function",2)
end
e.formatValue=o.formatValue
else
e.formatValue=nil
end
e.onChange=o and o.onChange or nil
e._activeHandle=nil
e._focusedHandle=e.range and"lower"or"single"
e._dragging=false
if e.range then
local t
local a
if o and type(o.value)=="table"then
t=o.value[1]
a=o.value[2]
end
if type(o.startValue)=="number"then
t=o.startValue
end
if type(o.endValue)=="number"then
a=o.endValue
end
if type(t)~="number"then
t=e.min
end
if type(a)~="number"then
a=e.max
end
if t>a then
t,a=a,t
end
e.lowerValue=e:_applyStep(t)
e.upperValue=e:_applyStep(a)
if e.lowerValue>e.upperValue then
e.lowerValue,e.upperValue=e.upperValue,e.lowerValue
end
else
local t=o and o.value
if type(t)~="number"then
t=e.min
end
e.value=e:_applyStep(t)
end
if not e.border then
e.border=v(true)
end
return e
end
function a:_clampValue(e)
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
function a:_applyStep(e)
e=self:_clampValue(e)
local t=self.step or 0
if t>0 then
local a=(e-self.min)/t
e=self.min+math.floor(a+.5)*t
e=self:_clampValue(e)
end
return e
end
function a:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local o=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n,i=self:getAbsoluteRect()
local h=math.max(0,self.width-t-o)
local s=math.max(0,self.height-a-e)
local n=n+t
local o=i+a
return n,o,h,s,t,a,e
end
function a:_valueToPosition(o,t)
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
function a:_positionToValue(e,t)
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
function a:_notifyChange()
if not self.onChange then
return
end
if self.range then
self.onChange(self,self.lowerValue,self.upperValue)
else
self.onChange(self,self.value)
end
end
function a:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function a:_setSingleValue(e,t)
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
function a:setValue(t)
if self.range then
return
end
e(1,t,"number")
self:_setSingleValue(t,false)
end
function a:getValue()
return self.value
end
function a:_setLowerValue(e,t)
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
function a:_setUpperValue(e,t)
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
function a:setRangeValues(a,t,o)
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
function a:getRangeValues()
return self.lowerValue,self.upperValue
end
function a:setRangeLimits(a,t)
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
function a:setStep(t)
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
function a:setShowValue(e)
self.showValue=not not e
end
function a:setColors(t,a,o)
if t~=nil then
e(1,t,"number")
self.trackColor=t
end
if a~=nil then
e(2,a,"number")
self.fillColor=a
end
if o~=nil then
e(3,o,"number")
self.handleColor=o
end
end
function a:_formatNumber(o)
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
function a:_formatDisplayValue()
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
function a:_getStepForNudge(t)
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
function a:_positionFromPoint(a)
local e,o,t=self:_getInnerMetrics()
if t<=0 then
return nil,t
end
local e=math.floor(a-e)
if e<0 then
e=0
elseif e>t-1 then
e=t-1
end
return e,t
end
function a:_beginInteraction(e)
local e,a=self:_positionFromPoint(e)
if not e then
return false
end
if self.range then
local n=self:_valueToPosition(self.lowerValue,a)
local s=self:_valueToPosition(self.upperValue,a)
local t=self._focusedHandle or"lower"
local i=math.abs(e-n)
local o=math.abs(e-s)
if i==o then
if e>s then
t="upper"
elseif e<n then
t="lower"
end
elseif i<o then
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
function a:_updateInteraction(e)
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
function a:_endInteraction()
self._activeHandle=nil
self._dragging=false
end
function a:_switchFocusedHandle()
if not self.range then
return
end
if self._focusedHandle=="lower"then
self._focusedHandle="upper"
else
self._focusedHandle="lower"
end
end
function a:_nudgeValue(e)
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
function a:onFocusChanged(e)
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
function a:draw(i,f)
if not self.visible then
return
end
local r,l,d,h=self:getAbsoluteRect()
local n=self.bg or self.app.background or t.black
c(i,r,l,d,h,n,n)
p(i,r,l,d,h)
local a,m,e,s=self:_getInnerMetrics()
if e<=0 or s<=0 then
if self.border then
y(f,r,l,d,h,self.border,n)
end
return
end
local o
local u=nil
if self.showValue and s>=2 then
u=m
o=m+s-1
else
o=m+math.floor((s-1)/2)
end
c(i,a,o,e,1,self.trackColor,self.trackColor)
local s
if self:isFocused()then
s=self._activeHandle or self._focusedHandle
end
local function m(n,h)
if n<0 or n>=e then
return
end
local e=self.handleColor or t.white
if s and h==s then
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
m(t,"lower")
m(e,"upper")
else
local e=self:_valueToPosition(self.value,e)
local t=e+1
if t>0 then
c(i,a,o,t,1,self.fillColor,self.fillColor)
end
m(e,"single")
end
if self.showValue and u then
local o=self:_formatDisplayValue()
if o and o~=""then
if#o>e then
o=o:sub(1,e)
end
local e=a+math.floor((e-#o)/2)
if e<a then
e=a
end
i.text(e,u,o,self.fg or t.white,n)
end
end
if self.border then
y(f,r,l,d,h,self.border,n)
end
end
function a:handleEvent(t,...)
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
if e==n.left or e==n.down then
self:_nudgeValue(-1)
return true
elseif e==n.right or e==n.up then
self:_nudgeValue(1)
return true
elseif e==n.home then
if self.range then
self:setRangeValues(self.min,self.upperValue)
self._focusedHandle="lower"
else
self:setValue(self.min)
end
return true
elseif e==n["end"]then
if self.range then
self:setRangeValues(self.lowerValue,self.max)
self._focusedHandle="upper"
else
self:setValue(self.max)
end
return true
elseif e==n.tab then
if self.range then
self:_switchFocusedHandle()
return true
end
elseif e==n.pageUp then
self:_nudgeValue(-5)
return true
elseif e==n.pageDown then
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
local o=b(a)or{}
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
e.border=v(true)
end
e:_normalizeSelection(true)
return e
end
function s:_getInnerMetrics()
local e=self.border
local o=(e and e.left)and 1 or 0
local t=(e and e.right)and 1 or 0
local a=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local n=math.max(0,self.width-o-t)
local i=math.max(0,self.height-a-e)
return o,t,a,e,n,i
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
function s:setHighlightColors(t,a)
if t~=nil then
e(1,t,"number")
self.highlightBg=t
end
if a~=nil then
e(2,a,"number")
self.highlightFg=a
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
local s,h=self:getAbsoluteRect()
local n,r,a,r,o,i=self:_getInnerMetrics()
if o<=0 or i<=0 then
return nil
end
local n=s+n
local a=h+a
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
local a=g.clock()
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
function s:draw(a,r)
if not self.visible then
return
end
local o,i,s,e=self:getAbsoluteRect()
local n=self.bg or t.black
local h=self.fg or t.white
c(a,o,i,s,e,n,n)
p(a,o,i,s,e)
if self.border then
y(r,o,i,s,e,self.border,n)
end
local d,l,r,l,e,s=self:_getInnerMetrics()
if e<=0 or s<=0 then
return
end
local o=o+d
local r=i+r
local d=#self.items
local n=n
local u=self.highlightBg or t.lightGray
local l=self.highlightFg or t.black
if d==0 then
for t=0,s-1 do
a.text(o,r+t,string.rep(" ",e),h,n)
end
local i=self.placeholder
if type(i)=="string"and#i>0 then
local i=i
if#i>e then
i=i:sub(1,e)
end
local e=o+math.floor((e-#i)/2)
if e<o then
e=o
end
a.text(e,r,i,t.lightGray,n)
end
return
end
for t=0,s-1 do
local s=r+t
local i=self.scrollOffset+t
if i>d then
a.text(o,s,string.rep(" ",e),h,n)
else
local t=self.items[i]or""
if#t>e then
t=t:sub(1,e)
end
local t=t
if#t<e then
t=t..string.rep(" ",e-#t)
end
local n=n
local e=h
if i==self.selectedIndex then
n=u
e=l
end
a.text(o,s,t,e,n)
end
end
end
function s:handleEvent(t,...)
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
if e==n.up then
self:_moveSelection(-1)
return true
elseif e==n.down then
self:_moveSelection(1)
return true
elseif e==n.pageUp then
self:_moveSelection(-self:_getInnerHeight())
return true
elseif e==n.pageDown then
self:_moveSelection(self:_getInnerHeight())
return true
elseif e==n.home then
if#self.items>0 then
self:setSelectedIndex(1)
end
return true
elseif e==n["end"]then
if#self.items>0 then
self:setSelectedIndex(#self.items)
end
return true
elseif e==n.enter or e==n.space then
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
function l:new(i,e)
e=e or{}
local o=b(e)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},l)
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
a.border=v(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function l:_normalizeSelection()
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
function l:setItems(t)
e(1,t,"table")
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
function l:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function l:setSelectedIndex(t,a)
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
function l:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function l:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function l:_setOpen(e)
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
function l:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function l:_isPointInDropdown(a,e)
if not self._open or#self.items==0 then
return false
end
local t,n,i,o=self:getAbsoluteRect()
local o=n+o
return a>=t and a<t+i and e>=o and e<o+#self.items
end
function l:_indexFromPoint(t,e)
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
function l:_handlePress(t,e)
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
function l:draw(s,e)
if not self.visible then
return
end
local n,o,i,h=self:getAbsoluteRect()
local a=self.bg or t.black
local r=self.fg or t.white
c(s,n,o,i,h,a,a)
p(s,n,o,i,h)
if self.border then
y(e,n,o,i,h,self.border,a)
end
local e=self.border
local t=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local l=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local d=n+t
local n=math.max(0,i-t-u)
local u=o+l
local e=math.max(0,h-l-e)
local h=n>0 and 1 or 0
local t=math.max(0,n-h)
local i
if e>0 then
i=u+math.floor((e-1)/2)
else
i=o
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
s.text(d,i,e,r,a)
end
if h>0 then
local t=self._open and string.char(30)or string.char(31)
local e=d+n-1
s.text(e,i,t,r,a)
end
end
function l:_drawDropdown(s,d)
if not self._open or#self.items==0 or self.visible==false then
return
end
local o,e,t,a=self:getAbsoluteRect()
local a=e+a
local r=#self.items
local e=self.border
local i=(e and e.left)and 1 or 0
local n=(e and e.right)and 1 or 0
local l=o+i
local i=math.max(0,t-i-n)
local h=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local n=r+e
c(s,o,a,t,n,self.dropdownBg,self.dropdownBg)
p(s,o,a,t,n)
for e=1,r do
local o=a+e-1
local a=self.items[e]or""
local e=h~=nil and h==e
local n=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local t=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if i>0 then
local e=a
if#e>i then
e=e:sub(1,i)
end
local a=math.max(0,i-#e)
local e=e..string.rep(" ",a)
s.text(l,o,e,t,n)
end
end
if self.border then
local e=b(self.border)
if e then
e.top=false
y(d,o,a,t,n,e,self.dropdownBg)
end
end
end
function l:handleEvent(e,...)
if not self.visible then
return false
end
if e=="mouse_click"then
local a,t,e=...
return self:_handlePress(t,e)
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
local a,t,e=...
if self._open then
self._hoverIndex=self:_indexFromPoint(t,e)
end
elseif e=="key"then
if not self:isFocused()then
return false
end
local e=...
if e==n.down then
self:setSelectedIndex(self.selectedIndex+1)
return true
elseif e==n.up then
self:setSelectedIndex(self.selectedIndex-1)
return true
elseif e==n.home then
self:setSelectedIndex(1)
return true
elseif e==n["end"]then
self:setSelectedIndex(#self.items)
return true
elseif e==n.enter or e==n.space then
if self._open then
self:_setOpen(false)
else
self:_setOpen(true)
end
return true
elseif e==n.escape then
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
local o={}
o.__index=o
setmetatable(o,{__index=h})
function o:new(i,t)
local a={}
if t then
for e,t in pairs(t)do
a[e]=t
end
end
a.focusable=true
a.height=a.height or 1
local e=setmetatable({},o)
e:_init_base(i,a)
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
e.border=v(true)
end
e:_ensureCursorVisible()
return e
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
function o:_setCursor(e)
local t=#self.text
e=math.max(1,math.min(e,t+1))
self._cursorPos=e
self:_ensureCursorVisible()
end
function o:_moveCursor(e)
self:_setCursor(self._cursorPos+e)
end
function o:_ensureCursorVisible()
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
function o:_notifyChange()
if self.onChange then
self.onChange(self,self.text)
end
end
function o:_insertText(e)
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
function o:_backspace()
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
function o:_delete()
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
function o:_cursorFromPoint(a)
local t,o,e=self:getAbsoluteRect()
local o=t+(e>2 and 1 or 0)
local t=e>2 and(e-2)or e
local e=math.floor(a-o)
if e<0 then e=0 end
if e>t then e=t end
return self._viewOffset+e
end
function o:draw(h,w)
if not self.visible then
return
end
local r,s,n,l=self:getAbsoluteRect()
local o=self.bg or t.black
local m=self.fg or t.white
local d,u=r+1,s+1
local a=math.max(0,n-2)
local i=math.max(0,l-2)
if a>0 and i>0 then
c(h,d,u,a,i,o,o)
else
c(h,r,s,n,l,o,o)
end
p(h,r,s,n,l)
local e=a>0 and a or n
local c=a>0 and d or r
local d
if i>0 then
d=u+math.floor((i-1)/2)
else
d=s
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
h.text(c,d,a,u,o)
end
if self:isFocused()then
local t=self._cursorPos-self._viewOffset+1
if t>=1 and t<=e then
local e=i:sub(t,t)
if e==""then
e=" "
end
h.text(c+t-1,d,e,o,m)
end
end
if self.border then
y(w,r,s,n,l,self.border,o)
end
end
function o:handleEvent(e,...)
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
if e==n.left then
self:_moveCursor(-1)
return true
elseif e==n.right then
self:_moveCursor(1)
return true
elseif e==n.home then
self:_setCursor(1)
return true
elseif e==n["end"]then
self:_setCursor(#self.text+1)
return true
elseif e==n.backspace then
return self:_backspace()
elseif e==n.delete then
return self:_delete()
end
end
end
return false
end
function o:setText(t)
e(1,t,"string")
self.text=self:_applyMaxLength(t)
self._cursorPos=math.min(self._cursorPos,#self.text+1)
self:_ensureCursorVisible()
self:_notifyChange()
end
function o:getText()
return self.text
end
function o:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function f.create(a)
if a~=nil then
e(1,a,"table")
end
a=a or{}
local h=false
local n
local e=a.window
if e==nil then
n=j.current()
local t,a=n.getSize()
e=E.create(n,1,1,t,a,true)
e.setVisible(true)
h=true
end
local o=z.new(e)
o.profiler.start_frame()
o.profiler.start_region("user")
local r=o.add_pixel_layer(5,"pixelui_pixels")
local u=o.add_text_layer(10,"pixelui_ui")
local l,d=e.getSize()
local s=a.background or t.black
o.fill(s)
local c=math.max(.01,a.animationInterval or .05)
local e=setmetatable({
window=e,
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
_animationInterval=c,
_radioGroups={}
},i)
e.root=m:new(e,{
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
function i:getRoot()
return self.root
end
function i:setBackground(t)
e(1,t,"number")
self.background=t
self.box.fill(t)
end
function i:getLayer()
return self.layer
end
function i:getPixelLayer()
return self.pixelLayer
end
function i:createFrame(e)
return m:new(self,e)
end
function i:createButton(e)
return w:new(self,e)
end
function i:createLabel(e)
return u:new(self,e)
end
function i:createTextBox(e)
return o:new(self,e)
end
function i:createComboBox(e)
return l:new(self,e)
end
function i:createList(e)
return s:new(self,e)
end
function i:createRadioButton(e)
return d:new(self,e)
end
function i:createProgressBar(e)
return r:new(self,e)
end
function i:createSlider(e)
return a:new(self,e)
end
function i:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=g.startTimer(self._animationInterval)
end
end
function i:_updateAnimations()
local t=self._animations
if not t or#t==0 then
return
end
local o=g.clock()
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
function i:animate(t)
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
e=k.linear
elseif type(e)=="string"then
e=k[e]
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
startTime=g.clock()
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
function i:setFocus(t)
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
self._animationTimer=g.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or j.current()
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
local e={T()}
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
f.widgets={
Frame=function(e,t)
return m:new(e,t)
end,
Button=function(t,e)
return w:new(t,e)
end,
Label=function(t,e)
return u:new(t,e)
end,
TextBox=function(t,e)
return o:new(t,e)
end,
ComboBox=function(t,e)
return l:new(t,e)
end,
List=function(e,t)
return s:new(e,t)
end,
RadioButton=function(t,e)
return d:new(t,e)
end,
ProgressBar=function(t,e)
return r:new(t,e)
end,
Slider=function(e,t)
return a:new(e,t)
end
}
f.Widget=h
f.Frame=m
f.Button=w
f.Label=u
f.TextBox=o
f.ComboBox=l
f.List=s
f.RadioButton=d
f.ProgressBar=r
f.Slider=a
f.easings=k
return f
