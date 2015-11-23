#class Admin::CategoriesController < ApplicationController #так как данный файл лежит в папке Admin
class Admin::CategoriesController < Admin::BaseController #т.к. мы вынесли общие вещи в basecontroller, то наследуемся от него 
before_action :set_category, only: [:edit, :update, :destroy]  
  
  def index
    @categories = Category.all
  end

  def show    
  end

   def new
    @category = Category.new 
  end

  def edit
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      redirect_to @category, notice: 'Категория создана'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Категория обновлена'
    else
      render :edit 
    end 
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Категория удалена'
  end


  private

  def set_category
    @category = Category.find(params[:id])
  end


  def category_params
    params.require(:category).permit(:body)
  end

end
