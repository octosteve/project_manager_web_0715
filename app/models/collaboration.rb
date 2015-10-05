class Collaboration < ActiveRecord::Base
  belongs_to :collaborator
  belongs_to :project
end
