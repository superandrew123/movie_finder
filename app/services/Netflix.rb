class Netflix
  @@mechanize = Mechanize.new do |mech|
    mech.user_agent_alias = 'Mac Safari'
  end

  def self.availability(title)
    page = @@mechanize.get("https://www.netflix.com")
    if page.at('a.authLinks') != nil
      Netflix.login(page)
    end
    Netflix.search(title)
  end

  private
    def self.search(title)
      search_url = 'https://www.netflix.com/search?q=' + title
      search_page = @@mechanize.get(search_url)
      html = Nokogiri::HTML(search_page.body)

      # If it is available for streaming, it will show in 'div.smallTitleCard'
      title_cards = html.css('.galleryContent .smallTitleCard')
      title_cards.each do |card|
        if title == card.attributes['aria-label'].value
          return 'Streaming available!'
        end
      end

      # If it is available on DVD, it will show up in 
      suggestions = html.css('div.suggestions li a')
      suggestions.each do |suggestion|
        if title == suggestion.text
          return 'Disk available, no streaming.'
        end
      end

      # Big nope from Netflix
      return "Netflix didn't find it."
    end
    def self.login(page)
      login_page = @@mechanize.click(page.at('a.authLinks'))
      login_form = login_page.forms[0]

      login_data = {
        email: Rails.application.secrets.netflix_email,
        password: Rails.application.secrets.netflix_pw,
        authURL: login_form.field_with(name: 'authURL').value,
        showState: 'hide',
        rememberMe: 'true',
        flow: 'websiteSignUp',
        mode: 'login',
        action: 'loginAction',
        withFields: 'email,password,rememberMe,nextPage'
      }

      header_data = {
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding' => 'gzip, deflate, br',
        'Accept-Language' => 'en-US,en;q=0.8',
        'Cache-Control' => 'max-age=0',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Content-Length' => '246',
        'Connection' => 'keep-alive',
        'Host' => 'www.netflix.com',
        'Origin' => 'https://www.netflix.com',
        'Referer' => 'https://www.netflix.com/Login',
        'Upgrade-Insecure-Requests' => '1'
      }

      @@mechanize.post("https://www.netflix.com/Login", login_data, header_data)
    end
end