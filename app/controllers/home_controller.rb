class HomeController < ApplicationController
    skip_before_action :authenticate_user!
    def top
    end

    def priporicy
    end

    def confirmable_wait
    end
end

  
