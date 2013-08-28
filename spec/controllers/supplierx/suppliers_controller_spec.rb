# encoding: utf-8
require 'spec_helper'

module Supplierx
  describe SuppliersController do
    
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
    end
    
    before(:each) do
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      #user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'projectx_misc_definitions', :role_definition_id => role.id, :rank => 1,
      #:sql_code => "Projectx::MiscDefinition.where(:active => true).order('ranking_order')")
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
    end
    
    render_views
  
    describe "GET 'index'" do
      it "should return suppliers" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "Supplierx::Supplier.where(:active => true).order('id')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:supplierx_supplier)
        get 'index', {:use_route => :supplierx}
        assigns(:suppliers).should =~ [sup]
      end
    end
  
    describe "GET 'new'" do
      it "should display the new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "Supplierx::Supplier.where(:active => true).order('id')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :supplierx}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "should create a new record" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.attributes_for(:supplierx_supplier)
        get 'create', {:use_route => :supplierx, :supplier => sup}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Supplier Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.attributes_for(:supplierx_supplier, :name => nil)
        get 'create', {:use_route => :supplierx, :supplier => sup}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns render edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:supplierx_supplier)
        get 'edit', {:use_route => :suppliers, :id => sup.id}
        response.should be_success
      end
            
    end
  
    describe "GET 'update'" do
      
      it "returns updated page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:supplierx_supplier)
        get 'update', {:use_route => :suppliers, :id => sup.id, :supplier => {:name => 'a new name'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Supplier Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:supplierx_supplier)
        get 'update', {:use_route => :suppliers, :id => sup.id, :supplier => {:name => ''}}
        response.should render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:supplierx_supplier, :last_updated_by_id => session[:user_id])
        get 'show', {:use_route => :supplierx, :id => sup.id}
        response.should be_success
      end
    end
  
  end
end
