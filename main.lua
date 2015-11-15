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
  player1 = player.newPlayer("Red", {}, -90, "a", "d", "w", {255, 120, 120})
  player2 = player.newPlayer("Blue", {}, 90, "left", "right", "up", {120, 120, 255})
  
  background.load()
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
  sound.play("menu")
end

-- 0 = normal mode, 1 = drunk mode
drunkMode = false
timeLeftToMenu = -1
drawMenu = true
time = 0
timeMultiplier = 1
maxAsteroids = 20
function love.update(dt)
  dt = dt * timeMultiplier
  camera.update(dt)
  if not drawMenu then
    if #asteroid.asteroids < maxAsteroids and math.random(0,1/dt) <= 3 then
      asteroid.spawn()
    end
    time = time + dt
    planet.update(dt)
    player.update(dt)
    projectile.update(dt)
    explosions.update(dt)
    asteroid.update(dt)
    events.update(dt)
    if timeLeftToMenu >= 0 then
      timeLeftToMenu = timeLeftToMenu - dt
      if timeLeftToMenu <= 0 then
        timeLeftToMenu = -1
        drawMenu = true
      end
    end
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
      --map.load(1)
      events.startEvent(6, 10)
    end
  elseif key == "1" then
    player.players[1].planet.hp = 0
  end
end

function startGame()
  drawMenu = false
  sound.menu:stop()
  sound.play("battle2")
  sound.battle2:setLooping(true)
  map.load(1)
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