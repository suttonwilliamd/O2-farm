local Pirate = {}

function Pirate.new(start_x, start_y)
    return {
        x = start_x,
        y = start_y,
        target_x = 25,  -- Center of map
        target_y = 25,
        speed = 15,
        
        -- Add this method to fix the error
        update = function(self, dt)
            local dx = self.target_x - self.x
            local dy = self.target_y - self.y
            local dist = math.sqrt(dx^2 + dy^2)
            
            if dist > 0 then
                self.x = self.x + (dx/dist) * self.speed * dt
                self.y = self.y + (dy/dist) * self.speed * dt
            end
        end
    }
end

return Pirate