class SearchesController < ApplicationController
  before_filter :signed_in_user

  def new
  end

  def index
	@query = "#{params[:query][:q1_term]}^#{params[:query][:q1_weight]}"
  	solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
  	@response = solr.get 'select', params: {q: @query}
  end

  def show
  end
  
  def create
  	@search = current_user.microposts.build(params[:search])
  	if @search.save
  		flash[:success] = "Search saved"
  		redirect_to root_path
	else
		render 'static_pages/home'
	end
  end

  def destroy
  end	
end
