class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :address, :city, :state, :email) #Strong Parameters
    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      flash[:notice] = 'Fornecedor cadastrado com sucesso.'
      redirect_to(suppliers_path)
    else
      flash.now[:notice] = 'Fornecedor não cadastrado.'
      render 'new'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :address, :city, :state, :email) #Strong Parameters

    if @supplier.update(supplier_params)
      flash[:notice] = 'Fornecedor atualizado com sucesso'
      redirect_to supplier_path(@supplier.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar o fornecedor'
      render 'edit'
    end
  end

end