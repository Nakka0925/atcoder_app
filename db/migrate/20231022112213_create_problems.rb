class CreateProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :problems do |t|
      t.string :problem_id
      t.string :contest_id
      t.string :problem_index
      t.string :name
      t.integer :algo_id


      t.timestamps
    end
  end
end