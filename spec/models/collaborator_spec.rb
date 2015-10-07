require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  context "Validations" do
    it "must have a name" do
      collaborator = Collaborator.new
      collaborator.valid?
      expect(collaborator.errors[:name]).to eq( ["can't be blank"])
    end

    it "must have a github_username" do
      collaborator = Collaborator.new
      collaborator.valid?
      expect(collaborator.errors[:github_username]).to eq( ["can't be blank"])
    end

    it "github_username must be unique" do
      steven = Collaborator.create(name: "Steven Nunez", github_username: "StevenNunez")
      steven_again = Collaborator.new(github_username: "StevenNunez")
      steven_again.valid?
      expect(steven_again.errors[:github_username]).to eq(["has already been taken"])
    end
  end

  context " getting users from github" do
    it "finds an existing user from the database" do
      steven = Collaborator.create(name: "Steven Nunez", github_username: "StevenNunez")
      steven_from_db = Collaborator.from_github_username('StevenNunez')
      expect(steven).to eq(steven_from_db)
    end

    it "fetches user's information from github if not found" do
      avi = double("Avi", name: "Avi Flombaum", login: "aviflombaum")
      expect(GithubUser).
          to receive(:from_username).
          with("aviflombaum").
          and_return(avi)

      avi = Collaborator.from_github_username('aviflombaum')
      expect(avi.name).to eq('Avi Flombaum')
    end
  end
end
