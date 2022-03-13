defmodule Huffman do
  def sample do
  'the quick brown fox jumps over the lazy dog
  this is a sample text that we will use when we build
  up a table we will only handle lower case letters and
  no punctuation symbols the frequency will of course not
  represent english but it is probably not that far off'
  end
  def text() do
  'this is something that we should encode'
  end

  def test do
  sample = sample()
  tree = tree(sample)
  IO.inspect(tree)
  encode = encode_table(tree)
  IO.inspect(encode)
  decode = decode_table(tree)
  text = text()
  seq = encode(text, encode)
  IO.inspect(seq)
  decode(seq, decode)
  end

  def tree(sample) do
    freq = freq(sample)
    IO.inspect(Enum.sort(freq, fn ({char, x}, {char2, y}) -> x < y end))
    huffman(freq)

  end

  def freq(sample) do
    freq(sample, [])
  end
  def freq([], freq) do
    freq
  end
  def freq([char | rest], freq) do
    freq(rest, insert(char,freq))
  end

  def insert(char, []) do
    [{char, 1}]
  end
  def insert(char, [{char, x}|tail]) do
    [{char, x+1}|tail]
  end
  def insert(char, [h|t]) do
    [h|insert(char,t)]
  end

  def huffman(freq) do
    ordered = Enum.sort(freq, fn ({char, x}, {char2, y}) -> x < y end)
    huffman_tree(ordered)
  end

  def huffman_tree([{last, _}]) do last end
  def huffman_tree([{c1, f1},{c2, f2}|t]) do
    huffman_tree(huffman_insert({{c1, c2},f1 + f2}, t))
  end

  def huffman_insert({c,f},[]) do [{c,f}] end
  def huffman_insert({c1, f1}, [{c2, f2}|t]) do
    case f1 < f2 do
      true ->
        [{c1, f1}, {c2, f2}|t]
      false ->
        [{c2, f2}| huffman_insert({c1, f1},t)]
    end
  end

  def encode_table(tree) do
    Enum.sort( find_path(tree, [], []), fn({_,path1},{_,path2}) -> length(path1) < length(path2) end)
  end

  def find_path({c1, c2}, path, acc) do
    left = find_path(c1, [0 | path], acc)
    find_path(c2, [1 | path], left)
  end
  def find_path(c, code, acc) do
    [{c, Enum.reverse(code)} | acc]
  end

  def decode_table(tree) do
    find_path(tree, [], [])
  end

  def encode([], table) do [] end
  def encode([h|t], table) do
    append(get_key(h,table),encode(t, table))
  end

  def append(list, []) do list end
  def append([], list) do list end
  def append([h|t], ys) do
    [h|append(t, ys)]
  end

  def get_key(h, [{h, code}|t]) do
    code
  end
  def get_key(h, [_|t]) do
    get_key(h, t)
  end

  def decode([], _) do
    []
  end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {c, _} ->
        {c, rest}
      nil ->
        decode_char(seq, n+1, table)
    end
  end

  def testread do
    list = read('text.txt', 5000)
    {length(list), list}
  end

  def read(file,n) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, n)
    File.close(file)
    case :unicode.characters_to_list(binary, :utf8) do
    {:incomplete, list, _} ->
      list
    list ->
      list
    end
  end

  def bench(n) do
    sample = read('text.txt', 1000)
    text = read('text.txt', n)
    {tree, t1} = time(fn -> tree(sample) end)
    {encode, t2} = time(fn -> encode_table(tree) end)
    {decode, t3} = time(fn -> decode_table(tree) end)
    {seq, t4} = time(fn -> encode(text, encode) end)
    {texten, t5} = time(fn -> decode(seq, decode) end)

    IO.puts("text of #{length(text)} characters")
    IO.puts("tree built in #{t1} ms")
    IO.puts("encoded in #{t4} ms")
    IO.puts("decoded in #{t5} ms")
    texten
  end

  def time(func) do
    start = Time.utc_now()
    result = func.()
    finish = Time.utc_now()
    {result, Time.diff(finish, start, :microsecond)/1000}
  end
end
