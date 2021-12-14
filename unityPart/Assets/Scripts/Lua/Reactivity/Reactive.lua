local Dep = require("Reactivity\\Dep")
local Reactive = {}

local Proxy = {
    data = {}
}

function Proxy.__index(table, key)
    print("this is __index func, and name:" .. key)
    Dep.track(table, key)
    return Proxy.data[key]
end
function Proxy.__newindex(table, key, val)
    print("this is __newindex func, and name:" .. key)
    Proxy.data[key] = val
    Dep.trigger(table,key)
end
function Proxy:new(target)
    local ret = {}
    self.data = target
    setmetatable(ret,Proxy)
    return ret
end

function Reactive.reactive(target)
    local ret = Proxy:new(target)
    
    return ret
end

return Reactive
