local Reactive = require("DynamicBind.Reactivity.Reactive")
function start()
    local scriptName = _ENV["scriptName"]
    local path = "UI.View." .. scriptName
    local view = require(path)
    view.CreateView(_ENV)
    -- local proxy = Reactive.reactive({test = 2, test2 = 5})
    -- local res = Reactive.computed(function ()
    --     return proxy.test * proxy.test2
    -- end)
    -- local res2 = Reactive.computed(function ()
    --     return res.value * 0.9
    -- end)
    -- print(res.value)
    -- print(res2.value)
    -- proxy.test2 = 10
    -- print("new res is:" .. tostring(res.value))
    -- print("new res2 is:" .. tostring(res2.value))
end

function update()
    
    --TextComp.text = tostring(count)
end

function ondestroy()
    print("lua destroy")
end