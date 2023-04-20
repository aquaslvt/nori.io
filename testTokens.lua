tokens = require("tokens")

Tokens = {}

function compareTokens(a, b)
  -- tokens must have a name
  if not a.token or not b.token then
    return false
  end

  -- these names must match
  if a.token ~= b.token then
    return false
  end
  
  -- "[" and "]" have the special fields
  -- indentation and jump
  if a.token == "[" or a.token == "]" then
    if not a.indentation or not b.indentation then
      return false
    end
    local cmpIndent = a.indentation == b.indentation

    if not a.jump or not b.jump then
      return false
    end
    local cmpJump = a.jump == b.jump

    return cmpIndent and cmpJump
  end

  -- "string", "number", and "variable" all have
  -- a special field called value
  if a.token == "string" or
    a.token == "number" or
    a.token == "variable" then
    if not a.value or not b.value then
      return false
    end

    return a.value == b.value
  end

  -- the token names match
  -- and they don't have any special values
  return true
end

function testTokenisation(code, expectedTokens)
  Tokens = tokens.tokenise(code)
  for i, val in ipairs(Tokens) do
    if not expectedTokens[i] then
      return i
    end

    if not compareTokens(val, expectedTokens[i]) then
      return i
    end
  end
  -- I am using false to indicate no issue
  -- because it is easy to compare
  -- without needing to consider type coercion
  return false
end

function runTests(tests)
  for i, test in ipairs(tests) do
    local outcome = testTokenisation(test.code, test.expected)
    if outcome then
      print("test " .. i, "token " .. outcome,
      "expected " .. test.expected[outcome], "got " .. Tokens[outcome])
    else
      print(i, "passed")
    end
  end
end

function printTokens(code)
  local Tokens = tokens.tokenise(code)
  for i, val in ipairs(Tokens) do
    if val.token == "[" or 
      val.token == "]" then
      print(val.token, val.indentation, jump)
    elseif val.token == "string" or
      val.token == "number" or
      val.token == "variable" then
      print(val.token, val.value)
    else
      print(val.token)
    end
  end
end

tests = {
  {code=">1", expected={{token=">"}, {token="number", value=1}}},
  {code=">27", expected={{token=">"}, {token="number", value=27}}},
  {code=">\"27\"", expected={{token=">"}, {token="string", value="27"}}},
  {code=">|27|", expected={{token=">"}, {token="variable", value="27"}}}
}
runTests(tests)
