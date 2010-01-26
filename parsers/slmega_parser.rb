require 'rubygems'
require 'mechanize'

module LPriceGrabber

=begin
SLMegaParser can parse slmega.com for all products in all categories and retrive their attributes such as name, price...etc
=end
  class SLMegaParser

=begin
Returns a array of Categories of products avilible on the site.
=end
    def categories
      categiries = []
      agent = WWW::Mechanize.new
      page = agent.get('http://www.slmega.com/catalog/index.php')

      page.search("/html/body/div[@id='wrap']/div[@id='menu_bar']/div[@id='category_menu']/div[@id='body']/div[@id='qm1']/div/a").each do |link|
        c = Category.new
        c.name = link.text
        c.url = "http://www.slmega.com/catalog/#{link['href']}"
        categiries << c
      end
      categiries
    end


=begin
Parse slmega.com for prodcuts and their attributes and will return a array of Product objects.
=end
    def parse
      count =0
      products = []
      agent = WWW::Mechanize.new

      self.categories.each do |category|
        page = agent.get category.url
        while true
          count =0
          page.search("/html/body/div[@id='wrap']/div[@id='bodyArea']/div[@id='products']/table/tr").each do |tr|
            p = Product.new
            p.name = tr.search('//td[2]/a')[count].text
            p.price = tr.search('//td[3]/h2')[count].text
            p.stock = tr.search('//td[3]')[count].text.include?('In-Stock')
            p.model = (tr.search('//td[2]/h1')[count].text).split(/Model:./)[1].split(/ \|SKU: [\w]+/)[0]
            p.sku = (tr.search('//td[2]/h1')[count].text).split(/Model: [\w]+ \|SKU: /)[1]
            p.description = tr.text.gsub(/\t|\n/, ' ').strip.squeeze(" ")
            p.image = tr.search('//td[1]/img')[count]['src']
            p.tag = category.name
            puts p
            products << p
            count = count + 1
          end

          link = page.link_with(:text => 'Next page>')
          if link != nil
            page = agent.click link
          else
            break
          end
        end
      end

      products
    end
  end
end