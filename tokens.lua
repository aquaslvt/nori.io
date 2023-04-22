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
    tokens.line = tokens + 1
  end
  return true
end

tokens.addToken = function()
  table.insert(tokens.Tokens, tokens.Token)
  tokens.Token = {}
end

tokens.addString = function()
  tokens.Token.token = "string"

  local e = tokens.cont()
  local start = tokens.ip
  while tokens.char ~= "\"" and e do
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

tokens.addNumber = function()
  tokens.Token.token = "number"

  local e = true
  local start = tokens.ip
  while string.match(tokens.char, "%d") and e do
    e = tokens.cont()
  end

  local stringVal = string.sub(tokens.code, start, tokens.ip - 1)
  tokens.Token.value = tonumber(stringVal)
  tokens.addToken()
end

tokens.addVariable = function()
  tokens.Token.token = "variable"

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
  tokens.Token.token = name
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

  repeat
    if tokens.char == ">" then
      tokens.simpleToken(">")
      if tokens.char == "\"" then
        tokens.addString()
      elseif string.match(tokens.char, "%d") then
        tokens.addNumber()
      elseif tokens.char == "|" then
        tokens.addVariable()
      else
        error("Push missing value to push\n",
          tokens.line, "| ",
          string.sub(tokens.code, tokens.bol, tokens.ip), "...")
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
      tokens.Token.indentation = tokens.bracketIndentation
      tokens.bracketIndentation = tokens.bracketIndentation - 1
      if tokens.bracketIndentation < 1 then
        error("No matching opening bracket for closing bracket\n",
          tokens.line, "| ",
          string.sub(tokens.code, tokens.bol, tokens.ip), "...")
      end
      for i=#tokens.Tokens, 1, -1 do
        if tokens.Tokens[i].token == "[" and tokens.Tokens[i].indentation == tokens.Token.indentation then
          tokens.Token.jump = i
          tokens.Tokens[i].jump = #tokens.Tokens + 1
          break
        end
      end
      if not tokens.Token.jump then
        error("This shouldn't have happened")
      end
      tokens.simpleToken("]")
    end
  until tokens.ip > #tokens.code
  if tokens.bracketIndentation > 1 then
    error("Unmatched opening brackets")
  end
  return tokens.Tokens
end

return tokens
