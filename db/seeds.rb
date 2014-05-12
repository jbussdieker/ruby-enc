# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
node1 = Node.find_or_create_by_name("node1")
node1.status = "unchanged"
node1.save
node2 = Node.find_or_create_by_name("node2")
node2.status = "changed"
node2.save
group1 = NodeGroup.find_or_create_by_name("group1")
group2 = NodeGroup.find_or_create_by_name("group2")
group3 = NodeGroup.find_or_create_by_name("group3")
