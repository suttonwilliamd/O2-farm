local Earth = {}
local config = require("config")

function Earth.load()
    Earth.radius = 60
    Earth.position = {x = 100, y = 100}
    Earth.rotation = 0
    Earth.rotation_speed = 0.5
    Earth.texture = Earth.create_texture(120)
end

function Earth.create_texture(size)
    local canvas = love.graphics.newCanvas(size, size)
    love.graphics.setCanvas(canvas)
    
    -- Base planet
    love.graphics.setColor(0.1, 0.3, 0.8)
    love.graphics.circle("fill", size/2, size/2, size/2)
    
    -- Continents
    love.graphics.setColor(0.2, 0.7, 0.3)
    for i=1, 15 do
        love.graphics.ellipse("fill",
            size/2 + love.math.random(-40, 40),
            size/2 + love.math.random(-40, 40),
            love.math.random(10, 20),
            love.math.random(10, 20))
    end
    
    -- Cloud layer
    love.graphics.setColor(1, 1, 1, 0.3)
    for i=1, 10 do
        love.graphics.ellipse("fill",
            size/2 + love.math.random(-50, 50),
            size/2 + love.math.random(-50, 50),
            love.math.random(8, 15),
            love.math.random(8, 15))
    end
    
    love.graphics.setCanvas()
    return canvas
end

function Earth.update(dt)
    Earth.rotation = (Earth.rotation + Earth.rotation_speed * dt) % (math.pi*2)
end

function Earth.draw()
    love.graphics.push()
    love.graphics.translate(Earth.position.x, Earth.position.y)
    love.graphics.rotate(Earth.rotation)
    love.graphics.draw(Earth.texture, -Earth.radius, -Earth.radius)
    love.graphics.pop()
end

return Earth