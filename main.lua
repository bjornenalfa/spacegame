require "planet"
require "projectile"
require "camera"
require "image"
require "player"

function love.load()
  projectile.new(image.missile_atomicbomb, 1, -360, 250, 20, 20, 200, 0, 90)
  
  -- suns and planets
  -- mass, x, y, radius, color, image
  sun = planet.newSun(100, 0, 0, 150, {255, 255, 255}, image.sun)
  -- mass, distance, radius, angle, speed, health, color, image
  planet1 = planet.new(20, 450, 50, 0, 0.5, 100, {200, 0, 200}, image.planet_1)
  planet2 = planet.new(8, 270, 20, 2, 1, 100, {0, 0, 250}, image.planet_1)
  planet3 = planet.new(15, 800, 40, 1, 0.15, 100, {100, 100, 100}, image.planet_1)
  moon1 = planet.new(1, 100, 10, 0, 1.5, 100, {200, 0, 200}, image.planet_1)
  sun:addMoon(planet1)
  sun:addMoon(planet2)
  sun:addMoon(planet3)
  planet1:addMoon(moon1)
  
  -- players
  -- name, planet
  player1 = player.newPlayer("Bob", planet1)
  player2 = player.newPlayer("SuperChungusIV", planet2)
end


time = 0
function love.update(dt)
  time = time + dt
  camera.update()
  planet.update(dt)
  projectile.update(dt)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  camera.draw()
  planet.draw()
  projectile.draw()
end