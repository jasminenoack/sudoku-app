class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.boolean :complete
      t.text :board 
      t.text :guess 

      t.timestamps
    end
  end
end
