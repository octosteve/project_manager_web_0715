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

    it "is invalid if not a valid heroku url" do
      project = Project.new
      project.heroku_url = "http://shirts.com"
      project.valid?
      expect(project.errors[:heroku_url]).to eq(["http://shirts.com is not a valid heroku url"])
    end

    it "is valid if a valid heroku url" do
      project = Project.new
      project.heroku_url = "http://pants.herokuapp.com"
      project.valid?
      expect(project.errors[:heroku_url]).to eq([])
    end

    it "is valid if it has at least 2 collaborators" do
      project = Project.new
      bob = Collaborator.create(name: "Bob Nadler", github_username: "BobNadler")
      steven = Collaborator.create(name: "Steven Nunez", github_username: "StevenNunez")
      project.collaborators << bob
      project.collaborators << steven
      project.valid?

      expect(project.errors[:collaborators]).to be_empty
    end

    it "is invalid if it has less than 2 collaborators" do
      project = Project.new
      bob = Collaborator.create(name: "Bob Nadler", github_username: "BobNadler")
      project.collaborators << bob
      project.valid?

      expect(project.errors[:collaborators]).to eq(["you need more people"])
    end
    it "is invalid if it has more than 4 collaborators" do
      project = Project.new
      bob = Collaborator.create(name: "Bob Nadler", github_username: "BobNadler")
      steven = Collaborator.create(name: "Steven Nunez", github_username: "StevenNunez")
      bob1 = Collaborator.create(name: "Bob Nadler", github_username: "BobNadler1")
      steven1 = Collaborator.create(name: "Steven Nunez", github_username: "StevenNunez1")
      josh = Collaborator.create(name: "Josh Owens", github_username: "joshuabamboo")

      project.collaborators << bob
      project.collaborators << steven
      project.collaborators << bob1
      project.collaborators << steven1
      project.collaborators << josh
      project.valid?

      expect(project.errors[:collaborators]).to eq(["you have too many people"])
    end
  end

end
