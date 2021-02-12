
-----------------------------------------------------
-------------------------------------
---------------- Cuffs --------------
-------------------------------------
-- Copyright (c) 2015 Nathan Healy --
-------- All rights reserved --------
-------------------------------------
-- weapon_cuff_standard.lua SHARED --
--                                 --
-- Rope handcuffs.                 --
-------------------------------------

AddCSLuaFile()

SWEP.Base = "weapon_leash_base"

SWEP.Category = "Handcuffs"
SWEP.Author = "my_hat_stinks"
SWEP.Instructions = "Use this to keep someone from moving long enough to convert them. Use E and LMB to attach them to walls to stop them from moving."

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AdminSpawnable = true
SWEP.droppable = false

SWEP.Slot = 3
SWEP.PrintName = "Rope Leash"

//
// Handcuff Vars
SWEP.CuffTime = 0.8 // Seconds to handcuff
SWEP.CuffSound = Sound( "buttons/lever7.wav" )

SWEP.CuffMaterial = "models/props_foliage/tree_deciduous_01a_trunk"
SWEP.CuffRope = "cable/rope"
SWEP.CuffStrength = 0.85
SWEP.CuffRegen = 0.8
SWEP.RopeLength = 100
SWEP.CuffReusable = true

SWEP.CuffBlindfold = false
SWEP.CuffGag = false

SWEP.CuffStrengthVariance = 0.1 // Randomise strangth
SWEP.CuffRegenVariance = 0.2 // Randomise regen
