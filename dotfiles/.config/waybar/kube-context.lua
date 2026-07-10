local cjson = require("cjson")
local output = {}

local ctx_handle = io.popen("kubectl config current-context 2>/dev/null")
local ctx = ctx_handle:read("*a"):gsub("\n", "")
ctx_handle:close()

local ns_handle = io.popen("kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null")
local ns = ns_handle:read("*a"):gsub("\n", "")
ns_handle:close()

if ns == "" then
    ns = "default"
end

if ctx == "" then
    output.text = "☸ no context"
    output.class = "none"
    print(cjson.encode(output))
    os.exit(0)
elseif ctx:find("prod") then
    output.class = "prod"
elseif ctx:find("sandbox") then
    output.class = "sandbox"
else
    output.class = "test"
end


output.text = "☸ " .. ctx .. "/" .. ns

print(cjson.encode(output))
