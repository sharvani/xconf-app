class SamlController
  def auth
    auth = request.env['omniauth.auth']
    session[:user_id] = auth[:uid]
    redirect to(params[:RelayState] || '/')
  end
end