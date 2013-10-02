class Pref < ActiveRecord::Base
  attr_accessible :capital, :name
  has_one:weather
  has_many:forecasts
end
