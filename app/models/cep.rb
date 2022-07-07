require 'net/http'
class CEP
  # não se conecta com o DB
  END_POINT = "https://viacep.com.br/ws"
  attr_reader :logradouro, :bairro, :localidade, :uf

  def initialize(cep)
    finded_cep = find_cep(cep)
    data_cep(finded_cep)
  end

  private

  def data_cep(cep)
    @logradouro = cep["logradouro"]
    @bairro = cep["bairro"]
    @localidade = cep["localidade"]
    @uf = cep["uf"]
  end

  def find_cep(cep)
    ActiveSupport::JSON.decode(
      Net::HTTP.get(
        URI("#{END_POINT}/#{cep}/json/")
      )
    )
  end
end