--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more\n
-------------------------------------------------------------------------------
local Reactive = require("DynamicBind.Reactivity.Reactive")local model = {
	userAccount = "",
	userPassword = "",
}
local Setter = {
	SetUserAccount = function(newValue)
        print("SetUserAccount")
		model.userAccount = newValue
	end,
	SetUserPassword = function(newValue)
        print("SetUserPassword")
		model.userPassword = newValue
	end,
}
local Getter = {
	GetUserAccount = function()
		return model.userAccount
	end,
	GetUserPassword = function()
		return model.userPassword
	end,
}
local React = Reactive.reactive(model)
return {Setter = Setter,  Getter = Getter}