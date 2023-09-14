package = "mock-generate-token"
version = "1.0.1-1"

source = {
    url = "*** please add URL for source tarball, zip or repository here ***"
}

description = {
    homepage = "*** please enter project homepage ***",
    license = "*** please specify a license ***"
}

dependencies = {
    "luasocket >= 3.1",
    "luajson >= 1.3"
}

build = {
    type = "builtin",
    modules = {
        handler = "kong/plugins/mock-generate-token/handler.lua",
        schema = "kong/plugins/mock-generate-token/schema.lua"
    }
}