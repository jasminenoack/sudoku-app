class ArticleRoutesTest < ActionController::TestCase
  test "should route to puzzle" do
    assert_routing '/puzzles/1', { controller: "puzzles", action: "show", id: "1" }
  end

  test "should route to puzzles" do
    assert_routing '/puzzles', { controller: "puzzles", action: "index" }
  end

  test "should route root to home page" do
    opts = { :controller => 'puzzles', :action => 'index'}
    assert_recognizes opts, '/'
  end
 
  test "should route to create puzzle" do
    assert_routing({ method: 'post', path: '/puzzles' }, { controller: "puzzles", action: "create" })
  end

  test "should route to new puzzle" do
    assert_routing '/puzzles/new', {controller: "puzzles", action: "new"}
  end

  test "should route to edit puzzle" do
    assert_routing '/puzzles/1/edit', {controller: "puzzles", action: "edit", id: "1"}
  end

  test "should route to solve puzzle" do
    assert_routing '/puzzles/1/solve', {controller: "puzzles", action: "solve", id: "1"}
  end



end