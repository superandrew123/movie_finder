class Netflix
  @@mechanize = Mechanize.new do |mech|
    mech.user_agent_alias = 'Mac Safari'
  end

  def self.availability(title)
    home_page = @@mechanize.get("http://www.netflix.com")
    if home_page.at('a.authLinks') != nil
      Netflix.login
    end
    # binding.pry
  end

  def self.login
    login_page = @@mechanize.get("http://www.netflix.com/Login")
    login_form = login_page.forms[0]

    email_field = login_form.fields.select {|field| field.name == 'email'}[0]
    pw_field = login_form.fields.select {|field| field.name == 'password'}[0]

    email_field.value = Rails.application.secrets.netflix_email
    pw_field.value = Rails.application.secrets.netflix_pw
    

    binding.pry
  end
end