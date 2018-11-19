require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    @letters = get_random_letters(9)
    @grid = @letters.join('')
  end

  def score
    word = params[:word]
    grid = params[:grid]
    if in_the_grid?(word, grid) == false
      answer = "Sorry but #{word} is not part of #{grid.split.join(',')}"
    elsif check_word(word) == false
      answer = "Sorry but #{word} is not an English word"
    else
      answer = "Congratulations"
    end
    @result = answer
  end

  def get_random_letters(length = 5)
    source = ('A'..'Z').to_a
    letters = []
    length.times { letters << source[rand(source.size)].to_s }
    return letters
  end

  def in_the_grid?(word, grid)
    word_array = word.upcase.split('')
    check = true
    word_array.each do |letter|
      if grid.include?(letter) == false
        check = false
      end
    end
    return check
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    result = JSON.parse(user_serialized)
    return result['found']
  end

end



