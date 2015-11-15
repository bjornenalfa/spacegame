pointDisplay = {}
local p = pointDisplay

function pointDisplay.draw()
  for i = 1, #player.players, 1 do
    love.graphics.setFont(font.base)
    love.graphics.setColor({255,255,255})
    padding = 40
    msg = player.players[i].name .. ": " .. math.floor(player.players[i].score)
    width = love.graphics.getWidth()
    x = -love.graphics.getWidth()/2 + padding
    y = -love.graphics.getHeight()/2 + padding
    side = "left"
    if i == 2 then
      side = "right"
      x = x - padding * 2
    end
    love.graphics.printf(msg, x / camera.mapScale, y / camera.mapScale, width / camera.mapScale, side)
  end
end