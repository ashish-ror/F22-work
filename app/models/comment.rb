class Comment < ActiveRecord::Base
	belongs_to :post
  has_many :subcomments, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
  belongs_to :parent_comment, class_name: "Comment"
  
  validates :description, presence: true
end
