

Ball = {}


function Ball:load()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.width = 25
    self.height = 25
    self.speed = 1000
    self.xVel = -self.speed
    self.yVel = 0
end


function Ball:update(dt)
    self:move(dt)
    self:collide()
end


function Ball:collide()
    self:collideWall()
    self:collidePlayer()
    self:collideAI()
    self:score()
    self:level()
end


function Ball:collideWall()
    if self.y < 0 then
        self.y = 0
        self.yVel = -self.yVel
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVel = -self.yVel
    end
end


function Ball:collidePlayer()
    if checkCollision(self, Player) then
        self.xVel = self.speed
        local middleBall = self.y + self.height / 2
        local middlePlayer = Player.y + Player.height / 2
        local collisionPosition = middleBall - middlePlayer
        self.yVel = collisionPosition * 5
    end
end


function Ball:collideAI()
    if checkCollision(self, AI) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2
        local middleAI = AI.y + AI.height / 2
        local collisionPosition = middleBall - middleAI
        self.yVel = collisionPosition * 5
    end
end


function Ball:resetPosition(modifier)
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yVel = 0
    self.xVel = self.speed * modifier
end


function Ball:score()
    if self.x < 0 then
        self:resetPosition(1)
        Score.ai = Score.ai +1
    end
    if self.x + self.width > love.graphics.getWidth() then
        self:resetPosition(-1)
        Score.player = Score.player +1
    end
end

function Ball:level()
    if Score.player == 5 then
        Score.player = 0
        Score.ai = 0
        gamestate = "title"
    end
    if Score.ai == 5 then
        Score.player = 0
        Score.ai = 0
        gamestate = "title"
    end
end


function Ball:move(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt
end


function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
