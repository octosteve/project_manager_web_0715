class Collaborator < ActiveRecord::Base
  validates :name, :github_username, presence: true
  validates :github_username, uniqueness: true
  has_many :collaborations
  has_many :projects, through: :collaborations

  def self.from_github_username(github_username)
    user = find_by(github_username: github_username)
    return user if user

    gh_user = GithubUser.from_username(github_username)
    create!(name: gh_user.name, github_username: gh_user.login)
  end
end
