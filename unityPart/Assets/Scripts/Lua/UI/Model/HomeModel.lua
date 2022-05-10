--this file is auto created by MouHongduo UI tool,you can edit it 
--do not need to care initialization of ui widget any more\n
-------------------------------------------------------------------------------
local Reactive = require("DynamicBind.Reactivity.Reactive")
local model = {
	matchTime = nil,
	isMatch = false,
}

local React = Reactive.reactive(model)

local Setter = {
	SetMatchTime = function(newValue)
		React.matchTime = newValue
	end,
	SetIsMatch = function(newValue)
		React.isMatch = newValue
		print("newIsMatch", model.isMatch)
	end
}
local Getter = {
	GetMatchTime = function()
		return React.matchTime
	end,
	GetIsMatch = function()
		return React.isMatch
	end
}
return {Setter = Setter,  Getter = Getter}