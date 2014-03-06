--  Problem 1
--
--  If we list all the natural numbers below 10 that are multiples of 3 or 5,
--  we get 3, 5, 6 and 9. The sum of these multiples is 23.
--
--  Find the sum of all the multiples of 3 or 5 below 1000.
--
--  233168

function solve ()
    local total = 0
    for i = 1, 999 do
        if i % 5 == 0 or i % 3 == 0 then
            total = total + i
        end
    end
    return total
end

print(solve())
