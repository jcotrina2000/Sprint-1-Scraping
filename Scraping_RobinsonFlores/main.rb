puts " Scraper opcionempleo.ec  \u{1f3ac}"

require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv
require_relative 'trabajo'
CSV.open('jobs_opcionempleo.csv','wb', col_sep: ';') do |csv|
    csv << %w[Cargo Ciudad Empresa Fecha_publicacion]
end
#para busqueda como desarrolador
link ='https://www.opcionempleo.ec/empleo-desarrollador.html'
cabeceraLink ='https://www.opcionempleo.ec/empleo-desarrollador.html'
nPagText = '?p='#parsed_content.css('.more').css('a').attr('href')
npag = 2 

while (npag<=12) 
  #siguiente = parsed_content.css('.more').css('a').attr('href')
  datosHTML = URI.open(link,'User-Agent' => 'firefox')
  datosStr = datosHTML.read
  parsed_content = Nokogiri::HTML(datosStr)
  jobsContainer = parsed_content.css('.jobs')
  jobsContainer.css('.job').each do |job|
    cargo = job.css('a').attr('title').inner_text.strip
    ciudad = job.css('.location').css('li').inner_text.split(",", 2)[0].strip
    empresa = job.css('.company').inner_text.strip
    fechaPublicacion = job.css('.badge').inner_text.strip
    trabajo = Trabajo.new(cargo, ciudad, empresa, fechaPublicacion)
    trabajo.guardar
  end
  nPagText = '?p='+npag.to_s
  link = cabeceraLink+nPagText
  puts link
  npag+=1
end 

#para busqueda como developer 
link ='https://www.opcionempleo.ec/empleo-developer.html'
cabeceraLink ='https://www.opcionempleo.ec/empleo-developer.html'
nPagText = '?p='#parsed_content.css('.more').css('a').attr('href')
npag = 2 

while (npag<=4) 
  #siguiente = parsed_content.css('.more').css('a').attr('href')
  datosHTML = URI.open(link,'User-Agent' => 'firefox')
  datosStr = datosHTML.read
  parsed_content = Nokogiri::HTML(datosStr)
  jobsContainer = parsed_content.css('.jobs')
  jobsContainer.css('.job').each do |job|
    cargo = job.css('a').attr('title').inner_text.strip
    ciudad = job.css('.location').css('li').inner_text.split(",", 2)[0].strip
    empresa = job.css('.company').inner_text.strip
    fechaPublicacion = job.css('.badge').inner_text.strip
    trabajo = Trabajo.new(cargo, ciudad, empresa, fechaPublicacion)
    trabajo.guardar
  end
  nPagText = '?p='+npag.to_s
  link = cabeceraLink+nPagText
  puts link
  npag+=1
  
  
end 

 
