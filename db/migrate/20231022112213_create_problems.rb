class CreateProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :problems, id: false do |t|
      t.string :id
      t.string :contest_id
      t.string :problem_index
      t.string :name
      t.bigint :algo_id


      t.timestamps
    end

    add_foreign_key :problems, :algos, column: :algo_id
  end
end