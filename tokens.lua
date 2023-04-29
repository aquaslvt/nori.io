-- TODO: Code cleanup @JJRubes and @mkukiro

tokens = {}

stack_funcs = require("stack_funcs")

tokens.ip = 0
tokens.bol = 1
tokens.line = 1
tokens.char = ""
tokens.code = ""
tokens.Tokens = {}
tokens.Token = {}
tokens.bracketIndentation = 1

tokens.cont = function()
  tokens.ip = tokens.ip + 1

  if tokens.ip > #tokens.code then
    return false
  end

  tokens.char = string.sub(tokens.code, tokens.ip, tokens.ip)
  if tokens.char == "\n" then
    tokens.bol = tokens.ip
    tokens.line = tokens.line + 1
  end
  return true
end

tokens.addToken = function()
  table.insert(tokens.Tokens, tokens.Token)
  tokens.Token = {}
end

tokens.strip = function()
  local e = true
  while string.match(tokens.char, "%s") and e do
    e = tokens.cont()
  end
  return e
end

tokens.addString = function()
  tokens.Token.name = "string"

  local quote = tokens.char
  if quote ~= "\"" and quote ~= "'" then
    error("you're calling the string tokenising function wrong")
  end

  local e = tokens.cont()
  local start = tokens.ip
  while tokens.char ~= quote and e do
    e = tokens.cont()
  end

  if not e then
    error("String missing closing quotation mark\n",
      tokens.line, "| ",
      string.sub(tokens.code, tokens.bol, tokens.ip), "...")
  end

  tokens.Token.value = string.sub(tokens.code, start, tokens.ip - 1)
  tokens.cont()
  tokens.addToken()
end

tokens.add_integer = function()
  tokens.Token.name = "number"

  local e = true
  local start = tokens.ip
  while string.match(tokens.char, "%d") and e do
    e = tokens.cont()
  end

  local stringVal = string.sub(tokens.code, start, tokens.ip - 1)
  tokens.Token.value = tonumber(stringVal)
  tokens.addToken()
end

tokens.add_float = function()
  if tokens.char ~= "f" then
    error("You're calling the float tokenising function wrong")
  end

  tokens.Token.name = "number"

  local e = tokens.cont()
  local start = tokens.ip
  while string.match(tokens.char, "%d") and e do
    e = tokens.cont()
  end
  
  if string.match(tokens.char, "%.") then
    e = tokens.cont()
    while string.match(tokens.char, "%d") and e do
      e = tokens.cont()
    end
  end

  local stringVal = string.sub(tokens.code, start, tokens.ip - 1)
  tokens.Token.value = tonumber(stringVal)
  tokens.addToken()
end

tokens.addVariable = function()
  tokens.Token.name = "variable"

  local e = tokens.cont()
  local start = tokens.ip
  while tokens.char ~= "|" and e do
    e = tokens.cont()
  end

  if not e then
    error("Variable missing closing pipe\n",
      tokens.line, "| ",
      string.sub(tokens.code, tokens.bol, tokens.ip), "...")
  end

  tokens.Token.value = string.sub(tokens.code, start, tokens.ip - 1)
  tokens.cont()
  tokens.addToken()
end

tokens.simpleToken = function(name)
  tokens.Token.name = name
  tokens.cont()
  tokens.addToken()
end

