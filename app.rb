#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:barbershop.db'

helpers do
  def selected(id, value)
    'selected' if id.to_s == value.to_s
  end
end

before do
  @barbers = Barber.all
end

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base

end

get '/' do
	erb :index
end

get '/vizit' do
  erb :vizit
end

post '/vizit' do
  @name = params[:name]
  @phone = params[:phone]
  @datestamp = params[:datetime]
  @barber = params[:master]
  @color = params[:head_color]

  b = Client.new
  b.name = @name
  b.phone = @phone
  b.datestamp = @datestamp
  b.barber = @barber
  b.color = @color

  b.save

  @message = "#{@name} вы записаны на #{@datestamp}, на стрижку к #{Barber.find(@barber).name}!"

  erb :vizit
end

get '/showusers' do
  @clients = Client.order('datestamp DESC')
  erb :showusers
end