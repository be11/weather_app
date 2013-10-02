# -*- coding: UTF-8 -*-
require 'date'
require 'getweather'
class ForecastsController < ApplicationController
  PARAMS = {time: "dt__txt", description: "weather_0_description", icon: "weather_0_icon", main: "weather_0_main", rain: "rain_3h", snow: "snow_3h", temp: "main_temp", temp_min: "main_temp__min", temp_max: "main_temp__max", pressure: "main_pressure", humidity: "main_humidity", windspeed: "wind_speed", winddeg: "wind_deg", clouds: "clouds_all"}
  FC = "fc_"
  def show
    @fdata, @forecast = Array.new
    unless @fdata = Forecast.find_all_by_pref_id(params[:pref][:id])
      create
    else
      if DateTime.now > @fdata[1].time.to_datetime
        update
      end
    end
    #@forecast.store(datetime, @fdata.time.localtime.strftime("%H:%M"))
    #PARAMS_FOR_VIEW.each_with_index do |(k, v), i|
    #  p = @fdata.send(k)
    #  @forecast.store(v, p)
    #end
    @icon = ICON_URL+@fdata.icon+".png"
  end

  def get
    fc = GetWeather.new(:place => Pref.find_by_id(params[:pref][:id]).capital + ",JP")
    fc.fc_get(DateTime.now.strftime("%c"))
    return fc
  end

  def create
    for i in [0..7] {@fdata[i] = Forecast.create(:pref_id => params[:pref][:id])}
    update
  end

  def update
    data = get
    PARAMS.each do |k, v|
      begin
        d = data.send(FC+v)
      rescue
        @fdata.each {|i| @fdata[i].update_attribute(k, nil)}
      else
        @fdata.each {|i| @fdata[i].update_attribute(k, (d[2*i+1]))}
      end
    end
      @fdata.each {|i| @fdata[i].update_attribute(time, d.send(FC+PARAMS[time]))}
  end
end
