module ApplicationHelper

   def full_title(page_title = '')
    base_title = "Sudoku"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def header(page_header = '')
    base_header = "Puzzle #{@puzzle.id}"
    if page_header.empty?
      "{page_header}"
    else
      "#{page_header}: #{base_header}"
    end
  end
  
end
