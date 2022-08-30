class ScrapingExpertini
    def extraerDatosEtiquetas(link)
        datosHTML = URI.open(link)    
        datosStr = datosHTML.read
        parsed_content = Nokogiri::HTML(datosStr)

        contenido = parsed_content.css('.row') 
        contenido.css(".grid-content").css(".job-info").each do |element|
            masdetall = element.css(".job-title").css("a").attr("href").inner_text()
            titulo = element.css(".job-title").inner_text()
            empresa = element.css(".info-company").css(".company").inner_text().strip()
            categoria = element.css(".info-company").css(".category").inner_text().strip()
            direccion = element.css(".info-company").css(".address").inner_text().strip()
            #condicion para obtener las provincias
            if (direccion.include?(',')) then
                provincia = direccion.split(",")[0]
            else
                if (direccion.include?('')) then
                    provincia = "otros"
                else
                    if(direccion.include?('Ecuador')) then
                        provincia = "otros"
                    else
                        provincia = "otros"
                    end
                
                end
            end


            #validación de categorias vacías             
            tiempo = element.css(".info-company").css(".job-type").inner_text().strip()
            
            #strip() usado para eliminar los espacioes en blanco iniciales y finales
            puts "TITULO=>" + titulo
            puts "EMPRESA=>" + empresa
            puts "CATEGORIA=>" + categoria
            puts "PROVINCIA=>" + provincia
            puts "detalle=>" + masdetall

            link = masdetall
            datosHTML = URI.open(link)    
            datosStr = datosHTML.read
            parsed_content = Nokogiri::HTML(datosStr)

            contenido = parsed_content.css('#job-detail-content') 
            contenido.css(".job-detail-info").each do |element|
                salario = element.css(".salary").css(".content").inner_text().strip()
                tipojob = element.css(".job-type").css(".content").inner_text().strip()
                dias = element.css(".posted").css(".content").inner_text().strip()

                #pasar horas al dia de hoy 
                
                now = Date.today
                
                if (dias.include?('hours')) then
                    dias = now.to_s
                else
                    dias2 = dias.split(' ')[0].to_i
                    dias = (now - dias2).to_s #restar dias a la fecha respecto a la fecha actual
                    
                end


                puts "SALARIO = " + salario 
                puts "TIPO = " + tipojob
                puts "DIAS = " + dias
              
                trabaj = Job.new(titulo, empresa, categoria, provincia, salario, tipojob, dias)
                trabaj.guardar
                
            end
     

        end
 

    end
end

