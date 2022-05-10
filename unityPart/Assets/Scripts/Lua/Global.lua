print("Global lua start")
local ecs = require("ECS.ecs")
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
export.Managers.SpawnManager = require("Managers.SpawnManager")
export.Managers.GameManager = require("Managers.GameManager")
export.Managers.ServerManager = require("Managers.ServerManager")
export.Managers.LogicManager = CSharpCallLua.managersMap.LogicManager
--export.Managers.ServerManager = require("Managers.ServerManager")
export.controllers = {}
export.controllers.CameraController = CSharpCallLua.controllersMap.CameraController


export.avatar = CS.UnityEngine.GameObject.Find("Avatar")
export.mainCamera = CS.UnityEngine.GameObject.Find("MainCamera")

export.Timer = CSharpCallLua.timer
return export