class RemoveSunrizeFromWeather < ActiveRecord::Migration
  def up
    remove_column :weathers, :sunrize
  end

  def down
    add_column :weathers, :sunrize, :datetime
  end
end
