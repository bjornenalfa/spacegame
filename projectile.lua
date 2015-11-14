require "image"
require "planet"

projectile = {}
local p = projectile

p.projectiles = {}

function projectile.new(mass, locationX, locationY, length, width, angle, speed, damage)
  table.insert(p.projectiles, {
      m = mass,
      x = locationX,
      y = locationY,
      l = length,
      w = width,
      t = angle,
      v = speed,
      d = damage
  })
end

function projectile.update(dt)
  for _, pr in pairs(p.projectiles) do
    pr.x = pr.x + (pr.v * dt * math.sin(pr.t))
    pr.y = pr.y + (pr.v * dt * math.cos(pr.t))
    for _, pl in pairs(planet) do
      print(pl)
      break
      if math.pow(math.pow(pl.x - pr.x, 2) + math.pow(pl.y - pr.y, 2), 0.5) < pl.r then
        pl.hp = pl.hp - pr.d
        table.remove(pr)
        break
      end
    end
  end
end

function projectile.draw()
  for _, pr in pairs(p.projectiles) do
    img = image.projectile1
    love.graphics.draw(pr.x, pr.y, pr.r, sx, sy, ox, oy)
  end
end