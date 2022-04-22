[{:addi, 1, 0, 5}, {:lw, 2, 0, :arg}, {:add, 4, 2, 1}, {:addi, 5, 0, 1}, {:label, :loop}, {:sub, 4, 4, 5}, {:out, 4}, {:bne, 4, 0, :loop}, :halt]

{:prgm, [{:addi, 1, 0, 5}, {:out, 1}, :halt], []}
{:prgm, [{:addi, 1, 0, 5}, {:out, 1}, {:addi, 2, 0, 1}, {:out, 2}, {:addi, 3, 2, 1}, {:out, 3}, {:sub, 4, 3, 2}, {:out, 4}, :halt], []}
{:prgm, code(), data()}

[:prgm, [{:addi, 1, 0, 5}, {:lw, 2, 0, :arg}, {:add, 4, 2, 1}, {:addi, 5, 0, 1}, {:label, :loop}, {:sub, 4, 4, 5}, {:out, 4}, {:bne, 4, 0, :loop}, :halt], {{:label, :arg}, {:word, 12}}]
