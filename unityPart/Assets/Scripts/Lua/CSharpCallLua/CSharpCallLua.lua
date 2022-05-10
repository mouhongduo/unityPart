
local export = {
    controllersMap = {},
    managersMap = {},
}

-- export.Controllers = {}

export.managersMap.LogicManager = require("Managers.LogicManager")
export.timer = require("CSharpCallLua.Timer")
-- export.CameraController = require("Controllers.CameraController")
export.SetAvatarAndEnemy = function(self, avatar, enemy)
    Global.avatar = avatar
    Global.enemy = enemy
    export.controllersMap.CameraController.SetAvatar(avatar)
end
export.OnGameBegin = function(self)
    local GameManager = Global.Managers.GameManager
    GameManager.OnGameBegin()
end

return export