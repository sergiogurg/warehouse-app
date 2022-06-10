class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
  
  def show
    @stocks = @warehouse.stock_products.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    # Aqui dentro nós vamos:
    # 1 - Receber os dados enviados no formulário
    # 2 - Criar um novo galpão no banco de dados
    @warehouse = Warehouse.new(warehouse_params())

    if @warehouse.save()
      # 3 - Utilizar flash messages
      flash[:notice] = 'Galpão cadastrado com sucesso.'
      # 4 - Redirecionar para a tela inicial
      redirect_to root_path   # redirect_to dispara uma NOVA requisição do tipo GET
    else
      # 3 - Utilizar o método .now das flash messages (que só aparece na requisição atual e se perde na próxima)
      flash.now[:notice] = 'Galpão não cadastrado.'
      # 4 - Redirecionar para a mesma tela do formulário
      render :new   # render NÃO dispara uma nova requisição; ela continua na requisição atual (no caso, na action create, na warehouses_path) e só faz buscar e imprimir a página passada como parâmetro (no caso, a página gerada pela view new.html.erb)
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params())
      flash[:notice] = 'Galpão atualizado com sucesso'
      redirect_to warehouse_path(@warehouse.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão'
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    flash[:notice] = 'Galpão removido com sucesso'
    redirect_to root_path
  end


  private


  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :description,
                                                         :code, :address, :city,
                                                         :state, :postal_code, :area)  # Strong Parameters
  end

end