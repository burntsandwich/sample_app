class Search < ActiveRecord::Base
  attr_accessible :query
  belongs_to :user 

  validates :user_id, presence: true
  default_scope order: 'searches.created_at ASC'
end
