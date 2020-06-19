def fibs(length)
    @fib_arr = [0,1]
    
    #PUSH TO NEXT INDEX THE SUM OF THE PREVIOUS 2 INDEXES
    #BREAK CYCLE IF ARRAY LENGTH IS EQUAL GIVEN NUMBER BY USER
    if length < 2
        return @fib_arr[length]
    else
        @fib_arr.each_index do |index|
            @fib_arr.push(@fib_arr[index] + @fib_arr[index+1])
            break if @fib_arr.length == length+1
        end
        return @fib_arr[length]
    end
end

def fibs_rec(input)
    input < 2 ? input : fibs_rec(input - 1) + fibs_rec(input - 2)
end

puts fibs(2)
puts fibs_rec(10)