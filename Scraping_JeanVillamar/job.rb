require 'csv'

class Job
    attr_accessor :titulo, :empresa, :categoria, :provincia, :salario, :tipo, :dias

  def initialize(titulo,empresa, categoria,provincia, salario, tipo, dias)
    @titulo = titulo
    @empresa = empresa
    @categoria = categoria
    @provincia = provincia
    @salario = salario
    @tipo = tipo
    @dias = dias
  end

  def guardar
    CSV.open('jobs_expertini.csv', 'a', col_sep: ';') do |csv|
      csv << [@titulo.to_s,@empresa.to_s,@categoria.to_s,@provincia.to_s,@salario.to_s, @tipo.to_s, @dias.to_s] 
    end
  end
end
    