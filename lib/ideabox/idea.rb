class Idea < ActiveRecord::Base

  def like!
    self.update_attribute(:likes, self.likes + 1)
  end

  def <=>(other)
    rank <=> other.rank
  end

  def new?
    self.new_record?
  end

  def rank
    self.likes
  end
  
end