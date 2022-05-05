local ecs = {}

ecs.class = require "ECS.common.class"
ecs.world = require "ECS.src.world"
ecs.entity_mgr = require "ECS.src.entity_mgr"
ecs.system = require "ECS.src.system"

--inject : ecs.all ecs.any ecs.no
local filters = require "ECS.src.filter"
for k,filter in pairs(filters) do
	ecs[k] = filter
end

return ecs