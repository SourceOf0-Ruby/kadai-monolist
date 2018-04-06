class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id]);
  end

  def new
    @user = User.new;
  end

  def create
    @user = User.new(user_params);
    
    if @user.save
      # ユーザ作成と同時にログイン状態にする
      # session[:user_id] = @user.id;
      
      flash[:success] = 'ユーザを登録しました。';
      redirect_to @user;
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。';
      render :new;
    end
  end
  
  
  private
  
  # Strong Paramter
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation);
  end
  
end
