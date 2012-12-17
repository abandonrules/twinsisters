Moon = class('Moon')

Moon.img = love.graphics.newImage('backgrounds/moon.png')
Moon.img:setFilter("nearest", "nearest")

function Moon:initialize(x, y, z)
  self.x = x
  self.y = y
  self.z = z
end

function Moon:draw()
  love.graphics.draw(Moon.img, camera.x+250, camera.y-400, 0, 1, 1, 0, 0)
end