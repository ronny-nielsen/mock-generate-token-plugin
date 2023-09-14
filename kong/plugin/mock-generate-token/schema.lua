local typedefs = require "kong.db.schema.typedefs"
local plugin_name = "mock-generate-token"

local schema = {
  name = plugin_name,
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { tenant_id = { type = "string", required = true, default = "-1" }, }
        },
        entity_checks = {
          { at_least_one_of = { "tenant_id" } },
          { distinct = { "tenant_id" } }
        }
      },
    },
  },
}

return schema;