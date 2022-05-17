class ProductModelsController < ApplicationController
  before_action :set_product_model, only: [:show, :edit, :update]

  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    get_suppliers_alphabetically()
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save()
      flash[:notice] = 'Modelo de produto cadastrado com sucesso'
      redirect_to @product_model  # Quando a instancia do model (objeto) é passada em vez da rota/URL, o rails inerpreta e busca a rota :SHOW daquele objeto.
    else
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto'
      get_suppliers_alphabetically()
      render :new
    end

  end

  def show
    
  end
  
  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :length, :width, :height, :sku, :supplier_id)
  end

  def get_suppliers_alphabetically
    @suppliers_by_name = Supplier.all.order(:brand_name)
  end
end