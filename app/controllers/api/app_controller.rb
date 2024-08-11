module Api
  class AppController < ApplicationController
    rescue_from MYError, with: :handle_400
    rescue_from MYAuthenticationError, with: :handle_401
    rescue_from JWT::VerificationError, with: :handle_401
    rescue_from JWT::ExpiredSignature, with: :handle_401
    rescue_from JWT::DecodeError, with: :handle_401

    private

    def handle_400(exception)
      render json: { success: false, error: exception.message }, status: :bad_request and return
    end

    def handle_401(exception)
      render json: { success: false, error: exception.message }, status: :unauthorized and return
    end
  end
end