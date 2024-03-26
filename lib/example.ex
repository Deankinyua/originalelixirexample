defmodule Unless do
  def fun_unless(clause, do: expression) do
    if(!clause, do: expression)
  end
  defmacro macro_unless(clause, do: expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end

defmodule Membership do
  defstruct [:type, :price]
end

defmodule User do
  defstruct [:name, :membership]
end

defmodule Post do
  defstruct [
    id: nil,
    title: "",
    description: "",
    author: ""
  ]
end

defmodule Example do
  require Unless
  require Integer
  use Application
  # @x 10

  def start(_type, _args) do
    # Example.main()
    # Example.tupleExample()
    # mapExample()
    # structExample()
    # guess()
    # listExample()
    # helper_avg()
    # enumExample()
    # mapsDepth()
    # reverseRecursion(123)
    # reverseList([1, 2, 3])
    # reverseList2([1, 2, 3])
    # keywordListExample()
    # mapFunctions()
    Unless.fun_unless(true, do: IO.puts "this should never be printed")
    Unless.macro_unless(true, do: IO.puts "this should never be printed")
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def main do
    list = [1, 2, 3]
    case Enum.at(list, 2) do
      1 -> IO.puts("this wont last")
      3 -> IO.puts("3 is a match")
      _ -> IO.puts("catch all")
    end
    name = "Caleb"
    status = Enum.random([:bronze, :gold, :"not member"])

    # * Cond in elixir
    post1 = %Post{id: 1, title: "Title1", description: "novel by ibsen", author: "henrick ibsen"}

    cond do
      # post1.author == "octallium jack" -> IO.puts("Editing by octallium")
      post1.author == "henrick ibsen" -> IO.puts("Editing by ibsen")
    end
    # * Case Statements in Elixir
    case status do
      :gold -> IO.puts("Welcome to the fancy Lounge #{name}")
      :"not member" -> IO.puts("Sign for the membership \"Bro\"")
      _ -> IO.puts("Get Lost Bruh")
    end
    IO.puts(Integer.gcd(10, 20))

    IO.puts("This \nis \na \nmessage")
    IO.puts("variable")

    IO.puts(returnExample())

 end

#  def compoundTypes do
#   time = Time.new!(0, 0, 0, 0)
#   date = Date.new!(2025, 1, 1)
#   currentDate = DateTime.new!(date, time, "Etc/UTC")
#   time_till = DateTime.diff(currentDate, DateTime.utc_now())

#   days = div(time_till, 86400)
#   hours = div(rem(time_till, 86400), 3600)
#   mins = div(rem(time_till, 3600), 60)
#   seconds = rem(time_till, 60)
#   IO.puts("#{days} days, #{hours} hours, #{mins} minutes, #{seconds} seconds left ")

#  end

 def tupleExample do
   memberships = {:gold, :silver}
   memberships = Tuple.append(memberships, :bronze)

   prices = {5, 10, 15}
   avg = Tuple.sum(prices) / tuple_size(prices)

   users = [
    {"caleb", :gold},
    {"dean", :silver},
    {"gabriel", :bronze}
   ]

   Enum.each(users, fn {name, membership} ->
    IO.puts("#{name} has a Membership of #{membership}.")
   end)

   IO.puts("The total average for #{elem(memberships, 0)}, #{elem(memberships, 1)} and #{elem(memberships, 2)} memberships is #{avg}")

  end

  def mapExample do
    gymMembers = %{
      gold: :gold,
      silver: :silver,
      bronze: :bronze
    }

    IO.puts(gymMembers.gold)
  end

  def structExample do
    goldMembership = %Membership{type: :gold, price: 25}
    silverMembership = %Membership{type: :silver, price: 15}
    bronzeMembership = %Membership{type: :bronze, price: 10}
    noneMembership = %Membership{type: :none, price: 0}

    users = [
      %User{name: "Caleb", membership: goldMembership},
      %User{name: "Dean", membership: silverMembership},
      %User{name: "Gabriel", membership: bronzeMembership},
      %User{name: "Mustafa", membership: noneMembership},
    ]

    Enum.each(users, fn%User{name: name, membership: membership} ->
    IO.puts("#{name} has a #{membership.type} membership paying #{membership.price} dollars.")
    end)
  end

  # * Guessing Game
  def guess do
    correct = :rand.uniform(3) - 1
    guess = IO.gets("Guess a number between 0 and 9 ") |> String.trim() |> Integer.parse()

    IO.inspect(guess)

    case guess do
      {result, _} ->
        IO.puts("Parse Successful #{result}")

        if result === correct do
          IO.puts("Your answer was correct")
        else
          IO.puts("The correct answer is #{correct}")
        end

      :error ->
        IO.puts('Something went wrong')

    end

  end

  # * LISTS
  def listExample do
    grades = [1, true, 20, false, 3, true]
    [head | tail] = grades

    # * Lists in Elixir are Linked Lists
    IO.inspect(head)
    IO.inspect(tail)

    #* Looping over the list
    grades1 = [1, 2,  3, 20]
    newGrades = for n <- grades1, do: n + 5
    IO.inspect(newGrades)

    #* Concatenating Lists
    _secondGrades = grades ++ [true, true, 1, 20, false]

    #* List Comprehensions
    even = for n <- grades1, Integer.is_even(n), do: n
    IO.inspect(even)


    end

    def helper_avg do
      theNumbers = ["4", "6", "9", "2", "13"]
      # * Here the internal function "String.to_integer/1"
      result = Enum.map(theNumbers, &String.to_integer/1)

      tupleSumAndAvg = calc_sum_and_avg(result)
      IO.inspect(tupleSumAndAvg)
    end

      def calc_sum_and_avg(numbers) do
        sum = Enum.sum(numbers)
        avg = sum / Enum.count(numbers)

        {sum, avg}
      end

      def enumExample do
        numbers = Enum.map([1, 2, 3], fn x -> x * 2 end)
        numbers2 = Enum.map(1..3, fn x -> x * 2 end)
        numbers3 = Enum.sum(1..3)
        map = %{"a" => 1, "b" => 2}
        mapResult = Enum.map(map, fn {k, v} -> {k, v * 2} end)

        IO.inspect(numbers)
        IO.inspect(numbers2)
        IO.inspect(numbers3)
        IO.inspect(mapResult)
      end

      def mapsDepth do
        # map = %{:a => 1, 2 => :b}
        # IO.puts(map[2])

        users = [
          john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
          mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
        ]

        users2 = put_in users[:john].age, 31
        IO.inspect(users2[:john].age)
        IO.inspect(users[:john].age)
      end

      def returnExample do
        3
      end

      def reverseRecursion(num, acc \\ 0)
      def reverseRecursion(0, acc), do: acc

      def reverseRecursion(num, acc) do

          new_num = div(num, 10)
          new_acc = acc * 10 + rem(num, 10)
          IO.puts(reverseRecursion(new_num, new_acc))

      end

      def reverseList(params, list \\ [])
      def reverseList([], list), do: list
      def reverseList(params, list) do

        [h | t] = params
        new_list = List.insert_at(list, 0, h)
        IO.inspect(new_list)
        reverseList(t, new_list)

      end

      def reverseList2(params, acc \\ [])
      def reverseList2([], acc), do: acc
      def reverseList2([h | t], acc) do

        IO.inspect(reverseList2(t, [h | acc]))

      end

      def keywordListExample do
        data1 = [a: 1, b: 2]
        data2 = [{:a, 1}, {:b, 2}]

        IO.puts(data1[:a])

        IO.inspect(data1 === data2)
      end

      def mapFunctions do
        # map = %{:a => 1, 2 => :b}
        # IO.puts(Map.get(map, :a))
        # map2 = Map.put(map, :c, 3)
        # IO.inspect(map2)
        # IO.inspect(Map.to_list(%{:a => 1, 2 => :b}))

        user = Map.put(%{}, :name, "dean")
        user = Map.put(user, :name, "brian")
        IO.inspect(user.name)

      end


end
