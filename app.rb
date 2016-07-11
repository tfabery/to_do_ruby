require 'sinatra'
require 'sinatra/reloader'
require './lib/list'
require './lib/task'
require 'pg'
also_reload './lib/**/*.rb'

DB = PG.connect({dbname: 'to_do'})

get '/' do
  @lists = List.all
  erb(:index)
end

get '/list/new' do
  erb(:list_form)
end

post '/lists' do
  @list = List.new({name: params['name'], id: nil})
  @list.save
  @lists = List.all
  erb(:index)
end

get ('/list/:id') do
  @list = List.find(params['id'])
  erb(:to_do)
end

get '/list/:id/task/new' do
  @list = List.find(params['id'])
  erb(:task_form)
end

post '/list/:id' do
  @list = List.find(params['id'])
  @task = Task.new({description: params['description'], list_id: params['id'], due_date: params['due_date']})
  @task.save
  erb(:to_do)
end
