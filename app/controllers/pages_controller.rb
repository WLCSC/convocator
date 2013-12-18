class PagesController < ApplicationController
  def show
      @page = Page.friendly.find(params[:id])
  end

  def index
      @pages = Page.all
  end
end
