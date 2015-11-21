class ChangeCourts < ActiveRecord::Migration
  def up
    add_column :courts, :court_type_id, :integer

    Court.all.each do |court|
      court_type = CourtType.find_or_create_by(description: court.setting)
      court.court_type = court_type
      court.save!
    end
  end

  def down
    remove_column :courts, :court_type_id
  end
end
