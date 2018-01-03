local cjson = require "cjson"
local _M = {}

function _M.execute(conf)
    ngx.say(
    cjson.encode(
      {
        data = "Hello-World"
      }
    )
  )
  ngx.exit(200)
end

return _M