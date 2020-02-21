# frozen_string_literal: true

class BillsController < ApplicationController

  def index 
    @bills = Bill.all
    @categories = Category.all
    
    if @bills
      render json: {
        bills: @bills,
        categories: @categories
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

end
