class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.integer :pref_id
      t.float :lat
      t.float :lon
      t.datetime :sunrize
      t.datetime :sunset
      t.string :main
      t.string :description
      t.string :icon
      t.float :humidity
      t.float :pressure
      t.float :temp
      t.float :windspeed
      t.float :winddeg
      t.float :rain
      t.float :snow
      t.float :clouds
      t.datetime :get_time

      t.timestamps
    end
  end
end
