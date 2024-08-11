Rails.configuration.to_prepare do
    class MYError < StandardError
    end

    class MYAuthenticationError < StandardError
    end
end