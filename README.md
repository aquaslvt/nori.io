# nori.io#
nori.io# is a one dimensional esolang that is interpreted in Scratch, altough you're currently seeing nori.io# which is the version written in Lua

## Commands
There are a bunch of commands in nori.io#, including event limited commands! Which will be coming in later versions

### Main commands
***

| Command     | Description                                           |
| ----------- | ----------------------------------------------------- |
| `>`         | Push the value next to it.                           |
| `<`         | Pop the last value.                                  |
| `I`         | Push the user input.                                 |
| `O`         | Output the last value to the console then pop it.    |
| `@`         | Swap the last two values.                            |
| `[`	      | Jump past the matching `]` if the last value is 0.   |
| `]`	      | Jump back to the matching `[` if the last value is not zero. |
| `+`     | Add last two values together, leaving only the result. |
| `-`     | Subtract last two values together, leaving only the result. |
| `*`     | Multiply last two values together, leaving only the result. |
| `/`     | Divide last two values together, leaving only the result. |
| `^`     | Raise last two values together, leaving only the result. |
| `%`     | Modulo last two values together, leaving only the result. |
| `v`     | Square root last two values together, leaving only the result. |
| `foo\'bar'\` | Set the variable `foo` to the string value `bar`

*Note that variables, `@`, `[]`, and `''` are currently available only in the beta versions, so you can't find them on the official version unless you're allowed to.*

## Example programs


### Cat program
```IO```

### Truth machine
```I[>1O]>0O```

### Hello world
```>'Hello World!'O```

