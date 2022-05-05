local private = {}
local public = {}

private.Tasks100 = {}
private.Tasks500 = {}
private.Tasks1000 = {}

public.Type = {
    TEN = "100",
    FIFTY  = "500",
    HUNDREAD = "1000"
}

public.AddTask = function(func, type)
    table.insert(private["Task" .. type], func)
end

public.DoUpdate100 = function()
    for index, value in ipairs(private.Tasks100) do
        value()
    end
end

public.DoUpdate500 = function()
    for index, value in ipairs(private.Tasks500) do
        value()
    end
end

public.DoUpdate1000 = function()
    for index, value in ipairs(private.Tasks1000) do
        value()
    end
end

return public