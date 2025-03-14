local WorldGenerator = {}

function WorldGenerator.new(width, height)
    return {
        grid = (function()
            local grid = {}
            for x = 1, width do
                grid[x] = {}
                for y = 1, height do
                    grid[x][y] = {type = "barren"}
                end
            end
            return grid
        end)()
    }
end

return WorldGenerator