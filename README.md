# nori.io
nori.io is a short esolang named after a stray cat I found

The iterpreter reads the program left-to-right, character per character, and always moves right.

## Commands
The interpreter ignores every other character than these, making them no-op.

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
| `$`         | Reverse the whole stack.                                      |
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

### Square area
This programs asks user input for a square's side

```>2N^O```

#### Rectangle area
This programs asks for the width and height of a rectangle

```NN*O```

## Other variations
[nori.io legacy](https://scratch.mit.edu/projects/819125582/)
