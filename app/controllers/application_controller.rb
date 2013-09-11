class ApplicationController < ActionController::Base
  before_filter :set_oauth_tokens

private

  def twitter_client
    Twitter::Client.new(
      oauth_token: @oauth_token,
      oauth_token_secret: @oauth_token_secret
    )
  end

  def set_oauth_tokens
    if session[:current_user_id]
      @oauth_token ||= current_user.oauth_token
      @oauth_token_secret ||= current_user.oauth_token_secret
    else
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= current_user_from_session
  end

  def current_user_from_session
    User.find(session[:current_user_id])
  end

  def cache_key(*fragments)
    common_fragments = [@oauth_token, params[:controller], params[:action]]
    logger.debug "Cache key: #{fragments.concat(common_fragments)}"
    common_fragments.concat(fragments)
  end

end
