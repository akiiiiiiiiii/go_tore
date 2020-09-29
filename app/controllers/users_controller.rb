class UsersController < ApplicationController
  def index
    @user = current_user
    @search = User.ransack(params[:q])
    @users = @search.result.page(params[:page]).reverse_order.per(10)
  end

  def show
    @user = User.find(params[:id])

    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
    if @user.birthday.nil?
       @age = ''
    else
      @age = age(@user.birthday.to_date)
    end

    if @user.age.nil?
      unless @user.birthday.nil?
        @user.age = age(@user.birthday.to_date)
        @user.save
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    puts @user.errors.full_messages
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :birthday, :gender_id, :blood_type_id, :birthplace, :residence, :history, :homegym, :purpose, :good, :bad, :supplement, :status, :twitter, :instagram,:age)
  end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end

  def age(birthday)
    date_format = "%Y%m%d"
    "#{(Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000}"
  end
end
