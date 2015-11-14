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

function p.keypressed(key)
  for _,v in pairs(p.players) do
    if key == v.keyFire then
      pt = v.planet
      x = pt.x + math.cos(v.towerAngle) * pt.r + 10
      y = pt.y + math.sin(v.towerAngle) * pt.r + 10
      projectile.new(image.missile_atomicbomb, 1, x, y, 20, 20, 200, v.fireAngle, 90)
    end
  end
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