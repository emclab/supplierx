#encoding: utf-8
require 'rails_helper'

module Supplierx
  RSpec.describe Supplier, type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:supplierx_supplier)
      expect(c).to be_valid
    end
    
    it "should take nil email" do
      c = FactoryGirl.build(:supplierx_supplier, :email => nil)
      expect(c).to be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:supplierx_supplier, :name => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil short name" do
      c = FactoryGirl.build(:supplierx_supplier, :short_name => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject duplidate name" do
      p = FactoryGirl.create(:supplierx_supplier, :name => 'test')
      p1 = FactoryGirl.build(:supplierx_supplier, :name => 'Test', :short_name => 'a new short')
      expect(p1).not_to be_valid
    end
    
    it "should reject duplidate short name" do
      p = FactoryGirl.create(:supplierx_supplier, :short_name => 'test')
      p1 = FactoryGirl.build(:supplierx_supplier, :short_name => 'Test', :name => 'a new short')
      expect(p1).not_to be_valid
    end
    
    it "should take nil contact name" do
      c = FactoryGirl.build(:supplierx_supplier, :contact_name => nil)
      expect(c).to be_valid
    end
    
    it "should take nil quality_system_id" do
      c = FactoryGirl.build(:supplierx_supplier, :quality_system_id => nil)
      expect(c).to be_valid
    end
    
    it "should reject nil phone" do
      c = FactoryGirl.build(:supplierx_supplier, :phone => nil)
      expect(c).not_to be_valid
    end
    
  end
end
