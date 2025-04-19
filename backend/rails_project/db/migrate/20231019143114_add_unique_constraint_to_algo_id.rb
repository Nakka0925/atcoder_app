# frozen_string_literal: true

class AddUniqueConstraintToAlgoId < ActiveRecord::Migration[7.0]
  def change
    add_index :algos, :algo_id, unique: true
  end
end
