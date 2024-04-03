# frozen_string_literal: true

class CreateGetProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :get_problems, &:timestamps
  end
end
