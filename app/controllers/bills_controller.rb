# frozen_string_literal: true

class BillsController < ApplicationController

  def index 
    @bills = Bill.all
    
    if @bills
      render json: {
        bills: @bills
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

end
