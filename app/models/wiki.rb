class Wiki < ApplicationRecord
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators
  scope :alphabetical, -> { order("title ASC") }
  scope :visible_to, -> (user) { (user.admin? || user.premium?) ? all : where(private: false) }

  before_save { self.private ||= false }

  def collaborator_for(user)
    collaborators.where(user_id: user.id).first
  end

  def users
    collaborators.collect(&:user)
  end

  def collabs
    users.collect(&:collaborator)
  end

end
