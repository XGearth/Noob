class Hangman
    @@wordbank = []
    @@word = ""
    @@letters = []
    @@guess = []
    @@wrong = []
    @@mistakes = 0

    def loadword(input)
        if input == 1
            File.open("5desk.txt").each do |word|
                @@wordbank.push(word)
            end

            @@word = @@wordbank.sample
        else
            print "GIVE ME WORDS! LOTS!: "
            @nwords = gets.chomp
            @nwordbank = @nwords.split(" ")

            @@word = @nwordbank.sample
        end

        @@letters = @@word.split("")

        @@letters.each_index do |index|
            @@guess[index] = "_"
        end    
    end

    def show
        puts @@guess
        puts "Wrong: #{@@wrong}\n"
    end

    def mechanic(input)
        if (@@letters.include? input)
            @@letters.each_with_index { |value, index|
                if input == value
                    @@guess[index] = input
                end
            }
        else
            @@wrong.push(input)
            @@mistakes += 1
        end
      
        @guess = @@guess.join(" ")
        
        puts "Word: #{@guess}"
        puts "Wrong: #{@@wrong}\n"
    end

    def death
        if @@mistakes == 6
            puts "GAME OVER\n Answer: #{@@word}"
            return false
        end
    end
end

#------------------

game = Hangman.new
ongoing = true
newload = 0
guess = ""

while newload < 1 || newload > 2
    print "Load a Wordbank or Input Your Own? [1/2]: "
    newload = gets.chomp.to_i
end

game.loadword(newload)

while ongoing == true

    game.show
    print "Take a Guess: "
    guess = gets.chomp

    game.mechanic(guess)

    ongoing = game.death
end