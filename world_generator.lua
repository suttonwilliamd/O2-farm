Tile = require("world_tile")
local WorldGenerator = {}

function WorldGenerator.new(width, height)
    local world = { grid = {} }
    
    for x = 1, width do
        world.grid[x] = {}
        for y = 1, height do
            world.grid[x][y] = Tile.new(x, y)
        end
    end
    
    return world
end

return WorldGenerator