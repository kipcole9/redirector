class Redirect < ActiveRecord::Base
end

get '/r/:id' do
  if redirect_to = Redirect.find_by_redirect_url(params[:id])
    redirect redirect_to.url
  else
    throw :halt, [404, "Sorry, don't know how to redirect with '#{params[:id]}'"]
  end
end

get '*' do
  "Keep moving, there's nothing to see here."
end
