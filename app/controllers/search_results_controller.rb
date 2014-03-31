class SearchResultsController < ApplicationController
	before_filter :authenticate_user!
	before_action :validate_org
require 'will_paginate/array'

	def search
		if params[:search] == "" || params[:search].nil?
			redirect_back_or_root
			flash[:info] = "Please enter a search query"
		else
			@search = params[:search]
			@orders = @organization.orders.search(@search).page(params[:page]).per_page(20)
		end
	end


	def redirect_back_or_root
 		redirect_to :back
	rescue ActionController::RedirectBackError
  	redirect_to root_path
	end
	
	private
	
	def validate_org
    if @organization.nil?
      redirect_to new_organization_path
      flash[:info] = "Please create an organization before continuing"
    end
  end
end
