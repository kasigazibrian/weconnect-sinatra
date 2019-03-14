# frozen_string_literal: true

class AddConstraintToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_index :businesses, :business_name, unique: true
  end
end
