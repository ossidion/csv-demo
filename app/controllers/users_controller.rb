class UsersController < ApplicationController
  def index
    @users = User.all
    @import = User::Import.new

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}" }
    end
  end

  def import 
    @import = User::Import.new user_import_params
    if @import.save
      redirect_to users_path, notice: "Imported #{@import.imported_count} users"
    else
      @users = User.all
      render action: :index, notice: "There were errors with your csv file"
    # count = User.import params[:file]
    # redirect_to users_path, notice: "Imported #{count} users"
  end
end

  

    def user_import_params
      params.require(:user_import).permit(:file)
    end
end