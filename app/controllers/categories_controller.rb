# frozen_string_literal: true

class CategoriesController < InheritedResources::Base
  def index
    @category = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
