local export = {}

export.New = function()
    local RolerComponent ={
        speed = 0.05,
        backSpeed = 0.04,
        speedScale = 1.8,
        Walk = false,
        Run = false,
        TurnBack = false,
        RunLeft = false,
        RunRight = false,
        RunLeftFront = false,
        RunRightFront = false,
        LeftAttack = 0,
        RightAttack = 0,
        LeftAttackMax = 1,
        RightAttackMax = 1
    }
    return RolerComponent
end

return export