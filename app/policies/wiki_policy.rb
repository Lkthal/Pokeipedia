class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    wiki.user == user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    wiki.user == user || user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end

end
