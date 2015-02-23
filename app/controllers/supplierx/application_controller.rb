module Supplierx
  class ApplicationController < ::ApplicationController
    include Authentify::SessionsHelper
    include Authentify::AuthentifyUtility
    include Authentify::UsersHelper
    include Authentify::UserPrivilegeHelper
    include Commonx::CommonxHelper
    include Searchx::SearchHelper
    
    before_action :require_signin
    before_action :max_pagination 
    before_action :check_access_right 
    before_action :load_session_variable, :only => [:new, :edit]  #for parent_record_id & parent_resource in check_access_right
    after_action :delete_session_variable, :only => [:create, :update]   #for parent_record_id & parent_resource in check_access_right
    before_action :view_in_config?
    
    def view_handler
      index  = params[:index].to_i
      url = params[:url]
      msg = params[:msg]
      unless session.blank?   #session expired and signout. session.nil? is true here.
        if index == 0   #backword
          session[:page_step] -= 1  #step_back
          url = session[('page' + session[:page_step].to_s).to_sym]      
        else  #forward
          session[:page_step] += 1 
          session[('page' + session[:page_step].to_s).to_sym] = url
        end
  
        #redirect to the page by url  
        if url.present?                                                                
          redirect_to url if msg.nil?
          redirect_to url, :notice => t(msg) if msg.present?   
        else
          redirect_to main_app.user_menus_path if msg.nil?
          redirect_to main_app.user_menus_path, :notice => t(msg) if msg.present?
        end
      else
        sys_logger(t('Login Expired')) unless Rails.env.test?
        sign_out
        redirect_to URI.escape(SUBURI + '/authentify/signin'), :notice => t('Login Expired')  #session expired. signin again.
      end
    end
    
    protected
  
    def max_pagination
      @max_pagination = find_config_const('pagination')
    end
    
    def view_in_config?
      @view_in_config = Authentify::AuthentifyUtility.load_view_in_config
    end
    
     
  end
end
