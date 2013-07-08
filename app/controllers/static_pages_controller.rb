class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		#Need to implement catch for users with no saved searches.
  		set_feed_timescope
  		set_feed_query
  		@query = "(#{session[:feed_query]}) AND LastMod:[#{session[:feed_timescope]} TO NOW]"
  		solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
  		begin
  			@response = solr.get 'select', params: {q: @query}
		rescue StandardError => @bang
		end	
	end
  end

  def help
  end

  def about
  end

  def contact
  end

end
