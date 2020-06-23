class Node
    attr_accessor :value, :next_node
    def initialize(value=nil, next_node=nil)
        @value = value
        @next_node = next_node
    end
end

class LinkedList
    attr_accessor :list

    def initialize
        @list = []
    end

    def appends(value)
        newNode = Node.new(value)

        @list[@list.length-1].nil? ? "" : @list[@list.length-1].next_node = newNode

        @list.push(newNode)

        return @list
    end

    def prepends(value)
        newNode = Node.new(value)
        @list.unshift(newNode)
        newNode.next_node = @list[1]

        return @list
    end

    def size
        index = 0

        while index != @list.length
            index += 1
        end

        "There are #{index} in total."
    end

    def head
        "The Head Node is #{@list[0]}."
    end

    def tail
        index = 0

        while index != @list.length
            index += 1
        end

        "The Tail Node is #{@list[index-1]}."
    end

    def at(index)
        "The Node at Index: #{index} is #{@list[index-1]}"
    end

    def pop
       @list.pop
    end

    def contains?(value)
        @list.each do |val|
            if val.value == value
                return true
            end
        end

        false
    end

    def find(value)
        index = 0
        @list.each do |val|
            if val.value == value
                return "Value: #{val.value} is on Index: #{index}"
            end
            index += 1
        end

        return "Not Found"
    end

    def to_s
        index = 0
        form = ""

        while index <= list.length
            if index < list.length
                form += "#{list[index].value} -> "
            else
                form += "nil"
            end
            index += 1
        end

        form
    end

    def insert_at(value, index)
        if index > list.length
            p "Invalid Index"
        else
            newNode = Node.new(value)
            
            list.insert(index, newNode)
        end
    end

    def remove_at(index)
        list.delete_at(index)
    end
end

a = LinkedList.new

a.appends("Albie")
a.prepends("Camille")
a.appends("Risato")
a.insert_at("Dengen", 2)

p a.to_s
a.remove_at(1)
p a.to_s
