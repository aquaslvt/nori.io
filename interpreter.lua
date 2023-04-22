interpreter = {}

require("stack_funcs")
interpreter.Stack = stack_funs:new()

-- Make sure to set the stack before calling the interpreter 

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
      
      elseif char == "," then
        local input = io.read()

        for character in string.gmatch(input, '.') do
          Stack:push(string.byte(character))
        end

      elseif char == "." then
        io.write(string.char(Stack:pop()))

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

      elseif char == "c" then
        local x = Stack:pop()
        Stack:push(math.ceil(x))

      elseif char == "f" then
        local x = Stack:pop()
        Stack:push(math.floor(x))

      elseif char == "r" then
        Stack:push(math.random())

      elseif char == "b" then
        Stack:push(math.random(0, 1))

      elseif char == "B" then
        local byte_str = ""

        for i = 1, 8 do
          byte_str = byte_str .. tostring(math.random(0, 1))
        end
        
        Stack:push(byte_str)
      
      elseif char == "@" then
        local x = Stack:pop()
        local y = Stack:pop()
        Stack:push(x)
        Stack:push(y)

      elseif char == ":" then
        local x = Stack:pop()
        Stack:push(x)
        Stack:push(x)

      elseif char == "$" then
        Stack:reverse()
        
      elseif char == "W" then
        ip = 0
    
      end
      -- Update the ip-
      ip = ip + 1
      char = string.sub(code, ip, ip)
      next_char = string.sub(code, ip + 1, ip + 1)
    until ip > #code
end

return interpreter