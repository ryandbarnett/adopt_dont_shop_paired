class ApplicationController < ActionController::Base
  helper_method :favorites

  def favorites
   @favorites ||= Favorites.new(session[:favorites])
 end
end
