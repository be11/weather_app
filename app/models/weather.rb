class Weather < ActiveRecord::Base
  attr_accessible :clouds, :description, :get_time, :humidity, :icon, :lat, :lon, :main, :pref_id, :pressure, :rain, :snow, :sunrize, :sunset, :temp, :winddeg, :windspeed
  belongs_to :pref
end
