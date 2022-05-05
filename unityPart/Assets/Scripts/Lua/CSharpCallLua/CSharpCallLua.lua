
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

return export