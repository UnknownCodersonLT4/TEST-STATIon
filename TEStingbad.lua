local old_unpack = unpack
local old_append = appendfile

local output = "yIKESs.txt"

local Credits = "\n"..[[
-]
Dumped By Slayerson V1 Dumper bot
-[
]]

local function appendfile(filename, content)
    if not isfile(filename) then
        writefile(filename, string.format("%s\n%s", Credits, content))
    end
    return old_append(filename, content)
end

local function format(tab, indent)
    indent = indent or 0
    local result = string.rep(" ", indent) .. "[table]:{\n"
    for index, value in pairs(tab) do
        if type(value) == "table" then
            result = result .. string.rep(" ", indent + 2) .. "[" .. tostring(index) .. "] = " .. format(value, indent + 2)
        else
            result = result .. string.rep(" ", indent + 2) .. "[" .. tostring(index) .. "] = " .. tostring(value) .. ",\n"
        end
    end
    result = result .. string.rep(" ", indent) .. "},\n"
    return result
end

local function foreach(tab)
    if type(tab) == "table" then
        for index, value in pairs(tab) do
            if type(value) == "table" then
                appendfile(output, format(value))
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

--[[ Script ]]--

--> Put your obfuscated script here
--> Using tbo as an example : It will freeze your game for a bit and then create a file named after your output
--> then it will basically just put all the stuff in there, just wait for it to be done

--> either loadstring or just the pasted script here
--> btw dont use tbo its skidded lmao

loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/refs/heads/main/paid"))()
