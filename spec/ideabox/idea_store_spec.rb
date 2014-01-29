require 'spec_helper'
describe IdeaStore do

  before do
    IdeaStore.reset!
  end

  it "saves and retrieves an idea" do
    idea = Idea.new(title: "celebrate", description: "with champagne")
    id = IdeaStore.save(idea)

    expect(IdeaStore.count).to eq(1)

    idea = IdeaStore.find(id)
    expect(idea.title).to eq("celebrate")
    expect(idea.description).to eq("with champagne")
  end

  it "has an id" do
    idea = Idea.new(title:"dinner", description: "beef stew")
    idea.id = 1
    expect(idea.id).to eq(1)
  end

  it "updates an idea" do
    idea = Idea.new(title: "drink", description: "tomato juice")
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
    idea = Idea.new(title:"drinks", description: "sparkly water")
    idea.title = "happy hour"
    idea.description = "mojitos"

    expect(idea.title).to eq("happy hour")
    expect(idea.description).to eq("mojitos")
  end

  it "deletes an idea" do
    id1 = IdeaStore.save Idea.new(title:"song", description:"99 bottles of beer")
    id2 = IdeaStore.save Idea.new(title:"gift", description:"micky mouse belt")
    id3 = IdeaStore.save Idea.new(title:"dinner", description:"cheeseburger with bacon and avocado")

    expect(IdeaStore.all.map(&:title).sort).to eq(["dinner", "gift", "song"])
    IdeaStore.delete(id2)
    expect(IdeaStore.all.map(&:title).sort).to eq(["dinner", "song"])
  end

  it "finds by title" do
    IdeaStore.save Idea.new(title:"dance", description: "like it's the 80s")
    IdeaStore.save Idea.new(title:"sleep", description: "like a baby")
    IdeaStore.save Idea.new(title:"dream", description: "like anything is possible")

    idea = IdeaStore.find_by_title("sleep")

    expect(idea.description).to eq("like a baby")
  end

end
