local config = require("config")
local Scaling = require("systems.scaling")
local Stars = require("systems.stars")
local Earth = require("objects.earth")
local Mars = require("objects.mars")

local paused = false
local show_help = true
local focused = true

function love.load()
    Scaling.initialize()
    Stars.load()
    Earth.load()
    Mars.load()
    love.graphics.setFont(love.graphics.newFont(18))
    focused = love.window.hasFocus()
end

function love.update(dt)
    if paused or not focused then
        return
    end
    Earth.update(dt)
    Mars.update(dt)
end

function love.draw()
    love.graphics.clear(0, 0, 0)
    Scaling.begin()
    Stars.draw()
    Earth.draw()
    Mars.draw()

    love.graphics.setColor(0.85, 0.9, 1)
    love.graphics.printf("O2-farm  |  Orbital prototype", 0, 24, config.BASE_W, "center")
    if paused or not focused then
        local status = paused and "Paused - Space to resume" or "Paused - window inactive"
        love.graphics.printf(status, 0, config.BASE_H / 2, config.BASE_W, "center")
    end
    if show_help then
        love.graphics.printf(
            "Space: pause/resume   |   F11: fullscreen   |   Esc: leave fullscreen   |   H: hide help",
            24, config.BASE_H - 44, config.BASE_W - 48, "center")
    end
    Scaling.finish()
end

function love.resize(w, h)
    Scaling.update(w, h)
end

function love.keypressed(key, scancode, isrepeat)
    if isrepeat then
        return
    end
    if key == "space" then
        paused = not paused
    elseif key == "h" then
        show_help = not show_help
    elseif key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
        Scaling.update(love.graphics.getDimensions())
    elseif key == "escape" and love.window.getFullscreen() then
        love.window.setFullscreen(false)
        Scaling.update(love.graphics.getDimensions())
    end
end

function love.focus(has_focus)
    focused = has_focus
end