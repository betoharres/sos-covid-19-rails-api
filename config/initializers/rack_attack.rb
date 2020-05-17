module Rack
  class Attack
    throttle('req/ip', limit: 6, period: 30, &:ip)

    throttle('limit patients creation', limit: 6, period: 3600) do |req|
      req.params['phone'] if req.path == '/patients' && req.post?
    end

    throttle('limit phone validation', limit: 10, period: 3600) do |req|
      req.params['number'] if req.path == '/phones/validate' && req.post?
    end

    throttle('limit phone creation', limit: 6, period: 3600) do |req|
      req.params['number'] if req.path == '/phones' && req.post?
    end
  end
end
