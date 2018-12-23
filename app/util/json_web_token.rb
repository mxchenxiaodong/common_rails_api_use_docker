require 'jwt'

class JsonWebToken
  class << self
    SECRET_KEY_BASE = '74995d21ff6ec3b964073514682d5005f5e0eb6710b23ee1c0b972a3693df0421331997c155c55f602c2188da2ebbc0439d260ce1d2e821f691fa8529ee6b5a0'

    def encode(payload)
      payload.reverse_merge!(meta)
      JWT.encode(payload, SECRET_KEY_BASE)
    end

    def decode(token)
      JWT.decode(token, SECRET_KEY_BASE)
    end

    # Validates the payload hash for expiration and meta claims
    def valid_payload(payload)
      if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
        return false
      else
        return true
      end
    end

    # Default options to be encoded in the token
    def meta
      {
        exp: 7.days.from_now.to_i,
        iss: 'issuer_name',
        aud: 'client',
      }
    end

    # Validates if the token is expired by exp parameter
    def expired(payload)
      Time.at(payload['exp']) < Time.now
    end
  end
end
