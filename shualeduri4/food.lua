
local class = require "class"

local Food = class()

function Food:init()
    self.x = math.random(0, love.graphics.getWidth() - 20)
    self.y = math.random(0, love.graphics.getHeight() - 20)
    self.size = 20
end

function Food:draw()
    love.graphics.setColor(1, 0.5, 0) -- Orange color for the food
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Food
