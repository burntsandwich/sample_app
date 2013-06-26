module SearchesHelper

  def terms_to_query(terms)
    #Accepts an array of terms and concatenates them into a single query string. Outputs query_build string.
    @query_build = []
    terms.each {|a| @query_build.push(a.keyword + "^" + a.weight.to_s)}
  end

  def query_cleaner(query)
    #Remove and [, ] or " characters and update the search field
    @clean_query = query.to_s.gsub(/(\[|\])/, '').delete('"')
  end

end
