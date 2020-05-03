class Game
    
    def initialize
        @status = false
        @turns = 10
        @word = selectWord
        puts @word
        @array = []
        (@word.length).times {@array << "_"}
        startGame
    end

    def startGame
        until @status || @turns == 0
            guess(@word)
            @turns -= 1
        end

        message = @status ? "You won!" : "You're out of turns! The word was #{@word}."
        puts message

    end

    def selectWord
        chosen_word = []
        until chosen_word.length >=5 && chosen_word.length <= 12
            chosen_word = File.readlines("5desk.txt").sample.chomp.split("").map(&:upcase)
        end
        chosen_word
    end

    def guess(phrase)

        puts "Guess a letter! Current progress: #{@array.join("")} \nRemaining Turns: #{@turns}"
        guess = gets.chomp.upcase
        
        until guess.length == 1 && guess =~ /^[a-zA-z]+$/
            puts "Please enter a single letter (case insensitive)."
            guess = gets.chomp.upcase
        end
        
        updateArray(guess)

    end

    def updateArray(letter)
        @word.each_with_index do |item, index|
            if item == letter
                @array[index] = letter
            end
        end
        @status = @array == @word
    end

end

hangman = Game.new