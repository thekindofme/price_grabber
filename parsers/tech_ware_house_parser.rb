require 'rubygems'
require 'mechanize'

module LPriceGrabber
  class TechWareHouseParser
    def initialize

    end

    def categories
      categories = []
      agent = WWW::Mechanize.new
      page = agent.get('http://www.bhavik.com/techwarehouse/')

      page.search("/html/body/table[4]//a").each do |link|
        if link.text.size > 0 #there are some images which are linked. we won't to avoid those.
          c = Category.new
          c.name = link.text.gsub(/\t|\n|\r/, ' ').strip.squeeze(" ")
          c.url = "http://www.bhavik.com/techwarehouse/#{link['href']}"
          categories << c
          puts c
        end
      end
      categories
    end


=begin
Parse TechWareHouse for products and their attributes and will return a array of Product objects.
=end
    def parse
      count =0
      products = []
      agent = WWW::Mechanize.new

      self.categories.each do |category|
        page = agent.get category.url
          page.search("/html/body/table[5]/tr[2]/td/table//tr").each do |tr|
            unless (tr.children[0].text == 'Brand.') #ignore header <tr>'s
              p = Product.new
              p.brand = tr.children[0].text
              p.model = tr.children[2].text
              p.description = tr.children[4].text
              p.price = tr.children[10].text
              p.warranty = tr.children[6].text.gsub(/Â/, '')
              p.stock = !tr.children[14].text.include?('(0)')
              tr.children[14].text =~ /\d+/ #try get the numerical value inside this expression
              p.items_in_stock = $&
              p.tag = category.name
              puts p
              products << p
              #count = count + 1
            end
          end
      end

      products
    end
  end
end
