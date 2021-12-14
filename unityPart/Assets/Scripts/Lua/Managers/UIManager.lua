print("UIManager init")
local export = {}
local _UIManager = CS.Game.UIManager

function export.OpenUI(name)
    print("OpenUI: " .. name)
    print(_UIManager)
    _UIManager.OpenUI(name)
end
return export