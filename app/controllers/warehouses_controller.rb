class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  def create
    # Aqui dentro nós vamos:
    # 1 - Receber os dados enviados no formulário
    # 2 - Criar um novo galpão no banco de dados
    warehouse_params = params.require(:warehouse).permit(:name, :description,
                                                        :code, :address, :city,
                                                        :state, :postal_code, :area)
    w = Warehouse.new(warehouse_params)
    w.save()
    # 3 - Redirecionar para a tela inicial
    redirect_to root_path
  end
end