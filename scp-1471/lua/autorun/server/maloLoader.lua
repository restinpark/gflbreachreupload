--In the event that the version of breach we're running on doesn't load components, load malo ourselves.

if not BREACH_GetComponent then
    include("breach/components/malo.lua")
    ServerLog("Loaded breach.components.malo\n")
end