require 'spec_helper'

describe Idea do

  it "has basic attributes" do
    idea = Idea.new(title: "title", description: "description")
    expect(idea.title).to eq("title")
    expect(idea.description).to eq("description")
  end

  it "is likeable" do
    idea = Idea.new(title: "diet",  description: "carrots and cucumbers")
    expect(idea.rank).to eq(0)
    idea.like!
    expect(idea.rank).to eq(1)
  end

  it "sorts by rank" do
    diet = Idea.new(title: "diet", description: "cabbage soup")
    exercise = Idea.new(title: "exercise", description: "long distance running")
    drink = Idea.new(title: "drink", description: "carrot smoothy")

    exercise.like!
    exercise.like!
    drink.like!

    ideas = [drink, exercise, diet]

    expect(ideas.sort).to eq([diet, drink, exercise])
  end

  it "is new" do
    idea = Idea.new(title: 'sleep', description:'all day')
    expect(idea.new?).to be_true
  end

  it "is old" do
    idea = Idea.create(title: 'drink', description:'lots of water')
    expect(idea.new?).to be_false
  end

  it "is created in the DB" do
    Idea.create(description:'A wonderful idea!')
    expect(Idea.count).to eq 1   
  end



end
