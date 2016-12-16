class Amazon < Scraper
  @@mechanize = Mechanize.new do |mech|
    mech.user_agent_alias = 'Mac Safari'
  end

  def self.availability(title, year)
    search_url = 'https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dinstant-video&field-keywords=' + title + ' ' + year.to_s
    header_data = {
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding' => 'gzip, deflate, sdch, br',
        'Accept-Language' => 'en-US,en;q=0.8',
        'Cache-Control' => 'max-age=0',
        'Connection' => 'keep-alive',
        'Host' => 'www.amazon.com',
        'Upgrade-Insecure-Requests' => '1'
      }
    search_page = @@mechanize.get(search_url, header_data)
    if search_page.title == "Robot Check"
      availability = "Error"
    else 
      availability = Amazon.find_status(search_page.at_css('#s-results-list-atf > li'))

    end
    availability
  end

  def self.find_status(results)
    # .s-price means the title is available for instant streaming.
    # If there are no elements with .s-price, streaming available is nil
    streaming_available = results.at_css('.s-price')
    if streaming_available && streaming_available.text == "$0.00"
      return 'Streaming avaialbile with Prime Membership.'
    else
      return 'Free streaming not available.'
    end
  end
end