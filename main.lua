local config = require("config")
local Scaling = require("systems.scaling")
local Stars = require("systems.stars")
local Earth = require("objects.earth")
local Mars = require("objects.mars")

function love.load()
    Scaling.initialize()
    Stars.load()
    Earth.load()
    Mars.load()
end

function love.update(dt)
    Earth.update(dt)
    Mars.update(dt)
    
    local current_w, current_h = love.graphics.getDimensions()
    if current_w ~= Scaling.last_w or current_h ~= Scaling.last_h then
        Scaling.update()
        Earth.position.x = 100 * (current_w/config.BASE_W)
        Earth.position.y = 100 * (current_h/config.BASE_H)
        Mars.position.x = current_w - 140 * (current_w/config.BASE_W)
        Mars.position.y = current_h - 140 * (current_h/config.BASE_H)
    end
end

function love.draw()
    love.graphics.setColor(0.05, 0.05, 0.1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    Stars.draw()
    Earth.draw()
    Mars.draw()
end

function love.resize(w, h)
    Scaling.update()
end