class OMDB
  def self.get_poster(search_term)
    url = 'https://www.omdbapi.com/'
    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get('/',{t: search_term, r: 'json'})
    body = JSON.parse(response.body)
    if body['Poster'] == "N/A" 
      return nil
    else
      return body['Poster']
    end
  end
end