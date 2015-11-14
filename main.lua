require "planet"
require "camera"
require "image"

function love.load()
  love.graphics.setBackgroundColor(0,0,0)
  -- mass, x, y, radius, color, image
  sun = planet.newSun(100, 0, 0, 200, {255, 255, 255}, image.sun)
  -- mass, distance, radius, angle, speed, health, color, image
  sun:addMoon(planet.new(1, 300, 20, 2, 0.1, 100, {0, 0, 250}, image.planet_1))
  sun:addMoon(planet.new(1, 400, 40, 1, 0.02, 100, {100, 100, 100}, image.planet_1))
  planet1 = planet.new(1, 200, 50, 0, 0.5, 100, {200, 0, 200}, image.planet_1)
  moon1 = planet.new(1, 150, 10, 0, 1.5, 100, {200, 0, 200}, image.planet_1)
  sun:addMoon(planet1)
  planet1:addMoon(moon1)
end


time = 0
function love.update(dt)
  time = time + dt
  camera.update()
  planet.update(dt)
end

function love.draw()
  camera.draw()
  --love.graphics.setColor(255, 255, 255)
  --love.graphics.draw(image.sun, 0, 0)
  planet.draw()
end