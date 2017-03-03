class Postservice
  HTTP_ERRORS = [
    Timeout::Error,
    Errno::EINVAL,
    Errno::ECONNRESET,
    EOFError,
    Net::HTTPBadResponse,
    Net::HTTPHeaderSyntaxError,
    Net::ProtocolError
  ]

  def request
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data('xml' => xml)
    http = Net::HTTP.new(url.host, url.post).start
    response = http.request(req)
  rescue *HTTP_ERRORS => e
    HoptoadNotifier.notify e
  end
end
