class CreateCourtTypes < ActiveRecord::Migration
  def change
    create_table :court_types do |t|
      t.string :description, null: false
    end
  end
end
