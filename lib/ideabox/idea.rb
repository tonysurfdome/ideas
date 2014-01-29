class Idea < ActiveRecord::Base

  attr_accessor :id, :title, :description

  # def initialize title, description
  #   @title       = title
  #   @description = description
  #   @rank       = 0
  # end

  def like!
    self.rank += 1
  end

  def <=>(other)
    rank <=> other.rank
  end

  def new?
    id.nil?
  end

  def rank
    @rank ||= 0
  end

  attr_writer   :rank
  
end