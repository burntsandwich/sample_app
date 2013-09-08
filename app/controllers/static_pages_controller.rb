class StaticPagesController < ApplicationController
  before_filter :set_feed_timescope_default, only: :home
  before_filter :set_feed_search_default, only: :home

  def home
  	if signed_in?
  		@query = "(#{session[:feed_query]}) AND LastMod:[#{session[:feed_timescope]} TO NOW]"
  		solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
      autolog format: :taw
		@response = solr.paginate params[:page], 10, 'select', params: {q: @query}
    autolog :off
	end
  end

  def help
  end

  def about
  end

  def contact
  end

end
