# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
top_org_type = OrganizationType.create(name: 'Top Org Type')

top_org_unit = OrganizationUnit.create(name: 'Top Org Unit', short_name: 'TOU', organization_type_id: top_org_type.id)

admin_user = User.create(organization_unit_id: top_org_unit.id,email: 'admin@membership.com', password: 'admin123', admin: true)
