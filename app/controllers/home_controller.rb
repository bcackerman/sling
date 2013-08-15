class HomeController < ApplicationController
  def index
    @clips_count = Rails.cache.fetch('home-clip-count', expires_in: 12.hours) {Clip.count}
  end

  def about
  end

  def contact
  end
end
