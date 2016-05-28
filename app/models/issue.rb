class Issue < ActiveRecord::Base
  belongs_to :repository
  delegate :user, to: :repository
end
