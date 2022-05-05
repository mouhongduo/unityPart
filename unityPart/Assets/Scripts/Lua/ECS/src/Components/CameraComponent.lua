local export = {}

export.New = function()
    local CameraComponent ={
        XSpeed = 20,
        YSpeed = 12,
        MinVertical = 0,
        MaxVertical = 80
    }
    return CameraComponent
end

return export