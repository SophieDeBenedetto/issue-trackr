class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :issues

  include ActiveModel::Validations
  validates_with RepositoryValidator
  validates :url, uniqueness: true, presence: true, format: {with: /https:\/\/github.com/, message: "must be a valid github url"}
end
