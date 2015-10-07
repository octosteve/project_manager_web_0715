class Collaborator < ActiveRecord::Base
  validates :name, :github_username, presence: true
  validates :github_username, uniqueness: true
  has_many :collaborations
  has_many :projects, through: :collaborations

  def self.from_github_username(github_username)
    user = find_by(github_username: github_username)
    if user
      user
    else
      gh_user = JSON.parse(RestClient.get("https://api.github.com/users/#{github_username}"))
      create!(name: gh_user["name"], github_username: github_username)
    end
  end
end
