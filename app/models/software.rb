class Software < ActiveRecord::Base
    belongs_to :user
    has_many :license
end
