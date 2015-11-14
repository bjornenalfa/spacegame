require "planet"
require "projectile"
require "camera"
require "image"
require "sound"
require "player"
require "background"
require "explosions"
require "menu"
require "asteroid"
require "font"
require "events"

function love.load()
  --projectile.new(image.missile_atomicbomb, 1, -360, 250, 20, 20, 200, 0, 90)
  
  asteroid.spawn()
  
  -- suns and planets
  -- mass, x, y, radius, color, image
  sun = planet.newSun(1e8, 0, 0, 150, {255, 255, 255}, image.sun)
  -- mass, distance, radius, startAngle, speed, selfRotate, health, color, image
  planetDuoBase = planet.new( 1,      200,  0,      270, -0.5,   0,   100000, {0, 0, 0},  image.planet_3)
  planetDuo1 = planet.new(    4e6,    30,   20,     180,  1,     2,   100,    {255, 100, 200},  image.planet_5)
  planetDuo2 = planet.new(    4e6,    30,   20,     0,    1,     3,   100,    {100, 100, 255},  image.planet_1)
  planet1 = planet.new(       20e6,   350,  50,     0,    0.5,   1.0, 100,    {255, 255, 255},  image.planet_2)
  planet2 = planet.new(       20e6,   350,  50,     180,  0.5,   1.0, 100,    {255, 255, 255},  image.planet_1)
  planet3 = planet.new(       8e6,    1200, 20,     90,   0.01,  0.1, 50,     {255, 0, 250},    image.planet_3)
  planet4 = planet.new(       15e6,   800,  40,     180,  0.05,  0.2, 50,     {100, 100, 100},  image.planet_4)
  planet5 = planet.new(       12e6,   200,  35,     135, -0.5,   0.5, 70,     {100, 255, 100},  image.planet_2)
  planet6 = planet.new(       15e6,   600,  47,     45,  -0.1,   1.5, 120,    {100, 255, 180},  image.planet_4)
  moon1 = planet.new(         1e6,    100,  10,     0,    1.5,   0,   100,    {255, 255, 255},  image.planet_3)
  moon2 = planet.new(         1e6,    100,  12,     90,   1.5,   0,   100,    {200, 0, 200},    image.planet_1)
  sun:addMoon(planet1)
  sun:addMoon(planet2)
  sun:addMoon(planet3)
  sun:addMoon(planet4)
  sun:addMoon(planet5)
  sun:addMoon(planet6)
  sun:addMoon(planetDuoBase)
  planetDuoBase:addMoon(planetDuo1)
  planetDuoBase:addMoon(planetDuo2)
  planet1:addMoon(moon1)
  planet1:addMoon(moon2)
  
  -- players
  -- name, planet
  player1 = player.newPlayer("Bob", planet1, -90, "a", "d", "w")
  player2 = player.newPlayer("SuperChungusIV", planet2, 90, "left", "right", "up")
  
  background.load()
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
  sound.play("menu")
end

-- 0 = normal mode, 1 = drunk mode
drunkMode = false
drawMenu = true
time = 0
function love.update(dt)
  camera.update(dt)
  if not drawMenu then
    if #asteroid.asteroids < 20 and math.random(0,1/dt) <= 3 then
      asteroid.spawn()
    end
    time = time + dt
    planet.update(dt)
    player.update(dt)
    projectile.update(dt)
    explosions.update(dt)
    asteroid.update(dt)
    events.update(dt)
  end
end

function love.keypressed(key)
  if not drawMenu then
    player.keypressed(key)
  end
  if key == "escape" then
    love.event.quit()
  elseif key == " " then
    if drawMenu then
      startGame()
    else
      events.startEvent(1, 5)
    end
  end
end

function startGame()
  drawMenu = false
  sound.menu:stop()
  sound.play("battle2")
end

function love.draw()
  if not drunkMode then background.drawNormal() end
  camera.draw()
  if drunkMode then background.drawDrunk() end
  if drawMenu then
    menu.draw()
  else
    planet.draw()
    player.draw()
    projectile.draw()
    explosions.draw()
    asteroid.draw()
    events.draw()
  end
end