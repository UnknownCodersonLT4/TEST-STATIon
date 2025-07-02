local old_unpack = unpack
local old_appendfile = appendfile

local output = "yjes.txt"

local Credits = "\n" .. [[
-]\n Dumped By Slayerson V1 Dumper bot \n-[
]]

local function appendfile(filename, content)
    if not isfile(filename) then
        writefile(filename, string.format("%s\n%s", Credits, content))
    end
    return old_appendfile(filename, content)
end

local function format(tab, indent)
    indent = indent or 0
    local indent_str = string.rep("  ", indent)
    local result = "[table]:{\n"
    for index, value in pairs(tab) do
        result = result .. indent_str .. "  [" .. tostring(index) .. "] = "
        if type(value) == "table" then
            result = result .. format(value, indent + 1) .. ",\n"
        else
            result = result .. tostring(value) .. ",\n"
        end
    end
    result = result .. indent_str .. "}"
    return result
end

local function foreach(tab)
    if type(tab) == "table" then
        for index, value in pairs(tab) do
            if type(value) == "table" then
                appendfile(output, format(value, 1) .. ",\n")
            else
                appendfile(output, string.format("  [%s] = %s,\n", tostring(index), tostring(value)))
            end
        end
    end
end

function unpack(...)
    local result = old_unpack(...)
    if type(result) == "table" then
        foreach(result)
    end
    return result
end

-- Execute the obfuscated script
loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/refs/heads/main/paid"))()
