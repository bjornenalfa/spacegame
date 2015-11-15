pointDisplay = {}
local p = pointDisplay

function pointDisplay.draw()
  for i = 1, #player.players, 1 do
    love.graphics.setFont(font.base)
    love.graphics.setColor({255,255,255})
    love.graphics.printf(player.players[i].name .. ": " .. math.floor(player.players[i].score), -love.graphics.getWidth()/2, -love.graphics.getHeight()/2 + 50 * i, 200000, "left")
  end
end