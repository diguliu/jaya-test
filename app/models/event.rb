class Event < ApplicationRecord
  belongs_to :issue
	validates :issue, :action, presence: { allow_blank: false }
end
