-- main.lua
function love.load()
    -- Initialize core systems
    WorldGenerator = require("world_generator")
    Plant = require("plant")
    Pirate = require("pirate")
    
    -- Game state
    world = WorldGenerator.new(50, 50)
    player = {
        o2 = 0,
        cash = 1000,
        selected_tool = "terraformer"
    }
    
    -- Dynamic entities
    plants = {}
    pirates = {}
    active_disasters = {}
    
    -- Timers
    raid_timer = 0
    o2_update_timer = 0
    
    -- UI
    font = love.graphics.newFont(14)
    love.graphics.setFont(font)
end

function love.update(dt)
    -- Update oxygen production every second
    o2_update_timer = o2_update_timer + dt
    if o2_update_timer >= 1 then
        for _, plant in ipairs(plants) do
            if plant.growth >= plant.max_growth then
                player.o2 = player.o2 + plant.o2_per_second
            end
        end
        o2_update_timer = 0
    end

    -- Update plant growth
    for _, plant in ipairs(plants) do
        plant.growth = math.min(plant.growth + 10 * dt, plant.max_growth)
    end

    -- Spawn pirate raids every 45 seconds
    raid_timer = raid_timer + dt
    if raid_timer >= 45 then
        table.insert(pirates, Pirate.new(
            love.math.random(1, 50),
            love.math.random(1, 50)
        ))
        raid_timer = 0
    end

    -- Update pirate movement
    for _, pirate in ipairs(pirates) do
        pirate:update(dt)
    end
end

function love.draw()
    -- Draw terrain grid
    for x = 1, 50 do
        for y = 1, 50 do
            local tile = world.grid[x][y]
            love.graphics.setColor(
                tile.type == "barren" and {0.5, 0.2, 0.2} or
                tile.type == "fertile" and {0.2, 0.6, 0.2} or
                {0.2, 0.2, 0.8} -- aquatic
            )
            love.graphics.rectangle("fill", (x-1)*16, (y-1)*16, 16, 16)
        end
    end

    -- Draw plants
    love.graphics.setColor(0, 0.8, 0)
    for _, plant in ipairs(plants) do
        local size = 8 * (plant.growth / plant.max_growth)
        love.graphics.circle("fill", (plant.x-1)*16 + 8, (plant.y-1)*16 + 8, size)
    end

    -- Draw pirates
    love.graphics.setColor(1, 0, 0)
    for _, pirate in ipairs(pirates) do
        love.graphics.circle("fill", (pirate.x-1)*16 + 8, (pirate.y-1)*16 + 8, 8)
    end

    -- Draw HUD
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("O₂: " .. math.floor(player.o2), 10, 10)
    love.graphics.print("Cash: °" .. player.cash, 10, 30)
    love.graphics.print("Tool: " .. player.selected_tool, 10, 50)
end

function love.mousepressed(x, y, button)
    local grid_x = math.floor(x / 16) + 1
    local grid_y = math.floor(y / 16) + 1
    
    if grid_x >= 1 and grid_x <= 50 and grid_y >= 1 and grid_y <= 50 then
        local tile = world.grid[grid_x][grid_y]
        
        if player.selected_tool == "terraformer" then
            -- Cycle through terrain types
            tile.type = ({
                barren = "fertile",
                fertile = "aquatic",
                aquatic = "barren"
            })[tile.type]
            
        elseif player.selected_tool == "planter" and tile.type == "fertile" then
            table.insert(plants, Plant.new(grid_x, grid_y))
            player.cash = player.cash - 50  -- Planting cost
        end
    end
end

function love.keypressed(key)
    -- Tool selection
    if key == "1" then player.selected_tool = "terraformer" end
    if key == "2" then player.selected_tool = "planter" end
end