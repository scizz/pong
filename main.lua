require("player")
require("ball")
require("ai")

generalFont = love.graphics.newFont('fonts/general.ttf', 30)
generalFontLarge = love.graphics.newFont('fonts/general.ttf', 144)

gamestate = "title"

function love.load()
    Player:load()
    Ball:load()
    AI:load()

    Score = {player = 0, ai = 0}
end


function love.update(dt)
    if gamestate == "title" then
        if love.keyboard.isDown("space") then
            gamestate = "play"
        end
    else
    Player:update(dt)
    Ball:update(dt)
    AI:update(dt)
    end
end


function love.draw()
    if gamestate == "title" then
        love.graphics.setFont(generalFontLarge)
        love.graphics.printf('PONG', 0, love.graphics.getHeight() / 2 - 90, love.graphics.getWidth(), 'center')
        love.graphics.setFont(generalFont)
        love.graphics.printf('Karl 2022', 0, love.graphics.getHeight() -50, love.graphics.getWidth(), 'center')
        if math.floor(love.timer.getTime()) % 2 == 0 then
        love.graphics.printf('Press Space to Play', 0, love.graphics.getHeight() / 2 + 30, love.graphics.getWidth(), 'center')
        end
    else
    Player:draw()
    Ball:draw()
    AI:draw()
    love.graphics.print("Player: "..Score.player, 50, 50)
    love.graphics.print("Opponent: "..Score.ai, 1050, 50)
    end
end

function checkCollision(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end
