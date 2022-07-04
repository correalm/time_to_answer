class Site::SearchController < SiteController
  def questions
    # O % % é o carctere curinga do Active Record do Rails
    # é preciso cuidar que o like pode acabar levando a problemas de performance. Implementa uma pesquisa linha a linha
    @questions = Question.search(params)
  end
end
