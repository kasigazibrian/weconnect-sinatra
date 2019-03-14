class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews, id: :uuid do |t|
      t.string :title
      t.text :body
      t.uuid :business_id, foreign_key: true, null: false
      t.uuid :user_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
