class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy
  before_save { self.role ||= :member }
  after_initialize :default_role

  enum role: [:member, :admin, :premium]

  def default_role
    self.role ||= :member
  end

end
