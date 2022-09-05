require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv

require './cargo'
require './ScraperComputrabajo'

urlComputrabajo = 'https://ec.computrabajo.com/trabajo-de-developer'

scraper = ScraperComputrabajo.new
caracter = '?p='

CSV.open('cargos.csv','wb', col_sep: '|') do |csv|
  csv << %w[cargo ciudad años_experiencia requisitos]
end

for i in 1..6
   if i == 1 then
      scraper.extraerDatos(urlComputrabajo)
   else
     scraper.extraerDatos(urlComputrabajo+caracter+i.to_s)
   end
end
