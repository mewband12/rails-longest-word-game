require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    array = []
    10.times do |x|
      array << ('A'..'Z').to_a.sample
    end
    @letters = array
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:new]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    truthy2 = user["found"]
    @words = user["word"].split("")
    @random = params[:letters].split(" ")
    truthy1 = true
    @words.each do |word|
      if !@random.include?(word.upcase())
        truthy1 = false
      end
    end
    if truthy1 == false
      @result = "The word can’t be built out of the original grid"
    elsif truthy2 == false
      @result = "The word is valid according to the grid, but is not a valid English word"
    else
      @result = "The word is valid according to the grid and is an English word"
    end
    # raise
  end
end
