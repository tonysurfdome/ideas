class Idea < ActiveRecord::Base

  attr_reader   :rank
  attr_accessor :id, :title, :description

  def initialize title, description
    @title       = title
    @description = description
    @rank       = 0
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    rank <=> other.rank
  end

  def new?
    id.nil?
  end

end