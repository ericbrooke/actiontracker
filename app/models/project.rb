class Project < ActiveRecord::Base
	has_many :actions, dependent: :destroy
	
  validates :name, presence: true
end
