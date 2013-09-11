class TimelinesController < ApplicationController
  def home
    @user   = cache(cache_key("user")) { user_info }
    @tweets = cache(cache_key("tweets")) { home_timeline }

    render "show"
  end

  def show
    @user   = cache(cache_key("user")) { user_info }
    @tweets = cache(cache_key("tweets", params[:id])) { user_timeline(params[:id]) }
  end

  private
  def home_timeline
    twitter_client.home_timeline
  end

  def user_timeline(screen_name)
    twitter_client.user_timeline(screen_name)
  end

  def user_info
    twitter_client.user
  end
end

