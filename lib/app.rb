require 'ideabox'

class IdeaboxApp < Sinatra::Base
  set :method_override, true
  set :root, "./lib/app"

  get '/' do
    redirect '/ideas'
  end

  get '/ideas' do
    erb :index, locals: {ideas: IdeaStore.all.sort.reverse }
  end

  get '/ideas/new' do
    erb :new
  end

  delete '/ideas/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/ideas'
  end

  post '/ideas/new' do
    idea = Idea.new(title: params[:title], description: params[:description])
    IdeaStore.save(idea)
    redirect '/ideas'
  end

  get '/ideas/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/ideas/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.title = params[:title]
    idea.description = params[:description]
    IdeaStore.save(idea)
    redirect '/ideas'
  end

  post '/ideas/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    redirect '/ideas'
  end

end
