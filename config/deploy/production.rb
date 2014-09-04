set :user, 'rgp'
server 'frodo', user: fetch(:user),
  roles: %w{web app db}
