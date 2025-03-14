local Mars = {}
local config = require("config")

function Mars.load()
    Mars.radius = 90
    Mars.position = {x = config.BASE_W - 140, y = config.BASE_H - 140}
    Mars.rotation = 0
    Mars.rotation_speed = 0.2
    Mars.texture = Mars.create_texture(180)
end

function Mars.create_texture(size)
    local canvas = love.graphics.newCanvas(size, size)
    love.graphics.setCanvas(canvas)
    
    -- Base planet
    love.graphics.setColor(0.6, 0.3, 0.2)
    love.graphics.circle("fill", size/2, size/2, size/2)
    
    -- Craters
    love.graphics.setColor(0.5, 0.25, 0.15)
    for i=1, 25 do
        local w = love.math.random(10, 30)
        love.graphics.ellipse("fill",
            size/2 + love.math.random(-70, 70),
            size/2 + love.math.random(-70, 70),
            w,
            w * 0.8)
    end
    
    -- Polar ice caps
    love.graphics.setColor(0.8, 0.85, 0.9)
    love.graphics.ellipse("fill", size/2, size/6, 40, 15)  -- North pole
    love.graphics.ellipse("fill", size/2, size - size/6, 35, 12)  -- South pole
    
    love.graphics.setCanvas()
    return canvas
end

function Mars.update(dt)
    Mars.rotation = (Mars.rotation + Mars.rotation_speed * dt) % (math.pi*2)
end

function Mars.draw()
    love.graphics.push()
    love.graphics.translate(Mars.position.x, Mars.position.y)
    love.graphics.rotate(Mars.rotation)
    love.graphics.draw(Mars.texture, -Mars.radius, -Mars.radius)
    love.graphics.pop()
end

return Mars