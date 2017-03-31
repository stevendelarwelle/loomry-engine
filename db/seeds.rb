# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Plan.create({
      name: 'Starter',
      price: 7.00,
      interval: 'month',
      stripe_id: '1',
      features: ['1 Software Endpoints', '200 Licenses', 'API Access', 'Dashboard'].join("\n\n"),
      display_order: 1
    })

    Plan.create({
      name: 'Gold',
      highlight: true, # This highlights the plan on the pricing page.
      price: 20.00,
      interval: 'month',
      stripe_id: '2',
      features: ['3 Software Endpoints', '3000 Licenses', 'API Access', 'Dashboard', 'Priority Support'].join("\n\n"),
      display_order: 2
    })

    Plan.create({
      name: 'Unliimited',
      price: 100.00, 
      interval: 'month',
      stripe_id: '3', 
      features: ['Unlimited Software Endpoints', 'Unlimited Licenses', 'API Access', 'Dashboard', 'Priority Support'].join("\n\n"), 
      display_order: 3
    })