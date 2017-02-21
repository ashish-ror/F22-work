class Post < ActiveRecord::Base
	belongs_to :person
  belongs_to :group
  has_many :comments
  
  validates :description, presence: true
end
