class Person < ActiveRecord::Base
	has_many :person_groups
  has_many :groups, through: :person_groups
  has_many :posts

  validates :name, presence: true, uniqueness: true

  def create_group(name)
    groups.create(name: name, owner_id: id.to_s ,admin_team: [self.id.to_s])
  end

  def edit_group(name)
    check_eligibility(name) ? 'You may edit the group' : errors.add(:base, 'You are not eligible to edit the group')
  end

  def destroy_group(name)
    check_eligibility(name) ? @group.destroy : errors.add(:base, 'You are not eligible to destroy the group')
  end

  def change_group_status(name, status)
    if check_eligibility(name)
      @group.status = status
      @group.save!
    else 
      errors.add(:base, 'You are not eligible to change group status')
    end
  end

  def invite_people_to_group(group_name, person_name)
    group = Group.find_by(name: group_name)
    if group
      if group.persons.map{|record| record.id.to_s}.include?(self.id.to_s)
        if verify_invitation.eql?("Yes")
          invited_person = Person.find_or_create_by(name: person_name)
          group.person_groups.create(person_id: invited_person.id)        
          group.invite_histories.create(invited_by: id.to_s, invited_to: invited_person.id.to_s)
        else
          errors.add(:base, 'invitation rejected by group admin')
        end
      else
        errors.add(:base, 'You donot belong to this group')
      end
    else
      errors.add(:base, 'No such group exists')
    end
  end

  def leave_group(group_name)
    group = groups.find_by(name: group_name)
    group ? group.person_groups.find_by(person_id: id).destroy : errors.add(:base, 'No such group exists')
  end

  def join_group(group_name)
    group = Group.find_by(name: group_name)
    group ? group.person_groups.create(person_id: id) : errors.add(:base, 'No such group exists')
  end

  def create_post(group_name, description)
    group = Group.find_by(name: group_name)
    if group.persons.map{|record| record.id.to_s}.include?(self.id.to_s)
      if verify_invitation.eql?("Yes")
        group.posts.create(person_id: id, description: description)
      else
        errors.add(:base, 'invitation rejected by group admin')
      end
    else
      errors.add(:base, 'You donot belong to this group')
    end
  end

  def create_comment(post_id, comment_id=nil, group_name, description)
    group = Group.find_by(name: group_name)
    if group.persons.map{|record| record.id.to_s}.include?(self.id.to_s)
      if Post.find_by(id: post_id)
        post = Post.find(id)
        post.comments.create(description: description, parent_comment_id: comment_id)
      else 
        errors.add(:base, 'Post exists no more')
      end
    else
      errors.add(:base, 'You donot belong to this group')
    end
  end

  private

  def check_eligibility(name)
    @group = groups.find_by(name: name)
    (@group and @group.owner_id.to_s.eql?(self.id.to_s))
  end

  def verify_invitation
    puts "Verifying the invitation"
    ["Yes", "No"].sample
  end
end
