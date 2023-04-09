interpreter = require("interpreter")

function runCode(code, startStack, expectedStack)
    interpreter.Stack.Stack = startStack
    interpreter.interpret(code)
    if #interpreter.Stack.Stack ~= #expectedStack then
        return false
    end
    for i, val in ipairs(interpreter.Stack.Stack) do
        if expectedStack[i] ~= val then
            return false
        end
    end
    return true
end

testResults = {}
function runTest(code, startStack, expectedStack, testName)
    local pass = runCode(code, startStack, expectedStack)
    if pass then
        io.write("O")
    else
        io.write("X")
        table.insert(testResults, testName)
    end
end

print("Individual Instructions")

runTest(">1", {}, {1}, "push 1")
runTest(">94", {}, {94}, "push 2 digit number")
runTest(">1>2>3", {}, {1, 2, 3}, "push 1, 2, 3")

runTest("<", {1, 2, 3}, {1, 2}, "push then pop")

-- I can't be bothered setting up IO tests

runTest("+", {7, 8}, {15}, "add 2 positive integers")

runTest("-", {7, 8}, {1}, "subtract 2 positive integers")

runTest("*", {7, 8}, {56}, "multiply 2 positive integers")

runTest("/", {4, 8}, {2}, "divide positive integer multiple")

runTest("%", {23, 8}, {7}, "modulo 2 positive integers")

runTest("^", {2, 5}, {25}, "square an integer")

runTest("v", {25}, {5}, "square root an integer")

runTest("@", {7, 8}, {8, 7}, "swap")

runTest(":", {7}, {7, 7}, "duplicate")

runTest("£", {}, {}, "reverse no elements")
runTest("£", {1}, {1}, "reverse one element")
runTest("£", {1, 2}, {2, 1}, "reverse 2 elements")
runTest("£", {"test", 73, true}, {true, 73, "test"}, "reverse various elements")

print()
for _, unpassedTest in ipairs(testResults) do
    print(unpassedTest)
end
