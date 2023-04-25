tokens = require("tokens")

Tokens = {}

function compareTokens(a, b)
  -- tokens must have a name
  if not a.name or not b.name then
    return false
  end

  -- these names must match
  if a.name ~= b.name then
    return false
  end
  
  -- "[" and "]" have the special fields
  -- indentation and jump
  if a.name == "[" or a.name == "]" then
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
  if a.name == "string" or
    a.name == "number" or
    a.name == "variable" then
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
    print("tokenising", test.code)
    local outcome = testTokenisation(test.code, test.expected)
    if outcome then
      print("failed")
      printTokens(test.code)
      -- print("token " .. outcome, "got " .. Tokens[outcome])
      --     "expected " .. test.expected[outcome], "got " .. Tokens[outcome])
    else
      print("passed")
    end
  end
end

function printTokens(code)
  local Tokens = tokens.tokenise(code)
  for i, val in ipairs(Tokens) do
    if val.name == "[" or 
      val.name == "]" then
      print(val.name, val.indentation, val.jump)
    elseif val.name == "string" or
      val.name == "number" or
      val.name == "variable" then
      print(val.name, val.value)
    else
      print(val.name)
    end
  end
end

tests = {}

function addTest(c, e)
    table.insert(tests, {code=c, expected=e})
end

addTest("h", {})
addTest("", {})
addTest(">1", {{name=">"}, {name="number", value=1}})
addTest(">1\n", {{name=">"}, {name="number", value=1}})
addTest("> 1", {{name=">"}, {name="number", value=1}})
addTest("1 > 1", {{name=">"}, {name="number", value=1}})
addTest(">f1", {{name=">"}, {name="number", value=1}})
addTest(">f1.1", {{name=">"}, {name="number", value=1.1}})
addTest(">1.", {{name=">"}, {name="number", value=1}, {name="."}})
addTest(">f1.1.", {{name=">"}, {name="number", value=1.1}, {name="."}})
addTest(">1>2", {{name=">"}, {name="number", value=1}, {name=">"}, {name="number", value=2}})
addTest(">27>35", {{name=">"}, {name="number", value=27}, {name=">"}, {name="number", value=35}})
addTest(">27", {{name=">"}, {name="number", value=27}})
addTest(">\"27\"", {{name=">"}, {name="string", value="27"}})
addTest(">'27'", {{name=">"}, {name="string", value="27"}})
addTest(">|27|", {{name=">"}, {name="variable", value="27"}})
addTest("[]", {{name="[", indentation=1, jump=2}, {name="]", indentation=1, jump=1}})
addTest("[[]]", {{name="[", indentation=1, jump=4},
                 {name="[", indentation=2, jump=3},
                 {name="]", indentation=2, jump=2},
                 {name="]", indentation=1, jump=1}})

runTests(tests)
