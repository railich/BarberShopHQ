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
  validates :name, presence: true
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :color, presence: true
end

class Barber < ActiveRecord::Base

end

get '/' do
	erb :index
end

get '/vizit' do
  @c = Client.new
  erb :vizit
end

post '/vizit' do

  @c = Client.new params[:client]
  if @c.save
    erb "<h2>Вы записаны!</h2>"
  else
    @errors = @c.errors.full_messages.first
    erb :vizit
  end


end

get '/showusers' do
  @clients = Client.order('datestamp DESC')
  erb :showusers
end

get '/barber/:id' do
  @barber = Barber.find(params[:id])
  @barber_clients = Client.where(barber: params[:id])
  erb :barber
end