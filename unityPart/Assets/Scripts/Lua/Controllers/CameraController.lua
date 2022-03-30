local Vector3 = CS.UnityEngine.Vector3;

local private = {
    RotateScalse = 8.0
}
local public  = {}



public.Awake = function()
    private.avatar = CS.UnityEngine.GameObject.Find("Avatar")
    private.camera = CS.UnityEngine.GameObject.Find("MainCamera")
    print(private.avatar.name);
end

public.Start = function()
end

public.Update = function()
    local centerPos = private.avatar.transform.position;
    private.camera.transform:Rotate(centerPos, Vector3.up, CS.UnityEngine.Input.GetAxisRaw("Mouse X" * CS.UnityEngine.Time.timeScale * private.RotateScalse))
end

return public