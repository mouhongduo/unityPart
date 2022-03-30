local Effect = Global.Effect
local Dep = {}

local targetMap = {} --weakTable
local weakKeyMt = {
    __mode = "k"
}
setmetatable(targetMap, weakKeyMt)

function Dep.track(target, key)
    if(Effect.activeEffect ~= nil) then
        local depsMap = targetMap[target]
        if(depsMap == nil) then
            depsMap = {}--depsMap
            setmetatable(depsMap, weakKeyMt)
            targetMap[target] = depsMap
        end
        local dep = depsMap[key]
        if(dep == nil) then
            dep = {}
            depsMap[key] = dep--dep
        end
        dep[#dep+1] = Effect.activeEffect
    else
        --print("Warn, Effect.activeEffect is null and key is:" .. key)
    end
end

function Dep.trigger(target, key)
    print("begin trigger")
    local depsMap = targetMap[target]
    if(depsMap == nil) then
        return
    end
    local dep = depsMap[key]
    local i = 0;
    for _, func in pairs(dep) do
        i = i+1
        func()
    end
end

return Dep