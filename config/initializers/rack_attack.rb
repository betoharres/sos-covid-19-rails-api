module Rack
  class Attack
    throttle('req/ip', limit: 10, period: 5, &:ip)
    # Throttle login attempts for a given email parameter to 6 reqs/minute
    # Return the email as a discriminator on POST /login requests
    throttle('limit patients creation', limit: 6, period: 60) do |req|
      req.params['phone'] if req.path == '/patients' && req.post?
    end
  end
end
