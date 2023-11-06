class AddDiffcultyPloblems < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :difficulty, :integer
  end
end
