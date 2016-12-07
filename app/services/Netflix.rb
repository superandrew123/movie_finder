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
      binding.pry

    end
    def self.login(page)
      login_page = @@mechanize.click(page.at('a.authLinks'))
      login_form = login_page.forms[0]

      login_form.field_with(name: 'email').value = Rails.application.secrets.netflix_email
      login_form.field_with(name: 'password').value = Rails.application.secrets.netflix_pw

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