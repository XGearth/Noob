#1) Split Array into 2 and Identify No. of Values
#2) Find the Biggest Number in the Array
#3) Find the Smallest Number and Pass it
#4) Push Smallest Number to New Array and Delete from Current Array
#5) Merge Array Back Together and Do 1 Last Sort

def findbig(array) #2
    @big = array[0]
    array.each do |value|
        value > @big ? @big = value : @big = @big
    end
    return @big
end

def sort_rec(array)
    @index = 0
    @value = 0
    @arr_new = []
    
    while array.length != 0
        @value = findbig(array)
        array.each_with_index do |value, index| #3 -->
            if @value >= value
                @value = value
                @index = index
            end
        end #3 <--
        @arr_new.push(@value) #4 -->
        array.delete_at(@index) #4 <--
    end

    return @arr_new
end

def identify(input) #1 -->
    @lhalf = input.length/2.floor
    input.length%2 != 0 ? @rhalf = @lhalf+1 : @rhalf = @lhalf

    @left = []
    @right = []

    while @left.length != @lhalf
        @left.push(input[@left.length])
    end

    while @right.length != @rhalf
        @right.push(input[@lhalf])
        @lhalf += 1
    end #1 <--

    @left = sort_rec(@left)
    @right = sort_rec(@right)
    @left.concat(@right) #5 -->
    @left = sort_rec(@left) #5 <--
end

numbers = [3,2,5,4,7,9,10,8,-1]
identify(numbers)