class RepositoryValidator < ActiveModel::Validator
  def validate(record)
    unless record.user.github_username == record.url.split("/")[-2]
      record.errors[:ownership] << 'you must be the owner of this repo in order to add it'
    end
  end
end
 