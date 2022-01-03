class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:new, :edit, :delete] 
  def index
    @prototypes = Prototype.all
  end
  def new
    @prototype = Prototype.new
  end
  #def create
  #  if Prototype.create(prototype_params)
  #    redirect_to root_path
  #  else
  #    render :new
  #  end
  #end

  #上記記述では失敗時に上手くいかず、下記表記で成功。
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
