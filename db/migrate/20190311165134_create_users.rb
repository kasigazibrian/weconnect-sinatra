class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, unique: true
      t.string :password
      t.string :password_digest
      t.string :username, null: false, unique: true
      t.string :gender

      t.timestamps null: false
    end
  end
end
