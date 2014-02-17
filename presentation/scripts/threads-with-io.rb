require 'net/http'

num_threads = ARGV.shift.to_i

all_urls = %w(www.ruby-lang.org
              stackoverflow.com
              ggapps.co.uk
              joncairns.com)

url_buckets = all_urls.each_slice(all_urls.length / num_threads).to_a

url_buckets.map { |urls|
  Thread.new(urls) do |urls|
    urls.each do |url|
      Net::HTTP.get(url, "/")
    end
  end
}.each(&:join)
