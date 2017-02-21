class Group < ActiveRecord::Base
	has_many :invite_histories
  has_many :posts
  has_many :person_groups
  has_many :persons, through: :person_groups

  serialize :admin_team, Array
  
  validates :name, presence: true, uniqueness: true
end
