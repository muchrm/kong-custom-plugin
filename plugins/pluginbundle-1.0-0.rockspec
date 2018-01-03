package = "pluginbundle"
version = "1.0-0"
source = {
  url = "kong.com"
}
description = {
  license = "None"
}
dependencies = {
  "lua ~> 5.1", "inspect ~> 3.1.0"
  -- If you depend on other rocks, add them here
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.helloworld.handler"] = "helloworld/handler.lua",
    ["kong.plugins.helloworld.schema"] = "helloworld/schema.lua",
    ["kong.plugins.helloworld.access"] = "helloworld/access.lua",
    }
}
