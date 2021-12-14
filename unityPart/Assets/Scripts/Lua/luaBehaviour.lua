local Reactive = require("Reactivity\\Reactive")
local Effect = require("Reactivity\\Effect")
function start()
    local proxy = Reactive.reactive({test = 2, test2 = 5})
    local res = 0
    Effect.effect(function ()
        print("do the effect")
        res = proxy.test * proxy.test2
    end)
    print(res)
    proxy.test2 = 10
    print("new res is:" .. tostring(res))
end

function update()
    
    --TextComp.text = tostring(count)
end

function ondestroy()
    print("lua destroy")
end