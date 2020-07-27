Destination.all.each do |destination|
    destination.update(user_id: [1, 2].sample)
end