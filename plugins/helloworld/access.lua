local _M = {}

function _M.execute(conf)
    ngx.log(ngx.ERR, "============ Hello World! ============")
    ngx.header["Hello-World"] = "Hello World!!!"
end

return _M