#Create the Node Class
class Node
    attr_accessor :value, :next_node
    def initialize(value=nil, next_node=nil)
        @value = value
        @next_node = next_node
    end
end

#Create the Linked List Class
class LinkedList
    attr_accessor :list
    
    #Initialize an Array that will store the Nodes
    def initialize
        @list = []
    end
    
    #Push in a new Node
    def appends(value)
        newNode = Node.new(value)

        @list[@list.length-1].nil? ? "" : @list[@list.length-1].next_node = newNode

        @list.push(newNode)

        return @list
    end
    
    #Add a Node at Index[0] and Link with Node at Index[1]
    def prepends(value)
        newNode = Node.new(value)
        @list.unshift(newNode)
        newNode.next_node = @list[1]

        return @list
    end

    #Find the Size of Array
    def size
        index = 0

        while index != @list.length
            index += 1
        end

        "There are #{index} in total."
    end
    
    #Find the Node at Index[0]
    def head
        "The Head Node is #{@list[0]}."
    end
    
    #Find the Last Node
    def tail
        index = 0

        while index != @list.length
            index += 1
        end

        "The Tail Node is #{@list[index-1]}."
    end
    
    #Find which Node is at Index[X]
    def at(index)
        "The Node at Index: #{index} is #{@list[index-1]}"
    end

    #Delete the Last Node
    def pop
       @list.pop
    end
    
    #Can [Value] be found in the List
    def contains?(value)
        @list.each do |val|
            if val.value == value
                return true
            end
        end

        false
    end
    
    #Find which Index in the Array [Value] is in
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
    
    #List all Values in the Array
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

    #Delete a Value from the Array
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
