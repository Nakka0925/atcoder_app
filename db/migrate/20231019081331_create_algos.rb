class CreateAlgos < ActiveRecord::Migration[7.0]
  def change
    create_table :algos do |t|
      t.integer :algo_id
      t.string :algo_name

      t.timestamps
    end
  end
end
