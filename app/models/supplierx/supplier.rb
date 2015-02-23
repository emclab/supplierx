# encoding: utf-8
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
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
    
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      
    validates_presence_of :name, :short_name, :phone
    validates :name, :short_name, :uniqueness => {:case_sensitive => false, :message => I18n.t('Must be unique!')}
    validates :email, :format     => { :with => email_regex, :message => '电邮格式错误！' },
                      :uniqueness => { :case_sensitive => false, :message => '电邮已占用！' },
                      :if => 'email.present?'
  end
end
