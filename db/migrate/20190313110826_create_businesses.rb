class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses, id: :uuid do |t|
      t.string :business_name
      t.string :business_email
      t.string :business_location
      t.string :contact_number
      t.string :business_description
      t.uuid :category_id, foreign_key: true, null: false
      t.uuid :user_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
