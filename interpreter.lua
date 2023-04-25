interpreter = {}

require("stack_funcs")
interpreter.Stack = stack_funs:new()

tokens = require("tokens")

-- Make sure to set the stack before calling the interpreter 

function interpreter.interpret(code)
  local Stack = interpreter.Stack

  token_list = tokens.tokenise(code)
  -- token pointer not toilet paper --
  local tp = 1
  local token = token_list[tp]

  ------------------------
  -- Interpret the code --
  ------------------------
  while tp <= #token_list do
    if token.name == ">" then
      tp = tp + 1
      token = token_list[tp]
      Stack:push(token.value)

    elseif token.name == "<" then
      Stack:pop()

    elseif token.name == "I" then
      Stack:push(io.read())

    elseif token.name == "N" then
      Stack:push(io.read('*n'))
    
    elseif token.name == "," then
      local input = io.read()

      for character in string.gmatch(input, '.') do
        Stack:push(string.byte(character))
      end

    elseif token.name == "." then
      io.write(string.char(Stack:pop()))

    elseif token.name == "O" then
      io.write(Stack:pop())

    elseif token.name == "+" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x + y)

    elseif token.name == "-" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x - y)

    elseif token.name == "*" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x * y)

    elseif token.name == "/" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x / y)

    elseif token.name == "%" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x % y)

    elseif token.name == "^" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x ^ y)

    elseif token.name == "z" then
      local x = Stack:pop()
      Stack:push(math.sqrt(x))

    elseif token.name == "c" then
      local x = Stack:pop()
      Stack:push(math.ceil(x))

    elseif token.name == "f" then
      local x = Stack:pop()
      Stack:push(math.floor(x))

    elseif token.name == "r" then
      Stack:push(math.random())

    elseif token.name == "b" then
      Stack:push(math.random(0, 1))

    elseif token.name == "B" then
      local byte_str = ""

      for i = 1, 8 do
        byte_str = byte_str .. tostring(math.random(0, 1))
      end
      
      Stack:push(byte_str)
    
    elseif token.name == "@" then
      local x = Stack:pop()
      local y = Stack:pop()
      Stack:push(x)
      Stack:push(y)

    elseif token.name == ":" then
      local x = Stack:pop()
      Stack:push(x)
      Stack:push(x)

    elseif token.name == "$" then
      Stack:reverse()

    elseif token.name == "_" then
      io.write('\a v( · w ·)v')
      
    elseif token.name == "W" then
      tp = 0
  
    end
    -- Update the tp-
    tp = tp + 1
    token = token_list[tp]
  end
end

return interpreter
