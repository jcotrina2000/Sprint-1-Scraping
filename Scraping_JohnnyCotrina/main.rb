require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv

require './cargo'
require './ScraperComputrabajo'

urlDesarrollador = 'https://ec.computrabajo.com/trabajo-de-desarrollador'

scraper = ScraperComputrabajo.new
caracter = '?p='

CSV.open('cargos.csv','wb', col_sep: '|') do |csv|
  csv << %w[cargo ciudad años_experiencia requisitos]
end

for i in 1..9
  if i == 1 then
     scraper.extraerDatos(urlDesarrollador)
  else
    scraper.extraerDatos(urlDesarrollador+caracter+i.to_s)
  end
end
