require './lib/ideabox/idea'        # ~> LoadError: cannot load such file -- ./lib/ideabox/idea
require './lib/ideabox/idea_store'

describe IdeaStore do

  before do
    IdeaStore.reset!
  end

  it "saves and retrieves an idea" do
    idea = Idea.new("celebrate", "with champagne")
    id = IdeaStore.save(idea)

    expect(IdeaStore.count).to eq(1)

    idea = IdeaStore.find(id)
    expect(idea.title).to eq("celebrate")
    expect(idea.description).to eq("with champagne")
  end

  it "has an id" do
    idea = Idea.new("dinner", "beef stew")
    idea.id = 1
    expect(idea.id).to eq(1)
  end

  it "updates an idea" do
    idea = Idea.new("drink", "tomato juice")
    id = IdeaStore.save(idea)

    idea = IdeaStore.find(id)
    idea.title = "cocktails"
    idea.description = "spicy tomato juice with vodka"

    IdeaStore.save(idea)

    expect(IdeaStore.count).to eq(1)

    idea = IdeaStore.find(id)
    expect(idea.title).to eq("cocktails")
    expect(idea.description).to eq("spicy tomato juice with vodka")
  end

  it "updates attributes" do
    idea = Idea.new("drinks", "sparkly water")
    idea.title = "happy hour"
    idea.description = "mojitos"
    expect(idea.title).to eq("happy hour")
    expect(idea.description).to eq("mojitos")
  end

  it "deletes an idea" do
    id1 = IdeaStore.save Idea.new("song", "99 bottles of beer")
    id2 = IdeaStore.save Idea.new("gift", "micky mouse belt")
    id3 = IdeaStore.save Idea.new("dinner", "cheeseburger with bacon and avocado")

    expect(IdeaStore.all.map(&:title).sort).to eq(["dinner", "gift", "song"])
    IdeaStore.delete(id2)
    expect(IdeaStore.all.map(&:title).sort).to eq(["dinner", "song"])
  end

end