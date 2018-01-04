local cjson = require "cjson"
local jwt = require "resty.jwt"
local _M = {}

function _M.execute(conf)

    local jwt_token = jwt:sign(
        "lua-resty-jwt",
        {
        header = {
            typ = "JWT",
            alg = "HS256" -- load_credential only loads HS256 for now
        },
        payload = {
            sub = "clerk",
            iss = "http://muchrm.me",
            iat = ngx.time(),
            exp = ngx.time() + 60
        }
        }
    )

    ngx.status = ngx.HTTP_OK  
    ngx.header.content_type = "application/json; charset=utf-8"  
    ngx.say(cjson.encode({
        data = {
            access_token = jwt_token,
            token_type = "Bearer",
            expires_in = 60
        }
      }))  
    return ngx.exit(ngx.HTTP_OK)
end

return _M