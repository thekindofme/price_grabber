require 'rubygems'
require 'mechanize'

module LPriceGrabber

=begin
LaptoplkParser can parse laptop.lk for all products in all categories and retrieve their attributes such as name, price...etc
=end
  class LaptoplkParser < Parser

=begin
Returns a array of Categories of products available on the site.
=end
    def categories
      categories = []
      WWW::Mechanize.new.get('http://laptop.lk').links.each {|link|
        if (link.href && link.href.include?("product_lists.php?"))
          c = Category.new
          c.name = link.text
          c.url = "http://laptop.lk/#{link.href}"
          categories << c
        end
      }
      categories
    end


=begin
Parse laptop.lk for products and their attributes and will return a array of Product objects.
//a[@class='ProductListProductTitle']
//span[@class='ProductListPrice']
=end
    def parse
      products = []
      agent = WWW::Mechanize.new

      self.categories.each do |category|
        page = agent.get category.url
        next_page = 2

        while true
          product_names_and_links = page.search("//a[@class='ProductListProductTitle']")
          product_prices = page.search("//span[@class='ProductListPrice']")

          #remove the last items from both arrays as there is a "Back..." link coming in as the last item.
          product_names_and_links.pop
          product_prices.pop

          i = 0
          product_names_and_links.each do |link|
            p = Product.new
            p.name = link.text
            p.url = "http://laptop.lk/#{link['href']}"
            p.price = get_price(product_prices[i].text); i+=1

            products << p
          end

          link = page.link_with(:text => next_page)
          if link != nil
            page = agent.click link
            ++next_page
          else
            break
          end
        end
      end

      products
    end

    def get_price source_text
      if source_text =~ /[+-]?[0-9]{1,3}(?:,?[0-9]{3})*(?:\.[0-9]{2})?/
        return $&
      else
        return ""
      end
    end
  end
end