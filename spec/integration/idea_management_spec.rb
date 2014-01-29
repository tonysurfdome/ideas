require 'spec_helper'
require 'sinatra/base'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'

require 'app'

Capybara.app = IdeaboxApp

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :headers =>  { 'User-Agent' => 'Capybara' })
end

describe "managing ideas" do
  include Capybara::DSL

  after(:each) do
    IdeaStore.reset!
  end

  it "manages ideas" do
    # Create the idea
    IdeaStore.save Idea.new("laundry", "buy more socks")
    IdeaStore.save Idea.new("groceries", "macaroni, cheese")

    visit '/ideas'
    expect(page).to have_content("buy more socks")
    expect(page).to have_content("macaroni, cheese")

    visit '/ideas/new'
    fill_in 'title', :with => 'eat'
    fill_in 'description', :with => 'chocolate chip cookies'
    click_button 'Save'
    expect(page).to  have_content("chocolate chip cookies")

    # Edit the idea
    idea = IdeaStore.find_by_title('eat')
    within("#idea_#{idea.id}") do
      click_link 'Edit'
    end

    expect(find_field('title').value).to eq('eat')
    expect(find_field('description').value).to eq('chocolate chip cookies')

    fill_in 'title', :with => 'eats'
    fill_in 'description', :with => 'chocolate chip oatmeal cookies'
    click_button 'Save'

    expect(page).to have_content("chocolate chip oatmeal cookies")
    expect(page).to have_content("buy more socks")
    expect(page).to have_content("macaroni, cheese")

    expect(page).not_to have_content("chocolate chip cookies")

    # Delete the idea
    within("#idea_#{idea.id}") do
      click_button 'Delete'
    end

    # Make sure the idea is gone
    expect(page).not_to have_content("chocolate chip oatmeal cookies")

    # Make sure the decoys are still untouched
    expect(page).to have_content("buy more socks")
    expect(page).to have_content("macaroni, cheese")
  end

  it "allows ranking of ideas" do
    id1 = IdeaStore.save Idea.new("fun", "ride horses")
    id2 = IdeaStore.save Idea.new("vacation", "camping in the mountains")
    id3 = IdeaStore.save Idea.new("write", "a book about being brave")

    visit '/ideas'

    idea = IdeaStore.all[1]
    idea.like!
    idea.like!
    idea.like!
    idea.like!
    idea.like!
    IdeaStore.save(idea)

    within("#idea_#{id2}") do
      3.times do
        click_button '+'
      end
    end

    within("#idea_#{id3}") do
      click_button '+'
    end

    ideas = page.all('td.description')
    expect(ideas[0].text).to match(/camping in the mountains/)
    expect(ideas[1].text).to match(/a book about being brave/)
    expect(ideas[2].text).to match(/ride horses/)
  end

end
