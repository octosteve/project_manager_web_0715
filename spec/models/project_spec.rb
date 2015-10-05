require 'rails_helper'

puts
RSpec.describe Project, type: :model do
  context "doneness" do
    it "is not done when no github_url or heroku_url" do
      project = Project.new
      expect(project.done?).to be false
    end

    it "is done when it has a github_url and heroku_url" do
      project = Project.new
      project.github_url = "http://github.com/StevenNunez/something_cool"
      project.heroku_url = "http://somethingcool.herokuapp.com"

      expect(project.done?).to be true
    end

    it "both have to be present" do
      project = Project.new
      project.github_url = "http://github.com/StevenNunez/something_cool"
      expect(project.done?).to be false

      project.github_url = nil
      project.heroku_url = "http://somethingcool.herokuapp.com"
      expect(project.done?).to be false
    end
  end

end
