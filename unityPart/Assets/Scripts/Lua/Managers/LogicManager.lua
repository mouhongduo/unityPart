local socket = require("socket.core")
local ecs = require("ECS.ecs")
local Vector3 = CS.UnityEngine.Vector3

local public = {
    isBattle = false,
    battleBeginTime = 0,
    lastTime = 0,
    timer = nil,
    updater = nil,
    render = nil,
    frameCount = 0,
    isClient = true,
    avatarEntity = nil,
    cameraEnitity = nil,
    beAttacking = false,
    attackBeginFrame = 0,
    preInput = {},
    battle = nil
}
local private = {
    
}

public.Awake = function()
    private.world = ecs.world:new()
    private.entity_mgr = private.world.entity_mgr
    private.Input = CS.UnityEngine.Input
    private.KeyCode = CS.UnityEngine.KeyCode
end

public.Start = function()
    private.ServerManager = Global and Global.Managers and Global.Managers.ServerManager or nil
end

public.BeginOnlineBattle = function ()
    public.avatarEntity = private.entity_mgr:create_entity("transformComponent", "rolerComponent", "InputComponent", "Avatar")
    public.cameraEntity = private.entity_mgr:create_entity("transformComponent", "cameraComponent", "Camera", "InputComponent")
    public.enemyEntity = private.entity_mgr:create_entity("transformComponent", "rolerComponent", "InputComponent", "Enemy")
    private.GameManager = Global and Global.Managers and Global.Managers.GameManager or nil
    if(private.GameManager ~= nil) then
        private.GameManager.AddEntityMaps(public.avatarEntity, Global.avatar)
        private.GameManager.AddEntityMaps(public.cameraEntity, Global.mainCamera)
        private.GameManager.AddEntityMaps(public.enemyEntity, Global.enemy)
    end

    local TransformComponent = require("ECS.src.Components.TransformComponent")
    local RolerComponent = require("ECS.src.Components.RolerComponent")
    local avaTransform = TransformComponent.New(Global.avatar.transform.position, Global.avatar.transform.rotation.eulerAngles, Global.avatar.transform.forward, Global.avatar.transform.right)
    local avaRoler = RolerComponent.New()
    private.entity_mgr:set_component(public.avatarEntity, "transformComponent", avaTransform)
    private.entity_mgr:set_component(public.avatarEntity, "rolerComponent", avaRoler)


    local avaTransform = TransformComponent.New(Global.enemy.transform.position, Global.enemy.transform.rotation.eulerAngles, Global.enemy.transform.forward, Global.enemy.transform.right)
    local avaRoler = RolerComponent.New()
    private.entity_mgr:set_component(public.enemyEntity, "transformComponent", avaTransform)
    private.entity_mgr:set_component(public.enemyEntity, "rolerComponent", avaRoler)


    local CameraComponnet = require("ECS.src.Components.CameraComponent")
    local cameraTransform = TransformComponent.New(Global.mainCamera.transform.position, Global.mainCamera.transform.rotation.eulerAngles)
    local cameraComponent = CameraComponnet.New()
    private.entity_mgr:set_component(public.cameraEntity, "transformComponent", cameraTransform)
    private.entity_mgr:set_component(public.cameraEntity, "cameraComponent", cameraComponent)

    private.AddTransformSystem()
    private.AddInputSystem()
    private.resetTime()
end

