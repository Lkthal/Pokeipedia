class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki

  before_save { self.role ||= :standard }
  #after_initialize :default_role

  enum role: [:standard, :admin, :premium]

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end
  
  def downgrade!
    ActiveRecord::Base.transaction do
      self.update_attribute(:role, :standard)
      self.wikis.where(private: true).all.each do |wiki|
        wiki.update_attribute(:private, false)
      end
    end
  end
end
