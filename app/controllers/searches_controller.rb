class SearchesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy, :edit, :update]

  def create
    @search = current_user.searches.build(params[:search])
    if @search.save
      flash[:success] = "Search created"
      redirect_to(:back)
    else
      redirect_to(:back)
    end
  end

  def edit
  end

  def update
    if @search.update_attributes(params[:search])
      terms_to_query(@search.terms)
      query_cleaner(@query_build)
      @search.update_attribute(:query, @clean_query)
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
