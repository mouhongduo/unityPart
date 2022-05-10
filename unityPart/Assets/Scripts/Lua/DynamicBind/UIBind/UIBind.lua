local BindType = require "DynamicBind.UIBind.BindType"
local Reactive = require "DynamicBind.Reactivity.Reactive"
local Effect   = require "DynamicBind.Reactivity.Effect"
local LoginModel = Global.Models["LoginModel"]
local export = {}

local funcMap  = {}
function funcMap.BindClick(item, func)
    if(func == nil) then
        func = function()
            print("this is null function")
        end
    end
    item:GetComponent("Button").onClick:AddListener(func)
end

function funcMap.BindText(item, func)
    if(func == nil) then
        item:GetComponent("Text").text = "null"
        return
    end
    local resource = Reactive.computed(function ()
        item:GetComponent("Text").text = func()
    end)
end

function funcMap.BindInput(item, func)
    if(func == nil) then
        print("this is nil")
        return
    end
    local InputField = item:GetComponent("InputField")
    local setter = func()
    InputField.onValueChange:AddListener(function()
        setter(InputField.text)
    end)
end
function funcMap.BindShow(item, func)
    if(func == nil) then
        item:SetActive(false)
    else
        local resource = Reactive.computed(function ()
            local isShow = func()
            item:SetActive(isShow)
        end)
    end
end

function export.CreateView(BindMap, vm)
    for key, value in ipairs(BindMap) do
        local item = vm[value.name]
        funcMap[value.bindType](item, value.func)
    end
end

return export
