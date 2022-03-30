print("Global lua start")
local export = {}
export.Effect = require("DynamicBind.Reactivity.Effect")

local ModelsMetaTable = {}
ModelsMetaTable.__index = function(table, key)
    table[key] = require("UI.Model." .. key)
    return table[key]
end
export.Models = {}
setmetatable(export.Models, ModelsMetaTable)

export.Managers = {}
export.Managers.UIManager = require("Managers.UIManager")


return export