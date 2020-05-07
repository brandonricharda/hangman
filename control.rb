require './hangman.rb'

require 'yaml'

def initiate
    if Dir.exist?("saved_games") && Dir["saved_games/**/*"].length != 0
        puts "Would you like to load one of your saved games? Respond with Y or N."
        response = gets.chomp.upcase
        if response == "N"
            hangman = Game.new
        elsif response == "Y"
            raw_file_names = Dir["saved_games/**/*.yml"]
            cleansed_names = []
            raw_file_names.each { |item| cleansed_names << item.split("/")[1] }
            puts "Which game would you like to load? (Don't type the extension)."
            puts cleansed_names
            selected_game = gets.chomp + ".yml"
            until File.exist?("saved_games/#{selected_game}")
                puts "You don't have any file with that name. Please double-check your input."
                selected_game = gets.chomp + ".yml"
            end
            startSavedGame(selected_game)
        end
    else
        hangman = Game.new
    end
end

def startSavedGame(game)
    load_data = YAML.load(File.read("saved_games/#{game}"))
    load_data.startGame
end

initiate