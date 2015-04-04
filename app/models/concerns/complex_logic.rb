module ComplexLogic
  def find_set_options(places)
    options=[]
    places.each do |place|
      options << check_place(*find_pos(place))
    end
    options
  end

  def compare_square(row, column)
    places = find_square_indexes(row, column)
    options = find_set_options(places)
    singles = compare(options)
    update_from_compare(singles, options, places)
  end

  def compare (options)
    nums=options.flatten.sort
    (1..9).each {|num| nums.delete(num) if nums.count(num)>1}
    nums
  end

  def update_from_compare(singles, options, places)
    singles.each do |num|
      if options.include?(num)
        next
      else
        options.each_with_index do |nums, index|
          next if nums.class == Fixnum
          if nums.include?(num)
            place_index = places[index]
            board[place_index] = num
            @after_guess << find_pos(place_index) if @guessed
          end
        end
      end
    end
  end

  def compare_squares
    (0..2).each do |row|
      (0..2).each do |column|
        compare_square(row*3, column*3)
      end
    end
  end

  def compare_row(row)
    places = (row * 9..(row * 9 + 8)).to_a
    options = find_set_options(places)
    singles = compare(options)
    update_from_compare(singles, options, places)
  end

  def compare_rows
    (0..8).each {|num| compare_row(num)}
  end

  def compare_column(column)
    places = []
    rows = (0..8).to_a
    places = rows.map { |row| find_index([row, column]) }
    options = find_set_options(places)
    singles = compare(options)
    update_from_compare(singles, options, places)
  end

  def compare_columns
    (0..8).each {|num| compare_column(num)}
  end
end
