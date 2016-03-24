class Admin::UsersController < Admin::AdminController

  def index
    @group_user_by_team = User.all.group_by { |user| user.team }
  end

  def to_admin
    @user = User.find(params[:id])

    if @user != current_user
      @user.to_admin!
    else
      flash[:danger] = "目前系統不支援修改自己權限。"
    end

    redirect_to admin_users_path
  end

  def to_normal
    @user = User.find(params[:id])

    if @user != current_user
      if @user.email == "shrimptrain@hotmail.com"
        flash[:danger] = "誰都別想修改我的權限。 by 火車"
      else
        @user.to_normal!
      end
    else
      flash[:danger] = "目前系統不支援修改自己權限。"
    end

    redirect_to admin_users_path
  end

end
