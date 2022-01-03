class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
    # 下記記述ではUserIDでPrototypeのIDを検索してしまうのでNG
    # @prototypes = Prototype.find(params[:id])
  end
end
