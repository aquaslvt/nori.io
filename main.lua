-- Define variables --
require("stack_funs")

local numbers = "1234567890"
local commands = "><IO^-+/%[]'"

local code_file = io.open("main.nio", "r")
local code = code_file:read("*all")

local ip = 0
local char = string.sub(code, ip, ip)
local next_char = string.sub(code, ip + 1, ip + 1)

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

  elseif char == "N" then
    push(io.read('*n'))

  elseif char == "O" then
    io.write(Stack[#Stack])
    pop()

  elseif char == "+" then
    local x = Stack[#Stack]
    pop()
    local y = Stack[#Stack]
    pop()
    push(x + y)

  elseif char == "-" then
    local x = Stack[#Stack]
    pop()
    local y = Stack[#Stack]
    pop()
    push(x - y)

  elseif char == "*" then
    local x = Stack[#Stack]
    pop()
    local y = Stack[#Stack]
    pop()
    push(x * y)

  elseif char == "/" then
    local x = Stack[#Stack]
    pop()
    local y = Stack[#Stack]
    pop()
    push(x / y)

  elseif char == "%" then
    local x = Stack[#Stack]
    pop()
    local y = Stack[#Stack]
    pop()
    push(x % y)

  elseif char == "^" then
    local x = Stack[#Stack]
    pop()
    local y = Stack[#Stack]
    pop()
    push(x ^ y)

  elseif char == "v" then
    local x = Stack[#Stack]
    pop()
    push(math.sqrt(x))

  elseif char == "@" then
    Stack[#Stack], Stack[#Stack-1] = Stack[#Stack-1], Stack[#Stack]

  elseif char == ":" then
    push(Stack[#Stack])

  elseif char == "£" then
    reverse()
  end

  -- Update the ip-
  ip = ip + 1
  char = string.sub(code, ip, ip)
  next_char = string.sub(code, ip + 1, ip + 1)
until ip > #code

print()
code_file:close()
