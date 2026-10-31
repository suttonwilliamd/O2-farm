local Stars = {}
local config = require("config")

function Stars.load()
    local canvas = love.graphics.newCanvas(config.BASE_W, config.BASE_H)
    
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(0.05, 0.05, 0.1)
    love.graphics.rectangle("fill", 0, 0, config.BASE_W, config.BASE_H)
    
    for i=1, 800 do
        if love.math.random() < 0.02 then  -- Rare twinkling stars
            love.graphics.setColor(1, 1, 1, love.math.random(0.5, 1))
        else  -- Regular stars
            love.graphics.setColor(1, 1, 1, love.math.random(0.1, 0.3))
        end
        love.graphics.points(
            love.math.random(config.BASE_W),
            love.math.random(config.BASE_H)
        )
    end
    love.graphics.setCanvas()
    Stars.texture = love.graphics.newImage(canvas:newImageData())
end

function Stars.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Stars.texture)
end

return Stars