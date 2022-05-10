class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    # Aqui dentro nós vamos:
    # 1 - Receber os dados enviados no formulário
    # 2 - Criar um novo galpão no banco de dados
    warehouse_params = params.require(:warehouse).permit(:name, :description,
                                                        :code, :address, :city,
                                                        :state, :postal_code, :area)  # Strong Parameters
    @warehouse = Warehouse.new(warehouse_params)

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

  def edit
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def update
    id = params[:id]
    @warehouse = Warehouse.find(id)
    warehouse_params = params.require(:warehouse).permit(:name, :description,
                                                         :code, :address, :city,
                                                         :state, :postal_code, :area)  # Strong Parameters

    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso'
      redirect_to warehouse_path(@warehouse.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão'
      render 'edit'
    end
  end

end