---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by bloon.
--- DateTime: 7/2/2020 12:08 PM
---

Player = Class{}

function Player:init()
    self.width = gGraphics['player']['left']:getWidth()
    self.height = gGraphics['player']['left']:getHeight()

    self.x = 50
    self.y = VIRTUAL_HEIGHT - gGraphics['ground']:getHeight() - self.height

    self.dy = 0
    self.dx = 0

    self.speed = 100
    self.jumpSpeed = 220

    self.acquiredMonitor = false
    self.numGhostsKilled = 0
end

function Player:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    -- if the above aren't true, they're overlapping
    return true
end

function Player:tileCollides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if target.y > self.y + self.height then
        return false
    end

    -- if the above aren't true, they're overlapping
    return true
end

function Player:update(dt, dy)
    -- apply velocity to character Y
    self.dy = dy or self.dy + GRAVITY
    self.y = self.y + self.dy * dt

    -- if we've gone below the map limit, set DY to 0
    if self.y > ((7 - 1) * 32.5) - self.height then
        self.y = ((7 - 1) * 32.5) - self.height
        self.dy = 0
    end

    -- keyboard input
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.dx = -self.speed
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.dx = self.speed
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end

    if (love.keyboard.isDown('up') or love.keyboard.isDown('w')) and self.dy == 0 then
        self.dy = -self.jumpSpeed
        gSounds['jump']:setVolume(0.5)
        gSounds['jump']:play()
    end
end

function Player:render()
    if self.acquiredMonitor then
        self.width = gGraphics['player']['radon_left']:getWidth()
        self.height = gGraphics['player']['radon_left']:getHeight()
    end

    if self.dx < 0 then
        if self.acquiredMonitor then
            love.graphics.draw(gGraphics['player']['radon_left'], self.x, self.y)
        else
            love.graphics.draw(gGraphics['player']['left'], self.x, self.y)
        end
    else
        if self.acquiredMonitor then
            love.graphics.draw(gGraphics['player']['radon_right'], self.x, self.y)
        else
            love.graphics.draw(gGraphics['player']['right'], self.x, self.y)
        end
    end
end

function Player:reset()
    self.x = 50
    self.y = VIRTUAL_HEIGHT - gGraphics['ground']:getHeight() - self.height
    self.dy = 0
    self.dx = 0
    self.acquiredMonitor = false
    self.numGhostsKilled = 0
end
