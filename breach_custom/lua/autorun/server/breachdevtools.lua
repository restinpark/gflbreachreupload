--Initially was gonna reduce the amount of copy and pasted code, but honestly I just didn't
COREUTILS = COREUTILS or {}

--A standard melee trace that returns the hit entity
--This function was written by kanade, it's fine. Leave it.
function COREUTILS:DoMeleeTrace(attacker, owner)
    local tr = util.TraceHull( {
        start = attacker:GetShootPos(),
        endpos = attacker:GetShootPos() + ( owner:GetAimVector() * 100 ),
        filter = attacker,
        mins = Vector( -10, -10, -10 ),
        maxs = Vector( 10, 10, 10 ),
        mask = MASK_SHOT_HULL
    } )
    return tr.Entity
end

COREUTILS.ScpUtils = COREUTILS.ScpUtils or {}

function COREUTILS.ScpUtils:HandleDamage(attacker, entity, inf)
    if attacker and IsValid(attacker) then
        if entity:GetClass() == "func_breakable" then
            entity:TakeDamage(200, attacker, inf)
        elseif BREACH_IsGateDoor and BREACH_IsGateDoor(entity) then
            entity:TakeDamage(math.random(20, 100), attacker, inf)
        end
    end
end