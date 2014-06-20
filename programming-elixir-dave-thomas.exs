## Lists and Recursion
# 
# defmodule MyList do
#     defp _mapsum([], _f, n), do: n
#     defp _mapsum([head|tail], f, n), do: _mapsum(tail, f, f.(head) + n)
#     def mapsum(l, f), do: _mapsum(l, f, 0)
# 
#     defp _max([], currentMax), do: currentMax
#     defp _max([head | tail], currentMax) when head > currentMax, do: _max(tail, head)  
#     defp _max([_head | tail], currentMax), do: _max(tail, currentMax)
#     def max([head|tail]), do: _max(tail, head)
# 
#     def caesar([], _offset), do: []
#     def caesar([head|tail], offset), do: [head+offset|caesar(tail, offset)]
# end
# 
# IO.puts "maxsum result is #{MyList.mapsum([1,2,3], &(&1*&1))}"
# 
# IO.puts "Max value in list is #{MyList.max([3,65,3,5,7])}"
# 
# IO.puts "caesar-ed 'Mike Hurd' is #{MyList.caesar('Mike Hurd', 1)}"

## Reduce
# 
# defmodule MyList do
#     def reduceLeft([], _f, n), do: n
#     def reduceLeft([head | tail], f, n), do: reduceLeft(tail, f, f.(head, n))
# end
# 
# IO.puts "Reduced value in list is #{MyList.reduceLeft([2,4,6], &(&1 + &2), 0)}"

## Head & Tail
#
# defmodule MyList do
#     def map([], _f), do: []
#     def map([head | tail], f), do: [f.(head) | map(tail, f)]
# end
# 
# IO.inspect MyList.map([1,2,3], &(&1*2))

## Matching Functions 
#
# defmodule Factorial do
#     def of(0), do: 1
#     def of(n) when n > 0, do: n * of(n-1)
# end
# 
# n = 10
# IO.puts "#{n}! is #{Factorial.of(n)}"
# 
# defmodule Sum do
#     def inner(0, t), do: t
#     def inner(n, t), do: inner(n-1, t+n)
#     def of(n), do: inner(n, 0)
# end
# 
# n = 5
# IO.puts "Sum of the numbers 1..#{n} is #{Sum.of(n)}"
# 
# defmodule GCD do
#     def of(x, 0), do: x 
#     def of(x, y), do: of(y, rem(x, y))
# end
# 
# x = 176
# y = 456
# IO.puts "Greatest Common Divisor of #{x} & #{y} is #{GCD.of(x, y)}"

## Modules 
#
# defmodule Times do 
#     def double(n), do: n * 2
#     def triple(n), do: n * 3
#     def quadruple(n), do: double(n)+double(n)
# end
# 
# IO.inspect Times.double(5)
# IO.inspect Times.triple(5)
# IO.inspect Times.quadruple(5)

## Annonymous function syntax sugar 
#
# IO.inspect Enum.map [1,2,3,4], &{&1+2}
# Enum.each [1,2,3,4], &IO.inspect/1
# 
# divrem = &{div(&1, &2), rem(&1, &2)}
# IO.inspect divrem.(13, 5)

## Returning Functions 
#
# prefix = fn p -> fn n -> "#{p} #{n}" end end
# mrs = prefix.("Mrs")
# IO.puts mrs.("Smith")
# IO.puts prefix.("ELixir").("rocks")

## Pattern Matching 
#
# fizzbuzz = fn
#     (0, 0, _) -> "FizzBuzz"
#     (0, _, _) -> "Fizz"
#     (_, 0, _) -> "Buzz"
#     (_, _, c) -> c
# end
# 
# fizzbuzz2 = fn (n) -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end
# 
# IO.puts fizzbuzz2.(10)
# IO.puts fizzbuzz2.(11)
# IO.puts fizzbuzz2.(12)
# IO.puts fizzbuzz2.(13)
# IO.puts fizzbuzz2.(14)
# IO.puts fizzbuzz2.(15)
# IO.puts fizzbuzz2.(16)

## Demo 
#
# handle_open = fn
#  {:ok, file} -> "First line: #{IO.read(file, :line)}"
#  {_, error} -> "Error: #{:file.format_error(error)}"
# end
# IO.puts handle_open.(File.open("C:\\Users\\mhurd\\development\\elixir\\scratch.exs")) # call with a file that exists
# IO.puts handle_open.(File.open("nonexistent")) # and then with one that doesn't