private.AddInputSystem = function()
    local InputSystem = ecs.class("InputSystem", ecs.system)
    function InputSystem:on_update()
        local avatarInput = ecs.all("InputComponent", "Avatar")
        self:foreach(avatarInput, function(entity)
            local rolerState = entity.rolerComponent
            if(private.Input.GetKey(private.KeyCode.W) and private.Input.GetKey(private.KeyCode.LeftShift)) then
                rolerState.RollForward = true
            elseif(private.Input.GetKey(private.KeyCode.W)) then
                rolerState.Run = true
            else
                rolerState.Run = false
                rolerState.RollForward = false
            end

            if(private.Input.GetKey(private.KeyCode.LeftShift)) then
                if(private.Input.GetKey(private.KeyCode.A)) then
                    rolerState.RollLeft = true
                end
                if(private.Input.GetKey(private.KeyCode.D)) then
                    rolerState.RollRight = true
                end
            else
                if(private.Input.GetKey(private.KeyCode.S)) then
                    rolerState.WalkBack = true
                else
                    rolerState.WalkBack = false
                end
    
                if(private.Input.GetKey(private.KeyCode.A)) then
                    rolerState.RunLeft = true
                else
                    rolerState.RunLeft = false
                end
                if(private.Input.GetKey(private.KeyCode.D)) then
                    rolerState.RunRight = true
                else
                    rolerState.RunRight = false
                end
                rolerState.RollRight = false
                rolerState.RollLeft = false
            end
            

            
            if(private.Input.GetKey(private.KeyCode.Mouse0)) then
                if(public.preInput == nil) then
                    public.preInput = 0
                else
                    rolerState.LeftAttack = (rolerState.LeftAttack == rolerState.LeftAttackMax and 1 or rolerState.LeftAttack+1)
                    public.beAttacking = true
                    public.attackBeginFrame = public.frameCount
                end
                -- print(rolerState.LeftAttack)
            elseif (private.Input.GetKey(private.KeyCode.Mouse1)) then
                if(public.preInput == nil) then
                    public.preInput = 1
                else
                    rolerState.RightAttack = (rolerState.RightAttack == rolerState.RightAttackMax and 1 or rolerState.RightAttack+1)
                    public.beAttacking = true
                    public.attackBeginFrame = public.frameCount
                end
            else
                if(public.preInput ~= nil) then
                    if(public.preInput == 1) then
                        rolerState.LeftAttack = (rolerState.LeftAttack == rolerState.LeftAttackMax and 1 or rolerState.LeftAttack+1)
                    else
                        rolerState.RightAttack = (rolerState.RightAttack == rolerState.RightAttackMax and 1 or rolerState.RightAttack+1)
                    end
                    public.attackBeginFrame = public.frameCount
                    public.preInput = nil
                else
                    if(public.frameCount - public.attackBeginFrame >= 10) then
                        public.beAttacking = false
                    end
                    rolerState.LeftAttack = 0
                    rolerState.RightAttack = 0
                end
            end
            
            if(private.GameManager ~= nil) then
                private.GameManager.RenderActor(entity.entity ,rolerState)
            end
        end)

        local enemyInput = ecs.all("InputComponent", "Enemy")
        self:foreach(enemyInput, function(entity)
            local rolerState = entity.rolerComponent
            if(private.Input.GetKey(private.KeyCode.W) and private.Input.GetKey(private.KeyCode.LeftShift)) then
                rolerState.RollForward = true
            elseif(private.Input.GetKey(private.KeyCode.W)) then
                rolerState.Run = true
            else
                rolerState.Run = false
                rolerState.RollForward = false
            end

            if(private.Input.GetKey(private.KeyCode.LeftShift)) then
                if(private.Input.GetKey(private.KeyCode.A)) then
                    rolerState.RollLeft = true
                end
                if(private.Input.GetKey(private.KeyCode.D)) then
                    rolerState.RollRight = true
                end
            else
                if(private.Input.GetKey(private.KeyCode.S)) then
                    rolerState.WalkBack = true
                else
                    rolerState.WalkBack = false
                end
    
                if(private.Input.GetKey(private.KeyCode.A)) then
                    rolerState.RunLeft = true
                else
                    rolerState.RunLeft = false
                end
                if(private.Input.GetKey(private.KeyCode.D)) then
                    rolerState.RunRight = true
                else
                    rolerState.RunRight = false
                end
                rolerState.RollRight = false
                rolerState.RollLeft = false
            end
            

            
            if(private.Input.GetKey(private.KeyCode.Mouse0)) then
                if(public.preInput == nil) then
                    public.preInput = 0
                else
                    rolerState.LeftAttack = (rolerState.LeftAttack == rolerState.LeftAttackMax and 1 or rolerState.LeftAttack+1)
                    public.beAttacking = true
                    public.attackBeginFrame = public.frameCount
                end
                -- print(rolerState.LeftAttack)
            elseif (private.Input.GetKey(private.KeyCode.Mouse1)) then
                if(public.preInput == nil) then
                    public.preInput = 1
                else
                    rolerState.RightAttack = (rolerState.RightAttack == rolerState.RightAttackMax and 1 or rolerState.RightAttack+1)
                    public.beAttacking = true
                    public.attackBeginFrame = public.frameCount
                end
            else
                if(public.preInput ~= nil) then
                    if(public.preInput == 1) then
                        rolerState.LeftAttack = (rolerState.LeftAttack == rolerState.LeftAttackMax and 1 or rolerState.LeftAttack+1)
                    else
                        rolerState.RightAttack = (rolerState.RightAttack == rolerState.RightAttackMax and 1 or rolerState.RightAttack+1)
                    end
                    public.attackBeginFrame = public.frameCount
                    public.preInput = nil
                else
                    if(public.frameCount - public.attackBeginFrame >= 10) then
                        public.beAttacking = false
                    end
                    rolerState.LeftAttack = 0
                    rolerState.RightAttack = 0
                end
            end
            
            if(private.GameManager ~= nil) then
                private.GameManager.RenderActor(entity.entity ,rolerState)
            end
        end)

        local cameraInput = ecs.all("InputComponent", "Camera")
        self:foreach(cameraInput, function(entity)
            local cameraComponent = entity.cameraComponent
            local centerPos = Global.avatar.transform.position;
            Global.mainCamera.transform:RotateAround(centerPos, Vector3.up, CS.UnityEngine.Input.GetAxisRaw("Mouse X") * CS.UnityEngine.Time.timeScale * cameraComponent.XSpeed)
            local oldPos = Global.mainCamera.transform.position
            local oldRatation = Global.mainCamera.transform.rotation
            Global.mainCamera.transform:RotateAround(centerPos, Global.mainCamera.transform.right, -CS.UnityEngine.Input.GetAxisRaw("Mouse Y") * CS.UnityEngine.Time.timeScale * cameraComponent.YSpeed)
            if(Global.mainCamera.transform.rotation.eulerAngles.x < cameraComponent.MinVertical or Global.mainCamera.transform.rotation.eulerAngles.x > cameraComponent.MaxVertical) then
                Global.mainCamera.transform.position = oldPos;
                Global.mainCamera.transform.rotation = oldRatation;
            end
            local avaTransform = private.entity_mgr:get_component(public.avatarEntity, "transformComponent")
            avaTransform.rotation.y = Global.mainCamera.transform.rotation.eulerAngles.y
            avaTransform.forward = Global.avatar.transform.forward
            avaTransform.right = Global.avatar.transform.right
        end)
    end

    private.world:add_system(InputSystem)
