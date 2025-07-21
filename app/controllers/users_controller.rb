class UsersController < ApplicationController
  def index
    @users = User.all
    @import = User::Import.new
  end

  #   respond_to do |format|
  #     format.html
  #     format.csv { send_data @users.to_csv, filename: "users-#{Date.today}" }
  #   end
  # end
  
def import
  if params[:user_import].present?
    file = params[:user_import][:file]
    count = User.import(file)
    redirect_to users_path, notice: "Imported #{count} users"
  else
    redirect_to users_path, notice: "Please select a CSV file to upload."
  end
end

  

    def user_import_params
      params.require(:user_import).permit(:file)
    end
end