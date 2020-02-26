class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin?
  end
  def create?
    user.admin?
  end
  def update?
    record.id == user.id
  end
  def destroy?
    user.admin?
  end
end
