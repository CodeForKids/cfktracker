class CreateTimetrackers < ActiveRecord::Migration
  def change
    create_table :timetrackers do |t|
      t.date :date
      t.float :time
      t.references :user
      t.boolean :received, default: false
      t.text :description
      t.timestamps
    end
  end
end
