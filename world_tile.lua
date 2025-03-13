local Tile = {}

function Tile.new(x, y)
    return {
        x = x, y = y,
        type = "barren",
        moisture = 0
    }
end

return Tile