class Anime < ActiveRecord::Base
  attr_accessible :description, :name, :rating, :tags

  validates :name, presence: true, length: { maximum: 200 }
  validates :description, presence: true
  validates :rating, presence: true, length: { maximum: 3 }
  validates :tags, presence: true, length: { maximum: 200 }

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
# == Schema Information
#
# Table name: animes
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  approved    :boolean         default(FALSE)
#  rating      :integer
#  tags        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

