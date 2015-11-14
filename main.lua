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

function love.load()
  --projectile.new(image.missile_atomicbomb, 1, -360, 250, 20, 20, 200, 0, 90)
  
  asteroid.spawn()
  
  -- suns and planets
  -- mass, x, y, radius, color, image
  sun = planet.newSun(1e8, 0, 0, 1, {255, 255, 255}, image.sun)
  -- mass, distance, radius, startAngle, speed, health, color, image
  planetDuoBase = planet.new( 1,   150,  0,   270,  0.5,   100000,  {0, 0, 0},  image.planet_1)
  planetDuo1 = planet.new( 4e6,   30,  20,   180,  1,   100,  {255, 100, 100},  image.planet_1)
  planetDuo2 = planet.new( 4e6,   30,  20,   0,  1,   100,  {100, 100, 255},  image.planet_1)
  planet1 = planet.new( 20e6,   350,  50,   0,    0.5,    100,  {200, 0, 200},    image.planet_1)
  planet2 = planet.new( 20e6,   350,  50,   180,    0.5,    100,  {200, 0, 200},    image.planet_1)
  planet3 = planet.new( 8e6,    270,  20,   90,   1,      100,  {0, 0, 250},      image.planet_1)
  planet4 = planet.new( 15e6,   800,  40,   180,  0.15,   100,  {100, 100, 100},  image.planet_1)
  moon1 = planet.new(   1e6,    100,  10,   0,    1.5,    100,  {200, 0, 200},    image.planet_1)
  moon2 = planet.new(   1e6,    100,  12,   90,    1.5,    100,  {200, 0, 200},    image.planet_1)
  sun:addMoon(planet1)
  sun:addMoon(planet2)
  sun:addMoon(planet3)
  sun:addMoon(planet4)
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
  
  sound.battle3:play()
  
  love.graphics.setBackgroundColor(0, 0, 0)
end

-- 0 = normal mode, 1 = drunk mode
drunkMode = 0
drawMenu = true
time = 0
function love.update(dt)
  dt = dt * 2
  if math.random(0,100) <= dt*100 then
    asteroid.spawn()
  end
  time = time + dt
  camera.update(dt)
  planet.update(dt)
  player.update(dt)
  projectile.update(dt)
  explosions.update(dt)
  asteroid.update(dt)
end

function love.keypressed(key)
  player.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == " " then
    if drawMenu then
      drawMenu = false
    else
      drunkMode = 1
      sound.battle1:stop()
      sound.sandstorm:play()
    end
  end
end

function love.draw()
  if drunkMode == 0 then background.drawNormal() end
  camera.draw()
  if drunkMode == 1 then background.drawDrunk() end
  if drawMenu then
    menu.draw()
  else
    planet.draw()
    player.draw()
    projectile.draw()
    explosions.draw()
    asteroid.draw()
  end
end