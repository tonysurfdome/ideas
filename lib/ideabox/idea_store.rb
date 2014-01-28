class IdeaStore

  def self.reset!
    @ideas, @id = nil, nil
  end

  def self.save idea
    if idea.new?
      all << idea
      idea.id = new_id
    end
    
    idea.id
  end

  def self.count
    all.count
  end

  def self.all
    @ideas ||= []
  end

  def self.find id
    all.select { |idea| idea.id == id }.first
  end

  def self.delete id
    idea = IdeaStore.find(id)
    all.delete(idea)
  end

  private

  def self.new_id
    @id ||= 0
    @id += 1
  end

end