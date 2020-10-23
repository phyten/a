require "active_support/all"
require "pp"
require "nokogiri"
require "anemone"

url = "https://www.driveplaza.com/dp/SearchTop"

Anemone.crawl(url) do |anemone|
  anemone.on_every_page do |page|
    puts page.url.to_s
    if page.url.to_s !~ /\.pdf/
      doc = Nokogiri::HTML.parse(page.body)
      title = doc.css("title").first.inner_text
      p = doc.css("p").map{ |e| e.inner_text}
      puts title
    else
      puts "PDF!!!"
    end
  end
end
