local Effect = {
    activeEffect = nil
}


function Effect.effect(func)
    Effect.activeEffect = func
    Effect.activeEffect()
    Effect.activeEffect = nil
    print("Effect.activeEffect is set nil")
end

return Effect