# encoding: utf-8
require_dependency "supplierx/application_controller"

module Supplierx
  class SuppliersController < ApplicationController
    before_filter :require_employee
    
    def index
      @title = t('Suppliers')
      @suppliers = params[:supplierx_suppliers][:model_ar_r].page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('supplier_index_view', 'supplierx')
    end
  
    def new
      @title = t('New Supplier')
      @supplier = Supplierx::Supplier.new()
    end
  
    def create
      @supplier = Supplierx::Supplier.new(params[:supplier], :as => :role_new)
      @supplier.last_updated_by_id = session[:user_id]
      if @supplier.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Supplier Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Supplier Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Supplier')
      @supplier = Supplierx::Supplier.find_by_id(params[:id])
    end
  
    def update
      @supplier = Supplierx::Supplier.find_by_id(params[:id])
      @supplier.last_updated_by_id = session[:user_id]
      if @supplier.update_attributes(params[:supplier], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Supplier Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Supplier Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Show Supplier')
      @supplier = Supplierx::Supplier.find_by_id(params[:id])
      @erb_code = find_config_const('supplier_show_view', 'supplierx')
    end
  end
end
