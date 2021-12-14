local Effect = require("Reactivity\\Effect")
local Dep = {}

local targetMap = {} --weakTable

function Dep.track(target, key)
    if(Effect.activeEffect ~= nil) then
        print("Effect.activeEffect is" .. tostring(Effect.activeEffect))
        local depsMap = targetMap[target]
        if(depsMap == nil) then
            depsMap = {}--depsMap
            targetMap[target] = depsMap
        end
        local dep = depsMap[key]
        if(dep == nil) then
            dep = {}
            depsMap[key] = dep--dep
        end
        dep.effect = Effect.activeEffect
    else
        print("Effect.activeEffect is null")
    end
end

function Dep.trigger(target, key)
    local depsMap = targetMap[target]
    if(depsMap == nil) then
        return
    end
    local dep = depsMap[key]
    for _, func in pairs(dep) do
        func()
    end
end

return Dep