class UsersController < ApplicationController
    before_action :find_user, only: [:update,:pass_update]

    def new
        @user = User.new
    end

    def create 
        @user = User.new user_params
        if @user.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @user = current_user
        # params[:id] == @user.id
    end

    def update
        if current_user.update user_params
            redirect_to root_path
        else
            render :edit
        end
    end

   
    def pass_edit
        @user = current_user
    end

    def pass_update
        # if current_user&.authenticate(params[:current_password])
        if current_user&.authenticate pass_params
            if params[:current_user] != current_user.password
                render edit_user_password_path, alert: "invalid password"
            
            elsif params[:new_password] == params[:current_user]
                render edit_user_password_path, alert: "new password can't be same as current password"
            elsif params[:new_password] != params[:password_confirmation]
                render edit_user_password_path, alert: "password confirmaion is wrong"
            else password.update 
                current_user.password == params[:new_password]
                render edit_user_path(current_user)
        
             end
            end
       
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def pass_params
        params.require(:user).permit(:name, :email, :current_password, :new_password, :password_confirmation)
    end
end
