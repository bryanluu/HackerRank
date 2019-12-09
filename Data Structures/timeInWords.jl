#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

function numAsWord(num::Int)::String
    if num == 0
        return ""
    elseif num == 1
        return "one"
    elseif num == 2
        return "two"
    elseif num == 3
        return "three"
    elseif num == 4
        return "four"
    elseif num == 5
        return "five"
    elseif num == 6
        return "six"
    elseif num == 7
        return "seven"
    elseif num == 8
        return "eight"
    elseif num == 9
        return "nine"
    elseif 10 <= num <= 19
        if num == 11
            return "eleven"
        elseif num == 12
            return "twelve"
        elseif num == 13
            return "thirteen"
        elseif num == 14
            return "fourteen"
        elseif num == 15
            return "half"
        elseif num == 16
            return "sixteen"
        elseif num == 17
            return "seventeen"
        elseif num == 18
            return "eighteen"
        elseif num == 19
            return "nineteen"
        end
    elseif 20 <= num <= 29
        ans = "twenty"
        suffix = numAsWord(num%10)
        if isempty(suffix)
            return ans
        else
            return ans * " " * suffix
        end
    elseif num == 30
        return "half"
    end
end

function timeInWords(hr::Int, mins::Int)::String
    if mins == 0
        return numAsWord(hr) * " o' clock"
    elseif mins == 15
        return "quarter past " * numAsWord(hr)
    elseif mins == 30
        return "half past " * numAsWord(hr)
    elseif mins == 45
        return "quarter to " * numAsWord(hr+1)
    elseif 1 <= mins <= 30
        return numAsWord(mins) * " minute" *
        (mins == 1 ? "" : "s") * " past " * numAsWord(hr)
    elseif 30 < mins
        newmin = 60-mins
        return numAsWord(newmin) * " minute" *
        (newmin == 1 ? "" : "s") * " to " * numAsWord(hr+1)
    end
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    hr = parse(Int, readline(stdin))
    mins = parse(Int, readline(stdin))

    println(timeInWords(hr, mins))
end
