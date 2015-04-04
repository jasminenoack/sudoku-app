module GuessLogic
  def pick_empty
    places_options = {}
    available_places.map { |place| places_options[place] = check_place(*place) }

    @incorrect.each do |set|
      next if places_options[[set[0], set[1]]].nil?
      places_options[[set[0], set[1]]].delete(set[2])
      places_options.delete([set[0], set[1]]) if places_options[[set[0], set[1]]].empty?
    end

    places_options = places_options.sort_by { |key, value| value.length}

    place = places_options.first
    return [*place[0], place[1].first]
  end

  def take_a_guess(nums)
    @guessed = true
    test_case = nums
    @guess << test_case
    @after_guess << ["mg", @guess.length - 1]
    board[find_index(test_case)] = test_case[2]
  end

  def backtrack
    guess = prev_guess
    clear_guess(guess.take(2))
    options = options_vs_incorrect(*guess.take(2))
    if options.empty?
      backtrack
    end
  end

  def prev_guess
    loop do
      guess = @after_guess.pop
      if guess[0]=="mg"
        guess = @guess.pop
        @incorrect << guess
        return guess
      else
        clear_guess(guess.take(2))
      end
    end
  end

  def clear_guess(place)
    board[find_index(place)] = 0
  end

  def options_vs_incorrect(*place)
    options = check_place(*place)
    wrong = @incorrect
      .select { |array| array[0..1] == place }
      .map { |array| array[2] }
    options - wrong
  end
end
