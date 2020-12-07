# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'



test_menu_items = [
    ['Butik', '#', enabled_from: '2017-04-23', children: [
        ['Handla', '/store'],
        ['Mina produkter', '/store/inventory'],
        ['Mina ordrar', '/store/orders'],
    ]],
    ['Frågor & Svar', '/faq'],
    ['Festivalen', '#', children: [
        ['SOF-armbandet', '/festival/bracelet'],
        ['Orkestrar', '/festival/artist_lineup'],
        ['Festivalschema', '/festival/schedule'],
        ['Spelschema', '/festival/orchestra/schedule'],
        ['Colour it', '/festival/colour_it'],
        ['Karta', '/festival/map'],
        ['Mat på området', '/festival/food'],
        ['Årets öl', '/festival/beer']
    ]],
    ['Kårtege', '#', children: [
        ['Kårtegeordning', '/cortege/lineups'],
        ['Kårtegens väg', '/cortege/map'],
        ['Om Kårtegen', '/cortege', active: false],
        ['Om Casekårtege', '/case_cortege', active: false],
        ['Kårtegeanmälan', '/cortege/interest', disabled_from: '2017-04-01'],
        ['Casekårtegeanmälan', '/case_cortege/new', disabled_from: '2017-04-01'],
    ]],
    ['Orkester', '#', children: [
        ['Information', '/orchestra'],
        ['Anmälan', '/orchestra/register'],
    ]],
    ['Kontakt', '#', children: [
        ['Huvudansvarig', '/contact/general'],
        ['Press', '/contact/press'],
        ['Orkestrar', '/contact/orchestra'],
        ['Kårtege', '/contact/cortege'],
        ['Biljetter', '/contact/tickets'],
        ['It/Webbsupport', '/contact/it']
    ]],
    ['Administration', '#', display_empty: false, children: [
        ['Hantera användare', '/manage/users', permissions: AdminPermission::LIST_USERS],
        ['Hantera orkestrar', '/manage/orchestras', permissions: AdminPermission::ORCHESTRA_ADMIN],
        ['Hantera kårteger', '/manage/corteges', permissions: AdminPermission::LIST_CORTEGE_APPLICATIONS],
        ['Hantera lineups', '/manage/lineups', permissions: AdminPermission::LIST_CORTEGE_APPLICATIONS],
        ['Hantera casekårteger', '/manage/case_corteges', permissions: AdminPermission::LIST_CORTEGE_APPLICATIONS],
        ['Hantera produkter', '/manage/products', permissions: AdminPermission::ALL],
        ['Hantera FAQs', '/manage/faqs', permissions: AdminPermission::EDITOR],
        ['Order-statistik', '/manage/products/statistics', permissions: AdminPermission::ANALYST],
        ['Lämna ut varor', '/manage/collect', permissions: AdminPermission::TICKETER]
    ]]
]

def create_menu_item(title, href, permissions: 0, display_empty: true, enabled_from: nil, disabled_from: nil, children: [], active: true)
  a = MenuItem.new
  a.title = title
  a.href = href
  a.required_permissions = permissions
  a.display_empty = display_empty
  a.enabled_from = enabled_from.present? ? DateTime.parse(enabled_from) : nil
  a.disabled_from = disabled_from.present? ? DateTime.parse(disabled_from) : nil
  a.menu_items = children.map { |c| create_menu_item *c }
  a.active = active
  a.save
  return a
end

MenuItem.delete_all
test_menu_items.each { |c| create_menu_item *c }

# Only seed in development if empty product database to avoid order and cart problems
if Rails.env.development? and BaseProduct.count == 0 and Product.count == 0
  BaseProduct.delete_all
  Product.delete_all


  weekend_ticket = BaseProduct.create(
    id: 1,
    name: 'Helhelgsbiljett',
    name_english: 'Weekend ticket',
    description: 'En biljett som räcker en hel helg',
    description_english: 'A ticket for a whole weekend',
    cost: 4000
  )

  weekend_prod = Product.create(
    max_num_available: 5
  )
  weekend_ticket.products.push(weekend_prod)

  single_day_ticket = BaseProduct.create(
    id: 2,
    name: 'Dagsbiljett',
    name_english: 'Day ticket',
    description: 'En biljett som räcker en dag',
    description_english: 'A ticket that lasts for a day',
    cost: 0
  )

  thursday = Product.create(
    kind: 'Torsdag',
    kind_english: 'Thursday',
    max_num_available: 5,
    cost: 1400
  )

  single_day_ticket.products.push(thursday)

  friday = Product.create(
    kind: 'Fredag',
    kind_english: 'Friday',
    max_num_available: 10,
    cost: 1600
  )

  single_day_ticket.products.push(friday)

  saturday = Product.create(
    kind: 'Lördag',
    kind_english: 'Saturday',
    cost: 1900
  )
  single_day_ticket.products.push(saturday)

  thurs_constraint = AmountConstraint.create(
    amount: 5
  )

  fri_constraint = AmountConstraint.create(
    amount: 10
   )

  sat_constraint = AmountConstraint.create(
    amount: 20
  )

  thursday.amount_constraints << thurs_constraint
  friday.amount_constraints  << fri_constraint
  saturday.amount_constraints  << sat_constraint

  weekend_prod.amount_constraints << thurs_constraint
  weekend_prod.amount_constraints  << fri_constraint
  weekend_prod.amount_constraints  << sat_constraint

  DiscountCode.create(
    uses: 1,
    discount: 100,
    product_id: weekend_prod.id,
    code: 'test'
  )
end

if Rails.env.development? and FunkisCategory.count == 0 and FunkisTimeslot.count == 0
  FunkisCategory.delete_all
  FunkisTimeslot.delete_all

  category_1 = FunkisCategory.create(
      id: 1,
      title: "Barfunkis"
  )
  category_2 = FunkisCategory.create(
      id: 2,
      title: "Byggfunkis"
  )

  timeslot_1 = FunkisTimeslot.create(
      id: 1,
      funkis_category_id: category_1.id,
      start_time: DateTime.new(2021, 5, 14, 12, 0),
      end_time: DateTime.new(2021, 5, 14, 16, 0)
  )

  timeslot_2 = FunkisTimeslot.create(
      id: 2,
      funkis_category_id: category_1.id,
      start_time: DateTime.new(2021, 5, 14, 12, 0),
      end_time: DateTime.new(2021, 5, 14, 16, 0)
  )

  timeslot_3 = FunkisTimeslot.create(
      id: 3,
      funkis_category_id: category_2.id,
      start_time: DateTime.new(2021, 5, 14, 12, 0),
      end_time: DateTime.new(2021, 5, 14, 16, 0)
  )


end
