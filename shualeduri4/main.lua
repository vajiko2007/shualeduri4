local class = require "class"
local Snake = require "snake"
local Food = require "food"


local snake
local food
local gameState

function love.load()
    gameState = "playing"
    snake = Snake()
    food = Food()
end

function love.update(dt)
    if gameState == "playing" then
        snake:update(dt)
        if snake:isDead() then
            gameState = "gameover"
        elseif snake:collides(food) then
            snake:eat()
            food = Food()
        end
    end
end


function love.draw()
    snake:draw()
    food:draw()

    if gameState == "gameover" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("Game Over", love.graphics.getWidth() / 2 - 40, love.graphics.getHeight() / 2)
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Score: " .. snake:getScore(), 10, 10)
    end
end

function love.keypressed(key)
    if gameState == "playing" then
        if key == "up" or key == "w" then
            snake.direction = "up"
        elseif key == "down" or key == "s" then
            snake.direction = "down"
        elseif key == "left" or key == "a" then
            snake.direction = "left"
        elseif key == "right" or key == "d" then
            snake.direction = "right"
        end
    end
end
