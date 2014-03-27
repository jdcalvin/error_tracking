class SearchResultsController < ApplicationController
require 'will_paginate/array'

	def search
		if params[:search] == "" || params[:search].nil?
			redirect_back_or_root
			flash[:info] = "Please enter a search query"
		else
			@search = params[:search]
			@orders = Order.reorder('order_name ASC').search(@search).page(params[:page]).per_page(20)	
		end
	end


	def redirect_back_or_root
 		redirect_to :back
	rescue ActionController::RedirectBackError
  	redirect_to root_path
	end
end
