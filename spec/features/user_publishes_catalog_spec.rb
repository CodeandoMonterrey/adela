require 'spec_helper'

feature User, 'publishes catalog:' do
  
  background do
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic, :organization => @user.organization, :published => true)
    given_logged_in_as(@user)

  end

  scenario "can see a disabled publish link and catalog url" do
    given_has_uploaded_an_inventory(1.day.ago)
    visit new_inventory_path
    tries_to_upload_the_file("inventory.csv")
    expect(page).to have_text("Paso 5")
    expect(page).to have_text("Publica tu inventario")
    expect(page).to have_css("#publish.disabled")
    expect(page).to have_link("Lo publicaré después, quiero avanzar")
  end

  scenario "sees permissions and publication requirements checkboxes" do
    given_has_uploaded_an_inventory(1.day.ago)
    visit new_inventory_path
    tries_to_upload_the_file("inventory.csv")
    click_on "Guardar"
    sees_data_requirements
  end

  scenario "can publish a catalog", :js => true do
    visit new_inventory_path
    tries_to_upload_the_file("inventory.csv")
    click_on "Guardar inventario"
    check_publication_requirements
    click_on "Publicar"
    sees_success_message "LISTO, has completados todos los pasos. Ahora utiliza esta herramienta para mantener tu programa de apertura e inventario de datos al día."
    expect(page).to have_text "Última versión"
    expect(page).to have_text "Versión publicada"
    expect(page).to have_text @user.name
    expect(page).to have_link "Subir nueva versión"
    @catalog = @user.organization.current_catalog
    activity_log_created_with_msg "publicó #{@catalog.datasets_count} conjuntos de datos con #{@catalog.distributions_count} recursos."
  end

  scenario "can publish a catalog later", :js => true do
    visit new_inventory_path
    tries_to_upload_the_file("inventory.csv")
    click_on "Guardar inventario"
    click_on "Lo publicaré después, quiero avanzar"
    expect(page).to have_text "OJO: No has completado el último paso que es publicar tu inventario."
  end

  def sees_data_requirements
    expect(page).to have_css("#personal_data")
    expect(page).to have_css("#open_data")
    expect(page).to have_css("#office_permission")
    expect(page).to have_css("#data_policy_requirements")
  end

  def check_publication_requirements
    check("personal_data")
    check("open_data")
    check("office_permission")
    check("data_policy_requirements")
    page.execute_script("$('#data_policy_requirements').trigger('change');")
  end

  def tries_to_upload_the_file(file_name)
    attach_file('inventory_csv_file', "#{Rails.root}/spec/fixtures/files/#{file_name}")
    click_on("Subir inventario")
  end

  def given_has_uploaded_an_inventory(days_ago)
    @inventory = FactoryGirl.create(:inventory)
    @inventory.update_attributes(:organization_id => @user.organization_id, :created_at => days_ago)
  end
end
