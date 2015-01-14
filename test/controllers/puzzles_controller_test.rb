require 'test_helper'

class PuzzlesControllerTest < ActionController::TestCase
  
  # __9 | __5 | _71
  # 5__ | 7_6 | ___
  # __8 | 49_ | _35
  # ----------------
  # _3_ | _18 | 2__
  # _9_ | 342 | _6_
  # __2 | 96_ | _4_
  # ----------------
  # 92_ | _74 | 3__
  # ___ | 6_9 | __2
  # 76_ | 8__ | 4__

  def setup
    @puzzle = puzzles(:one)
  end

  test "should save values" do 
    assert_equal @puzzle.send("0, 2"), "9"
    assert_equal @puzzle.send("1, 2"), "5"
    assert_equal @puzzle.send("2, 1"), "7"
    assert_equal @puzzle.send("3, 8"), "2"
    assert_equal @puzzle.send("4, 4"), "4"
    assert_equal @puzzle.send("5, 0"), "2"
    assert_equal @puzzle.send("6, 1"), "2"
    assert_equal @puzzle.send("7, 2"), "4"
    assert_equal @puzzle.send("8, 6"), "4"
  end

  test "should update puzzle" do 
    put :update
  end
  



end
