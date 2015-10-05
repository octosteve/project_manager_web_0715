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

  context "validations" do
    it "requires a name" do
      project = Project.new
      expect(project.valid?).to be false
      expect(project.errors[:name]).to eq(["can't be blank"])
    end

    it "is invalid if not a valid github url" do
      project = Project.new
      project.github_url = "http://pants.com"
      project.valid?
      expect(project.errors[:github_url]).to eq(["http://pants.com is not a valid github url"])
    end

    it "is valid if a valid github url" do
      project = Project.new
      project.github_url = "http://github.com/StevenNunez/slide_hero"
      project.valid?
      expect(project.errors[:github_url]).to eq([])
    end
  end

end
