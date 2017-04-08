class ItemsController < ApplicationController
  before_action :find_item, except: [:index, :new, :create]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

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

  private
    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
