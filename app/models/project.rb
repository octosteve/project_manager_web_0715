class Project < ActiveRecord::Base
  GITHUB_URL_PATTERN = "http://github.com/.*"
  validates :name, presence: true
  validates :github_url, format: { with: /\A#{GITHUB_URL_PATTERN}\z/,
                          message: "%{value} is not a valid github url" }
  def done?
    !!(github_url && heroku_url)
  end
end
