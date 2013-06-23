# == Schema Information
#
# Table name: searches
#
#  id         :integer         not null, primary key
#  query      :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  name       :string(255)
#

require 'spec_helper'

describe Search do
  
  let(:user) {FactoryGirl.create(:user)}
  before { @search = user.searches.build(query: "piano")}

  subject { @search }

  it { should respond_to(:query) }
  it { should respond_to(:user_id) }
  it {should respond_to(:user) }
  its(:user) { should == user }

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
  		expect do
  			Search.new(user_id: user.id)
		end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
	end
  end

  describe "when user_id is not present" do
  	before { @search.user_id = nil }
  	it { should_not be_valid }
  end
end
