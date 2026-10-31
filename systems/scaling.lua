local Scaling = {}
local config = require("config")

function Scaling.initialize()
    Scaling.update(love.graphics.getDimensions())
end

function Scaling.update(window_w, window_h)
    -- Keep a fixed logical scene without recreating the window or its canvases.
    Scaling.scale = math.min(window_w / config.BASE_W, window_h / config.BASE_H)
    Scaling.offset_x = (window_w - config.BASE_W * Scaling.scale) / 2
    Scaling.offset_y = (window_h - config.BASE_H * Scaling.scale) / 2
end

function Scaling.begin()
    love.graphics.push()
    love.graphics.translate(Scaling.offset_x, Scaling.offset_y)
    love.graphics.scale(Scaling.scale)
end

function Scaling.finish()
    love.graphics.pop()
end

return Scaling