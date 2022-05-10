
local Vector3 = CS.UnityEngine.Vector3
local Quaternion = CS.UnityEngine.Quaternion
local private = {}
local public = {}

public.EnityMaps = {}

public.BeginOnlineBattle = function ()
    local SpawnManager = Global.Managers.SpawnManager
    local avaName = RolerEnum.BLACKMAN.path .. RolerEnum.BLACKMAN.name
    local eneName = RolerEnum.BLACKMAN.path .. RolerEnum.BLACKMAN.name
    -- local avaName = RolerEnum.NEWBLACKMAN.path .. RolerEnum.NEWBLACKMAN.name
    -- local eneName = RolerEnum.NEWBLACKMAN.path .. RolerEnum.NEWBLACKMAN.name
    Global.avatar = SpawnManager.SpawnPrefab(avaName, Vector3(0,2,-4), Quaternion.Euler(0,0,0))
    Global.enemy = SpawnManager.SpawnPrefab(eneName, Vector3(0,2,4), Quaternion.Euler(0,180,0))
    Global.mainCamera.transform.position =  Vector3(Global.avatar.transform.position.x,Global.avatar.transform.position.y + 2,Global.avatar.transform.position.z-2.5)
    -- local ServerManager = Global.Managers.ServerManager
    -- ServerManager.Connect()
    -- -- Global.controllers.CameraController.SetAvatar(Global.avatar)
    
    -- private.BeginCountMatchTime()
    -- --Global.Managers.ServerManager.connect()
    public.OnGameBegin()
end

private.BeginCountMatchTime = function()
    local HomeModel = Global.Models["HomeModel"]
    HomeModel.Setter.SetIsMatch(true)
    local Timer = Global.Timer
    local lastTime = os.time()
    local func = function ()
        local thisTime = os.time()
        HomeModel.Setter.SetMatchTime((thisTime - lastTime) // 1)
    end
    Timer.AddTask(func, Timer.Type.HUNDREAD, 1000000)
end

public.OnGameBegin = function()
    Global.Managers.LogicManager.SetIsBattle(true)
    Global.Managers.LogicManager.BeginOnlineBattle()
    Global.Managers.UIManager.CloseUI("HomeView")
end

public.AddEntityMaps = function (entity_id, gameobject)
    --print("AddEnityMaps:" .. tostring(gameobject.name))
    public.EnityMaps[entity_id] = gameobject
end

public.RenderTransform = function(entity_id ,transform)
    local gameobject = public.EnityMaps[entity_id]
    if(entity_id == 1) then
        local offsetX = transform.position.x - gameobject.transform.position.x
        local offsetY = transform.position.y - gameobject.transform.position.y
        local offsetZ = transform.position.z - gameobject.transform.position.z
        Global.mainCamera.transform.position = Vector3(Global.mainCamera.transform.position.x + offsetX, Global.mainCamera.transform.position.y + offsetY, Global.mainCamera.transform.position.z + offsetZ)
    end
    gameobject.transform.position = transform.position
    gameobject.transform.rotation = Quaternion.Euler(transform.rotation.x, transform.rotation.y, transform.rotation.z)
end

public.RenderActor = function(entity_id, rolerState)
    local gameobject = public.EnityMaps[entity_id]
    local animator = gameobject:GetComponent(typeof(CS.UnityEngine.Animator))
    animator:SetBool("Run", rolerState.Run)
    animator:SetBool("WalkBack", rolerState.WalkBack)
    animator:SetBool("RunLeft", rolerState.RunLeft)
    animator:SetBool("RunRight", rolerState.RunRight)
    animator:SetBool("RollForward", rolerState.RollForward)
    animator:SetInteger("LeftAttack", rolerState.LeftAttack)
    animator:SetInteger("RightAttack", rolerState.RightAttack)
    animator:SetBool("RollLeft", rolerState.RollLeft)
    animator:SetBool("RollRight", rolerState.RollRight)
end

return public