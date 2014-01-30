require 'ideabox'

class IdeaboxApp < Sinatra::Base
  set :method_override, true
  set :root, "./lib/app"

  get '/' do
    redirect '/ideas'
  end

  get '/ideas' do
    erb :index, locals: {ideas: Idea.all.sort.reverse }
  end

  get '/ideas/new' do
    erb :new
  end

  delete '/ideas/:id' do |id|
    Idea.destroy(id.to_i)
    redirect '/ideas'
  end

  post '/ideas/new' do
    params.symbolize_keys!
    Idea.create(title: params[:title], description: params[:description])
    redirect '/ideas'
  end

  get '/ideas/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/ideas/:id/edit' do |id|
    params.symbolize_keys!

    Idea.find(id.to_i).update_attributes(
      title: params[:title],
      description: params[:description]
    )
    redirect '/ideas'
  end

  post '/ideas/:id/like' do |id|
    idea = Idea.find(id.to_i)
    idea.like!
    redirect '/ideas'
  end

end
