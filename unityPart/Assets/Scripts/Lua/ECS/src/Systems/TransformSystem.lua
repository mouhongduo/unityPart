local ecs = require("ECS.ecs")

local transformSystem = ecs.class("transformSystem", ecs.system)

function transformSystem:on_update()
    self.filter = self.filter or ecs.all("transformSystem")
    self:foreach(self.filter, function(ed)
        local speedScale = ed.isRun and ed.speedScalte or 1
        ed.transofm.Translate(ed.transofm.forward * ed.speed * speedScale)
    end)
end