tokens.tokenise = function(code)
  tokens.ip = 0
  tokens.bol = 1
  tokens.line = 1
  tokens.char = ""
  tokens.code = ""
  tokens.Tokens = {}
  tokens.Token = {}
  tokens.bracketIndentation = 1

  tokens.code = code
  tokens.ip = 0
  tokens.cont()
  tokens.strip()

  while tokens.ip <= #tokens.code do
    if tokens.char == ">" then
      tokens.simpleToken(">")
      tokens.strip()
      if tokens.char == "\"" or tokens.char == "'" then
        tokens.addString()
      elseif tokens.char == "F" then
        tokens.add_float()
      elseif string.match(tokens.char, "%d") then
        tokens.add_integer()
      elseif tokens.char == "|" then
        tokens.addVariable()
      else
        error("Push missing value to push\n" .. tokens.line .. "| " ..
          string.sub(tokens.code, tokens.bol, tokens.ip) .. "...")
      end
    elseif tokens.char == "|" then
      tokens.addVariable()
      tokens.strip()
      if tokens.char == "\"" or tokens.char == "'" then
        tokens.addString()
      elseif tokens.char == "F" then
        tokens.add_float()
      elseif string.match(tokens.char, "%d") then
        tokens.add_integer()
      elseif tokens.char == "|" then
        tokens.addVariable()
      elseif tokens.char == "<" then
        tokens.simpleToken("<")
      else
        error("Push missing value to set variable to\n" .. tokens.line .. "| " ..
          string.sub(tokens.code, tokens.bol, tokens.ip) .. "...")
      end
    elseif tokens.char == "<" then
      tokens.simpleToken("<")
    elseif tokens.char == "I" then
      tokens.simpleToken("I")
    elseif tokens.char == "N" then
      tokens.simpleToken("N")
    elseif tokens.char == "," then
      tokens.simpleToken(",")
    elseif tokens.char == "." then
      tokens.simpleToken(".")
    elseif tokens.char == "O" then
      tokens.simpleToken("O")
    elseif tokens.char == "+" then
      tokens.simpleToken("+")
    elseif tokens.char == "-" then
      tokens.simpleToken("-")
    elseif tokens.char == "*" then
      tokens.simpleToken("*")
    elseif tokens.char == "/" then
      tokens.simpleToken("/")
    elseif tokens.char == "%" then
      tokens.simpleToken("%")
    elseif tokens.char == "^" then
      tokens.simpleToken("^")
    elseif tokens.char == "z" then
      tokens.simpleToken("z")
    elseif tokens.char == "c" then
      tokens.simpleToken("c")
    elseif tokens.char == "f" then
      tokens.simpleToken("f")
    elseif tokens.char == "r" then
      tokens.simpleToken("r")
    elseif tokens.char == "b" then
      tokens.simpleToken("b")
    elseif tokens.char == "B" then
      tokens.simpleToken("B")
    elseif tokens.char == "@" then
      tokens.simpleToken("@")
    elseif tokens.char == ":" then
      tokens.simpleToken(":")
    elseif tokens.char == "$" then
      tokens.simpleToken("$")
    elseif tokens.char == "_" then
      tokens.simpleToken("_")
    elseif tokens.char == "W" then
      tokens.simpleToken("W")
    elseif tokens.char == "[" then
      tokens.Token.indentation = tokens.bracketIndentation
      tokens.bracketIndentation = tokens.bracketIndentation + 1
      tokens.simpleToken("[")
    elseif tokens.char == "]" then
      tokens.bracketIndentation = tokens.bracketIndentation - 1
      tokens.Token.indentation = tokens.bracketIndentation
      if tokens.bracketIndentation < 1 then
        error("No matching opening bracket for closing bracket\n",
          tokens.line, "| ",
          string.sub(tokens.code, tokens.bol, tokens.ip), "...")
      end
      for i=#tokens.Tokens, 1, -1 do
        if tokens.Tokens[i].name == "[" and tokens.Tokens[i].indentation == tokens.Token.indentation then
          tokens.Token.jump = i
          tokens.Tokens[i].jump = #tokens.Tokens + 1
          break
        end
      end
      if not tokens.Token.jump then
        error("This shouldn't have happened")
      end
      tokens.simpleToken("]")
    elseif tokens.char == "~" then
      tokens.cont()
      if tokens.char == "~" then
        tokens.cont()
        while tokens.char ~= "~" do
          while tokens.char ~= "~" do
            tokens.cont()
          end
          tokens.cont()
        end
      end
    else
      tokens.cont()
    end
    tokens.strip()
  end
  if tokens.bracketIndentation > 1 then
    error("Unmatched opening brackets")
  end
  return tokens.Tokens
end

return tokens
