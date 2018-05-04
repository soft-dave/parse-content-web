require "net/http"
require "uri"

class PagesController < ApplicationController
	def index
		response = Faraday.get(Rails.application.secrets.api_url + "/v1/pages")
		@contents = JSON.parse(response.body)
	end

	def new
	end

	def create
		url = URI.parse(Rails.application.secrets.api_url + "/v1/pages")
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true if Rails.env.production?
		request = Net::HTTP::Post.new(url)
		request.set_form_data({"page_url" => params[:page][:page_url]})
		response = http.request(request)
		redirect_to root_path
	end

	def show
		response = Faraday.get(Rails.application.secrets.api_url + "/v1/pages/" + params[:id] )
		@contents = JSON.parse(response.body)
	end

	def destroy
		response = Faraday.delete(Rails.application.secrets.api_url + "/v1/pages/" + params[:id] )
		redirect_to root_path
	end

end
