module Rack
  class Attack
    throttle('req/ip', limit: 4, period: 20, &:ip)
  end
end
