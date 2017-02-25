class Event < ApplicationRecord
	belongs_to :user
	has_many :users, through: :user_events
	has_many :user_events

        has_many :tasks

        accepts_nested_attributes_for :tasks
end
