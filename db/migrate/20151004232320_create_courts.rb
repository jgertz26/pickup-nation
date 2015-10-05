class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :name, null: false
      t.decimal :latitude, precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :setting, null: false
      t.string :hours
      t.integer :hoop_count, null: false

      t.timestamps null: false
    end

  add_index :courts, [:street_address, :city, :state, :zip], unique: true
  end
end
