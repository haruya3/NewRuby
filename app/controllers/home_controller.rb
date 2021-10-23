class HomeController < ApplicationController
    skip_before_action :authenticate_user!
    def top
    end

    def priporicy
    end
end

  