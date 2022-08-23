require 'open-uri' #consultar a la plataforma
require 'nokogiri' #formatear, parsear a html

$link = 'https://ec.indeed.com/jobs?q=engineer%20software&l=Ecuador&vjk=74e9c3033648168c'
$datosHTML = URI.open($link)
$datosStr = $datosHTML.read
$parsed_content = Nokogiri::HTML($datosStr)

var = 10



def scrap1()
    contenido = $parsed_content.css('.cardOutline')
    contenido.css(".cardOutline").each do |element|  
        titulo = element.css('.jobTitle').css('.css-jspxzf').inner_text()
        lugar = element.css('.companyLocation').inner_text()
        dia =  element.css('.date').inner_text()
        exper = element.css('.jobsearch').inner_text()

        if titulo.include?("/")
            puts "TITULO -->"+titulo.split("/")[0]  #id  .clase
        else
            puts "TITULO -->"+ titulo
        end
        puts "LUGAR-->"+lugar.split(",")[0]
        puts "DIAS-->"+dia.split(" ")[1]
        puts "\n"
          
    end

    
def avanzar(number)
    $link = "/jobs?q=software&l=Ecuador&start="+number.to_s
    puts $link
    $datosHTML = URI.open($link)
    $datosStr = $datosHTML.read
    $parsed_content = Nokogiri::HTML($datosStr)
    
    scrap1()
end


    
end

i = 0
while i < 100
    scrap1()
    i += 10
    
 end
