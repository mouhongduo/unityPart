print("UIManager init")
local export = {}
local _UIManager = CS.Game.UIManager

function export.OpenUI(name)
    print("OpenUI: " .. name)
    _UIManager.OpenUI(name)
end
return export