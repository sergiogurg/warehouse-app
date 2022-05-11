class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, :registration_name, :address, :city, :state, :email) #Strong Parameters
    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      flash[:notice] = 'Fornecedor cadastrado com sucesso.'
      redirect_to(suppliers_path)
    else
      flash.now[:notice] = 'Fornecedor não cadastrado'
      render :new
    end
    
  end

end