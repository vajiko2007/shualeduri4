
local class = require "class"

local Snake = class()

function Snake:init()
    self.body = {
        { x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2 }
    }
    self.direction = "right"
    self.speed = 100
    self.canChangeDirection = true
    self.score = 0
    self.grow = false
end

function Snake:update(dt)
    if self.canChangeDirection then
        if love.keyboard.isDown("up") and self.direction ~= "down" then
            self.direction = "up"
        elseif love.keyboard.isDown("down") and self.direction ~= "up" then
            self.direction = "down"
        elseif love.keyboard.isDown("left") and self.direction ~= "right" then
            self.direction = "left"
        elseif love.keyboard.isDown("right") and self.direction ~= "left" then
            self.direction = "right"
        end
        self.canChangeDirection = false
    end

    local head = self.body[1]
    local newHead = {
        x = head.x,
        y = head.y,
    }
    if self.direction == "up" then
        newHead.y = newHead.y - self.speed * dt
    elseif self.direction == "down" then
        newHead.y = newHead.y + self.speed * dt
    elseif self.direction == "left" then
        newHead.x = newHead.x - self.speed * dt
    elseif self.direction == "right" then
        newHead.x = newHead.x + self.speed * dt
    end

  
    self.canChangeDirection = true

  
    if self.grow then
        table.insert(self.body, 1, newHead)
        self.grow = false
    else
        table.insert(self.body, 1, newHead)
        table.remove(self.body)
    end
end

function Snake:draw()
    love.graphics.setColor(0, 1, 0) 
    for _, segment in ipairs(self.body) do
        love.graphics.rectangle("fill", segment.x, segment.y, 20, 20)
    end
end

function Snake:eat()
   
    self.score = self.score + 1
    self.speed = self.speed + 14

   
    local tail = self.body[#self.body]
    for i = 1, 3 do
        table.insert(self.body, { x = tail.x, y = tail.y })
    end
end

function Snake:isDead()
    
    local head = self.body[1]
    for i = 2, #self.body do
        if head.x == self.body[i].x and head.y == self.body[i].y then
            return true 
        end
    end

    local maxX = love.graphics.getWidth()
    local maxY = love.graphics.getHeight()
    if head.x < 0 or head.x >= maxX or head.y < 0 or head.y >= maxY then
        return true 
    end

    return false
end

function Snake:collides(food)
    local head = self.body[1]
    if head.x < food.x + food.size and head.x + 20 > food.x and head.y < food.y + food.size and head.y + 20 > food.y then
        return true 
    end
    return false
end

function Snake:getScore()
    return self.score
end

return Snake
