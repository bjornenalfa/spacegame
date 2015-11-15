asteroid = {}
local a = asteroid

a.asteroids = {}

function asteroid.new(x, y, radius, angle, speed, image, color, rotationSpeed, score)
  newAsteroid = {
    x = x,
    y = y,
    vx = math.cos(angle)*speed,
    vy = math.sin(angle)*speed,
    r = radius,
    color = color,
    angle = 0,
    av = rotationSpeed,
    image = image,
    score = score
  }
  table.insert(a.asteroids, newAsteroid)
end

function asteroid.spawn()
  min_distance = 1600
  max_distance = 1600
  max_angle = math.rad(90)
  angle_interval = math.rad(45)
  
  dist = math.random(min_distance, max_distance)
  incoming = math.rad(math.random(0, 360))
  movementDirection = math.rad(180) + incoming + math.random(-angle_interval, angle_interval)
  if cars then
    asteroid.new(dist * math.cos(incoming), dist * math.sin(incoming), 40, movementDirection, math.random(100,250), "spacecar", {255, 255, 255}, 0.5, -100)
  else
    asteroid.new(dist * math.cos(incoming), dist * math.sin(incoming), math.random(20,30), movementDirection, 50, "planetdebris"..math.random(1,5), {255, 255, 255}, 2, 30)
  end
end

function a.update(dt)
  collisions = {}
  projectileRemovals = {}
  timeout = {}
  for projectileIndex, pr in pairs(a.asteroids) do
    if (pr.x * pr.x) + (pr.y * pr.y) > 1800*1800 then
      table.insert(timeout, projectileIndex)
    else
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
            other.owner.score = other.owner.score + pr.score
          end
          table.insert(projectileRemovals, i)
          break
        end
      end
    end
  end
  for i = #projectileRemovals, 1, -1 do
    explosions.new(projectile.projectiles[projectileRemovals[i]].x, projectile.projectiles[projectileRemovals[i]].y, 0.2, projectile.projectiles[projectileRemovals[i]].w, true)
    table.remove(projectile.projectiles, projectileRemovals[i])
  end
  for i = #collisions, 1, -1 do
    explosions.new(a.asteroids[collisions[i]].x, a.asteroids[collisions[i]].y, 0.2, a.asteroids[collisions[i]].r, true)
    table.remove(a.asteroids, collisions[i])
  end
  for i = #timeout, 1, -1 do
    table.remove(a.asteroids, timeout[i])
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