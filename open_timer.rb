get '/refresh_image_test' do
  code = <<-EOC
  <html>
  <body>
    <img src='http://redirector.local/image.png' style="display:none">
    <p>Am going to refresh the image now.</p>
  </body>
  </html>
  EOC
end

SERIES = [0,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,5,5,5,5,5,5,5,5,10]
get '/image.png' do
  index = request.query_string.to_i rescue 0
  options = {
    :type => 'image/png',
    :disposition => 'inline'
  }
  if next_period = SERIES[index + 1]
   response['Refresh'] = "#{next_period}; /image.png?#{index + 1}"
  end
  cache_control :no_cache
  send_file('/Users/kip/Development/Rails/Redirector/public/1px.png', options)
end


get '*' do
  status 404
  "Keep moving, there's nothing to see here."
end
