
require 'net/http'
require 'json'

def encurtar_url(url, token)
     uri = URI.parse("https://api-ssl.bitly.com/v4/shorten")
     http = Net:HTTP.new(uri.host, uri.port)
     http.use_ssl = true

     request = Net::HTTP::Post.new(uri.path,
                                   { 'Content-Type' => 'application/json',
                                     'Authorization' => "Bearer #{token}"})
                                     
request.body = { long_url: url }.to_json

response = http.request(request)

if response.code == '200'
    data = JSON.parse(response.body)
    return data['id']

else
    puts "Erro ao encurtara URL. Código de resposta: #{response.code}"
    return nil
  end
end

puts "Digite a URL que deseja encurtar:"
url = gets.chomp

puts "Digite a sua chave de Api do Bitly"
token = gets.chomp
short_url = encurtar_url(url, token)

if short_url 
    puts "URL encurtada: #{short_url}"
end
