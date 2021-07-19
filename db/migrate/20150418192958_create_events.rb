class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.string :name
      t.string :price
      t.text :description
      t.string :link

      t.timestamps null: false
    end
  end
end
