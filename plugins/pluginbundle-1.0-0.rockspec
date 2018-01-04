package = "pluginbundle"
version = "1.0-0"
source = {
  url = "kong.com"
}
description = {
  license = "None"
}
dependencies = {
  "lua ~> 5.1",
  "inspect ~> 3.1.0",
  "lua-resty-jwt ~> 0.1.10-1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.mis-login.handler"] = "mis-login/handler.lua",
    ["kong.plugins.mis-login.schema"] = "mis-login/schema.lua",
    ["kong.plugins.mis-login.access"] = "mis-login/access.lua",
    }
}
