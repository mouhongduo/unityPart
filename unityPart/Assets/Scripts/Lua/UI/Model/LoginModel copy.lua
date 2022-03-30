local Reactive = require("DynamicBind.Reactivity.Reactive")

local model = {
    userAccount = "",
    userPassword = ""
}
local Setter = {
    SetUserAccount = function(newStr)
        print("SetUserAccount")
        model.userAccount = newStr
    end,
    SetUserPassword = function(newStr)
        print("SetUserPassword")
        model.userPassword = newStr
    end,
    
}

local Getter = {
    GetUserAccount = function(newStr)
        return model.userAccount
    end,
    GetUserPassword = function(newStr)
        return model.userPassword
    end,
}

local React = Reactive.reactive(model)
return {Setter = Setter,  Getter = Getter}