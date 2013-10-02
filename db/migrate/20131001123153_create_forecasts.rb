class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer :pref_id
      t.datetime :time
      t.float :temp
      t.float :temp_min
      t.float :temp_max
      t.float :humidity
      t.float :pressure
      t.string :main
      t.string :description
      t.string :icon
      t.float :clouds
      t.float :windspeed
      t.float :winddeg
      t.float :rain
      t.float :snow

      t.timestamps
    end
  end
end
