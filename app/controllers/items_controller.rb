class ItemsController < ApplicationController
  before_action :find_item, except: [:index, :new, :create]

  def index
    if user_signed_in?
      @items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      flash[:notice] = "Tarea creada"
      redirect_to root_path
    else
      flash[:alert] = "La tarea no pudo ser creada"
      render 'new'
    end
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Tarea actualizada"
      redirect_to @item
    else
      flash[:alert] = "La tarea no pudo ser actualizada"
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "Tarea eliminada"
    redirect_to root_path
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end

  private
    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
