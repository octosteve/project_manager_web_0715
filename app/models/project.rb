class Project < ActiveRecord::Base
  def done?
    !!(github_url && heroku_url)
  end
end
