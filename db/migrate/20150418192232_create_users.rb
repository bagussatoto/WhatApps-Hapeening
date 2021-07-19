class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_no
      t.string :name
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
