background = {}
local b = background

function b.draw()
  starScale = 0.4
  imgList = {image.stars1, image.stars2, image.stars3, image.stars4}
  img = imgList[math.floor(time * 4 % 4 + 1)]
  width = img:getWidth()
  height = img:getHeight()
  for x = -10, 10 do
    for y = -10, 10 do
      love.graphics.draw(img, width * x * starScale, height * y * starScale, 0, starScale)
    end
  end
end

function b.draw1()
  img = image.background2
  width = img:getWidth()
  height = img:getHeight()
  love.graphics.draw(img, - width / 2, - height / 2)
end