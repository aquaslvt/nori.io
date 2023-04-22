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
  while tokens.char ~= "\"" or not e do
    e = tokens.cont()
  end

  if not e then
    error("String missing closing quotation mark\n",
      tokens.line, "| ",
      string.sub(tokens.code, tokens.bol, tokens.ip), "...")
  end

  tokens.Token.value = string.sub(tokens.code, start, tokens.ip - 1)
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
end

tokens.addVariable = function()
  tokens.Token.token = "variable"

  local e = tokens.cont()
  local start = tokens.ip
  while tokens.char ~= "|" or not e do
    e = tokens.cont()
  end

  if not e then
    error("Variable missing closing pipe\n",
      tokens.line, "| ",
      string.sub(tokens.code, tokens.bol, tokens.ip), "...")
  end

  tokens.Token.value = string.sub(tokens.code, start, tokens.ip - 1)
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

  -- should this include 0 or not?
  local numbers = "[123456789]"

  tokens.code = code
  tokens.ip = 0
  tokens.cont()

  repeat
    if tokens.char == ">" then
      tokens.Token.token = ">"
      tokens.addToken()
      if not tokens.cont() then
        error("Reached end of file without a value to push")
      end
      if tokens.char == "\"" then
        tokens.addString()
      elseif string.match(tokens.char, numbers) then
        tokens.addNumber()
      elseif tokens.char == "|" then
        tokens.addVariable()
      else
        error("Push missing value to push\n",
          tokens.line, "| ",
          string.sub(tokens.code, tokens.bol, tokens.ip), "...")
      end
    elseif tokens.char == "<" then
      tokens.Token.token = "<"
    elseif tokens.char == "I" then
      tokens.Token.token = "I"
    elseif tokens.char == "N" then
      tokens.Token.token = "N"
    elseif tokens.char == "," then
      tokens.Token.token = ","
    elseif tokens.char == "." then
      tokens.Token.token = "."
    elseif tokens.char == "O" then
      tokens.Token.token = "O"
    elseif tokens.char == "+" then
      tokens.Token.token = "+"
    elseif tokens.char == "-" then
      tokens.Token.token = "-"
    elseif tokens.char == "*" then
      tokens.Token.token = "*"
    elseif tokens.char == "/" then
      tokens.Token.token = "/"
    elseif tokens.char == "%" then
      tokens.Token.token = "%"
    elseif tokens.char == "^" then
      tokens.Token.token = "^"
    elseif tokens.char == "z" then
      tokens.Token.token = "z"
    elseif tokens.char == "c" then
      tokens.Token.token = "c"
    elseif tokens.char == "f" then
      tokens.Token.token = "f"
    elseif tokens.char == "r" then
      tokens.Token.token = "r"
    elseif tokens.char == "@" then
      tokens.Token.token = "@"
    elseif tokens.char == ":" then
      tokens.Token.token = ":"
    elseif tokens.char == "$" then
      tokens.Token.token = "$"
    elseif tokens.char == "W" then
      tokens.Token.token = "W"
    elseif tokens.char == "[" then
      tokens.Token.token = "["
      tokens.Token.indentation = tokens.bracketIndentation
      tokens.bracketIndentation = tokens.bracketIndentation + 1
    elseif tokens.char == "]" then
      tokens.Token.token = "]"
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
      if ~tokens.Token.jump then
        error("This shouldn't have happened")
      end
    end
    tokens.addToken()
    tokens.cont()
  until tokens.ip > #tokens.code
  if tokens.bracketIndentation > 1 then
    error("Unmatched opening brackets")
  end
  return tokens.Tokens
end

return tokens
