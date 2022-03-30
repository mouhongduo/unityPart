print("UIManager init")
local export = {}
local _UIManager = CS.Base.UIManager

local UIMap = {}

function export.OpenUI(name)
    print("OpenUI: " .. name)
    _UIManager.OpenUI(name)
end

function export.CloseUI(name)
    print("CloseUI：" .. name)
    _UIManager.CloseUI(name);
end

return export