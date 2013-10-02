class CreatePrefs < ActiveRecord::Migration
  def change
    create_table :prefs do |t|
      t.string :name
      t.string :capital

      t.timestamps
    end
  end
end
