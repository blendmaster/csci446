Order.transaction do
	100.times do |i|
		Order.create({
			name: "Customer #{i}",
			address: "#{i} Main Street",
			email: "#{i}@example.com",
			pay_type: "Check"
		})
	end
end

