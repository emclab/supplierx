require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
  describe "GET /supplierx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      config_entry = FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'SESSION_TIMEOUT_MINUTES', :argument_value => 30)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @qs = FactoryGirl.create(:commonx_misc_definition, :for_which => 'quality_system')
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "Supplierx::Supplier.where(:active => true).order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'supplierx_suppliers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      
      #visit authentify.new_session_path
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login' 
    end
    it "works! (now write some real specs)" do
      sup = FactoryGirl.create(:supplierx_supplier, :quality_system_id => @qs.id)
      visit supplierx.suppliers_path
      save_and_open_page
      expect(page).to have_content('Suppliers')
      
      click_link 'Edit'  #not working
      #visit supplierx.edit_supplier_path(sup)
      expect(page).to have_content('Update Supplier')
      fill_in 'supplier_short_name', with: 'a new name'
      click_button 'Save'
      visit supplierx.suppliers_path
      save_and_open_page
      expect(page).to have_content('a new name')
      
      visit supplierx.suppliers_path
      click_link sup.id    
      expect(page).to have_content('Supplier Info')
      
      visit supplierx.suppliers_path
      #save_and_open_page
      click_link "New Supplier"
      expect(page).to have_content('New Supplier')
      fill_in 'supplier_name', with: 'a wired name'
      fill_in 'supplier_short_name', with: 'a very wired name'
      fill_in 'supplier_phone', with: '1234567'
      fill_in 'supplier_contact_name', with: 'a contact name'
      click_button 'Save'
      #save_and_open_page
      visit supplierx.suppliers_path
      save_and_open_page
      expect(page).to have_content('a very wired name')
      
    end
  end
end
