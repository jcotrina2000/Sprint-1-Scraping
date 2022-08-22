require 'csv' #escribir y leer csv

class Trabajo
  # accessor get and set method
  attr_accessor :cargo, :ciudad, :empresa, :fechaPublicacion
  def initialize(cargo, ciudad, empresa, fechaPublicacion)
    @cargo = cargo
    @ciudad = ciudad
    @empresa = empresa
    @fechaPublicacion = fechaPublicacion
  end
  def guardar
    CSV.open('jobs_opcionempleo.csv', 'a',col_sep: ';') do |csv|
      csv << [@cargo.to_s, @ciudad.to_s, @empresa.to_s, @fechaPublicacion.to_s]
    end
  end 
end

  