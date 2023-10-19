class CreateProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :problems do |t|
      t.string :problem_id
      t.bigint :algo_id

      t.timestamps
    end

    add_foreign_key :problems, :algos, column: :algo_id
  end
end