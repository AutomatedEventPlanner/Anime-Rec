class Anime < ActiveRecord::Base
  attr_accessible :description, :name, :rating, :tags

  validates :name, presence: true, length: { maximum: 200 }
  validates :description, presence: true
  validates :rating, presence: true
  validates :tags, presence: true

  def recScore(interests)
     if (self.approved && !interests.nil? && !interests.empty?)
        tagsArray = self.tags.downcase.split('|')
        interestsArray = interests.downcase.split('|')
        matchPoints = 0

  
         interestsArray.each do |inter|
             if (tagsArray.include?(inter))
                 matchPoints += 1
             end
         end

         return (matchPoints / interestsArray.length) * 100

     else
         return -1
     end
  end
end
