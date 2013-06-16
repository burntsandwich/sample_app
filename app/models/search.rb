class Search < ActiveRecord::Base
  attr_accessible :query
  belongs_to :user 

  validates :user_id, presence: true
  validates :query, presence: true, length: {minimum: 3}
  default_scope order: 'searches.created_at ASC'
end
