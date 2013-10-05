class SearchesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_search, only: [:destroy, :edit, :update, :update_j]

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
    solr = RSolr::Ext.connect url: 'http://localhost:8080/solr/TuneFeeder'
    solrparams = {queries: '*:*', rows: 0, facets: {fields: 'ftext'} }
    
    @terms = @search.terms

    #Build the full list of used keywords from the database
    @keywords = []
    @search.terms.each do |term|
      if term.keyword[0] == "-"
        @keywords << term.keyword[1..-1]
      else
        @keywords << term.keyword
      end
    end

    #Build a stopword list to filter out words that got through the Solr stopword list
    @stopwords = []
    File.open("#{Rails.root}/config/stopwords_additionalforrails.txt").each do |line|
      @stopwords << line.strip
    end

    #Build a list of recommended keywords, excluding stopwords and keywords that are already in use
    @recommendations = []
    @response = solr.find solrparams
    @response.facets.each do |facet|
      facet.items.each do |item|
        if @stopwords.exclude?("#{item.value.to_s.gsub(/\W/, "")}") and @keywords.exclude?("#{item.value.to_s}")
          @recommendations << item.value
        end
      end
    end  
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

  def update_j
    #Update terms db with new 'green' terms
    terms_in = JSON.parse(params[:keywords_in_to_db])
    terms_blacklist = JSON.parse(params[:keywords_blacklist_to_db])

    terms_in.each do |x|
      Term.where(search_id: @search, keyword: x).first_or_create(weight: 1)
    end

    #Update terms db with new blacklisted terms
    terms_blacklist.each do |x|
      Term.where(search_id: @search, keyword: x).first_or_create(weight: 1)
    end

    #Remove any terms from db that have been dragged out

    
    render :nothing => true
  end


  def destroy
  	@search.destroy
  	redirect_to(:back)
  end	

  private
  	def correct_search
  		@search = current_user.searches.find_by_id(params[:id])
  		redirect_to root_path if @search.nil?
	  end

end
