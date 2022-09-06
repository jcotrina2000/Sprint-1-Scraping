require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv'
require 'date'

# require './prueba'
#require './ScrapingExpertini' 
#require './job'
 require_relative 'ScrapingExpertini'
 require_relative 'job'
# require_relative 'prueba'
# load './ScrapingExpertini.rb' load './job.rb'
CSV.open('Scraping_JeanVillamar/jobs_expertini.csv','wb', col_sep: ';') do |csv|
  csv << %w[titulo empresa categoria provincia salario tipo dias]
end
link = 'https://ec.expertini.com/jobs/search/developer-ecuador/'
datosHTML = URI.open(link)
datosStr = datosHTML.read
parsed_content = Nokogiri::HTML(datosStr)
contadorpag = 0
contenido2 = parsed_content.css('.w-pagination')

contenido2.css('.page-numbers').each do |_element|
  contadorpag += 1
end
contadorpag -= 2 # se le resta 2 dado que cuenta tambien los botones de siguiente y anterior

(1..10).each do |i| #(1..contadorpag).each do |i| por alguna razon a partir de la pestaña 11 comienzan a salir cargos que no tienen 
                    #relacion con developers por ello se tuvo que hacerlo de esta forma
  link = 'https://ec.expertini.com/jobs/search/developer-ecuador/?No=' + i.to_s
  
  objprub = ScrapingExpertini.new
  objprub.extraerDatosEtiquetas(link)
end
