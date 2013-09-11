class TimelinesController < ApplicationController
  def home
    @user   = cache(cache_key) { user_info }
    @tweets = cache(cache_key) { home_timeline }

    render "show"
  end

  def show
    @user   = cache(cache_key) { user_info }
    @tweets = cache(cache_key) { user_timeline(params[:id]) }
  end

  private
  def home_timeline
    twitter_client.home_timeline
  end

  def user_timeline(screen_name)
    twitter_client.user_timeline(screen_name)
  end

  def user_info
    cache(cache_key) { twitter_client.user }
  end
end

