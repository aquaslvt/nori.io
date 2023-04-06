-- Define variables --
local numbers = "1234567890"
local commands = "><IO^-+/%[]'"

local code_file = io.open("main.nio", "r")
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

---------------
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
    elseif char == "+" then
        push(Stack[#Stack] + Stack[#Stack - 1])
    elseif char == "-" then
        push(Stack[#Stack] - Stack[#Stack - 1])
    elseif char == "*" then
        push(Stack[#Stack] * Stack[#Stack - 1])
    elseif char == "/" then
        push(Stack[#Stack] / Stack[#Stack - 1])
    elseif char == "%" then
        push(Stack[#Stack] % Stack[#Stack - 1])
    elseif char == "^" then
        push(Stack[#Stack] ^ Stack[#Stack - 1])
    elseif char == "v" then
        push(math.sqrt(Stack[#Stack]))
    elseif char == "@" then
        Stack[#Stack], Stack[#Stack-1] = Stack[#Stack-1], Stack[#Stack]
    elseif char == ":" then
        push(Stack[#Stack])
    end

    ip = ip + 1
    char = string.sub(code, ip, ip)
    next_char = string.sub(code, ip + 1, ip + 1)
until ip > #code

print()
code_file:close()