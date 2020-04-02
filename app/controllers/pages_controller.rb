# frozen_string_literal: true

class PagesController < ApplicationController
  def about
    @pages = Page.all.first
  end
end
