planet = {}
local p = planet
p.__index = p --Inheritance!

p.planets = {}
p.suns = {}

function planet.newSun(mass, x, y, radius, color, image)
  newSun = {
    m = mass,
    r = radius,
    x = x,
    y = y,
    color = color,
    image = image,
    scale = radius * 2 / image:getWidth(),
    moons = {},
    isSun = true
  }
  table.insert(p.planets, newSun)
  setmetatable(newSun, planet)
  return newSun
end

function planet.new(mass, distance, radius, startAngle, speed, health, color, image)
  newPlanet = {
      m = mass, 
      d = distance, 
      r = radius, 
      x = 0,
      y = 0,
      angle = math.rad(startAngle),
      speed = speed,
      hp = health,
      color = color,
      image = image,
      scale = radius * 2 / image:getWidth(),
      moons = {},
      isSun = false
  }
  table.insert(p.planets, newPlanet)
  setmetatable(newPlanet, planet)
  return newPlanet
end

function planet:addMoon(moon)
  table.insert(self.moons, moon)
end

function planet.getPlayerOne()
  if table.getn(p.planets) then
    p1 = p.planets[1]
    return -p1.x, -p1.y
  else
    return 0, 0
  end
end

function planet.update(dt)
  destroyed = {}
  for k,v in pairs(p.planets) do
    planet.updateMoons(v.x, v.y, v.moons, dt)
    if not v.isSun and v.hp < 1 then
      table.insert(destroyed, k)
    end
  end
  for i = #destroyed, 1, -1 do
    planet.fullRemove(p.planets[destroyed[i]])
  end
end

function planet.updateMoons(cx, cy, moons, dt)
  for _,v in pairs(moons) do
    v.angle = v.angle + dt*v.speed
    v.x = cx+math.cos(v.angle)*v.d
    v.y = cy+math.sin(v.angle)*v.d
    planet.updateMoons(v.x, v.y, v.moons, dt)
  end
end

function planet.draw()
  
  for _,v in pairs(p.planets) do
    love.graphics.setColor(v.color)
    img = v.image
    imgWidth = img:getWidth()
    imgHeight = img:getHeight()
    love.graphics.draw(img, v.x - v.r, v.y - v.r, 0, v.scale)
    --love.graphics.circle("line", v.x, v.y, v.r)
  end
end

function planet.fullRemove(target)
  if target.moons == {} then
    for k, v in pairs(p.planets) do
      if v == target then
        table.remove(p.planets, k)
        assert(not elem(v, p.planets), "Planet not removed.")
        return
      end
    end
    assert(false, "No such item in p.planets")
  else
    for _, v in pairs(target.moons) do
      assert(elem(v, p.planets), "Moon not in planet list")
      planet.fullRemove(v)
      -- assert(not elem(v, p.planets), "Moon not removed")
    end
    target.moons = {}
  end
end

function elem(item, list)
  for _, v in pairs(list) do
    if v == item then return true end
  end
  return false
end