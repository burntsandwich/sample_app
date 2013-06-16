class SearchesController < ApplicationController
  def new
  end

  def index
	@query = "#{params[:query][:q1_term]}^#{params[:query][:q1_weight]}"
  	solr = RSolr.connect url: 'http://localhost:8080/solr/TuneFeeder'
  	@response = solr.get 'select', params: {q: @query}
  end

end
