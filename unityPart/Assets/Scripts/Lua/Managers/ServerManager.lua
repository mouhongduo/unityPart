local _ServerManager = CS.Base.ServerManager

local public = {}

public.Connect = function ()
    _ServerManager.Connect("mouhongduo")
    --_ServerManager.SendJoin()
end

public.SendBattle = function(position)
    _ServerManager.SendBattle(position)
end

return public