# nori.io
nori.io is a short esolang named after a stray cat I found

The iterpreter reads the program left-to-right, character per character, and always moves right.

## Commands

### Main commands

| Command     | Description                                                   |
| ----------- | ------------------------------------------------------------- |
| `>`         | Push the value next to it.                                    |
| `<`         | Pop the last value.                                           |
| `N`         | Push the numeric user input.                                  |
| `I`         | Push the user input.                                          |
| `,`         | Push the user input as an ASCII value.                        |
| `O`         | Output the last value to the console then pop it.             |
| `.`         | Output the last ASCII value to the console then pop it.       |
| `@`         | Swap the last two values.                                     |
| `£`         | Reverse the whole stack.                                      |
| `:`         | Duplicate the top value.                                      |
| `+`         | Add last two values together, leaving only the result.        |
| `-`         | Subtract last two values together, leaving only the result.   |
| `*`         | Multiply last two values together, leaving only the result.   |
| `/`         | Divide last two values together, leaving only the result.     |
| `^`         | Raise last two values together, leaving only the result.      |
| `z`         | Square root last two values together, leaving only the result.|
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
[nori.io legacy](https://scratch.mit.edu/projects/819125582/)
