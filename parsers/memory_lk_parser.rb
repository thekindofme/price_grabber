require 'rubygems'
require 'mechanize'

module LPriceGrabber
  class MemoryLK
    def initialize

    end

    def categories
      categories = []
      agent = WWW::Mechanize.new
      page = agent.get('http://shop.memory.lk')

      page.search("/html/body/div/table/tr[2]/td/table/tr[2]/td[2]/table//a").each do |link|
        if link['href'].include? 'category-list-' #there are some other unneeded stuff comming up... so this is to filter those out
          c = Category.new
          c.name = link.text.gsub(/\t|\n|\r/, ' ').strip.squeeze(" ")
          c.url = "http://shop.memory.lk/#{link['href']}"
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
          page.search("//table[@width=175]").each do |table|
              p = Product.new
              p.name = table.children[1].children[0].text
              p.price = table.children[3].children[2].text
              p.model = table.children[4].children[0].text
              str = table.children[5].text.gsub(/\n|\t|Â/, '').strip.squeeze(" ") #this position can hold the warranty info or description
              if str.include? 'Warranty'
              p.warranty = str
              else
                p.description = str
                p.warranty = table.children[6].text.gsub(/\n|\t|Â/, '').strip.squeeze(" ")
              end
              p.tag = category.name
              puts p
              products << p
              #count = count + 1
          end
      end

      products
    end
  end
end
