OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '793181580695859', 'f7694cc315f760524d59b199002c4c02', {:provider_ignores_state => true}
end

OmniAuth.config.on_failure = Proc.new do |env| new_path = "/auth/failure"
 [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end