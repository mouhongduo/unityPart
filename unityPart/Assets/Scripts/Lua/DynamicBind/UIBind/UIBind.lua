local BindType = require "DynamicBind.UIBind.BindType"
local export = {}

local funcMap  = {}
function funcMap.BindClick(item, func)
    print(item:GetComponent("Button"))
    item:GetComponent("Button").onClick:AddListener(func)
end

function export.CreateView(BindMap, vm)
    for key, value in ipairs(BindMap) do
        print("name:" .. value.name .. ",func:" .. tostring(value.func) .. ",bindtype:" .. value.bindType)
        local item = vm[value.name]
        if(value.bindType == BindType.BindClick) then
            funcMap[value.bindType](item, value.func)
        end
    end
    
end

return export
