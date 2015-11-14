projectile = {}
local p = projectile

p.projectiles = {}

function projectile.new(image, mass, locationX, locationY, length, width, speed, angle, damage)
  table.insert(p.projectiles, {
      img = image,
      m = mass,
      x = locationX,
      y = locationY,
      l = length,
      w = width,
      vx = speed * math.cos(angle),
      vy = speed * math.sin(angle),
      d = damage
  })
end

function projectile.update(dt)
  collisions = {}
  for projectileIndex, pr in pairs(p.projectiles) do
    pr.x = pr.x + (pr.vx * dt)
    pr.y = pr.y + (pr.vy * dt)
    for _, pl in pairs(planet.planets) do
      if math.sqrt((pl.x - pr.x)*(pl.x - pr.x) + (pl.y - pr.y)*(pl.y - pr.y)) < pl.r then
        --pl.hp = pl.hp - pr.d
        table.insert(collisions, projectileIndex)
        break
      end
    end
  end
  for i = #collisions, 1, -1 do
    table.remove(p.projectiles, collisions[i])
  end
end

function projectile.draw()
  for _, pr in pairs(p.projectiles) do
    love.graphics.draw(pr.img, pr.x, pr.y, pr.r, pr.w/pr.img:getWidth(), pr.l/pr.img:getHeight(), 0, 0)
  end
end