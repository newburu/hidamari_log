server "rails-server", user: "rails", roles: %w[app db web]

set :ssh_options, {
  keys: %w[/Users/newburu/.ssh/rails-server],
  forward_agent: true
  # auth_methods: %w(publickey) # Removed to allow other methods or better fallback
}
