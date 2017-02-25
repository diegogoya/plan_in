class Registration < ActiveRecord::Base
	belongs_to :event, required: false
	belongs_to :user, required: false

	enum role: { participant: 0, admin: 1}
end
