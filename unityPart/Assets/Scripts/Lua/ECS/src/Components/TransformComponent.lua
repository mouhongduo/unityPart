local export = {}

export.New = function(position, rotation, forward, right)
    local RolerComponent ={
        position = position,
        rotation = rotation,
        forward = forward,
        right = right,
    }
    return RolerComponent
end

return export