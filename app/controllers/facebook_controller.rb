class FacebookController < ApplicationController
	def index
		client = FBGraph::Client.new(:client_id => '793181580695859', 
			:secret_id => 'f7694cc315f760524d59b199002c4c02', 
			:token => current_user.oauth_token)
		@user = client.selection.me.info!
	end
end
