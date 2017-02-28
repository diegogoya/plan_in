class Event < ApplicationRecord
	has_many :users, through: :registrations
	has_many :registrations

        has_many :tasks

        accepts_nested_attributes_for :tasks
end
