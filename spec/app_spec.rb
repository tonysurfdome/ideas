require 'spec_helper'
require 'app'
require 'sinatra/base'

describe IdeaboxApp do
  include Rack::Test::Methods

  def app
    IdeaboxApp
  end

  # after(:each) do
  #   IdeaStore.reset!
  # end

  it "displays a list of ideas" do
    Idea.create(title: "dinner", description: "spaghetti and meatballs")
    Idea.create(title: "drinks", description: "imported beers")
    Idea.create(title: "movie", description: "The Matrix")

    get '/ideas'

    [
      /dinner/, /spaghetti/,
      /drinks/, /imported beers/,
      /movie/, /The Matrix/
    ].each do |content|
      expect(last_response.body).to match(content)
    end
  end

  it "stores an idea" do
    post '/ideas', title: 'costume', description: "scary vampire"
    # IdeaStore.save Idea.new(title: "costume", description: "scary vampire")

    expect(Idea.count).to eq(1)

    idea = Idea.first
    expect(idea.title).to eq("costume")
    expect(idea.description).to eq("scary vampire")
  end

  it "deletes an idea" do
    idea = Idea.create(title: 'breathe', description: 'fresh air in the mountains')

    expect(Idea.count).to eq(1)

    delete "/ideas/#{idea.id}"

    expect(last_response.status).to eq(302)
    expect(Idea.count).to eq(0)
  end

  it "updates an idea" do
    idea = Idea.create(title: 'sing', description: 'happy songs')

    put "/ideas/#{idea.id}", {title: 'yodle', description: 'joyful songs'}

    idea = Idea.find(idea)

    expect(last_response.status).to eq(302)

    expect(idea.title).to eq('yodle')
    expect(idea.description).to eq('joyful songs')
  end

  it "likes an idea" do
    idea = Idea.create(title: 'run', description: 'really, really fast')

    post "/ideas/#{idea.id}/like"

    expect(last_response.status).to eq(302)

    idea = Idea.find(idea)
    expect(idea.rank).to eq(1)
  end

end
