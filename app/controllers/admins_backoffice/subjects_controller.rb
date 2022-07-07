class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  # Sempre acontece antes da ação...
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { @subjects = Subject.all.order(:description).page(params[:page]).per(15) }
      format.pdf  { @subjects = Subject.all.order(:description) }
      
      # preciso colocar entre parenteses para que ele primeiro resolva subjects para depois seguir a execução
      # except -> digo quais parâmetros não serão passados
      #format.json { render json: (@subjects = Subject.all.order(:description)), except: [:created_at, :updated_at] }
      
      # manda para o JBuilder -> precisa ter uma view com o mesmo nome da action
      format.json { @subjects = Subject.all.order(:description) }
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params_subject)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Assunto inserido com sucesso"
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @subject.update(params_subject)
      redirect_to admins_backoffice_subjects_path, notice: "Assunto atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto removido com sucesso"
    else
      render :index
    end
  end

  private
  def params_subject
    params.require(:subject).permit(:description)
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end
end
