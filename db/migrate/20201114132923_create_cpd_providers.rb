class CreateCpdProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :cpd_providers, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :organization_category
      t.string :type_of_organization
      t.string :name_of_organization
      t.boolean :availability_of_office
      t.string :telephone_fax_email, array: true
      t.string :training_hall
      t.string :syndicate_room
      t.string :computer_printer_lcd_photo_copy, array: true
      t.string :availability_of_shelf
      t.boolean :availability_of_electronic_database
      t.boolean :toilet_service
      t.string :running_water_available
      t.string :place_for_coffee_break
      t.boolean :website_availability
      t.boolean :internet_connection
      t.boolean :accredited_activities_on_website
      t.string :how_frequently_updated
      t.boolean :administration_assistant
      t.boolean :designated_cpd_director
      t.string :cpd_director_name
      t.string :cpd_director_telephone_number
      t.string :cpd_director_email
      t.boolean :training_officer
      t.boolean :it_officer
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :city
      t.string :sub_city_or_zone
      t.string :woreda
      t.string :kebele
      t.string :house_number
      t.string :telephone_number
      t.string :street
      t.string :email
      t.string :pobox
      t.boolean :applied_to_another_accreditor
      t.string :name_of_accreditor
      t.string :outcome_and_reason
      t.string :status

      t.timestamps
    end
  end
end
