---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by bloon.
--- DateTime: 7/2/2020 12:06 PM
---

PlayState = Class{__include = BaseState}

function PlayState:enter(params)
    self.player = params.player
end

function PlayState:update(dt)
    self.player:update(dt)
end

function PlayState:render()
    self.player:render()
end


