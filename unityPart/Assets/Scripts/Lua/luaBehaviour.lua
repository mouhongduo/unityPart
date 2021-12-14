local Reactive = require("Reactivity\\Reactive")
local Effect = require("Reactivity\\Effect")
function start()
    local proxy = Reactive.reactive({test = 2, test2 = 5})
    -- local res = Reactive.computed(function ()
    --     return proxy.test * proxy.test2
    -- end)
    -- local res2 = Reactive.computed(function ()
    --     return res.value * 0.9
    -- end)
    local res = Reactive.ref(0)
    local res2 = 0;
    Effect.effect(function()
        res.value = proxy.test * proxy.test2
    end)
    Effect.effect(function()
        res2 = res.value * 0.9
    end)
    print(res.value)
    print(res2)
    proxy.test2 = 10
    print("new res is:" .. tostring(res.value))
    print("new res2 is:" .. tostring(res2))
end

function update()
    
    --TextComp.text = tostring(count)
end

function ondestroy()
    print("lua destroy")
end