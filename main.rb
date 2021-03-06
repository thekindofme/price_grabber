require "data_structures/category"
require "data_structures/product"
require "parsers/slmega_parser"
require "parsers/barclays_parser"
require "parsers/laptoplk_parser"
require "parsers/tech_ware_house_parser"
require "parsers/memory_lk_parser"
require "parsers/abc_computers_parser"

#LPriceGrabber::LaptoplkParser.new.categories.each { |result| puts result }
#LPriceGrabber::LaptoplkParser.new.parse

#LPriceGrabber::BarclaysParser.new.categories.each { |result| puts result }
#LPriceGrabber::BarclaysParser.new.parse

#LPriceGrabber::TechWareHouseParser.new.categories.each { |result| puts result }
#LPriceGrabber::TechWareHouseParser.new.parse

#LPriceGrabber::MemoryLK.new.categories.each { |result| puts result }
#LPriceGrabber::MemoryLK.new.parse

#LPriceGrabber::ABCComputersParser.new.categories.each { |result| puts result }
#LPriceGrabber::ABCComputersParser.new.parse

LPriceGrabber::SLMegaParser.new.parse.each { |product| puts product }
LPriceGrabber::SLMegaParser.new.categories.each { |result| puts result }