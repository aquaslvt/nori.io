interpreter = {}

require("stack_funs")
interpreter.Stack = stack_funs:new()

interpreter.numbers = "1234567890"
interpreter.commands = "><IO^-+/%[]'"

-- Make sure to set the stack before
-- calling interpret
function interpreter.interpret(code)
    local Stack = interpreter.Stack

    local ip = 0
    local char = string.sub(code, ip, ip)
    local next_char = string.sub(code, ip + 1, ip + 1)

    ------------------------
    -- Interpret the code --
    ------------------------
    repeat
      if char == ">" then
        Stack:push(next_char)

      elseif char == "<" then
        Stack:pop()

      elseif char == "I" then
        Stack:push(io.read())

      elseif char == "N" then
        Stack:push(io.read('*n'))

      elseif char == "O" then
        io.write(Stack:pop())

      elseif char == "+" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x + y)

      elseif char == "-" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x - y)

      elseif char == "*" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x * y)

      elseif char == "/" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x / y)

      elseif char == "%" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x % y)

      elseif char == "^" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x ^ y)

      elseif char == "z" then
        local x = Stack:pop()
        Stack:push(math.sqrt(x))

      elseif char == "@" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x)
        Stack:push(y)

      elseif char == ":" then
        local x = Stack:pop()
        Stack:push(x)
        Stack:push(x)

      elseif char == "£" then
        Stack:reverse()
      end

      -- Update the ip-
      ip = ip + 1
      char = string.sub(code, ip, ip)
      next_char = string.sub(code, ip + 1, ip + 1)
    until ip > #code
end

return interpreter
