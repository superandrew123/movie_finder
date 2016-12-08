class Amazon < Scraper

  def self.availability(title, year)
    search_url = 'https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dinstant-video&field-keywords=' + title + ' ' + year.to_s
    search_page = @@mechanize.get(search_url)
    availability = Amazon.find_status(search_page.at_css('#s-results-list-atf > li'))
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