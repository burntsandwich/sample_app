class SearchesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy, :edit, :update]

  def index
    @searches = current_user.searches
#	@query = "#{params[:query][:q1_term]}^#{params[:query][:q1_weight]}"
#  	solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
#  	@response = solr.get 'select', params: {q: @query}
  end

  def create
    @search = current_user.searches.build(params[:search])
    if @search.save
      flash[:success] = "Search created!"
      redirect_to(:back)
    else
      redirect_to(:back)
    end
  end

  def edit
  end

  def update
    if @search.update_attributes(params[:search])
      @keyweight = []
      @search.terms.each {|a| @keyweight.push(a.keyword + "^" + a.weight.to_s)}
      #Remove and [, ] or " characters and update the search field
      @search.update_attribute(:query, @keyweight.to_s.gsub(/(\[|\])/, '').delete('"'))
      flash[:success] = "Search updated"
      redirect_to(:back)
    else
      render 'edit'
    end
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
