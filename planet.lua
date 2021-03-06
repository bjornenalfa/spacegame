planet = {}
local p = planet
p.__index = p --Inheritance!

p.planets = {}
p.suns = {}

function planet.newSun(mass, x, y, radius, color, image)
  newSun = {
    m = mass,
    r = radius,
    oldr = radius,
    x = x,
    y = y,
    hp = 100000,
    maxhp = 100000,
    color = color,
    image = image,
    scale = radius * 2 / image:getWidth(),
    xscale = radius * 2 / image:getWidth(),
    yscale = radius * 2 / image:getHeight(),
    moons = {},
    isSun = true
  }
  table.insert(p.planets, newSun)
  table.insert(p.suns, newSun)
  setmetatable(newSun, planet)
  return newSun
end

function planet.new(mass, distance, radius, startAngle, speed, selfRotationSpeed, health, color, image)
  newPlanet = {
      m = mass, 
      d = distance, 
      r = radius, 
      x = 0,
      y = 0,
      angle = math.rad(startAngle),
      speed = speed,
      selfRotation = 0,
      selfRotationSpeed = selfRotationSpeed,
      hp = health,
      maxhp = health,
      color = color,
      image = image,
      scale = radius * 2 / image:getWidth(),
      xscale = radius * 2 / image:getWidth(),
      yscale = radius * 2 / image:getHeight(),
      moons = {},
      isSun = false
  }
  table.insert(p.planets, newPlanet)
  setmetatable(newPlanet, planet)
  return newPlanet
end

function planet:addMoon(moon)
  table.insert(self.moons, moon)
  moon.parent = self
end

function planet:addMoons(...)
  moons = {...}
  for _,moon in pairs(moons) do
    table.insert(self.moons, moon)
    moon.parent = self
  end
end

function planet.update(dt)
  destroyed = {}
  for k,v in pairs(p.planets) do
    if v.isSun then
      planet.updateMoons(v.x, v.y, v.moons, dt)
    elseif v.hp <= 0 then
      table.insert(destroyed, k)
    end
  end
  for i = #destroyed, 1, -1 do
    pl = p.planets[destroyed[i]]
    explosions.new(pl.x, pl.y, 0.2, pl.r)
    planet.remove(pl)
    sound.planet_explode:play()
  end
end

function planet.updateMoons(cx, cy, moons, dt)
  for _,v in pairs(moons) do
    v.angle = v.angle + dt*v.speed
    v.x = cx+math.cos(v.angle)*v.d
    v.y = cy+math.sin(v.angle)*v.d
    v.selfRotation = v.selfRotation + v.selfRotationSpeed * dt
    planet.updateMoons(v.x, v.y, v.moons, dt)
  end
end

function planet.draw()
  
  for _,v in pairs(p.planets) do
    love.graphics.setColor(v.color)
    img = v.image
    if v.isSun and drunkMode then img = image.sun_sunglasses end
    imgWidth = img:getWidth()
    imgHeight = img:getHeight()
    crack = math.floor(((v.maxhp - v.hp) / v.maxhp) * 5 + 0.5)
    --love.graphics.draw(img, v.x - v.r, v.y - v.r, 0, v.scale)
    --love.graphics.draw(image["cracks"..math.min(5,crack)], v.x - v.r, v.y - v.r, 0, v.scale)
    if v.isSun and v.r == 1 then
      love.graphics.draw(img, v.x, v.y, v.selfRotation, v.xscale, v.yscale, v.oldr / v.xscale, v.oldr / v.yscale)
    else
      love.graphics.draw(img, v.x, v.y, v.selfRotation, v.xscale, v.yscale, v.r / v.xscale, v.r / v.yscale)
    end
    love.graphics.draw(image["cracks"..math.min(5,crack)], v.x, v.y,
          v.selfRotation, v.xscale, v.yscale, v.r / v.xscale, v.r / v.yscale)
    --love.graphics.circle("line", v.x, v.y, v.r)
  end
end

function planet.remove(target)
  target.removed = true
  delete = true
  while delete do
    delete = false
    deleteList = {}
    for _,v in pairs(p.planets) do
      if v.removed then
        table.insert(deleteList, _)
        v.moons = {}
      else
        if v.parent then
          if v.parent.removed then
            v.parent = {}
            table.insert(deleteList, _)
          end
        end
      end
    end
    for i = #deleteList,1,-1 do
      table.remove(p.planets, deleteList[i])
      delete = true
    end
  end
end

--[[function planet.fullRemove(target)
  for k, v in pairs(p.planets) do
    if v == target then
      table.remove(p.planets, k)
      assert(not elem(v, p.planets), "Planet not removed.")
      break
    end
  end
  for k, v in pairs(target.parent.moons) do
    if v == target then
      table.remove(target.parent.moons, k)
      assert(not elem(v, target.parent.moons), "Planet not removed.")
      break
    end
  end
  if #target.moons then
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
end]]