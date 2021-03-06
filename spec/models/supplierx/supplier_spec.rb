#encoding: utf-8
require 'spec_helper'

module Supplierx
  describe Supplier do
    it "should be OK" do
      c = FactoryGirl.build(:supplierx_supplier)
      c.should be_valid
    end
    
    it "should take nil email" do
      c = FactoryGirl.build(:supplierx_supplier, :email => nil)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:supplierx_supplier, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil short name" do
      c = FactoryGirl.build(:supplierx_supplier, :short_name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil contact name" do
      c = FactoryGirl.build(:supplierx_supplier, :contact_name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil address" do
      c = FactoryGirl.build(:supplierx_supplier, :address => nil)
      c.should_not be_valid
    end
    
    it "should reject nil phone" do
      c = FactoryGirl.build(:supplierx_supplier, :phone => nil)
      c.should_not be_valid
    end
    
  end
end
