class Board
    attr_reader :x_loc, :y_loc, :origin
    attr_accessor :destination

    def initialize(x_axis, y_axis, start = nil)
        @x_loc = x_axis
        @y_loc = y_axis
        @origin = start
        @destination = []
    end
end

class Knight
    # moves that can be made within X and Y axis
    def initialize
        @x_axis = [-2, -2, -1, -1,  1, 1,  2, 2]
        @y_axis = [-1,  1, -2,  2, -2, 2, -1, 1]
    end

    def movements(board_coord)
        moves = []
        
        # all moves possible from current position
        8.times do |a|
            moves << [board_coord.x_loc + @x_axis[a], board_coord.y_loc + @y_axis[a]]
        end

        # select moves within 1..8
        ok = moves.select do |loc|
            (loc[0] >= 1 && loc[0] <= 8) && (loc[1] >= 1 && loc[1] <= 8)
        end

        # record destinations
        ok.each do |loc|
            
            # access the destination array in board_coord {aka start}
            # insert a new board classes into this array with
            # new coordinates and board_coord details as their origin
            board_coord.destination << Board.new(loc[0], loc[1], board_coord)
        end
    end
    
    def search(origin, ending)

        # create board then input knight origin
        start = Board.new(origin[0], origin[1])

        # queue for..
        queue = [start]

        # find moves
        movements(start)

        # append all of start's destination values to queue
        start.destination.each do |actions|
            queue << actions
        end

        loop do

            # pass queue[0] to current
            # and remove from queue
            current = queue.shift

            # show the step if it matches with destination
            if ending[0] == current.x_loc && ending[1] == current.y_loc
                return showmoves(current)

            # otherwise map out additional movements
            # from the updated coordinates of current
            # and append all newly found moves to queue
            else
                movements(current)
                current.destination.each do |moves|
                    queue << moves
                end
            end
        end
    end

    def showmoves(coordinates)

        # take the origin of passed coordinate
        current_origin = coordinates.origin

        # stores the correct x y as the right path to destination
        route = [coordinates.x_loc, coordinates.y_loc]

        # until traceback returns to the first
        # board class created {aka start}
        until current_origin.nil?
            route.unshift([current_origin.x_loc, current_origin.y_loc])
            current_origin = current_origin.origin
        end

        puts "You made it in #{route.length-1} moves. Here's your path: "
        route
    end
end

stallion = Knight.new
p stallion.search([1,2],[7,7])