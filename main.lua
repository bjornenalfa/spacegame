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
require "pointDisplay"

function love.load()
  --projectile.new(image.missile_atomicbomb, 1, -360, 250, 20, 20, 200, 0, 90)
  
  --asteroid.spawn()
  
  -- players
  -- name, planet
  player1 = player.newPlayer("Bob", {}, -90, "a", "d", "w")
  player2 = player.newPlayer("SuperChungusIV", {}, 90, "left", "right", "up")
  
  background.load()
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
  sound.play("menu")
end

-- 0 = normal mode, 1 = drunk mode
drunkMode = false
drawMenu = true
time = 0
timeMultiplier = 1
function love.update(dt)
  dt = dt * timeMultiplier
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
  if key == "escape" then
    love.event.quit()
  elseif not drawMenu then
    if key == "1" then
      player.players[1].planet.hp = 0
    else
      player.keypressed(key)
    end
  else
    if not pcall(function() startGame(tonumber(key)) end) then
      startGame(1)
    end
    --map.load(1)
    --events.startEvent(2, 10)
  end
end

function startGame(lvl)
  drawMenu = false
  sound.menu:stop()
  sound.play("battle"..math.random(1,3))
  map.load(lvl)
end

function love.draw()
  if not drunkMode then background.drawNormal() end
  camera.draw()
  if drunkMode then background.drawDrunk() end
  if drawMenu then
    menu.draw()
  else
    explosions.draw()
    planet.draw()
    player.draw()
    projectile.draw()
    
    asteroid.draw()
    events.draw()
    
    pointDisplay.draw()
  end
end