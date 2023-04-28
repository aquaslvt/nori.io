-- Define variables --
interpreter = require("interpreter")

-- If there is an argument, open it! --
local file_name = "main.nio"

if arg[1] then
  file_name = arg[1]
end

local code_file = io.open(file_name, "r")

if not code_file then
  error("No file called " .. file_name)
end

-- Read the file into a string --
local code = code_file:read("*all")

-- Interpret the code --
interpreter.interpret(code)

print()
code_file:close()
