class SessionsController < ActionController::Base
  def new
  end
  def create
    ldap = Net::LDAP.new
    ldap.host = "ldap.cedar.uta.edu"
    ldap.port = 636
    ldap.base = 'cn=accounts, dc=uta, dc=edu'
    ldap.encryption(:simple_tls)
    ldap.auth "uid=#{params[:netid]},cn=Accounts,dc=uta,dc=edu", params[:password]
    if ldap.bind
      user ||= User.find_by_netid(params[:netid])
      user ||= User.create(netid: params[:netid])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      redirect_to root_url, :alert => "Invalid username or password!"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
