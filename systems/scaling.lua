local Scaling = {}
local config = require("config")

function Scaling.initialize()
    love.window.setMode(config.BASE_W, config.BASE_H, {
        resizable = true,
        minwidth = config.MIN_WIDTH,
        minheight = config.MIN_HEIGHT
    })
    Scaling.last_w, Scaling.last_h = love.graphics.getDimensions()
end

function Scaling.update()
    local window_w, window_h = love.graphics.getDimensions()
    
    -- Maintain 16:9 aspect ratio
    local current_ratio = window_w/window_h
    if current_ratio > config.ASPECT_RATIO then
        window_w = window_h * config.ASPECT_RATIO
    else
        window_h = window_w / config.ASPECT_RATIO
    end
    
    love.window.setMode(window_w, window_h)
    Scaling.last_w, Scaling.last_h = window_w, window_h
end

return Scaling