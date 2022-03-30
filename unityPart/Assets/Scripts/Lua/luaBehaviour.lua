local Reactive = require("DynamicBind.Reactivity.Reactive")
function start()
    local scriptName = _ENV["scriptName"]
    local path = "UI.View." .. scriptName
    local view = require(path)
    view.CreateView(_ENV)
end

function update()
    
    --TextComp.text = tostring(count)
end

function ondestroy()
    print("lua destroy")
end