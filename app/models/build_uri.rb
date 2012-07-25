module BuildUri
	def build_uri(params=nil)
		if params
		  BASE_URI + "&" + params.join("&")
		else
		  BASE_URI
		end
	end
end