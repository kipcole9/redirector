class Redirect < ActiveRecord::Base
end

# Make sure we have a database connection
before do 
  ActiveRecord::Base.verify_active_connections!
end

get '/r/:id' do
  if redirect_to = Redirect.find_by_redirect_url(params[:id])
    redirect (request.query_string && request.query_string.length > 0) ? "#{redirect_to.url}?#{request.query_string}" : redirect_to.url
  else
    throw :halt, [404, "Sorry, don't know how to redirect with '#{params[:id]}'"]
  end
end
