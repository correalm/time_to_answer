class AdminsBackoffice::AdminsController < AdminsBackofficeController
  # Sempre acontece antes da ação...
  before_action :password_verify, only: [:update]
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index      
    @admins = Admin.all.page(params[:page]).per(5)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador inserido com sucesso"
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @admin.update(params_admin)
      # Aqui configuro o envio do email -> Cuidar deliver_now (para a execução do código nesse momento)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador removido com sucesso"
    else
      render :index
    end
  end

  private
  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def password_verify
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

end
