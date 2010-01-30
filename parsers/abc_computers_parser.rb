require 'rubygems'
require 'mechanize'

module LPriceGrabber
  class ABCComputersParser < Parser

    def categories
      categories = []
      WWW::Mechanize.new.get('http://www.abc.lk/onlineshop.aspx').search("//*[@id=\"ctl00_GridViewMenu\"]//a").each do |link|
        #i don't want to follow links that lead to filtered (on product brand) set of products.
        #because they are already included in the main product category
        if link['href'].include? 'brandid=&'
          c = Category.new
          c.name = link.text.gsub(/\t|\n|\r/, ' ').strip.squeeze(" ")
          c.url = "http://www.abc.lk/#{link['href']}"
          categories << c
        end
      end
      categories
    end


=begin
Parse ABCComputers for products and their attributes and will return a array of Product objects.
=end
    def parse
      products = []
      agent = WWW::Mechanize.new

      self.categories.each do |category|
        page = agent.get category.url
        page.search("//table[@class='OutBorder']").each do |tr|
          unless (tr.children[0].text == 'Brand.') #ignore header <tr>'s
            p = Product.new
            p.name =  tr.children[0].children[0].children[1].text
            p.image = tr.children[1].children[0].children[1].children[0]['src']
            p.brand = tr.children[0].text
            p.model = tr.children[2].text
            p.description = tr.children[4].text
            p.price = tr.children[10].text
            p.warranty = tr.children[6].text.gsub(/'/, '')
            p.stock = !tr.children[14].text.include?('(0)')
            tr.children[14].text =~ /\d+/ #try get the numerical value inside this expression
            p.items_in_stock = $&
            p.tag = category.name
            products << p
          end
        end
      end

      products
    end
  end
end
