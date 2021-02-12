--Loading this file enables the APIs that are required by versions of breach made after May 13, 2019


--Event timer support. Now used by SCP-607 and medkits, might be used for the threser in a future version of site13
if SERVER then
    include("breach/components/eventTimers.lua")
end

if CLIENT then
    include("breach/components/cEventTimers.lua")
end