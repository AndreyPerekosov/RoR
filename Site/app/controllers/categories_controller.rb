class CategoriesController < ApplicationController
  
  def show
  @category = Category.find(params[:id])
  @posts = @category.posts #загружаем список всех постов для данной категории
   render 'posts/published' #рендерим вид для постов, т. к. по заданию до кликанию на категории должны
  # отоброжаться посты. Так делать может т.к. в 'posts/index' передается @posts, а сейас в ней только
  # посты для данной категории. 
  end

 end