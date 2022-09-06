class ScraperComputrabajo
  def extraerDatos(url)
    url_principal = 'https://ec.computrabajo.com/'
    datosHTML = URI.open(url, 'User-Agent' => 'firefox')
    datosStr = datosHTML.read
    parsed_content = Nokogiri::HTML(datosStr)
    container = parsed_content.css('div.w100')
    container.css('div.bClick').each do |post|
      ocupacion = post.css('.js-o-link').inner_text
      ciudad_linea = post.css('p.fc_base').inner_text
      city = ciudad_linea.split(' ')[-2].to_s
      if city.include? ","
        ciudad = ciudad_linea.split(',')[-1]
        post.css('.js-o-link').each do |var|
            link = var.attribute('href')
            datosLink = URI.open(url_principal+link, 'User-Agent' => 'firefox')
            datosStrLink = datosLink.read
            parsed_contentLink = Nokogiri::HTML(datosStrLink)
            contenedor = parsed_contentLink.css('ul.disc')      
            years_experience = contenedor.css('li.mb10')[1].inner_text.split(' ')[0]
            if !years_experience.start_with?('1', '2', '3','4','5','6','7','8','9')
              years_experience = '1'
            end
            requisitos = contenedor.css('li.mb10')[-3].inner_text
            if !requisitos.start_with?('Conocimientos')
              requisitos = 'Conocimientos: No especificado'
            end
            carr = Ocupacion.new(ocupacion,ciudad,years_experience,requisitos.split(':')[1])
            #carr.toString
            carr.guardar('cargos.csv')  
          end
      end     
    end
  end
end
