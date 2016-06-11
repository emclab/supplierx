# encoding: utf-8
require_dependency "supplierx/application_controller"

module Supplierx
  class SuppliersController < ApplicationController
    before_action :require_employee
    after_action :info_logger, :except => [:new, :edit, :event_action_result, :wf_edit_result, :search_results, :stats_results, :acct_summary_result]
    
    helper_method :return_misc_definitions
    
    def index
      @title = t('Suppliers')
      @suppliers = params[:supplierx_suppliers][:model_ar_r].page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('supplier_index_view', session[:fort_token], 'supplierx')
    end
  
    def new
      @title = t('New Supplier')
      @supplier = Supplierx::Supplier.new()
      @erb_code = find_config_const('supplier_new_view', session[:fort_token], 'supplierx')
    end
  
    def create
      @supplier = Supplierx::Supplier.new(new_params)
      @supplier.last_updated_by_id = session[:user_id]
      @supplier.fort_token = session[:fort_token]
      if @supplier.save
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Supplier Not Saved!')
        @erb_code = find_config_const('supplier_new_view', session[:fort_token], 'supplierx')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Supplier')
      @supplier = Supplierx::Supplier.find_by_id(params[:id])
      @erb_code = find_config_const('supplier_edit_view', session[:fort_token], 'supplierx')
    end
  
    def update
      @supplier = Supplierx::Supplier.find_by_id(params[:id])
      @supplier.last_updated_by_id = session[:user_id]
      if @supplier.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Supplier Not Updated!')
        @erb_code = find_config_const('supplier_edit_view', session[:fort_token], 'supplierx')
        render 'edit'
      end
    end
  
    def show
      @title = t('Show Supplier')
      @supplier = Supplierx::Supplier.find_by_id(params[:id])
      @erb_code = find_config_const('supplier_show_view', session[:fort_token], 'supplierx')
    end
    
    def autocomplete
      @parts = Supplierx::Supplier.where("active = ?", true).order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @parts.map(&:name)    
    end  
    
    protected
    
    private
    
    def new_params
      params.require(:supplier).permit(:active, :address, :cell, :contact_name, :contact_info, :email, :fax, :last_eval_date, :main_product, :name, :phone, :quality_system_name, 
                     :short_name, :supply_since, :web, :note, :short_comment, :quality_system_id, :supplier_cagetory_id)
    end
    
    def edit_params
      params.require(:supplier).permit(:active, :address, :cell, :contact_name, :contact_info, :email, :fax, :last_eval_date, :main_product, :name, :phone, :quality_system_name, 
                     :short_name, :supply_since, :web, :note, :short_comment, :quality_system_id, :supplier_category_id)
    end
  end
end
