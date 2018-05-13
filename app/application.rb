class Application
	def call(env)
		resp = Rack::Response.new
		req = Rack::Request.new(env)

		if req.path.match(/items/)
			searched_item = req.path.split(/items/).last
			found = nil
			Item.all.each {|item| 
				# binding.pry
				if "/#{item.name}" == searched_item
					resp.write "#{item.price}"
					found = true
				end
			}
			if found == nil
				resp.status = 400
				resp.write "Item not found"
			end
		else
			resp.status = 404
			resp.write "Route not found"
		end
		resp.finish
	end
end