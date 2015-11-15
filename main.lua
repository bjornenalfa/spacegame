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
require "map"

function love.load()
  --projectile.new(image.missile_atomicbomb, 1, -360, 250, 20, 20, 200, 0, 90)
  
  --asteroid.spawn()
  
  -- players
  -- name, planet
  player1 = player.newPlayer("Bob", {}, -90, "a", "d", "w")
  player2 = player.newPlayer("SuperChungusIV", {}, 90, "left", "right", "up")
  
  map.load(1)
  
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
      events.startEvent(2, 10)
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