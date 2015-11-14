player = {}
local p = player

p.players = {}

function p.newPlayer(name, planet, towerAngle, keyLeft, keyRight, keyFire)
  newPlayer = {
    name = name,
    planet = planet,
    fireAngle = math.rad(towerAngle),
    towerAngle = math.rad(towerAngle),
    keyLeft = keyLeft,
    keyRight = keyRight,
    keyFire = keyFire
  }
  table.insert(p.players, newPlayer)
  return newPlayer
end

function p.update(dt)
  for _,v in pairs(p.players) do
    if love.keyboard.isDown(v.keyFire) then
      pt = v.planet
      x = pt.x + math.cos(v.towerAngle) * pt.r + 10
      y = pt.y + math.sin(v.towerAngle) * pt.r + 10
      projectile.new(image.missile_atomicbomb, 1, x, y, 20, 20, 1000, v.towerAngle + v.fireAngle, 90)
    end
    if love.keyboard.isDown(v.keyLeft) then
      v.fireAngle = v.fireAngle - math.pi * dt * 0.5
      if (v.fireAngle < -math.pi/2) then
        v.fireAngle = -math.pi/2
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
  for _,v in pairs(p.players) do
    img = image.FireStationBase
    width = img:getWidth()
    height = img:getHeight()
    pt = v.planet
    x = pt.x + math.cos(v.towerAngle) * pt.r
    y = pt.y + math.sin(v.towerAngle) * pt.r
    offX = width * 0.5
    offY = height * 0.5
    love.graphics.draw(img, x, y, v.towerAngle, pt.scale, pt.scale, offX, offY)
  end
end