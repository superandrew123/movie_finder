class Scraper
  @@mechanize = Mechanize.new do |mech|
    mech.user_agent_alias = 'Mac Safari'
  end
end