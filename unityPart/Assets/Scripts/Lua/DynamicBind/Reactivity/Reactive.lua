local Dep = require("DynamicBind.Reactivity.Dep")
local Effect = Global.Effect
local Reactive = {}

local Proxy = {
    data = {}
}

function Proxy.__index(table, key)
    Dep.track(table, key)
    return Proxy.data[key]

end
function Proxy.__newindex(table, key, val)
    Proxy.data[key] = val
    Dep.trigger(table,key)
end
function Proxy:new(target)
    local proxy = {}
    self.data = target
    setmetatable(proxy,Proxy)
    return proxy
end

function Reactive.reactive(target)
    local ret = Proxy:new(target)
    
    return ret
end

local Ref = {
    value = nil
}

function Ref:new(raw)--使用闭包实现
    local ref = {}
    local mt = {
        __index = function(table, key)
            Dep.track(ref, "value")
            return raw
        end,
        __newindex = function(table, key, val)
            raw = val
            Dep.trigger(ref,"value")
        end
    }
    setmetatable(ref, mt)
    return ref
end

function Reactive.ref(raw)
    local ret = Ref:new(raw)

    return ret
end

function Reactive.computed(getter)--用ref来实现计算属性
    local ret = Ref:new()

    Effect.effect(function()
        local val = getter()
        ret.value = val
    end)

    return ret
end

return Reactive
