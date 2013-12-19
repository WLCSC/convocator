class WelcomeController < ApplicationController
  def index
      p = Page.where(:name => 'special#home')
      if p.count > 0
          @content = p.first.body
      elsif option('blurb-home')
          @content = option('blurb-home')
      else
          @content = "The site admin doesn't have any information here."
      end

  end
end
