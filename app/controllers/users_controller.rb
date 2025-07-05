class UsersController < ApplicationController
  def index
    @users = User.all
    # @import = User::Import.new

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end

  def import 
    count = User.import params[:file]
    redirect_to users_path, notice: "Imported #{count} users"
  end
end