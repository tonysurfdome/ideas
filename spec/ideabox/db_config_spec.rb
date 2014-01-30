require 'spec_helper'

describe 'DBConfig' do

  it "check db file" do
    file = './config/database.yml'
    expect(file).to eq DBConfig.new('env').file
  end

  it "overrride file" do
    file = './config/database.yml'
    expect(file).to eq DBConfig.new('env',file).file
  end


  it 'enviroment specific values' do
    config = DBConfig.new('fake', './spec/fixtures/database.yml')
    options = {
      'adapter' => 'sqlite3',
      'database' => 'db/ideabox_fake'
    }

    expect(options).to eq config.options
  end

  it 'blow up for unknow enviroment' do
    config = DBConfig.new('real', './spec/fixtures/database.yml')
    
    expect { config.options }.to raise_error DBConfig::UnconfiguredEnvironment
  end 

end
