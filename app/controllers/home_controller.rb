class HomeController < ApplicationController
    def index
        redirect_to new_user_session_path, notice: "Login to continue"
    end
end
