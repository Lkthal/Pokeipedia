class Wiki < ApplicationRecord
  belongs_to :user

  scope :alphabetical, -> { order("title ASC") }
  scope :visible_to, -> (user) { (user.admin? || user.premium?) ? all : where(private: false) }

  before_save { self.private ||= false }

end
