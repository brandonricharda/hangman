require 'yaml'

class Game

    #Maybe we can look at setting parameters for Initialize that default to the starting values if nothing is input and the actual save game values if something is input.
    #Or perhaps the serialization process will take care of that altogether... find out tomorrow!
    
    def initialize
        @status = false
        @turns = 15
        @word = selectWord
        @array = []
        @current_file = ""
        (@word.length).times {@array << "_"}
        if !Dir.exist?("saved_games")
            Dir.mkdir("saved_games")
        end
        startGame
    end

    def startGame

        until @status || @turns == 0
            guess(@word)
            if @turns % 5 == 0 && @current_file == ""
                ask_to_save
            else
                save(@current_file)
            end
            @turns -= 1
        end

        message = @status ? "You won!" : "You're out of turns! The word was #{@word.join("")}."
        puts message

    end

    def ask_to_save
        puts "Would you like to save this game? Type 'Y/N'."
        response = gets.chomp.upcase
        if response == "Y"
            puts "What would you like to name the file?"
            name = gets.chomp
            save(name)
        elsif response == "N"
            puts "Okay. I'll let you play some more then ask again."
        else
            puts "Please enter Y or N to indicate your choice (case insensitive)."
            ask_to_save
        end
    end

    def save(name)
        file = File.open("saved_games/#{name}", "w")
        data = YAML::dump(self)
        file.puts data
        file.close
        @current_file = name
        puts "File updated."
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
        puts @array.join("")
        @status = @array == @word
    end

end

hangman = Game.new