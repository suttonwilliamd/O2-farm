local Plant = {}

function Plant.new(x, y)
    return {
        x = x, y = y,
        growth = 0,
        max_growth = 100,
        o2_per_second = 0.5
    }
end

return Plant