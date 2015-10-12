module Jekyll
	class Sitemap < Generator
		safe true
		priority :lowest
		
		def generate(site)
			pages = site.pages
	        languages = site.config['languages'] || ['en']
	        default_lang = site.config['default_lang'] || 'en'

	        sitemap = {}
	        languages.each do |lang|
	            lang == default_lang ? lang = '' : lang = '/' + lang
	            pages.each do |page|
	            	page_full_name = page.dir + page.name
	                if sitemap.key?(page_full_name)
	                    sitemap[page_full_name] << lang + page.url
	          		else
	            		sitemap.store(page_full_name, [ lang + page.url ])
	          		end
	        	end
	      	end
      		save sitemap
      	end

	    private

	    def save(sitemap)
	        File.open("sitemap.json", "w") do |f|
	          f.write(sitemap.to_json)
	        end
	    end
	end
end
