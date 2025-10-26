local k=assert(rawget(_G,"term"),"term API unavailable")
local t=assert(rawget(_G,"colors"),"colors API unavailable")
local p=assert(rawget(_G,"os"),"os API unavailable")
local x=assert(p.pullEvent,"os.pullEvent unavailable")
local z=assert(rawget(_G,"window"),"window API unavailable")
local r=assert(rawget(_G,"keys"),"keys API unavailable")
local e=require("cc.expect").expect
local j=require("shrekbox")
local m={
version="0.1.0"
}
local b={
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
local l={}
l.__index=l
setmetatable(l,{__index=s})
local c={}
c.__index=c
setmetatable(c,{__index=s})
local h={}
h.__index=h
setmetatable(h,{__index=s})
local o={}
o.__index=o
setmetatable(o,{__index=s})
local n={}
n.__index=n
setmetatable(n,{__index=s})
local d={}
d.__index=d
setmetatable(d,{__index=s})
local a={}
a.__index=a
local i={"top","right","bottom","left"}
local _=string.char(7)
local function v(e)
if not e then
return nil
end
local t={}
for e,a in pairs(e)do
t[e]=a
end
return t
end
local function g(a,t)
e(nil,a,"string")
e(nil,t,"number")
if t<1 or t~=math.floor(t)then
error(('%s must be a positive integer, got "%s"'):format(a,tostring(t)),3)
end
end
local function y(a)
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
for e=1,#i do
o(i[e],a[i[e]])
end
end
if e.thickness<1 then
e.thickness=1
end
return e
end
local function u(n,o,i,e,t,s,h,a)
if e<=0 or t<=0 then
return
end
local a=a or" "
local a=a:rep(e)
for e=0,t-1 do
n.text(o,i+e,a,s,h)
end
end
local function w(a,o,t,i,e)
if i<=0 or e<=0 then
return
end
local n=j.transparent
for i=0,i-1 do
a.pixel(o+i,t,n)
if e>1 then
a.pixel(o+i,t+e-1,n)
end
end
for e=1,math.max(0,e-2)do
a.pixel(o,t+e,n)
if i>1 then
a.pixel(o+i-1,t+e,n)
end
end
end
local function f(s,a,r,o,i,e,t)
if o<=0 or i<=0 then
return
end
local n=e.color
local h=t or n
local a=(a-1)*2+1
local t=(r-1)*3+1
local o=o*2
local i=i*3
local l=3
local u=2
local r=math.min(e.thickness,i)
local d=math.min(e.thickness,o)
local l=math.min(i,math.max(r,l))
local u=math.min(o,math.max(d,u))
local function f(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(a+t,e,n)
end
end
end
local function m(h,e,n)
for e=0,e-1 do
local e=h+e
if e<t or e>=t+i then break end
for t=0,o-1 do
s.pixel(a+t,e,n)
end
end
end
local function c(n,e,h)
for e=0,e-1 do
local e=n+e
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(e,t+a,h)
end
end
end
local function w(h,e,n)
for e=0,e-1 do
local e=h+e
if e<a or e>=a+o then break end
for a=0,i-1 do
s.pixel(e,t+a,n)
end
end
end
if e.left then
c(a,u,h)
end
if e.right then
c(a+o-u,u,h)
end
if e.top then
f(t,l,h)
end
if e.bottom then
f(t+i-l,l,h)
end
if e.top then
m(t,r,n)
end
if e.bottom then
m(t+i-r,r,n)
end
if e.left then
w(a,d,n)
end
if e.right then
w(a+o-d,d,n)
end
end
local function i(e)
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
self.border=y(a.border)
self.focusable=a.focusable==true
self._focused=false
g("width",self.width)
g("height",self.height)
end
function s:setSize(t,e)
g("width",t)
g("height",e)
self.width=t
self.height=e
end
function s:setPosition(a,t)
e(1,a,"number")
e(2,t,"number")
self.x=math.floor(a)
self.y=math.floor(t)
end
function s:setZ(t)
e(1,t,"number")
self.z=t
end
function s:setBorder(t)
if t==nil then
self.border=nil
return
end
if t==false then
self.border=nil
return
end
if t==true then
self.border=y(true)
return
end
e(1,t,"table","boolean")
self.border=y(t)
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
local e,t=i(self)
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
function l:new(a,t)
local e=setmetatable({},l)
e:_init_base(a,t)
e._children={}
e._orderCounter=0
e.title=t and t.title or nil
e.focusable=false
return e
end
function l:addChild(t)
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
function l:removeChild(e)
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
local function g(e)
local t={}
for a=1,#e do
t[a]=e[a]
end
return t
end
local function q(e)
table.sort(e,function(t,e)
if t.z==e.z then
return(t._orderIndex or 0)<(e._orderIndex or 0)
end
return t.z<e.z
end)
end
function l:getChildren()
return g(self._children)
end
function l:setTitle(t)
if t~=nil then
e(1,t,"string")
end
self.title=t
end
function l:draw(s,r)
if not self.visible then
return
end
local n,t,a,i=self:getAbsoluteRect()
local o=self.bg or self.app.background
local d,l=n+1,t+1
local e=math.max(0,a-2)
local h=math.max(0,i-2)
if e>0 and h>0 then
u(s,d,l,e,h,o,o)
elseif a>0 and i>0 then
u(s,n,t,a,i,o,o)
end
w(s,n,t,a,i)
local h=self.title
if type(h)=="string"and#h>0 then
local a=e>0 and e or a
local n=e>0 and d or n
local t=(i>2)and(t+1)or t
if a>0 then
local e=h
if#e>a then
e=e:sub(1,a)
end
if#e<a then
e=e..string.rep(" ",a-#e)
end
s.text(n,t,e,self.fg,o)
end
end
if self.border then
f(r,n,t,a,i,self.border,o)
end
local e=g(self._children)
q(e)
for t=1,#e do
e[t]:draw(s,r)
end
end
function l:handleEvent(t,...)
if not self.visible then
return false
end
if s.handleEvent(self,t,...)then
return true
end
local e=g(self._children)
q(e)
for a=#e,1,-1 do
if e[a]:handleEvent(t,...)then
return true
end
end
return false
end
function c:new(a,e)
local t=setmetatable({},c)
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
function c:setLabel(t)
e(1,t,"string")
self.label=t
end
function c:setOnClick(t)
if t~=nil then
e(1,t,"function")
end
self.onClick=t
end
function c:draw(h,m)
if not self.visible then
return
end
local i,n,s,a=self:getAbsoluteRect()
local e=self.bg or t.gray
local t=self.fg or t.white
local e=e
local d=t
if self.clickEffect and self._pressed then
e,d=d,e
end
local l,c=i+1,n+1
local o=math.max(0,s-2)
local r=math.max(0,a-2)
if o>0 and r>0 then
u(h,l,c,o,r,e,e)
else
u(h,i,n,s,a,e,e)
end
w(h,i,n,s,a)
if self.border then
f(m,i,n,s,a,self.border,e)
end
local a=self.label or""
local t=o>0 and o or s
if#a>t then
a=a:sub(1,t)
end
local s=0
if t>#a then
s=math.floor((t-#a)/2)
end
local a=string.rep(" ",s)..a
if#a<t then
a=a..string.rep(" ",t-#a)
end
local o=o>0 and l or i
local t
if r>0 then
t=c+math.floor((r-1)/2)
else
t=n
end
h.text(o,t,a,d,e)
end
function c:handleEvent(e,...)
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
function n:new(s,a)
a=a or{}
local o=v(a)or{}
local i="Option"
if a and a.label~=nil then
i=tostring(a.label)
end
o.focusable=true
o.height=o.height or 1
o.width=o.width or math.max(4,#i+4)
local e=setmetatable({},n)
e:_init_base(s,o)
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
function n:_registerWithGroup()
if self.app and self.group then
self.app:_registerRadioButton(self)
end
end
function n:_unregisterFromGroup()
if self.app and self._registeredGroup then
self.app:_unregisterRadioButton(self)
end
end
function n:_notifyChange()
if self.onChange then
self.onChange(self,self.selected,self.value)
end
end
function n:_applySelection(e,t)
e=not not e
if self.selected==e then
return
end
self.selected=e
if not t then
self:_notifyChange()
end
end
function n:setLabel(t)
e(1,t,"string")
self.label=t
end
function n:setValue(e)
self.value=e
end
function n:getValue()
return self.value
end
function n:setGroup(t)
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
function n:getGroup()
return self.group
end
function n:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function n:setSelected(e)
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
function n:isSelected()
return self.selected
end
function n:_activate()
if self.group then
if not self.selected then
self:setSelected(true)
end
else
self:setSelected(not self.selected)
end
end
function n:draw(s,r)
if not self.visible then
return
end
local o,e,a,i=self:getAbsoluteRect()
local h=self.bg or t.black
local n=self.fg or t.white
local t=h
local n=n
if self:isFocused()then
t=self.focusBg or t
n=self.focusFg or n
end
u(s,o,e,a,i,t,t)
w(s,o,e,a,i)
if self.border then
f(r,o,e,a,i,self.border,t)
end
local h=e+math.floor((i-1)/2)
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
function n:handleEvent(e,...)
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
if e==r.space or e==r.enter then
self:_activate()
return true
end
end
return false
end
function h:new(i,a)
a=a or{}
local o=v(a)or{}
o.focusable=false
o.height=o.height or 1
o.width=o.width or 12
local e=setmetatable({},h)
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
e.border=y(true)
end
if e.indeterminate then
e:_startIndeterminateAnimation()
end
return e
end
function h:_clampValue(e)
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
function h:_stopIndeterminateAnimation()
if self._animationHandle then
self._animationHandle:cancel()
self._animationHandle=nil
end
self._indeterminateProgress=0
end
function h:_startIndeterminateAnimation()
if not self.app or self._animationHandle then
return
end
local e=self.indeterminateSpeed or 1.2
self._animationHandle=self.app:animate({
duration=e,
easing=b.linear,
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
function h:setRange(a,t)
e(1,a,"number")
e(2,t,"number")
if t<=a then
error("ProgressBar max must be greater than min",2)
end
self.min=a
self.max=t
self.value=self:_clampValue(self.value)
end
function h:getRange()
return self.min,self.max
end
function h:setValue(t)
if self.indeterminate then
return
end
e(1,t,"number")
t=self:_clampValue(t)
if t~=self.value then
self.value=t
end
end
function h:getValue()
return self.value
end
function h:getPercent()
local e=self.max-self.min
if e<=0 then
return 0
end
return(self.value-self.min)/e
end
function h:setIndeterminate(e)
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
function h:isIndeterminate()
return self.indeterminate
end
function h:setLabel(t)
if t~=nil then
e(1,t,"string")
end
self.label=t
end
function h:setShowPercent(e)
self.showPercent=not not e
end
function h:setColors(t,a,o)
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
self.textColor=o
end
end
function h:draw(i,e)
if not self.visible then
return
end
local a,o,r,n=self:getAbsoluteRect()
local s=self.trackColor or(self.bg or t.gray)
local h=self.fillColor or t.lightBlue
local m=self.textColor or(self.fg or t.white)
u(i,a,o,r,n,s,s)
w(i,a,o,r,n)
if self.border then
f(e,a,o,r,n,self.border,s)
end
local e=self.border
local t=(e and e.left)and 1 or 0
local c=(e and e.right)and 1 or 0
local l=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local a=a+t
local d=o+l
local t=math.max(0,r-t-c)
local n=math.max(0,n-l-e)
if t<=0 or n<=0 then
return
end
u(i,a,d,t,n,s,s)
local l=0
local r=0
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
r=math.floor(t*e+.5)
u(i,a+r,d,o,n,h,h)
else
local e=self:getPercent()
if e<0 then e=0 end
if e>1 then e=1 end
l=math.floor(t*e+.5)
if l>0 then
u(i,a,d,l,n,h,h)
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
local u=d+math.floor((n-1)/2)
local t=a+math.floor((t-#e)/2)
if t<a then
t=a
end
for n=1,#e do
local d=e:sub(n,n)
local a=(t-a)+(n-1)
local e=s
if self.indeterminate then
if a>=r and a<r+o then
e=h
end
else
if a<l then
e=h
end
end
i.text(t+n-1,u,d,m,e)
end
end
end
function h:handleEvent(e,...)
return false
end
function o:new(n,a)
a=a or{}
local i=v(a)or{}
i.focusable=true
i.height=i.height or 5
i.width=i.width or 16
local e=setmetatable({},o)
e:_init_base(n,i)
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
e.border=y(true)
end
e:_normalizeSelection(true)
return e
end
function o:_getInnerMetrics()
local e=self.border
local t=(e and e.left)and 1 or 0
local a=(e and e.right)and 1 or 0
local o=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local i=math.max(0,self.width-t-a)
local n=math.max(0,self.height-o-e)
return t,a,o,e,i,n
end
function o:_getInnerHeight()
local t,t,t,t,t,e=self:_getInnerMetrics()
if e<1 then
e=1
end
return e
end
function o:_clampScroll()
local e=self:_getInnerHeight()
local e=math.max(1,#self.items-e+1)
if self.scrollOffset<1 then
self.scrollOffset=1
elseif self.scrollOffset>e then
self.scrollOffset=e
end
end
function o:_ensureSelectionVisible()
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
function o:_normalizeSelection(t)
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
function o:getItems()
local e={}
for t=1,#self.items do
e[t]=self.items[t]
end
return e
end
function o:setItems(t)
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
function o:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function o:setSelectedIndex(t,a)
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
function o:getSelectedIndex()
return self.selectedIndex
end
function o:setOnSelect(t)
if t~=nil then
e(1,t,"function")
end
self.onSelect=t
end
function o:setPlaceholder(t)
if t~=nil then
e(1,t,"string")
end
self.placeholder=t
end
function o:setHighlightColors(a,t)
if a~=nil then
e(1,a,"number")
self.highlightBg=a
end
if t~=nil then
e(2,t,"number")
self.highlightFg=t
end
end
function o:_notifySelect()
if self.onSelect then
self.onSelect(self,self:getSelectedItem(),self.selectedIndex)
end
end
function o:onFocusChanged(e)
if not e and self._typeSearch then
self._typeSearch.buffer=""
self._typeSearch.lastTime=0
end
end
function o:_itemIndexFromPoint(t,e)
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
function o:_moveSelection(t)
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
function o:_scrollBy(e)
if e==0 then
return
end
self.scrollOffset=self.scrollOffset+e
self:_clampScroll()
end
function o:_handleTypeSearch(t)
if not t or t==""then
return
end
local e=self._typeSearch
if not e then
e={buffer="",lastTime=0}
self._typeSearch=e
end
local a=p.clock()
local o=self.typeSearchTimeout or .75
if a-(e.lastTime or 0)>o then
e.buffer=""
end
e.buffer=e.buffer..t:lower()
e.lastTime=a
self:_searchForPrefix(e.buffer)
end
function o:_searchForPrefix(e)
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
function o:draw(o,r)
if not self.visible then
return
end
local a,i,e,s=self:getAbsoluteRect()
local n=self.bg or t.black
local h=self.fg or t.white
u(o,a,i,e,s,n,n)
w(o,a,i,e,s)
if self.border then
f(r,a,i,e,s,self.border,n)
end
local d,l,r,l,e,s=self:_getInnerMetrics()
if e<=0 or s<=0 then
return
end
local a=a+d
local r=i+r
local d=#self.items
local n=n
local l=self.highlightBg or t.lightGray
local u=self.highlightFg or t.black
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
e=l
n=u
end
o.text(a,s,t,n,e)
end
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
local e=self:_itemIndexFromPoint(e,t)
if e then
self:setSelectedIndex(e)
end
return true
end
elseif t=="monitor_touch"then
local a,e,t=...
if self:containsPoint(e,t)then
self.app:setFocus(self)
local e=self:_itemIndexFromPoint(e,t)
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
if e==r.up then
self:_moveSelection(-1)
return true
elseif e==r.down then
self:_moveSelection(1)
return true
elseif e==r.pageUp then
self:_moveSelection(-self:_getInnerHeight())
return true
elseif e==r.pageDown then
self:_moveSelection(self:_getInnerHeight())
return true
elseif e==r.home then
if#self.items>0 then
self:setSelectedIndex(1)
end
return true
elseif e==r["end"]then
if#self.items>0 then
self:setSelectedIndex(#self.items)
end
return true
elseif e==r.enter or e==r.space then
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
function d:new(i,e)
e=e or{}
local o=v(e)or{}
o.focusable=true
o.height=o.height or 3
o.width=o.width or 16
local a=setmetatable({},d)
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
a.border=y(true)
end
a._open=false
a._hoverIndex=nil
return a
end
function d:_normalizeSelection()
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
function d:setItems(t)
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
function d:getSelectedItem()
if self.selectedIndex>=1 and self.selectedIndex<=#self.items then
return self.items[self.selectedIndex]
end
return nil
end
function d:setSelectedIndex(t,a)
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
function d:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function d:_notifyChange()
if self.onChange then
self.onChange(self,self:getSelectedItem(),self.selectedIndex)
end
end
function d:_setOpen(e)
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
function d:onFocusChanged(e)
if not e then
self:_setOpen(false)
end
end
function d:_isPointInDropdown(e,o)
if not self._open or#self.items==0 then
return false
end
local t,a,i,n=self:getAbsoluteRect()
local a=a+n
return e>=t and e<t+i and o>=a and o<a+#self.items
end
function d:_indexFromPoint(t,e)
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
function d:_handlePress(e,t)
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
function d:draw(n,e)
if not self.visible then
return
end
local i,a,s,h=self:getAbsoluteRect()
local o=self.bg or t.black
local r=self.fg or t.white
u(n,i,a,s,h,o,o)
w(n,i,a,s,h)
if self.border then
f(e,i,a,s,h,self.border,o)
end
local e=self.border
local t=(e and e.left)and 1 or 0
local u=(e and e.right)and 1 or 0
local l=(e and e.top)and 1 or 0
local e=(e and e.bottom)and 1 or 0
local d=i+t
local s=math.max(0,s-t-u)
local u=a+l
local e=math.max(0,h-l-e)
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
n.text(d,i,e,r,o)
end
if h>0 then
local t=self._open and string.char(30)or string.char(31)
local e=d+s-1
n.text(e,i,t,r,o)
end
end
function d:_drawDropdown(n,d)
if not self._open or#self.items==0 or self.visible==false then
return
end
local a,t,i,e=self:getAbsoluteRect()
local o=t+e
local r=#self.items
local e=self.border
local t=(e and e.left)and 1 or 0
local s=(e and e.right)and 1 or 0
local l=a+t
local t=math.max(0,i-t-s)
local h=self._hoverIndex or(self.selectedIndex>0 and self.selectedIndex or nil)
local e=(e and e.bottom)and 1 or 0
local s=r+e
u(n,a,o,i,s,self.dropdownBg,self.dropdownBg)
w(n,a,o,i,s)
for e=1,r do
local a=o+e-1
local o=self.items[e]or""
local e=h~=nil and h==e
local s=e and(self.highlightBg or self.dropdownBg)or self.dropdownBg
local i=e and(self.highlightFg or self.dropdownFg)or self.dropdownFg
if t>0 then
local e=o
if#e>t then
e=e:sub(1,t)
end
local t=math.max(0,t-#e)
local e=e..string.rep(" ",t)
n.text(l,a,e,i,s)
end
end
if self.border then
local e=v(self.border)
if e then
e.top=false
f(d,a,o,i,s,e,self.dropdownBg)
end
end
end
function d:handleEvent(e,...)
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
local e,t=...
if self._open then
self._hoverIndex=self:_indexFromPoint(e,t)
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
if e==r.down then
self:setSelectedIndex(self.selectedIndex+1)
return true
elseif e==r.up then
self:setSelectedIndex(self.selectedIndex-1)
return true
elseif e==r.home then
self:setSelectedIndex(1)
return true
elseif e==r["end"]then
self:setSelectedIndex(#self.items)
return true
elseif e==r.enter or e==r.space then
if self._open then
self:_setOpen(false)
else
self:_setOpen(true)
end
return true
elseif e==r.escape then
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
local i={}
i.__index=i
setmetatable(i,{__index=s})
function i:new(o,t)
local a={}
if t then
for e,t in pairs(t)do
a[e]=t
end
end
a.focusable=true
a.height=a.height or 1
local e=setmetatable({},i)
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
e.border=y(true)
end
e:_ensureCursorVisible()
return e
end
function i:onFocusChanged(e)
self:_ensureCursorVisible()
end
function i:_applyMaxLength(e)
if not self.maxLength then
return e
end
if#e<=self.maxLength then
return e
end
return e:sub(1,self.maxLength)
end
function i:_setCursor(e)
local t=#self.text
e=math.max(1,math.min(e,t+1))
self._cursorPos=e
self:_ensureCursorVisible()
end
function i:_moveCursor(e)
self:_setCursor(self._cursorPos+e)
end
function i:_ensureCursorVisible()
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
function i:_notifyChange()
if self.onChange then
self.onChange(self,self.text)
end
end
function i:_insertText(e)
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
function i:_backspace()
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
function i:_delete()
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
function i:_cursorFromPoint(a)
local t,o,e=self:getAbsoluteRect()
local o=t+(e>2 and 1 or 0)
local t=e>2 and(e-2)or e
local e=math.floor(a-o)
if e<0 then e=0 end
if e>t then e=t end
return self._viewOffset+e
end
function i:draw(h,y)
if not self.visible then
return
end
local s,n,r,l=self:getAbsoluteRect()
local o=self.bg or t.black
local c=self.fg or t.white
local d,m=s+1,n+1
local e=math.max(0,r-2)
local i=math.max(0,l-2)
if e>0 and i>0 then
u(h,d,m,e,i,o,o)
else
u(h,s,n,r,l,o,o)
end
w(h,s,n,r,l)
local a=e>0 and e or r
local w=e>0 and d or s
local d
if i>0 then
d=m+math.floor((i-1)/2)
else
d=n
end
local e=self._viewOffset
local i=e+a-1
local i=self.text:sub(e,i)
if#i<a then
i=i..string.rep(" ",a-#i)
end
local e=i
local u=c
local m=(not self:isFocused())and self.text==""and type(self.placeholder)=="string"and#self.placeholder>0
if m then
e=self.placeholder
if#e>a then
e=e:sub(1,a)
end
if#e<a then
e=e..string.rep(" ",a-#e)
end
u=t.lightGray
end
if a>0 then
h.text(w,d,e,u,o)
end
if self:isFocused()then
local e=self._cursorPos-self._viewOffset+1
if e>=1 and e<=a then
local t=i:sub(e,e)
if t==""then
t=" "
end
h.text(w+e-1,d,t,o,c)
end
end
if self.border then
f(y,s,n,r,l,self.border,o)
end
end
function i:handleEvent(e,...)
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
if e==r.left then
self:_moveCursor(-1)
return true
elseif e==r.right then
self:_moveCursor(1)
return true
elseif e==r.home then
self:_setCursor(1)
return true
elseif e==r["end"]then
self:_setCursor(#self.text+1)
return true
elseif e==r.backspace then
return self:_backspace()
elseif e==r.delete then
return self:_delete()
end
end
end
return false
end
function i:setText(t)
e(1,t,"string")
self.text=self:_applyMaxLength(t)
self._cursorPos=math.min(self._cursorPos,#self.text+1)
self:_ensureCursorVisible()
self:_notifyChange()
end
function i:getText()
return self.text
end
function i:setOnChange(t)
if t~=nil then
e(1,t,"function")
end
self.onChange=t
end
function m.create(o)
if o~=nil then
e(1,o,"table")
end
o=o or{}
local h=false
local n
local i=o.window
if i==nil then
n=k.current()
local t,e=n.getSize()
i=z.create(n,1,1,t,e,true)
i.setVisible(true)
h=true
end
local e=j.new(i)
e.profiler.start_frame()
e.profiler.start_region("user")
local r=e.add_pixel_layer(5,"pixelui_pixels")
local c=e.add_text_layer(10,"pixelui_ui")
local u,m=i.getSize()
local s=o.background or t.black
e.fill(s)
local d=math.max(.01,o.animationInterval or .05)
local e=setmetatable({
window=i,
box=e,
layer=c,
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
_animationInterval=d,
_radioGroups={}
},a)
e.root=l:new(e,{
x=1,
y=1,
width=u,
height=m,
bg=s,
fg=t.white,
border=o.rootBorder,
z=-math.huge
})
return e
end
function a:getRoot()
return self.root
end
function a:setBackground(t)
e(1,t,"number")
self.background=t
self.box.fill(t)
end
function a:getLayer()
return self.layer
end
function a:getPixelLayer()
return self.pixelLayer
end
function a:createFrame(e)
return l:new(self,e)
end
function a:createButton(e)
return c:new(self,e)
end
function a:createTextBox(e)
return i:new(self,e)
end
function a:createComboBox(e)
return d:new(self,e)
end
function a:createList(e)
return o:new(self,e)
end
function a:createRadioButton(e)
return n:new(self,e)
end
function a:createProgressBar(e)
return h:new(self,e)
end
function a:_ensureAnimationTimer()
if not self._animationTimer then
self._animationTimer=p.startTimer(self._animationInterval)
end
end
function a:_updateAnimations()
local a=self._animations
if not a or#a==0 then
return
end
local o=p.clock()
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
function a:_clearAnimations(t)
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
function a:animate(t)
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
e=b.linear
elseif type(e)=="string"then
e=b[e]
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
startTime=p.clock()
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
function a:_registerPopup(e)
if not e then
return
end
local t=self._popupLookup
if not t[e]then
t[e]=true
table.insert(self._popupWidgets,e)
end
end
function a:_unregisterPopup(e)
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
function a:_drawPopups()
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
function a:_registerRadioButton(e)
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
function a:_unregisterRadioButton(t)
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
function a:_selectRadioInGroup(o,t,a)
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
function a:setFocus(t)
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
function a:getFocus()
return self._focusWidget
end
function a:render()
self.box.fill(self.background)
self.pixelLayer.clear()
self.layer.clear()
self.root:draw(self.layer,self.pixelLayer)
self:_drawPopups()
self.box.render()
end
function a:step(e,...)
if not e then
return
end
local t=false
if e=="timer"then
local e=...
if self._animationTimer and e==self._animationTimer then
self:_updateAnimations()
if self._animations and#self._animations>0 then
self._animationTimer=p.startTimer(self._animationInterval)
else
self._animationTimer=nil
end
t=true
end
end
if not t and e=="term_resize"then
if self._autoWindow then
local e=self._parentTerminal or k.current()
local e,t=e.getSize()
if self.window.reposition then
self.window.reposition(1,1,e,t)
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
function a:run()
self.running=true
self:render()
while self.running do
local e={x()}
if e[1]=="terminate"then
self.running=false
else
self:step(table.unpack(e))
end
end
end
function a:stop()
self.running=false
self:_clearAnimations(true)
end
m.widgets={
Frame=function(e,t)
return l:new(e,t)
end,
Button=function(e,t)
return c:new(e,t)
end,
TextBox=function(t,e)
return i:new(t,e)
end,
ComboBox=function(t,e)
return d:new(t,e)
end,
List=function(e,t)
return o:new(e,t)
end,
RadioButton=function(t,e)
return n:new(t,e)
end,
ProgressBar=function(e,t)
return h:new(e,t)
end
}
m.Widget=s
m.Frame=l
m.Button=c
m.TextBox=i
m.ComboBox=d
m.List=o
m.RadioButton=n
m.ProgressBar=h
m.easings=b
return m
