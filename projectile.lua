require "planet"

projectile = {}
local p = projectile

p.projectiles = {}
p.image = love.graphics.newImage("")

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
  for pr in p.projectiles do
    pr.x = pr.x + (pr.v * math.cos(pr.t))
    pr.y = pr.y + (pr.v * math.sin(pr.t))
    for pl in planet.p.planets do
      if math.pow(math.pow(pl.x - pr.x, 2) + math.pow(pl.y - pr.y, 2), 0.5) < pl.r then
        pl.hp = pl.hp - pr.d
        table.remove(pr)
        break
      end
    end
  end
end

function projectile.draw()
  for pr in p.projectiles do
    love.graphics.rectangle("fill", pr.x, pr.y, pr.l, pr.w) -- Placeholder: This is ugly, but I don't know how to handle line separators in image file paths, or whether file paths are absolute or relative.
  end
end