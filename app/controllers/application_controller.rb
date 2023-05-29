# frozen_string_literal: true

class ApplicationController < ActionController::Base
def default_url_options
   { locale: set_locale }
end

private def set_locale
  params[:locale] || I18n.default_locale
end
end
