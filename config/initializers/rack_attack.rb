module Rack
  class Attack
    throttle('req/ip', limit: 10, period: 5, &:ip)

    throttle('limit patients creation', limit: 6, period: 60) do |req|
      req.params['phone'] if req.path == '/patients' && req.post?
    end

    throttle('limit phone validation', limit: 6, period: 60) do |req|
      req.params['number'] if req.path == '/phones/validate' && req.post?
    end
  end
end
