-- local Vector3 = CS.UnityEngine.Vector3;

-- local private = {
--     RotateScale = 8.0,
--     VerticalRange = {
--         min = 0,
--         max = 60
--     }
-- }
-- local public  = {}



-- public.Awake = function()
    
-- end

-- public.SetAvatar = function(avatar)
--     private.avatar = avatar
--     private.camera.transform.position =  Vector3(private.avatar.transform.position.x,private.avatar.transform.position.y + 2,private.avatar.transform.position.z-2.5)
-- end

-- public.Start = function()
--     private.avatar = nil
--     private.camera = Global.mainCamera
--     private.LogicManager = Global.Managers.LogicManager
-- end

-- public.Update = function()
--     if(private.avatar ~= nil and private.LogicManager.isBattle) then
--         local centerPos = private.avatar.transform.position;
--         private.camera.transform:RotateAround(centerPos, Vector3.up, CS.UnityEngine.Input.GetAxisRaw("Mouse X") * CS.UnityEngine.Time.timeScale * private.RotateScale)
--         local oldPos = private.camera.transform.position
--         local oldRatation = private.camera.transform.rotation
--         private.camera.transform:RotateAround(centerPos, private.camera.transform.right, CS.UnityEngine.Input.GetAxisRaw("Mouse Y") * CS.UnityEngine.Time.timeScale * private.RotateScale / 4)
--         if(private.camera.transform.rotation.eulerAngles.x < private.VerticalRange.min or private.camera.transform.rotation.eulerAngles.x > private.VerticalRange.max) then
--             private.camera.transform.position = oldPos;
--             private.camera.transform.rotation = oldRatation;
--         end
--     end
-- end

-- return public