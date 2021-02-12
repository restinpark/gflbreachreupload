if SERVER then
  include("server.lua")
else
  include("client.lua")
end
