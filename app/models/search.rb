class Search < ActiveRecord::Base
  attr_accessible :query
  belongs_to :user
  has_many :query_generators
  has_many :terms, :through => :query_generators

  validates :user_id, presence: true
  validates :query, presence: true
  default_scope order: 'searches.created_at ASC'
end
