local ltn12 = require("ltn12")
local http = require("socket.http")
local json = require("json")

local MockGenerateToken = {
    VERSION = "1.0.1",
    PRIORITY = 1300
}

function generate(conf)
    local tenantId = conf["tenant_id"]
    local requestBody = '{ "aud": "gateway.apiway.net", "iss": "gateway.apiway.net", "tenantIdClaim": ' .. tenantId .. ' }'
    local body = {}

    local res, code, headers, status = http.request {
        method = "POST",
        url = "https://mock.api.apiway.net/v1/token",
        source = ltn12.source.string(requestBody),
        headers = {
            ["content-type"] = "application/json",
            ["content-length"] = string.len(requestBody)
        },
        sink = ltn12.sink.table(body)
    }

    local response = table.concat(body)
    local decode = json.decode(response)
    local token = decode["value"]
    local bearer = "Bearer " .. token

    kong.service.request.set_header("Authorization", bearer)

    return response;
end

function MockGenerateToken:init_worker()
    -- Implement logic for the init_worker phase here (http/stream)
    kong.log("init_worker")
end

function MockGenerateToken:preread()
    -- Implement logic for the preread phase here (stream)
    kong.log("preread")
end

function MockGenerateToken:certificate(config)
    -- Implement logic for the certificate phase here (http/stream)
    kong.log("certificate")
end

function MockGenerateToken:rewrite(config)
    -- Implement logic for the rewrite phase here (http)
    kong.log("rewrite")
end

function MockGenerateToken:access(config)
    -- Implement logic for the access phase here (http)
    kong.log("access")
    generate(config)
end
function CustomHandler:ws_handshake(config)
    -- Implement logic for the WebSocket handshake here
    kong.log("ws_handshake")
  end
  
  function CustomHandler:header_filter(config)
    -- Implement logic for the header_filter phase here (http)
    kong.log("header_filter")
  end
  
  function CustomHandler:ws_client_frame(config)
    -- Implement logic for WebSocket client messages here
    kong.log("ws_client_frame")
  end
  
  function CustomHandler:ws_upstream_frame(config)
    -- Implement logic for WebSocket upstream messages here
    kong.log("ws_upstream_frame")
  end
  
  function CustomHandler:body_filter(config)
    -- Implement logic for the body_filter phase here (http)
    kong.log("body_filter")
  end
  
  function CustomHandler:log(config)
    -- Implement logic for the log phase here (http/stream)
    kong.log("log")
  end
  
  function CustomHandler:ws_close(config)
    -- Implement logic for WebSocket post-connection here
    kong.log("ws_close")
  end

  return MockGenerateToken