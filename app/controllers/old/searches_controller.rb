class SearchesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
  	@search = current_user.searches.build if signed_in?
  end

  def index
    @searches = current_user.searches

#	@query = "#{params[:query][:q1_term]}^#{params[:query][:q1_weight]}"
#  	solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
#  	@response = solr.get 'select', params: {q: @query}
  end

  def show
    @user=current_user
  end

  def create
  end

  def edit
  end


  def destroy
  	@search.destroy
  	redirect_to(:back)
  end	

  private
  	def correct_user
  		@search = current_user.searches.find_by_id(params[:id])
  		redirect_to root_path if @search.nil?
	end
end
