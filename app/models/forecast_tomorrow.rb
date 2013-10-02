class ForecastTomorrow < ActiveRecord::Base
  attr_accessible :clouds, :description, :humidity, :icon, :main, :pref_id, :pressure, :rain, :snow, :temp, :temp_max, :temp_min, :time, :winddeg, :windspeed
end
