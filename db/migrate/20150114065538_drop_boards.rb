class DropBoards < ActiveRecord::Migration
  def change
    drop_table :boards
    add_column :puzzles, :original, :text
    add_column :puzzles, :solution, :text
  end
end
