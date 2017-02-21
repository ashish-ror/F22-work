class PersonGroup < ActiveRecord::Base
	belongs_to :person
  belongs_to :group

  validates :person, :group, presence: true
  validates_uniqueness_of :person, scope: :group_id

end
