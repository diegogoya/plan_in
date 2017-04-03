class Event < ApplicationRecord
    has_many :users, through: :registrations
    has_many :registrations

    has_many :tasks

    accepts_nested_attributes_for :tasks

    def get_creator
        self.registrations.find_by(role: "admin").user
    end
end
