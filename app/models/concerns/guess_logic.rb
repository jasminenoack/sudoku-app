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
    loop do
      break if @after_guess.empty?
      guess = @after_guess.pop
      if guess[0]=="mg"
        guess = @guess.pop
        @incorrect << guess
        board[find_index(guess.take(2))] = 0

        options = check_place(*guess.take(2))
        wrong = @incorrect
          .select { |array| array[0..1] == guess[0..1] }
          .map { |array| array[2] }
        options -= wrong

        if !options.empty?
          break
        end
      else
        board[find_index(guess)] = 0
      end
    end
  end
end
