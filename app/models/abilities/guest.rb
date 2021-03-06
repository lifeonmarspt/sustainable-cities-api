# frozen_string_literal: true
module Abilities
  class Guest
    include CanCan::Ability

    def initialize(user=nil)
      can    :read, :all
      cannot :read, ::Project, project_type: 'BusinessModel'
      cannot :read, ::Comment
    end
  end
end
