events = {}
local e = events

--[[ 1 - Drunkmode
  
  ]]

e.active = {}
e.stop = {}
e.amount = 1

function events.init()
  for i = 1, e.amount do
    e.active[i] = false
  end
end

function events.startEvent(i, time)
  e.active[i] = true
  table.insert(e.stop, {time=time, event=i})
  if i == 1 then
    e.showText("Space sunglasses")
    drunkMode = true
    sound.battle1:stop()
    sound.play(sound.sandstorm)
  end
end

function events.stopEvent(i)
  if i == 1 then
    drunkMode = false
    sound.sandstorm:stop()
    sound.play(sound.battle1)
  end
end

function events.showText(text)
  e.showtext = true
  e.texttime = 2
  e.text = text
end

function events.update(dt)
  if e.showtext then
    e.texttime = e.texttime - dt
    if e.texttime <= 0 then
      e.showtext = false
    end
  end
  toStop = {}
  for _,v in pairs(e.stop) do
    v.time = v.time - dt
    if v.time <= 0 then
      table.insert(toStop, _)
    end
  end
  for i = #toStop, 1, -1 do
    events.stopEvent(e.stop[toStop[i]].event)
    table.remove(e.stop, toStop[i])
  end
end

e.showtext = false
e.text = ""
e.texttime = 0

function events.draw()
  if e.showtext then
    menu.drawOutlinedText(e.text, 0, font.big, 3, {255,255,255,128}, {0,0,0,20})
  end
end