class Amazon < Scraper

  def self.availability(title)
    search_url = 'https://www.amazon.com/s/ref=sr_rot_p_n_ways_to_watch_2?fst=as%3Aoff&rh=n%3A2858778011%2Ck%3Astar+trek%2Cp_n_ways_to_watch%3A12007865011&bbn=2858778011&keywords=' + title + '&ie=UTF8&qid=1481153572&rnid=12007862011'
    search_page = @@mechanize.get(search_url)
    availability = search_page.at_css('.a-size-small.a-color-base').text
    binding.pry
  end

end