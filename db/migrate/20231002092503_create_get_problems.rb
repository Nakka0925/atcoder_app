class CreateGetProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :get_problems do |t|

      t.timestamps
    end
  end
end
