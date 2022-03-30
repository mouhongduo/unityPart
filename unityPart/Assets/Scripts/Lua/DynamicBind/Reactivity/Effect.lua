local Effect = {
    activeEffect = nil
}


function Effect.effect(func)
    Effect.activeEffect = func
    Effect.activeEffect()
    Effect.activeEffect = nil
end

return Effect