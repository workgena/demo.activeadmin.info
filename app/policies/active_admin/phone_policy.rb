module ActiveAdmin
  class PhonePolicy < ApplicationPolicy
    def index?
      false
    end

    def batch_update?
      false
    end
  end
end


