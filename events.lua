events = {}
local e = events

--[[ 1 - Drunkmode
  
  ]]

e.active = {}
e.stop = {}
e.amount = 6

cars = false

function events.init()
  for i = 1, e.amount do
    e.active[i] = false
  end
end

function events.startEvent(i, time)
  if e.active[i] then
    return
  end
  e.active[i] = true
  table.insert(e.stop, {time=time, event=i})
  if i == 1 then
    e.showText("Space sunglasses")
    drunkMode = true
    sound.battle1:stop()
    sound.play(sound.sandstorm)
  elseif i == 2 then
    e.showText("Black holes")
    for _,v in pairs(planet.suns) do
      v.oldr = v.r
      v.r = 1
      --v.scale = v.r * 2 / v.image:getWidth()
      v.image = image.blackhole_mini
    end
  elseif i == 3 then
    e.showText("Speed up!")
    timeMultiplier = timeMultiplier * 1.5
  elseif i == 4 then
    e.showText("Speed down!")
    timeMultiplier = timeMultiplier * 0.7
  elseif i == 5 then
    e.showText("Rapid fire!")
    player.cooldown = player.cooldown / 10
    player.damage = player.damage / 10
  elseif i == 6 then
    e.showText("Avoid traffic!")
    cars = true
    maxAsteroids = maxAsteroids * 1.5
  elseif i == 7 then
    e.showText("More asteroids!")
    maxAsteroids = maxAsteroids * 3
  end
end

function events.stopEvent(i)
  e.active[i] = false
  if i == 1 then
    drunkMode = false
    sound.sandstorm:stop()
    sound.play(sound.battle1)
  elseif i == 2 then
    for _,v in pairs(planet.suns) do
      v.r = v.oldr
      v.scale = v.r * 2 / v.image:getWidth()
      v.image = image.sun
    end
  elseif i == 3 then
    timeMultiplier = timeMultiplier / 1.5
  elseif i == 4 then
    timeMultiplier = timeMultiplier / 0.7
  elseif i == 5 then
    player.cooldown = player.cooldown * 10
    player.damage = player.damage * 10
  elseif i == 6 then
    cars = false
    maxAsteroids = maxAsteroids / 1.5
  elseif i == 7 then
    maxAsteroids = maxAateroids / 3
  end
end

function events.stopAll()
  for i = 1, #e.active do
    if e.active[i] then
      e.stopEvent(i)
    end
  end
end

function events.showText(text, text2)
  e.showtext = true
  e.texttime = 2
  e.text = text
  e.secondtext = text2
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
e.secondtext = ""
e.texttime = 0

function events.draw()
  if e.showtext then
    menu.drawOutlinedText(e.text, 0, font.big, 3, {255,255,255,128}, {0,0,0,20})
    --menu.drawOutlinedText(e.secondtext, -70, font.h1, 2, {255,255,255,128}, {0,0,0,20})
  end
end