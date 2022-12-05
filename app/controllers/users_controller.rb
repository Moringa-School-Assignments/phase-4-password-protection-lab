class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    def create
        user = User.create!(user_params)
        session[:user] = user.id
        render json: user, status: :created, except: [:created_at, :updated_at]

    end

    def show
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            render json: user, status: :ok
        else
            render json: {errors: user.errors}, status: :not_found
        end
    end

    private

    def record_invalid(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end

    def user_params
        params.permit(:username, :password)
    end
end
