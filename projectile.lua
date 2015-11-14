projectile = {}
local p = projectile

p.projectiles = {}

function projectile.new(image, mass, locationX, locationY, length, width, speed, angle, damage)
  table.insert(p.projectiles, {
      img = image,
      m = mass,
      x = locationX,
      y = locationY,
      ox = 0,
      oy = 0,
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
    pr.ox = pr.x
    pr.oy = pr.y
    ax = 0
    ay = 0
    for _, pl in pairs(planet.planets) do
      sqdis = (pl.x - pr.x)*(pl.x - pr.x) + (pl.y - pr.y)*(pl.y - pr.y)
      angle = math.atan2(pl.y - pr.y, pl.x - pr.x)
      g = (pl.m) / sqdis
      ax = ax + math.cos(angle) * g
      ay = ay + math.sin(angle) * g
    end
    pr.vx = pr.vx + ax * dt 
    pr.vy = pr.vy + ay * dt
    pr.x = pr.x + (pr.vx * dt)
    pr.y = pr.y + (pr.vy * dt)
    
    for _, pl in pairs(planet.planets) do
      if (pl.x - pr.x)*(pl.x - pr.x) + (pl.y - pr.y)*(pl.y - pr.y) < pl.r*pl.r then
        if not pl.isSun then
          pl.hp = pl.hp - pr.d
        end
        table.insert(collisions, projectileIndex)
        break
      end
    end
    
    projectileRemovals = {}
    for i, other in pairs(p.projectiles) do
      if (pr.x - other.x) * (pr.x - other.x) + (pr.y - other.y) * (pr.y - other.y) < 10*10 and pr ~= other then
        table.insert(projectileRemovals, projectileIndex)
        table.insert(projectileRemovals, i)
      end
    end
    for i = #projectileRemovals, 1, -1 do
      print(projectileRemovals[i])
      table.remove(p.projectiles, projectileRemovals[i])
    end
    for i = #collisions, 1, -1 do
      table.remove(p.projectiles, collisions[i])
    end
  end
end

function projectile.draw()
  love.graphics.setColor(255,255,255)
  for _, pr in pairs(p.projectiles) do
    --love.graphics.line(pr.ox, pr.oy, pr.x, pr.y)
    love.graphics.draw(pr.img, pr.x, pr.y, (math.atan2(pr.vy, pr.vx)), pr.w/pr.img:getWidth(), pr.l/pr.img:getHeight(), 0, 0)
  end
end