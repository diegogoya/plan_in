class Task < ApplicationRecord
	belongs_to :event
	has_many :choices
end
