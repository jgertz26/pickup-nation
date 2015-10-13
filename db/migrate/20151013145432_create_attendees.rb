class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.belongs_to :meetup, null: false
      t.belongs_to :user, null: false
    end

  add_index(:attendees, [:meetup_id, :user_id], unique: true)
  end
end
