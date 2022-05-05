local Vector3 = CS.UnityEngine.Vector3
local Quaternion = CS.UnityEngine.Quaternion

local export = {}
local UIMap = {}

function export.SpawnPrefab(name, position, rotation)
    local _SpawnManager = CS.Base.SpawnManager
    return _SpawnManager.SpawnPrefab(name, position, rotation)
end

-- function export.CloseUI(name)
--     print("CloseUI：" .. name)
--     _UIManager.CloseUI(name);
-- end

return export