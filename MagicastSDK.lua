local c,computer=component,computer
local g=c.proxy(next(c.list("gpu")))
g.bind(next(c.list("screen")))
g.setResolution(80,25)

local sdk={}

sdk.region="Ekstroyan"

function sdk.clear(bg)
  g.setBackground(bg or 0x000000)
  g.fill(1,1,80,25," ")
end

function sdk.print(x,y,text,fg,bg)
  if bg then g.setBackground(bg) end
  if fg then g.setForeground(fg) end
  g.set(x,y,text)
end

function sdk.center(text,fg,bg)
  local x=math.floor((80-#text)/2)
  sdk.print(x,12,text,fg,bg)
end

function sdk.button(x,y,w,h,text,fg,bg)
  g.setBackground(bg or 0x003300)
  g.fill(x,y,w,h," ")
  g.setForeground(fg or 0x00FF00)
  g.set(x+math.floor((w-#text)/2),y+math.floor(h/2),text)
  return {x1=x,y1=y,x2=x+w-1,y2=y+h-1}
end

function sdk.clicked(btn,x,y)
  return x>=btn.x1 and x<=btn.x2 and y>=btn.y1 and y<=btn.y2
end

function sdk.wait()
  return computer.pullSignal()
end

function sdk.checkRegion(cardregion)
  if cardregion and cardregion~=sdk.region then
    sdk.clear()
    sdk.center("Wrong Region: "..cardregion,0xFF0000)
    return false
  end
  return true
end

return sdk
