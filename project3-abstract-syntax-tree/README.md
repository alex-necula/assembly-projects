# Tema 3 IOCLA - AST

## Necula Alexandru - 322CD

For these functions, I used the `cdecl` convention, where the callee has to save
all general purpose registers except `EAX`, `ECX` and `EDX`. Result is stored in
`EAX`

### `iocla_atoi` function

- Firstly, we check if the number is positive or negative (use `EDI` to store 0
  or 1)
- For negative numbers, we use 2's complement
- We iterate over the characters of the token and build the number in `EAX`

### `create_node` function

- Its header in C would be `Node* create_node(char* token)`
- Allocates memory using `malloc` and `strdup` and maps the data according to
  the given structure

### `create_tree` function

- We use `strtok` to split the input string
- For each node, it calls the `create_node` function
- Firstly, we create the root node and save its address in the `root` variable
- Nodes containing operators are pushed to the stack in order to create the AST
- For each token, we pop its parent from the stack and link the created node to
  either left or right
- Finally, we move the root's address back to `EAX`

### Homework feedback

- I learned how to use functions in assembly and improved memory represantion
  understanding
- It was rather difficult
- Statement contains all the necessary information
- Useful functions to check for bugs
- Pretty checker
