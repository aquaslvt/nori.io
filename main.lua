-- Define variables --
interpreter = require("interpreter")

local code_file = io.open("main.nio", "r")
local code = code_file:read("*all")

interpreter.interpret(code)

print()
code_file:close()