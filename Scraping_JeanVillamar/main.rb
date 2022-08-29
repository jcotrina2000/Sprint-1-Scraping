require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html


$link = 'https://ec.expertini.com/jobs/search/developer/'
$datosHTML = URI.open($link)    
$datosStr = $datosHTML.read
$parsed_content = Nokogiri::HTML($datosStr)
$contadorpag = 0

def contadorpagina()
  contenido2 = $parsed_content.css('.w-pagination')
  contenido2.css(".page-numbers").each do |element|
    $contadorpag+=1
  end
  $contadorpag = $contadorpag-2 #se le resta 2 dado que cuenta tambien los botones de siguiente y anterior
end


contadorpagina()


def scrapeo()

contenido = $parsed_content.css('.row') 
contenido.css(".grid-content").css(".job-info").each do |element|
    titulo = element.css(".job-title").inner_text()
    empresa = element.css(".info-company").css(".company").inner_text().strip()
    categoria = element.css(".info-company").css(".category").inner_text().strip()
    direccion = element.css(".info-company").css(".address").inner_text().strip()
  
    tiempo = element.css(".info-company").css(".job-type").inner_text().strip()
  
    #strip() usado para eliminar los espacioes en blanco iniciales y finales
    puts "TITULO=>" + titulo
    puts "EMPRESA=>" + empresa
    puts "CATEGORIA=>" + categoria
    puts "DIRECCION=>" + direccion
    #puts "TIEMPO=>" + tiempo
    puts ""
    end
end





def siguiente(number)
  $link = "https://ec.expertini.com/jobs/search/developer/?No="+number.to_s
  $datosHTML = URI.open($link)
  $datosStr = $datosHTML.read
  $parsed_content = Nokogiri::HTML($datosStr)   
  scrapeo()
  
end

for i in 1..$contadorpag
  siguiente(i)
  puts i
end
#










