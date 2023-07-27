# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, Public: true
    can :read, Comment, Public: true

    return unless user.present?
    can :read, :all

    if user.role == "admin"
      can :manage, :all
    end
  end
end