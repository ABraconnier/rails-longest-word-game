require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def word_match?(input, grid)
    input.all? do |letter|
      input.count(letter) >= grid.count(letter)
    end
  end

  def correct?(input, grid)
    if word_match?(input, grid)
      "Sorry but #{@word.upcase} can't be build out of #{@current_letters}"
    elsif @word_found['found'] == false
      "Sorry but #{@word.upcase} doesn't exist"
    else
      "Great job"
    end
  end

  def score
    @word = params[:word]
    word_array = @word.upcase.split('')
    @current_letters = params[:letters]
    current_letters_array = @current_letters.split(' ')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @word_found = JSON.parse(open(url).read)
    @score = correct?(word_array, current_letters_array)
  end
end
