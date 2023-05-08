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
  local variables = {}

  ------------------------
  -- Interpret the code --
  ------------------------
  
  while tp <= #token_list do
    if token.name == ">" then
      tp = tp + 1
      token = token_list[tp]

      -- Check if it's a variable

      if token.name == "variable" then
        if not variables[token.value] then
          error("Variable" .. token.value .. "not yet set")
        end
        Stack:push(variables[token.value])
      else
        Stack:push(token.value)
      end

    elseif token.name == "<" then
      Stack:pop()

    elseif token.name == "I" then
      Stack:push(io.read())

    elseif token.name == "N" then
      local input = false
      repeat
        input = tonumber(io.read())
      until input
      Stack:push(input)
    
    elseif token.name == "," then
      local input = io.read()

      for character in string.gmatch(input, '.') do
        Stack:push(string.byte(character))
      end

    elseif token.name == "." then
      io.write(string.char(Stack:pop()))

    elseif token.name == "O" then
      io.write(Stack:pop())
    
    elseif token.name == "o" then
      print(Stack:pop())

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
  local variables = {}

  ------------------------
  -- Interpret the code --
  ------------------------
  
  while tp <= #token_list do
    if token.name == ">" then
      tp = tp + 1
      token = token_list[tp]

      -- Check if it's a variable

      if token.name == "variable" then
        if not variables[token.value] then
          error("Variable" .. token.value .. "not yet set")
        end
        Stack:push(variables[token.value])
      else
        Stack:push(token.value)
      end

    elseif token.name == "<" then
      Stack:pop()

    elseif token.name == "I" then
      Stack:push(io.read())

    elseif token.name == "N" then
      local input = false

      repeat
        input = tonumber(io.read())
      until input
      Stack:push(input)
    
    elseif token.name == "," then
      local input = io.read()

      for character in string.gmatch(input, '.') do
        Stack:push(string.byte(character))
      end

    elseif token.name == "." then
      io.write(string.char(Stack:pop()))

    elseif token.name == "O" then
      io.write(Stack:pop())

    elseif token.name == "o" then
      print(Stack:pop())

    elseif token.name == "X" then
      os.execute("clear")

    elseif token.name == "+" then
      local x = Stack:pop()
      local y = Stack:pop()
      
      Stack:push(x + y)

    elseif token.name == "-" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y - x)

    elseif token.name == "*" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(x * y)

    elseif token.name == "/" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y / x)

    elseif token.name == "%" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y % x)

    elseif token.name == "^" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y ^ x)

    elseif token.name == "z" then
      Stack:push(math.sqrt(Stack:pop()))

    elseif token.name == "c" then
      Stack:push(math.ceil(Stack:pop()))

    elseif token.name == "f" then
      Stack:push(math.floor(Stack:pop()))

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

    elseif token.name == "v" then
      local x = Stack:pop()

      table.insert(Stack, 1, x)

    elseif token.name == "_" then
      io.write('\a v( · w ·)v')
    
    elseif token.name == "W" then
      tp = 0
  
    elseif token.name == "[" then
      local x = Stack:pop()
      
      if x == 0 then
        tp = token.jump
      end

      Stack:push(x)

    elseif token.name == "]" then
      local x = Stack:pop()

      if x ~= 0 then
        tp = token.jump
      end

      Stack:push(x)

    elseif token.name == "variable" then
      variable_name = token.value
      tp = tp + 1
      token = token_list[tp]
      if token.name == "<" then
        variables[variable_name] = Stack:pop()
      else
        variables[variable_name] = token.value
      end

    end

    tp = tp + 1
    token = token_list[tp]
  end
end

return interpreter


    elseif token.name == "+" then
      local x = Stack:pop()
      local y = Stack:pop()
      
      Stack:push(x + y)

    elseif token.name == "-" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y - x)

    elseif token.name == "*" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(x * y)

    elseif token.name == "/" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y / x)

    elseif token.name == "%" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y % x)

    elseif token.name == "^" then
      local x = Stack:pop()
      local y = Stack:pop()

      Stack:push(y ^ x)

    elseif token.name == "z" then
      Stack:push(math.sqrt(Stack:pop()))

    elseif token.name == "c" then
      Stack:push(math.ceil(Stack:pop()))

    elseif token.name == "f" then
      Stack:push(math.floor(Stack:pop()))

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
  
    elseif token.name == "[" then
      local x = Stack:pop()
      
      if x == 0 then
        tp = token.jump
      end

      Stack:push(x)

    elseif token.name == "]" then
      local x = Stack:pop()

      if x ~= 0 then
        tp = token.jump
      end

      Stack:push(x)

    elseif token.name == "variable" then
      variable_name = token.value
      tp = tp + 1
      token = token_list[tp]
      if token.name == "<" then
        variables[variable_name] = Stack:pop()
      else
        variables[variable_name] = token.value
      end

    end

    tp = tp + 1
    token = token_list[tp]
  end
end

return interpreter
