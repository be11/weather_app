# -*- coding: utf-8 -*-
require 'json'
require 'open-uri'
require 'date'

class GetWeather
  DIV = 8
  def initialize(args)
    @path = make_url(args)
  end

  def make_url(args)
    if args.key?(:place) && args[:place].is_a?(String)
      return "q=#{args[:place].downcase.gsub(/\s+/, "")}"
    elsif args.key?(:lat) && args.key?(:lon)
      return "lat=#{args[:lat]}&lon=#{args[:lon]}"
    elsif args.key?(:id)
      return "id=#{args[:id]}"
    else
      raise "Invalid argment, too many argments or too few argments"
    end
  end

  def get
    @data = JSON.parser.new(open(URL_W+@path+MTR).read).parse()
    raise "invalid address" unless data_correct?(@data)
  end

  def fc_get(datetime)
    @fdata = JSON.parser.new(open(URL_F+@path+MTR).read).parse()
    if data_correct?(@fdata)
      @fdata = @fdata["list"].delete_if{|x|
        DateTime.parse(datetime) >= DateTime.parse(x["dt_txt"])+Rational(1, DIV) || DateTime.parse(x["dt_txt"]) > DateTime.parse(datetime)+1}
        raise "invalid date" if @fdata.empty?
    else
      raise "invalid address"
    end
  end

  def method_missing(id)
    begin
      data = Array.new
      if (param = id.to_s)=~ /^fc_/
        @fdata.each do |i|
          d = i
          param.sub(/^fc_/, '').gsub(/__/," ").split(/_/).each {|j| d = (j =~ /[0-9]/) ? d[j.to_i] : d[j.gsub(/\s/, "_")]}
          super unless d
          data.push(i["dt_txt"], d)
        end
      else
        data = @data
        param.gsub(/__/, " ").split(/_/).each {|i| data = (i =~ /[0-9]/) ? data[i.to_i] : data[i.gsub(/\s/, "_")]}
        super unless data
      end
    rescue super
    end
   data
  end

  def url_correct?
    if @path =~ /^lat=-?(90|([0-9]|[1-8][0-9])(\.[0-9]+)?)&lon=-?(180|([0-9]|[1-9][0-9]|1[0-7][0-9])(\.[0-9]+)?)$|(^q=[a-z]+,[a-z]+$)|(^id=[0-9]+$)/
    return true
    end
    return false
  end

  def data_correct?(data)
    if data.is_a?(Hash) && data["cod"].to_i != OK
      return false
    end
    return true
  end
end
