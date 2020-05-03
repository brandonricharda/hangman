def startGame

end

def selectWord
    chosen_word = ""
    until chosen_word.length == 7 || chosen_word.length == 14
        chosen_word = File.readlines("5desk.txt").sample
    end
    puts chosen_word
end

10.times {selectWord}