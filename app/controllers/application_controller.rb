class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
        token = auth_header.split(' ')[1]
        begin
          JWT.decode(token, 'secret', true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
    end
  end

  def authorized_member
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
      if @user.role != "member"
        render json: { message: 'Unauthorized' }, status: :unauthorized
      end
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end

  def authorized_admin
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
      if @user.role != "admin"
        render json: { message: 'Unauthorized' }, status: :unauthorized
      end
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end
end
