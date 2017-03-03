class PostService
  def request
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data('xml' => xml)
    http = Net::HTTP.new(url.host, url.post).start
    http.read_timeout = 3
    response = http.request(req)
  end
end
