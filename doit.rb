Node.all.each do |node|
  parts = node.name.split(".")
  env = parts[-3]
  node.environment = env
  node.save
end
