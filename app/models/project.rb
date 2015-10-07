class Project < ActiveRecord::Base
  GITHUB_URL_PATTERN = "http://github.com/.*"
  HEROKU_URL_PATTERN = "http://.*\.herokuapp.com/"
  validates :name, presence: true
  validates :github_url, format: { with: /\A#{GITHUB_URL_PATTERN}\z/,
                          message: "%{value} is not a valid github url" }
  validates :heroku_url, format: { with: /\A#{HEROKU_URL_PATTERN}?\z/,
                          message: "%{value} is not a valid heroku url" }
  validates :collaborators, length: {minimum: 2,
                            maximum: 4,
                            too_short: "you need more people",
                            too_long: "you have too many people"}
  has_many :collaborations
  has_many :collaborators, through: :collaborations

  def done?
    !!(github_url && heroku_url)
  end
end
