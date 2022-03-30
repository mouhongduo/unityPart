print("xlua start")

Global = require("Global")
CSharpCallLua = require("CSharpCallLua.CSharpCallLua")

for key, value in pairs(_G) do
    print(tostring(key) .. ":" .. tostring(value))
end