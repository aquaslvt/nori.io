# nori.io

nori.io is a short stack-based esolang named after a stray cat I found!

The interpreter reads the program left-to-right, character per character, and always moves right.

## Commands

The interpreter ignores every other character than these, making them no-op.

### Main commands

| Command     | Description                                                   |
| ----------- | ------------------------------------------------------------- |
| `>`         | Push the value next to it                                     |
| `<`         | Pop the last value                                            |
| `N`         | Push the numeric user input                                   |
| `I`         | Push the user input                                           |
| `,`         | Push the user input as an ASCII value                         |
| `O`         | Output the last value to the console then pop it              |
| `.`         | Output the last ASCII value to the console then pop it        |
| `@`         | Swap the last two values                                      |
| `$`         | Reverse the whole stack                                       |
| `:`         | Duplicate the top value                                       |
| `+`         | Add last two values together, leaving only the result         |
| `-`         | Subtract last two values together, leaving only the result    |
| `*`         | Multiply last two values together, leaving only the result    |
| `/`         | Divide last two values together, leaving only the result      |
| `^`         | Raise last two values together, leaving only the result       |
| `z`         | Square root the last value, leaving only the result           |
| `%`         | Modulo last two values together, leaving only the result      |
| `c`         | Ceil the last number                                          |
| `f`         | Floor the last number                                         |
| `r`         | Push a random number                                          |
| `b`         | Push a random bit (either 0 or 1)                             |
| `B`         | Push a random byte                                            |
| `[`         | Jump past the matching `]` if last value is 0                 |
| `]`         | Jump back to the matching `[` if last value is 1              |
| `W`         | Set the IP position to 0 (repeat the program)                 |

nori.io arithmetic is NOS × TOS, meaning that `>3>2*`, for example, will duplicate 3 (2nd value) by 2 (last value).

### Strings

You can define strings using `""`, for example, `>"Hi"O` pushes the string *Hi* and then outputs it.

Strings in nori.io are the same as Lua strings, so they might have weird behavior

## Example programs

Here are some example programs! There are a lot of them (send help they spawn every single nanosecond I breathe)

### Cat program

```IO```

### Numerical cat program

```NO```

### Bit inverter

```>1@-```

### Hello world

```>"Hello, world!"O```

### Simple adder

```NN+O```

### Cooler adder

```II@:O>" + "O:O+>" = "OO```

### Rectangle area

```nio
>"Width: "O N
>"Height: "O N*O
```

### Generate random bytes over and over

```BOW```

### Random character generator

```r>94*f>32+.```

### Random CJK character generator

*Note: might not work on all terminals*

```nio
r>28607*f>12353+   ~~ generate a code point ~~
::>64/f>64*-       ~~ get the bottom 6 bits ~~
>128+@             ~~ store the last byte ~~
>64/f              ~~ remove the bottom six bits ~~
::>64/f>64*-       ~~ get the bottom 6 bits ~~
>128+@             ~~ store the next byte ~~
>64/f              ~~ remove the bottom six bits ~~
>224+              ~~ store the first byte ~~
...                ~~ print the character ~~
```

### 99 bottles of beer

```nio
>99
[
:O
>" bottles of beer on the wall, "O :O >" bottles of beer.
Take one down and pass it around, "O
>1-
:O >" bottles of beer on the wall.

"O
]
```

## Other variations

[nori.io legacy](https://scratch.mit.edu/projects/819125582/)

[nori.io++ (unofficial)](https://github.com/MoshiKoi/noripp)
