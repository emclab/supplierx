module Supplierx
  class Supplier < ActiveRecord::Base
    attr_accessor :active_noupdate, :quality_system_name
    attr_accessible :active, :address, :cell, :contact_name, :contact_info, :email, :fax, :last_eval_date, :last_updated_by_id, :main_product, :name, :phone, :quality_system_name, 
                     :short_name, :supply_since, :web, :note, :short_comment, :quality_system_id,
                     :as => :role_new
    attr_accessible :active, :address, :cell, :contact_name, :contact_info, :email, :fax, :last_eval_date, :last_updated_by_id, :main_product, :name, :phone, :quality_system_name, 
                     :short_name, :supply_since, :web, :note, :short_comment, :quality_system_id, 
                     :active_noupdate,
                     :as => :role_update
                     
    attr_accessor :start_date_s, :end_date_s, :name_keyword_s, :contact_name_s, :quality_system_id_s, :active_s
    attr_accessible :start_date_s, :end_date_s, :name_keyword_s, :contact_name_s, :quality_system_id_s, :active_s,     
                    :as => :role_search_stats
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
    
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      
    validates :name, :short_name, :phone, :presence => true
    validates :name, :short_name, :presence => true, :uniqueness => {:case_sensitive => false, :message => I18n.t('Must be unique!')}
    validates :email, :format     => { :with => email_regex, :message => I18n.t('Wrong email format!') },
                      :uniqueness => { :case_sensitive => false, :message => I18n.t('Duplicate email!') },
                      :if => 'email.present?'
    validates :quality_system_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'quality_system_id.present?' 
  end
end
