class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all
    @parents = Category.all.order("id ASC").limit(1)
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to root_path
  end

  def show
    @products = Product.find(params[:id])
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
  end

  def edit
    @product = Product.find(params[:id])
    # gon.product = @product
    # gon.product_images = @product.product_images
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :description, :status,
    product_images_attributes: [:product_image, :id]).merge(seller_id: current_user.id)
  end

end

