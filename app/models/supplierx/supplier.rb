module Supplierx
  class Supplier < ActiveRecord::Base
    attr_accessible :active, :address, :cell, :contact_name, :contact_info, :email, :fax, :last_eval_date, :last_updated_by_id, :main_product, :name, :phone, :quality_system, 
                     :short_name, :supply_since, :web, :note, :short_comment, :quality_system_id, :as => :role_new
    attr_accessible :active, :address, :cell, :contact_name, :contact_info, :email, :fax, :last_eval_date, :last_updated_by_id, :main_product, :name, :phone, :quality_system, 
                     :short_name, :supply_since, :web, :note, :short_comment, :quality_system_id, :as => :role_update
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
    
    validates_presence_of :name, :short_name, :contact_name, :address, :phone
  end
end
