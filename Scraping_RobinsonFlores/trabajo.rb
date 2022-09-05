require 'csv' #escribir y leer csv

class Trabajo
  # accessor get and set method
  attr_accessor :cargo, :ciudad, :empresa, :fechaPublicacion, :jornada, :horario
  
  def initialize(cargo, ciudad, empresa, fechaPublicacion, jornada, horario)
    @cargo = cargo
    @ciudad = ciudad
    @empresa = empresa
    @fechaPublicacion = fechaPublicacion
    @jornada = jornada
    @horario = horario
  end
  def guardar
    CSV.open('jobs_opcionempleo.csv', 'a',col_sep: ';') do |csv|
      csv << [@cargo.to_s, @ciudad.to_s, @empresa.to_s, @fechaPublicacion.to_s, @jornada.to_s,@horario.to_s ]
    end
  end 
end

  