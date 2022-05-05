-- local export = {}

-- export.AddInputSystem = function()
--     local InputSystem = ecs.class("InputSystem", ecs.system)
--     function InputSystem:on_update()
--         local avatarInput = ecs.all("InputComponent", "Avatar")
--         self:foreach(avatarInput, function(entity)
--             local rolerState = entity.rolerComponent
--             if(private.Input.GetKey(private.KeyCode.W) and private.Input.GetKey(private.KeyCode.LeftShift)) then
--                 print("W+Shift")
--                 rolerState.Run = true
--             elseif(private.Input.GetKey(private.KeyCode.W)) then
--                 print("W")
--                 rolerState.Walk = true
--             else
--                 rolerState.Walk = false
--                 rolerState.Run = false
--             end

                
--             if(private.Input.GetKey(private.KeyCode.S)) then
--                 rolerState.WalkBack = true
--             else
--                 rolerState.WalkBack = false
--             end

--             if(private.Input.GetKey(private.KeyCode.A)) then
--                 rolerState.RunLeft = true
--             else
--                 rolerState.RunLeft = false
--             end
--             if(private.Input.GetKey(private.KeyCode.D)) then
--                 rolerState.RunRight = true
--             else
--                 rolerState.RunRight = false
--             end

--             if(private.Input.GetKey(private.KeyCode.W) and private.Input.GetKey(private.KeyCode.A)) then
--                 rolerState.RunLeftFront = true
--             else
--                 rolerState.RunLeftFront = false
--             end
--             if(private.Input.GetKey(private.KeyCode.W) and private.Input.GetKey(private.KeyCode.D)) then
--                 rolerState.RunRightFront = true
--             else
--                 rolerState.RunRightFront = false
--             end

            
--             if(private.GameManager ~= nil) then
--                 private.GameManager.RenderActor(entity.entity ,rolerState)
--             end
--         end)

--         local cameraInput = ecs.all("InputComponent", "Camera")
--         self:foreach(cameraInput, function(entity)
--             local cameraComponent = entity.cameraComponent
--             local centerPos = Global.avatar.transform.position;
--             Global.mainCamera.transform:RotateAround(centerPos, Vector3.up, CS.UnityEngine.Input.GetAxisRaw("Mouse X") * CS.UnityEngine.Time.timeScale * cameraComponent.XSpeed)
--             local oldPos = Global.mainCamera.transform.position
--             local oldRatation = Global.mainCamera.transform.rotation
--             Global.mainCamera.transform:RotateAround(centerPos, Global.mainCamera.transform.right, -CS.UnityEngine.Input.GetAxisRaw("Mouse Y") * CS.UnityEngine.Time.timeScale * cameraComponent.YSpeed)
--             if(Global.mainCamera.transform.rotation.eulerAngles.x < cameraComponent.MinVertical or Global.mainCamera.transform.rotation.eulerAngles.x > cameraComponent.MaxVertical) then
--                 Global.mainCamera.transform.position = oldPos;
--                 Global.mainCamera.transform.rotation = oldRatation;
--             end
--             local avaTransform = private.entity_mgr:get_component(public.avatarEntity, "transformComponent")
--             avaTransform.rotation.y = Global.mainCamera.transform.rotation.eulerAngles.y
--             avaTransform.forward = Global.avatar.transform.forward
--             avaTransform.right = Global.avatar.transform.right
--         end)
--     end

--     private.world:add_system(InputSystem)
-- end

-- return export