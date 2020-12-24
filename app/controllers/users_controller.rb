class UsersController < ApplicationController
  def show
    @favorites = current_user.favorites
    @articles = []
    @favorites.each do |favorite|
      @articles << favorite.article
    end
  end
end
