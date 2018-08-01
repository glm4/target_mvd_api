module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      headers = request.headers
      user = User.find_by(email: headers[:uid]) if headers[:uid].present?
      return user if user&.valid_token?(headers[:'access-token'], headers[:client])

      reject_unauthorized_connection
    end
  end
end