end

private.AddTransformSystem = function()
    local transformSystem = ecs.class("transformSystem", ecs.system)
    function transformSystem:on_update()
        local transformFilter = ecs.all("transformComponent","rolerComponent")
        self:foreach(transformFilter, function(entity)
            local transform = entity.transformComponent
            local rolerState = entity.rolerComponent
            local speedScale = rolerState.Run and rolerState.speedScale or 1
            local Timer = Global.Timer
            if(rolerState.Run) then
                transform.position = Vector3(transform.position.x + transform.forward.x * rolerState.speed * speedScale,
                transform.position.y + transform.forward.y * rolerState.speed * speedScale,
                transform.position.z + transform.forward.z * rolerState.speed * speedScale)
            elseif(rolerState.WalkBack) then
                transform.position = Vector3(transform.position.x - transform.forward.x * rolerState.backSpeed,
                transform.position.y - transform.forward.y * rolerState.backSpeed,
                transform.position.z - transform.forward.z * rolerState.backSpeed)
            elseif (rolerState.RunLeft) then
                transform.position = Vector3(transform.position.x - transform.right.x * rolerState.backSpeed,
                transform.position.y - transform.right.y * rolerState.backSpeed,
                transform.position.z - transform.right.z * rolerState.backSpeed)
            elseif (rolerState.RunRight) then
                transform.position = Vector3(transform.position.x + transform.right.x * rolerState.backSpeed,
                transform.position.y + transform.right.y * rolerState.backSpeed,
                transform.position.z + transform.right.z * rolerState.backSpeed)
            elseif( rolerState.RollForward) then
                transform.position = Vector3(transform.position.x + transform.forward.x * rolerState.speed * 2,
                transform.position.y + transform.forward.y * rolerState.speed * 2,
                transform.position.z + transform.forward.z * rolerState.speed * 2)
            elseif(rolerState.RollLeft) then
                Timer.AddTask(function()
                    transform.position = Vector3(transform.position.x - transform.right.x * rolerState.speed * 2,
                        transform.position.y - transform.right.y * rolerState.speed * 2,
                        transform.position.z - transform.right.z * rolerState.speed * 2)
                    end, Timer.Type.TEN, 500)
            elseif(rolerState.RollRight) then
                transform.position = Vector3(transform.position.x + transform.right.x * rolerState.speed * 2,
                transform.position.y + transform.right.y * rolerState.speed * 2,
                transform.position.z + transform.right.z * rolerState.speed * 2)
            end
            transform.rotation.z = 0
            if(private.GameManager ~= nil) then
                private.GameManager.RenderTransform(entity.entity ,transform)
            end
        end)
        local avatarFilter = ecs.all("avatar")
        self:foreach(avatarFilter, function(entity)
            local transform = entity.transformComponent
            
            local transformMsg = {
                transform = {
                    x = transform.position.x,
                    y = transform.position.y,
                    z = transform.position.z,
                },
                rotation = {
                    x = transform.rotation.x,
                    y = transform.rotation.y,
                    z = transform.rotation.z,
                },
                forward = {
                    x = transform.forward.x,
                    y = transform.forward.y,
                    z = transform.forward.z,
                },
                right = {
                    x = transform.right.x,
                    y = transform.right.y,
                    z = transform.right.z,
                }
            }
        end)
        -- local transCameraFilter = ecs.all("transformComponent", "Camera")
        -- local i = 0
        -- self:foreach(transCameraFilter, function(entity)
        --     local avaTransform = private.entity_mgr:get_component(public.avatarEntity, "transformComponent")
        --     local transform = entity.transformComponent
        --     transform.position = Vector3(avaTransform.position.x , avaTransform.position.y + 2, avaTransform.position.z - 2.5)
        --     if(private.GameManager ~= nil) then
        --         private.GameManager.RenderTransform(entity.entity ,transform)
        --     end
        -- end)
    end
    private.world:add_system(transformSystem)
end

private.resetTime = function()
    public.battleBeginTime = socket.gettime()
    public.lastTime = public.battleBeginTime
    public.frameCount = 0
end

public.Update = function()
    local thisTime = socket.gettime()
    --print(tostring(thisTime))
    if(thisTime - public.lastTime > 0.02) then
        public.frameCount = public.frameCount+1
        private.world:update()
        public.lastTime = thisTime
        if(public.battle ~= nil and public.battle.rolerState ~= nil and public.battle.transform ~= nil and private.ServerManager ~= nil) then
            private.ServerManager.SendBattle(public.battle)
            public.battle = nil
        end
    end
end


public.SetIsBattle = function (newValue)
    public.isBattle = newValue
end

return public