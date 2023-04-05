-- Define variables --
local numbers = "1234567890"
local commands = "><IO^-+/%[]'"

local code_file = io.open("main.ni", "r")
local code = code_file:read("*all")

local ip = 0
local char = string.sub(code, ip, ip)
local next_char = string.sub(code, ip + 1, ip + 1)

-- Define the stack --
Stack = {}

function push(item)
    table.insert(Stack, item)
end

function pop()
    table.remove(Stack)
end

------------------------
-- Interpret the code --
------------------------
repeat
    if char == ">" then
        push(next_char)
    elseif char == "<" then
        pop()
    elseif char == "I" then
        push(io.read())
    elseif char == "O" then
        io.write(Stack[#Stack])
        pop()
    end

    ip = ip + 1
    char = string.sub(code, ip, ip)
    next_char = string.sub(code, ip + 1, ip + 1)
until ip > #code

print()
code_file:close()