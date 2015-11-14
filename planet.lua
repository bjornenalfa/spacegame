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
  for _,v in pairs(p.planets) do
    planet.updateMoons(v.x, v.y, v.moons, dt)
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