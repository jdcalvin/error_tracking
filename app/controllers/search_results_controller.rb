class SearchResultsController < ApplicationController
require 'will_paginate/array'

	def search
		if params[:search] == "" || params[:search].nil?
			@orders = nil
			flash[:info] = "Please enter a search query"
		else
			@search = params[:search]
			@orders = Order.reorder('order_name ASC').search(@search).page(params[:page]).per_page(20)
			
		end
	end

end
