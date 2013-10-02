class AddSunriseToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :sunrise, :datetime
  end
end
