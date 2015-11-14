asteroid = {}
local a = asteroid

a.asteroids = {}

function asteroid.new(x, y, radius, angle, speed, image, color, rotationSpeed)
  newAsteroid = {
    x = x,
    y = y,
    vx = math.cos(angle)*speed,
    vy = math.sin(angle)*speed,
    r = radius,
    color = color,
    angle = 0,
    av = rotationSpeed,
    image = image
  }
  table.insert(a.asteroids, newAsteroid)
end

function asteroid.spawn()
  asteroid.new(math.random(-500,500), -500, 20, -math.pi*math.random(0.01,0.99), 50, "planetdebris"..math.random(1,5), {255, 255, 255}, 2)
end

function a.update(dt)
  collisions = {}
  projectileRemovals = {}
  for projectileIndex, pr in pairs(a.asteroids) do
    -- asteroid specific
    pr.angle = pr.angle + pr.av * dt
    --general
    collided = false
    ax = 0
    ay = 0
    for _, pl in pairs(planet.planets) do
      sqdis = (pl.x - pr.x)*(pl.x - pr.x) + (pl.y - pr.y)*(pl.y - pr.y)
      angle = math.atan2(pl.y - pr.y, pl.x - pr.x)
      g = (0.02 * pl.m) / sqdis
      ax = ax + math.cos(angle) * g
      ay = ay + math.sin(angle) * g
    end
    pr.vx = pr.vx + ax * dt 
    pr.vy = pr.vy + ay * dt
    pr.x = pr.x + (pr.vx * dt)
    pr.y = pr.y + (pr.vy * dt)
    
    for _, pl in pairs(planet.planets) do
      if (pl.x - pr.x)*(pl.x - pr.x) + (pl.y - pr.y)*(pl.y - pr.y) < pl.r*pl.r then
        table.insert(collisions, projectileIndex)
        collided = true
        break
      end
    end
    
    for i, other in pairs(projectile.projectiles) do
      if (pr.x - other.x) * (pr.x - other.x) + (pr.y - other.y) * (pr.y - other.y) < 50+pr.r*pr.r then
        if not collided then
          table.insert(collisions, projectileIndex)
        end
        table.insert(projectileRemovals, i)
        break
      end
    end
  end
  for i = #projectileRemovals, 1, -1 do
    explosions.new(projectile.projectiles[projectileRemovals[i]].x, projectile.projectiles[projectileRemovals[i]].y, 0.2, projectile.projectiles[projectileRemovals[i]].w)
    table.remove(projectile.projectiles, projectileRemovals[i])
  end
  for i = #collisions, 1, -1 do
    explosions.new(a.asteroids[collisions[i]].x, a.asteroids[collisions[i]].y, 0.2, a.asteroids[collisions[i]].r)
    table.remove(a.asteroids, collisions[i])
  end
end

function a.draw()
  for _,v in pairs(a.asteroids) do
    love.graphics.setColor(v.color)
    img = image[v.image]
    imgWidth = img:getWidth()
    imgHeight = img:getHeight()
    love.graphics.draw(img, v.x, v.y, v.angle, v.r * 2/imgWidth, v.r * 2/imgWidth, v.r, v.r)
    --love.graphics.draw(image["cracks"..math.min(5,crack)], v.x - v.r, v.y - v.r, 0, v.scale)
    --love.graphics.circle("line", v.x, v.y, v.r)
  end
end