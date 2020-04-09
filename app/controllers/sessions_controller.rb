class SessionsController < ApplicationController
  skip_before_action :login_required
  def new
  end

  def create
    user = User.find_by(email: session_params[:email] )

    if user&.authenticate(session_params[:password] )
      # わかってあえてやっているのであれば問題ないのですが(公開されない前提で)、
      # sessionで管理するこのやり方だとセキュリティ的に危険なので
      # ライブラリ使うようにした方が良いです
      session[:user_id] = user.id
      redirect_to root_url, notice: 'logged'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'logouted'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
