class Feed < ActiveRecord::Base
  has_many :posts
end
