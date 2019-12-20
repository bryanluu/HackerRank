#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function strongPassword(s::String)
    numbers = "0123456789"
    lower_case = "abcdefghijklmnopqrstuvwxyz"
    upper_case = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    special_characters = "!@#\$%^&*()-+"

    n = length(s)

    nums = 0
    lc = 0
    uc = 0
    sc = 0

    for c = s
        if occursin(c, numbers)
            nums += 1
        elseif occursin(c, lower_case)
            lc += 1
        elseif occursin(c, upper_case)
            uc += 1
        elseif occursin(c, special_characters)
            sc += 1
        end
    end

    ans = 0

    if nums == 0
        ans += 1
    end

    if lc == 0
        ans += 1
    end

    if uc == 0
        ans += 1
    end

    if sc == 0
        ans += 1
    end

    if n < 6
        return max(6 - n, ans)
    else
        return ans
    end
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    n = parse(Int, readline(stdin))
    s = readline(stdin)

    ans = strongPassword(s)

    println(ans)
end
