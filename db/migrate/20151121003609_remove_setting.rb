class RemoveSetting < ActiveRecord::Migration
  def up
    remove_column :courts, :setting

    change_column :courts, :court_type_id, :integer, null: false
  end

  def down
    change_column :courts, :court_type_id, :integer
    
    add_column :courts, :setting, :string

    Court.all.each do |court|
      court.setting = court.court_type.description
      court.save!
    end

    change_column :courts, :setting, :string, null: false
  end
end
