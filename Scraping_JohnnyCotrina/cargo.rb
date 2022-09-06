class Ocupacion
  attr_accessor :nombre_cargo, :ciudad, :años_experiencia, :requisitos

  def initialize(nombre_cargo, ciudad, años_experiencia, requisitos)
    @nombre_cargo = nombre_cargo
    @ciudad = ciudad
    @años_experiencia = años_experiencia
    @requisitos = requisitos
  end

  def toString()
    puts "Nombre = "+ @nombre_cargo.to_s + ' ,' + "Ciudad = " + @ciudad.to_s.strip + ' ,' +'Años de experiencia = ' + @años_experiencia + ' ,' + 'Lista requisitos = ' + @requisitos + "\n "
  end  
  
  def guardar(nombre_archivo)
    CSV.open(nombre_archivo,'a', col_sep: '|') do |csvw|
      csvw << [@nombre_cargo.to_s, @ciudad.to_s.strip, @años_experiencia.to_s, @requisitos.to_s.strip]
    end
  end 
end