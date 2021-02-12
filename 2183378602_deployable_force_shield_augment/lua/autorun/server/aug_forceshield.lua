util.PrecacheSound("npc/attack_helicopter/aheli_mine_drop1.wav") -- diring shield deployer sound
util.PrecacheSound("buttons/combine_button_locked.wav") -- cooldown still active alert
util.PrecacheSound("npc/scanner/combat_scan5.wav") --cooldown over sound
game.AddParticles("vortigaunt_fx.pcf")

--Vmanip compatibility setup-------------------
--Initializing local func below outside of timer so that if 
--the user spams force_shield_deploy concommand as soon as he joins, it wont error 
local aug_forceshield_Vmanip_compatible = false 
timer.Simple(5, function() --"because if vmanip doesn't get loaded first then it'll think it's not there" -datæ (Thanks for bugfix)
    local file1Exists = file.Exists( "vmanip/anims/vmanip_baseanims.lua", "LUA" )
    local file2Exists = file.Exists( "vmanip/autorun/server/sv_vmanip.lua", "LUA" )
    local file3Exists = file.Exists( "vmanip/autorun/client/cl_vmanip.lua", "LUA" )
    if file1Exists or file2Exists or file3Exists then
        aug_forceshield_Vmanip_compatible = true 
    end
end)
-----------------------------------------------


local function forceShieldDeploy(ply)
    ply.active_aug1_cooldown = ply.active_aug1_cooldown or CurTime()
    ply.emitSoundCooldown = ply.emitSoundCooldown or CurTime() 
    local augJustFired = false --This is required so it doesnt play the cooldown sound when firing

    if(CurTime() >= ply.active_aug1_cooldown) then
        augJustFired = true --Were firing so the augment will have been fired at the end of this if block
        timer.Simple(.1,function()-- .1 seconds from this timer, set augJustFired back to false
            augJustFired = false
        end)
        ply.active_aug1_cooldown = CurTime() + 33
        timer.Simple(33, function() --Play a sound when cooldown is over
            ply:EmitSound("npc/scanner/combat_scan5.wav", 40) 
        end)
        ply:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav",35)

  
        --Vmanip check----------------------------
        if(aug_forceshield_Vmanip_compatible) then 
            net.Start("VManip_SimplePlay") 
            net.WriteString("use") 
            net.Send(ply)
        end---------------------------------------
        
   
    end
    --if the augment had just fired, wed better not play the cooldown sound
    --in addition, if the the users emitsoundcooldown isn't dont, we better not play the sound
    if(!augJustFired and CurTime() >= ply.emitSoundCooldown) then 
        ply.emitSoundCooldown = CurTime() + 2.5
        ply:EmitSound("buttons/combine_button_locked.wav",35)
    end
end

concommand.Add( "deploy_force_shield", forceShieldDeploy)

hook.Add( "PlayerInitialSpawn", "ClearShieldCoolDown", function( ply, transition)
    if transition == true then
        ply.active_aug1_cooldown = 0
        ply.emitSoundCooldown = 0
    end
end )

