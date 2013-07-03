class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		set_feed_timescope
  		@query = "(#{current_user.searches.first.query}) AND LastMod:[#{session[:feed_timescope]} TO NOW]"
  		solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
  		@response = solr.get 'select', params: {q: @query}
	end
  end

  def help
  end

  def about
  end

  def contact
  end

end
