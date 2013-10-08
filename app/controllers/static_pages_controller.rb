class StaticPagesController < ApplicationController
  before_filter :set_feed_timescope_default, only: :home
  before_filter :set_feed_search_default, only: :home

  def home
  	if signed_in? && session[:feed_search]
      @search_name = Search.find_by_id(session[:feed_search]).name
      query_from_db = current_user.searches.find_by_id(session[:feed_search]).query
  		@query = "(#{query_from_db}) AND LastMod:[#{session[:feed_timescope]} TO NOW]"
  		solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
		  @response = solr.paginate params[:page], 10, 'select', params: {q: @query}
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
