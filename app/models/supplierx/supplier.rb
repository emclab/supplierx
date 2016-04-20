module Supplierx
  class Supplier < ActiveRecord::Base
    attr_accessor :active_noupdate, :quality_system_name
         
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
    
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      
    validates :name, :short_name, :phone, :fort_token, :presence => true
    validates :name, :short_name, :presence => true, :uniqueness => {:case_sensitive => false, :message => I18n.t('Must be unique!')}
    validates :email, :format     => { :with => email_regex, :message => I18n.t('Wrong email format!') },
                      :uniqueness => { :case_sensitive => false, :message => I18n.t('Duplicate email!') },
                      :if => 'email.present?'
    validates :quality_system_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'quality_system_id.present?' 
    validates :supplier_category_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'supplier_category_id.present?'
    
    default_scope {where(fort_token: Thread.current[:fort_token])}
    
  end
end
