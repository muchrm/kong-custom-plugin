local cjson = require "cjson"
local jwt = require "resty.jwt"
local singletons = require "kong.singletons"
local responses = require "kong.tools.responses"

local function retrieve_credentials()
    ngx.req.read_body()
    local text = ngx.var.request_body
    local value = cjson.decode(text)
    return value["username"],value["password"];
end

local function fetch_acls(username)
    print(username)
    local results, err = singletons.dao.acls:find_all {username = username}
    if err then
      return nil, err
    end
    return results
end
  
local function load_credential(username)
    print(username)
    local rows, err = singletons.dao.jwt_secrets:find_all {username = username, algorithm = "HS256"}
    if err then
      return nil, err
    end
    return rows[1]
end

local _M = {}

function _M.execute(conf)
    local username, password = retrieve_credentials()
    local acls, err = fetch_acls(username)

    if err then
        return responses.send_HTTP_INTERNAL_SERVER_ERROR(err)
    end
    
    local credential, err = load_credential(consumer_id)

    local jwt_token = jwt:sign(
        "lua-resty-jwt",
        {
        header = {
            typ = "JWT",
            alg = "HS256"
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