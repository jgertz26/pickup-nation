class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.belongs_to :user, null: false
      t.belongs_to :court, null: false
      t.datetime :start_time, null: false
      t.string :description
      t.string :condition
      t.timestamps null: false
    end
  end
end
