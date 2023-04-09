# nori.io#
nori.io is a one dimensional esolang that is interpreted in Scratch, although you're currently seeing nori.io# which is the version written in Lua

The iterpreter reads the program left-to-right, character per character, and always moves right.

## Commands
There are a bunch of commands in nori.io#, including event limited commands! Which will be coming in later versions

### Main commands

| Command     | Description                                                   |
| ----------- | ------------------------------------------------------------- |
| `>`         | Push the value next to it.                                    |
| `<`         | Pop the last value.                                           |
| `N`         | Push the numeric user input.                                  |
| `I`         | Push the user input.                                          |
| `O`         | Output the last value to the console then pop it.             |
| `@`         | Swap the last two values.                                     |
| `£`         | Reverse the whole stack.                                      |
| `:`         | Duplicate the top value.                                      |
| `+`         | Add last two values together, leaving only the result.        |
| `-`         | Subtract last two values together, leaving only the result.   |
| `*`         | Multiply last two values together, leaving only the result.   |
| `/`         | Divide last two values together, leaving only the result.     |
| `^`         | Raise last two values together, leaving only the result.      |
| `v`         | Square root last two values together, leaving only the result.|
| `%`         | Modulo last two values together, leaving only the result.     |

## Example programs

There are actually a bunch more (hello world, truth-machine, etc...) but they include commands that aren't here yet

### Cat program
```IO```

#### Numerical cat program
```NO```

### Simple adder
```II+O```

## Other variations
[nori.io](https://scratch.mit.edu/projects/819125582/)
