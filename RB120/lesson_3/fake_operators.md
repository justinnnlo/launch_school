# What are these?

These are methods that look like operators due to syntactical sugar.

These include: `[]`. `[]=`, `**`, `+ `. `-`, `*`, `/`, `<=>`, `!=`, `==`, etc.

Actual operatos are:
- `&&` and `||`
- `..` (inclusive range) and `...` (exclusive range)
- `? :` ternery if-then-else
- `=`, `%=`, `/=`, `-=`, `+=`, `|=`, `&=`, `>>=`, `<<=`, `*=`, `&&=`, `||=`, `**=` and `{` (block delimeter)

Corrollary: **every class can provide their own fake operator**.

To keep in mind: the fake operators and how they work across classes to know when to implement one.