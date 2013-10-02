# -*- coding: UTF-8 -*-
require 'date'
require 'getweather'
class WeathersController < ApplicationController
  DIV = 48
  PARAMS = {lon: "coord_lon", lat: "coord_lat", description: "weather_0_description", icon: "weather_0_icon", main: "weather_0_main", rain: "rain_3h", snow: "snow_3h", temp: "main_temp", pressure: "main_pressure", humidity: "main_humidity", windspeed: "wind_speed", winddeg: "wind_deg", clouds: "clouds_all"}
  PARAMS_TIME = { sunrise: "sys_sunrise", sunset: "sys_sunset", get_time: "dt"}
  PARAMS_FC = {time: "dt__txt", description: "weather_0_description", icon: "weather_0_icon", main: "weather_0_main", rain: "rain_3h", snow: "snow_3h", temp: "main_temp", temp_min: "main_temp__min", temp_max: "main_temp__max", pressure: "main_pressure", humidity: "main_humidity", windspeed: "wind_speed", winddeg: "wind_deg", clouds: "clouds_all"}
  PARAMS_JP = {sunrise: "日の出", sunset: "日の入", description: "天気", rain: "降水量", snow: "降雪量", temp: "気温", pressure: "気圧", humidity: "湿度", windspeed: "風速", winddeg: "風向", clouds: "雲量"}
  PARAMS_FC_JP = {time: "時刻", description: "天気", rain: "降水量", snow: "降雪量", temp: "気温", temp_max: "最高気温", temp_min: "最低気温", pressure: "気圧", humidity: "湿度", windspeed: "風速", winddeg: "風向", clouds: "雲量"}
  UNITS = [nil, nil, nil, "mm", "mm", "度", "hPa", "%", "m/秒", "度", "%", nil]
  UNITS_FC = [nil, nil, "mm", "mm", "度", "度", "度", "hPa", "%", "m/秒", "度", "%"]
  FC = "fc_"
 
  def show
    unless @wdata = Weather.find_by_pref_id(params[:pref][:id])
      create
    else
      if !@wdata.get_time || DateTime.now > @wdata.get_time.to_datetime + Rational(1, DIV)
        update
      end
    end
    @data = Hash.new
    PARAMS_JP.each_with_index do |(k, v), i|
      p = @wdata.send(k) if @wdata.attribute_present?(k)
      p.is_a?(ActiveSupport::TimeWithZone) ? @data.store(v, p.localtime.strftime("%H:%M")) : @data.store(v, p)
    end
    forecast
    @pref = Pref.find_by_id(params[:pref][:id]).name
    @units = UNITS
    @icon = ICON_URL+@wdata.icon+".png"
  end

  def get
    w = GetWeather.new(:place => Pref.find_by_id(params[:pref][:id]).capital + ",JP")
    w.get
    return w
  end

  def create
    @wdata = Weather.create(:pref_id => params[:pref][:id])
    update
  end

  def update
    data = get
    PARAMS.each do |k, v|
      begin
        data.send(v)
      rescue
        @wdata.update_attribute(k, nil)
      else
        @wdata.update_attribute(k, data.send(v))
      end
    end
    PARAMS_TIME.each do |k, v|
      @wdata.update_attribute(k, Time.at(data.send(v).to_i))
    end
  end

  def forecast
    if (@fdata = Forecast.find_all_by_pref_id(params[:pref][:id])).empty?
      create_fc
    else
      if !@fdata[1].time || DateTime.now > @fdata[1].time.to_datetime
        update_fc
      end
    end
    @params = PARAMS_FC_JP
    @units_fc = UNITS_FC
  end

  def get_fc
    fc = GetWeather.new(:place => Pref.find_by_id(params[:pref][:id]).capital + ",JP")
    fc.fc_get(DateTime.now.strftime("%c"))
    return fc
  end

  def create_fc
    9.times {|i| @fdata[i] = Forecast.create(:pref_id => params[:pref][:id])}
    update_fc
  end

  def update_fc
    data = get_fc
    PARAMS_FC.each do |k, v|
      begin
        d = data.send(FC+v)
      rescue
        @fdata.each {|p| p.update_attribute(k, nil)}
      else
        @fdata.each_with_index {|p, i| p.update_attribute(k, d[2*i+1])}
      end
    end
    #@icon_fc = Array.new
    #@fdata.each_with_index {|p, i| @icon_fc[i] = ICON_URL + p.icon + ".png"}
  end
end
