class AboutController < ApplicationController
  def index
      p = Page.where(:name => 'special#about')
      if p.count > 0
          @content = p.first.body
      elsif option('blurb-about')
          @content = option('blurb-about')
      else
          @content = "The site admin doesn't have any information here."
      end
  end

  def presenters
      @presenters = Presenter.where(:public => true)
  end

  def presenter
    @presenter = Presenter.friendly.find(params[:id])
  end

  def organizers
      @organizers = Organizer.where(:public => true)
  end

  def organizer
    @organizer = Organizer.friendly.find(params[:id])
  end
end
