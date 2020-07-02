---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by bloon.
--- DateTime: 7/2/2020 12:08 PM
---

Monitor = Class{}


function Monitor:init(img, x, y)
    self.image = img
    self.width = img:getWidth()
    self.height = img:getHeight()
    self.x = x
    self.y = y
    self.isVisible = true
end

function Monitor:collides(target)
    if self.x < target.x + target.width and
    target.x < self.x + self.width and
    self.y < target.y + target.height and
    target.y < self.y + self.height then
        self.isVisible = false
    end
    
end

function Monitor:update(dt)

end

function Monitor:render()

    if self.isVisible then
        love.graphics.draw(self.image, self.x, self.y, 0)
    end
end
