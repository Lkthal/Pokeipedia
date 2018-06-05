class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy
  before_save { self.role ||= :standard }
  #after_initialize :default_role

  enum role: [:standard, :admin, :premium]

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
end
