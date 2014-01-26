class Project < ActiveRecord::Base
	has_many :actions, dependent :delete_all
	
  validates :name, presence: true
end
