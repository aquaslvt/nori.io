interpreter = require("interpreter")

function runCode(code, start_stack, expected_stack)
    interpreter.Stack.Stack = start_stack
    interpreter.interpret(code)
    if #interpreter.Stack.Stack ~= #expected_stack then
        return false
    end
    for i, val in ipairs(interpreter.Stack.Stack) do
        if expected_stack[i] ~= val then
            return false
        end
    end
    return true
end

testResults = {}
function runTest(code, start_stack, expected_stack, test_name)
    local pass = runCode(code, start_stack, expected_stack)
    if pass then
        io.write("O")
    else
        io.write("X")
        table.insert(testResults, test_name)
    end
end

print("     Empty Program")
print("=======================")
runTest("", {}, {}, "Empty Program")

print()
print("Individual Instructions")
print("=======================")

runTest(">1", {}, {1}, "Push 1")
runTest(">94", {}, {94}, "Push a 2 digit number")
runTest(">1>2>3", {}, {1, 2, 3}, "Push 1, 2, 3")

runTest("<", {1, 2, 3}, {1, 2}, "Pop from the stack")

runTest("+", {7, 8}, {15}, "Add 2 positive integers")

runTest("-", {7, 8}, {1}, "Subtract 2 positive integers")

runTest("*", {7, 8}, {56}, "Multiply 2 positive integers")

runTest("/", {4, 8}, {2}, "Divide positive integer multiple")

runTest("%", {8, 23}, {7}, "Modulo 2 positive integers")

runTest("^", {2, 5}, {25}, "Square an integer")

runTest("z", {25}, {5}, "Square root an integer")

runTest("@", {7, 8}, {8, 7}, "Swap")

runTest(":", {7}, {7, 7}, "Duplicate")

runTest("$", {}, {}, "Reverse no elements")
runTest("$", {1}, {1}, "Reverse one element")
runTest("$", {1, 2}, {2, 1}, "Reverse 2 elements")
runTest("$", {"test", 73, true}, {true, 73, "test"}, "Reverse various elements")

print()

for _, unpassedTest in ipairs(testResults) do
    print(unpassedTest)
end
