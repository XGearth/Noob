class Node
    attr_accessor :value, :left, :right
    def initialize(value=nil, left=nil, right=nil)
        @value = value
        @left = left
        @right = right
    end    
end

class Tree
    attr_accessor :list
    def initialize(root=nil)
        @root = root
    end

    def build_tree(array)
        return if array.empty?;
        @root = Node.new(array[array.length/2])
        current = @root
        
        array.each do | value |
            newNode = Node.new(value)
            current = @root

            #right nodes
            if value > current.value
                current = current.right while !current.right.nil?
                current.right = newNode if current.right.nil?
            
            #left nodes
            elsif value < current.value
                if @root.left.nil?
                    @root.left = newNode
                else
                    current = @root.left

                    while value > current.value && !current.right.nil?
                        current = current.right
                    end

                    current.right = newNode
                end
            else
                ""
            end
        end

        @root
    end    

    def search_val(value, option=0)
        current = @root
        parent = @root

        #If Value == Root Value
        return current if value == current.value

        #Looks for both Parent and Current Node of Value
        #If Value Exists, Returns Node of Value
        #Else, Return NIL Node Where Value Can Be Placed
        if value < @root.value || value > @root.value
            while !current.nil? && value != current.value
                parent = current
                value < current.value ? current = current.left : current = current.right
            end

            #Which to Pass, Parent or Current Node
            option == 1 ? parent : current
        end
    end

    def insert(value)
        newNode = Node.new(value)

        #Search for Parent Node
        parent = search_val(value, 1)

        #Identify which Node to place Child in.
        value < parent.value ? parent.left = newNode : parent.right = newNode
    end

    def delete(value)
        temp = search_val(value, 0)
        temp2 = search_val(value, 0)
        parent = search_val(value, 1)
        current = search_val(value, 0)

        return "Doesn't Exist" if current.nil?

        #If No Child
        if current.left.nil? && current.right.nil?
            current = nil
            value > parent.value ? parent.right = nil : parent.left = nil
        end

        #If No Left Child -> Find Leftmost of Right Child
        if !current.nil? && current.left.nil?
            temp = temp.right
            while !temp.left.nil?
                temp = temp.left
            end

            parent.right = temp
            current = nil
        end

        #If No Right Child -> Find Rightmost of Left Child
        if !current.nil? && current.right.nil?
            temp = temp.left
            while !temp.right.nil?
                temp = temp.right
            end

            parent.left = temp
            current = nil
        end

        #If Both Child Exists
        if !current.nil? && !current.right.nil? && !current.left.nil?
            #Search for LMR Child
            ptemp = current
            temp = temp.right
            while !temp.left.nil?
                ptemp = temp
                temp = temp.left
            end
            lmr = temp.value - current.value

            #Search for RML Child
            ptemp2 = current
            temp2 = temp2.left
            while !temp2.right.nil?
                ptemp2 = temp2
                temp2 = temp2.right
            end
            rml = current.value - temp2.value

            #Select Child to Inherit Position
            #If LMR is Closer to Current
            if lmr <= rml
                temp.left = current.left
                temp.right = current.right
                parent.right = temp
                ptemp.value == current.value ? ptemp.right = nil : ptemp.left = nil

            #If RML is Closer to Current
            elsif lmr > rml
                temp2.left = current.left
                temp2.right = current.right
                parent.right = temp2
                ptemp2.value == current.value ? ptemp2.left = nil : ptemp2.right = nil
            end

            ptemp.right, ptemp2.left, temp, temp2 = nil
        end

        @root
    end

    def find(value)
        #Search the Tree for the Value
        current = search_val(value)
        current.nil? ? "Number Does Not Exist" : current
    end

    def sort_val(value)
        #Sorts Values
        value = value.sort
        return dupli(value)
    end

    def dupli(value)
        #Removes Duplicates
        value = value.uniq
        return build_tree(value)
    end

    def level_order
        #If Tree has not been Grown
        return "No Tree" if @root.nil?

        #Node Checker "CURRENT" and Queue Array "QUEUE" to Place Visited Nodes
        current = @root
        queue = []

        #Pass Root Node as First Queue Value
        queue << current.value

        #For Each Value in Queue
        queue.each do |value|

            #Search for the Node of Value
            current = search_val(value)

            #If Value is in Queue and Value is not Nil
            if (queue.include? current.value) && (!current.value.nil?)
                
                #Check then Push to Queue if Left Child Exists
                if !current.left.nil?
                    queue << current.left.value if (queue.include? current.left.value) == false
                end

                #Check then Push to Queue if Right Child Exists
                if !current.right.nil?
                    queue << current.right.value if (queue.include? current.right.value) == false
                end
            end
        end

        queue
    end

    def preorder
        return "No Tree" if @root.nil?

        current = @root
        queue = []

        #Pass the Root Value
        queue << current.value

        #Looper
        queue.each do
            #Search for All Left Child from Root
            while (!current.left.nil?) && (!queue.include? current.left.value)
                queue << current.left.value
                current = current.left
            end
            
            #When No More Left Children, Search for Nearest Right Child
            queue.reverse.each do |child|
                current = search_val(child)
                if (!current.right.nil?) && (!queue.include? current.right.value)
                    queue << current.right.value
                    current = current.right
                    break
                end
            end
        end
    end

    def inorder
        return "No Tree" if @root.nil?

        current = @root
        queue = []

        #Push the Leftmost Child of Root
        current = current.left while !current.left.nil?
        queue << current.value if (!queue.include? current.value)

        #Looper
        queue.each do

            #Push the Leftmost Child of Root
            current = current.left while !current.left.nil?
            queue << current.value if (!queue.include? current.value)

            #Search for Right Child of Current if Any
            !current.right.nil? ? (current = current.right) : ""

            #Search for Parent and push if Parent is not in Queue
            parent = search_val(current.value, 1)
            queue << parent.value if (!queue.include? parent.value)

            while true #Looper
                #Break if Root Value
                if parent.value == @root.value
                    queue << parent.value if (!queue.include? parent.value)
                    current = parent.right
                    break
                #Loop until Parent with Right Child that is not in Queue
                elsif (parent.right.nil?) || (queue.include? parent.right.value)
                    parent = search_val(parent.value, 1)
                    queue << parent.value if (!queue.include? parent.value)
                #Break if Parent with Right Child that isn't in Queue is found
                else
                    current = parent.right
                    break
                end
            end
        end
    end

    def postorder
        return "No Tree" if @root.nil?

        current = @root
        queue = []

        #Find the Leftmost Child with no Children
        while !current.left.nil?
            current = current.left while !current.left.nil?
            current = current.right if !current.right.nil?
        end

        queue << current.value
        parent = search_val(current.value, 1)

        while !queue.include? parent.value do

            #Search for Parent with Right Child
            while parent.right.nil? || (queue.include? parent.right.value)
                
                #Push if Parent is not in Queue
                !queue.include? parent.value ? (queue << parent.value) : ""
                
                #Find Parent of Parent
                parent = search_val(parent.value, 1)

                #Break when Root Value is finally in Queue
                break if queue.include? @root.value
            end

            #Go to that Child
            current = parent.right

            #Find Leftmost Child with no Children
            while !current.left.nil? || !current.right.nil?
                current = current.left while !current.left.nil?
                current = current.right if !current.right.nil?
            end

            #Queue Current if not yet
            !queue.include? current.value ? (queue << current.value if (!queue.include? current.value)) : ""

            #Update Parent Node of Current
            parent = search_val(current.value, 1)
        end
    end

    def balanced?
        current = @root
        queue = []
        maxl = maxr = count = 0
        condition = true

        #Search Left Subtree
        while condition == true

            #Increase Count for each passed Node
            while !current.left.nil?
                current = current.left
                queue << current.value if (!queue.include? current.value)
                count += 1

                #Pass lowest depth reached by Count
                maxl = count if maxl < count
            end

            #Reduce Count for each backtracked Node
            while current.right.nil? || (queue.include? current.right.value)
                current = search_val(current.value, 1)
                count -= 1
            end

            #Move to Right Child as long as not at Root
            if current.value != @root.value
                current = current.right
                queue << current.value
                count += 1

                #Pass lowest depth reached by Count
                maxl = count if maxl < count
            else

                #Change condition to stop loop
                condition = false
            end
        end

        #Reset Conditions
        while queue.length != 0 do
            queue.pop
        end

        condition = true
        count = 0

        #Search Right Subtree
        while condition == true

            #Increase Count for each passed Node
            while !current.right.nil?
                current = current.right
                queue << current.value if (!queue.include? current.value)
                count += 1

                #Pass lowest depth reached by LCount
                maxr = count if maxr < count
            end

            #Reduce Count for each backtracked Node
            while current.left.nil? || (queue.include? current.left.value)
                current = search_val(current.value, 1)
                count -= 1
            end

            #Move to Left Child as long as not at Root
            if current.value != @root.value
                current = current.left
                queue << current.value
                count += 1

                #Pass lowest depth reached by Count
                maxr = count if maxr < count
            else

                #Change condition to stop loop
                condition = false
            end
        end

        #Return Result
        ((maxl - maxr).abs < 1) ? true : false
    end

    def rebalance!
        assist = balanced?
        array = level_order

        assist == true ? "Tree is Balanced" : build_tree(array)
    end

    def depth(value)

        #Coming Soon
        
    end
end

a = Tree.new
a.sort_val([1,6,10,15,20,25,30,35,40])
a.insert(0)
a.insert(-1)
a.insert(3)
a.insert(5)
a.insert(4)
a.insert(2)
a.insert(8)
a.insert(7)
a.insert(9)
a.insert(28)
a.insert(29)
a.insert(39)

a.balanced?
p a.rebalance!