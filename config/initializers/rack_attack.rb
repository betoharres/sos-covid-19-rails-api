module Rack
  class Attack
    throttle('req/ip', limit: 1, period: 3, &:ip)
  end
end
