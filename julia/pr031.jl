# Problem 31
#
# 22 November 2002
#
#
# In England the currency is made up of pound, £, and pence, p, and there
# are eight coins in general circulation:
#
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# It is possible to make £2 in the following way:
#
#     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
# How many different ways can £2 be made using any number of coins?
#
# 73682

# This works faster when the larger coins are at the front.
const coins = Int64[200, 100, 50, 20, 10, 5, 2, 1]

function rways(remaining, coins)
   if isempty(coins)
      remaining == 0 ? 1 : 0
   else
      coin = coins[1]
      others = coins[2:end]

      total = 0
      for r = remaining:-coin:0
         total += rways(r, others)
      end
      total
   end
end

function solve()
   rways(200, coins)
end

println(solve())
