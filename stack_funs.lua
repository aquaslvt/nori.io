-- Define the stack --
stack_funs = {}

Stack = {}

function push(item)
    table.insert(Stack, item)
end

function pop()
    table.remove(Stack)
end

function reverse()
  for i=#item, 1, -1 do
  	Stack[#Stack + 1] = item[i]
  end
  item = Stack
end

stack_funs.push = push
stack_funs.pop = pop
return stack_funs