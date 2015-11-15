player = {}
local p = player

p.players = {}

function p.newPlayer(name, planet, towerAngle, keyLeft, keyRight, keyFire)
  newPlayer = {
    name = name,
    planet = planet,
    fireAngle = 0,
    towerAngle = math.rad(towerAngle),
    keyLeft = keyLeft,
    keyRight = keyRight,
    keyFire = keyFire,
    cooldown = 0,
    score = 0
  }
  table.insert(p.players, newPlayer)
  return newPlayer
end

function p.update(dt)
  for _,v in pairs(p.players) do
    v.fireAngle = v.fireAngle
    v.cooldown = v.cooldown - dt
    if love.keyboard.isDown(v.keyFire) and v.cooldown <= 0 then
      v.cooldown = 1
      pt = v.planet
      x = pt.x + math.cos(v.towerAngle + v.planet.selfRotation) * (pt.r + 10)
      y = pt.y + math.sin(v.towerAngle + v.planet.selfRotation) * (pt.r + 10)
      projectile.new(image.missile_atomicbombSmall, 1, x, y, 17, 28, 1000, v.towerAngle + v.fireAngle + v.planet.selfRotation, 10, v)
    end
    if love.keyboard.isDown(v.keyLeft) then
      v.fireAngle = v.fireAngle - math.pi * dt * 0.5
      if (v.fireAngle < - math.pi/2) then
        v.fireAngle = - math.pi/2
      end
    end
    if love.keyboard.isDown(v.keyRight) then
      v.fireAngle = v.fireAngle + math.pi * dt * 0.5
      if (v.fireAngle > math.pi/2) then
        v.fireAngle = math.pi/2
      end
    end
  end
end

function p.keypressed(key)
  --[[for _,v in pairs(p.players) do
    if key == v.keyFire then
      pt = v.planet
      x = pt.x + math.cos(v.towerAngle) * pt.r + 10
      y = pt.y + math.sin(v.towerAngle) * pt.r + 10
      projectile.new(image.missile_atomicbomb, 1, x, y, 20, 20, 1000, v.fireAngle, 90)
    elseif key == v.keyLeft then
      v.fireAngle = v.fireAngle - math.pi / 8
    elseif key == v.keyRight then
      v.fireAngle = v.fireAngle + math.pi / 8
    end
  end]]
end

function p.draw()
  love.graphics.setColor(255,255,255)
  for _,v in pairs(p.players) do
    img = image.FireStationBase
    width = img:getWidth()
    height = img:getHeight()
    pt = v.planet
    x = pt.x + math.cos(v.towerAngle + pt.selfRotation) * pt.r
    y = pt.y + math.sin(v.towerAngle + pt.selfRotation) * pt.r
    offX = width * 0.5
    offY = height * 0.5
    love.graphics.draw(img, x, y, v.towerAngle + pt.selfRotation, pt.scale, pt.scale, offX, offY)
    cannonImg = image.cannonBig
    cannonWidth = cannonImg:getWidth()
    cannonHeight = cannonImg:getHeight()
    x = pt.x + math.cos(v.towerAngle + pt.selfRotation) * (pt.r + 8)
    y = pt.y + math.sin(v.towerAngle + pt.selfRotation) * (pt.r + 8)
    love.graphics.draw(cannonImg, x, y, v.towerAngle + v.fireAngle + pt.selfRotation, pt.scale, pt.scale, 0, cannonImg:getHeight()/2)
    -- love.graphics.draw(cannonImg, x, y, v.towerAngle + v.fireAngle, cannonWidth/ cannonImg:getWidth(), cannonHeight/ cannonImg:getHeight(), 0, cannonImg:getHeight()/2)
  end
end