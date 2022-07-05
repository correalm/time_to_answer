class AdminsBackoffice::WelcomeController < AdminsBackofficeController 
  def index
    # Posso fazer a pesquisa pelo nome do campo na tabela, nesse caso, event
    @total_questions = AdminStatistic.total_questions
    @total_users = AdminStatistic.total_users
  end
end
