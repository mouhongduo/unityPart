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

public.AddTask = function(func, type, time)
    table.insert(private["Tasks" .. type], {func = func, time = time})
end

public.DoUpdate100 = function()
    for index, value in ipairs(private.Tasks100) do
        local func = value.func
        local time = value.time
        if(time > 0) then
            func()
        end
        value.time = time - 100
    end
end

public.DoUpdate500 = function()
    for index, value in ipairs(private.Tasks500) do
        local func = value.func
        local time = value.time
        if(time > 0) then
            func()
        end
        value.time = time - 500
    end
end

public.DoUpdate1000 = function()
    for index, value in ipairs(private.Tasks1000) do
        local func = value.func
        local time = value.time
        if(time > 0) then
            func()
        end
        value.time = time - 1000
    end
end

return public