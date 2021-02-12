if SERVER then AddCSLuaFile() end

TFABOI = {}
TFABOI.Items = {}
TFABOI.Items2 = {}

IsaacItem = {}
IsaacItem.Name = "The Sad Onion"
IsaacItem.ID = "1"
IsaacItem.Pickup = "Tears up"
IsaacItem.Desc = "+0.7 Tears Up"
IsaacItem.Stats = { ["Tears"] = "0.7" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[1] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Inner Eye"
IsaacItem.ID = "2"
IsaacItem.Pickup = "Triple shot"
IsaacItem.Desc = "Tears now shoot three at a time (Triple Shot) Tears Down significantly (tears = tears * 2.1 + 3)."
IsaacItem.Stats = {  ["TearsShot"] = "3", ["TearDelayMult"] = "1.1", ["TearDelayExtra"] = "3", ["TearSpread"] = "80" }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[2] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spoon Bender"
IsaacItem.ID = "3"
IsaacItem.Pickup = "Homing shots"
IsaacItem.Desc = "Gives Isaac's tears a homing effect."
IsaacItem.Tear = {  ["Homing"] = true }
IsaacItem.Type = {"Passive"}
TFABOI.Items[3] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cricket's Head"
IsaacItem.ID = "4"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+0.5 Damage Up +50% / 1.5 times Damage Multiplier (Does not stack with the Magic Mushroom multiplier). Tears now have a significant knockback effect (Does not increase the shot speed stat). Can be found in golden chests. Cricket's Head used to be known as 'Max's Head in the original game and was renamed for Rebirth."
IsaacItem.Stats = { ["Damage"] = "0.5", ["DamageMult"] = "0.5" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[4] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "My Reflection"
IsaacItem.ID = "5"
IsaacItem.Pickup = "Boomerang tears"
IsaacItem.Desc = "Gives tears a boomerang effect. +1.5 Range Up. +0.6 Shot Speed Up. +1 Tear Height."
IsaacItem.Stats = { ["Range"] = "1.5", ["ShotSpeed"] = "0.6" }
IsaacItem.Tear = {  ["Boomerang"] = true }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[5] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Number One"
IsaacItem.ID = "6"
IsaacItem.Pickup = "Tears up"
IsaacItem.Desc = "Gives you a very high tear rate in exchange for a big range down. +1.5 Tears Up. -15.78 Range Down. +0.45 Tear Height."
IsaacItem.Stats = { ["Tears"] = "1.5", ["Range"] = "-15.78" }
IsaacItem.Color = { [25] = {255,255,0}}
IsaacItem.Type = {"Passive"}
TFABOI.Items[6] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blood of the Martyr"
IsaacItem.ID = "7"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+1.0 Damage Up. +50% / 1.5 times Damage Multiplier if you also have Book of Belial (Does not stack with Magic Mushroom or Cricket's Head multipliers) This item can only be found in the item room pool, unlike the original game where it was also a god item"
IsaacItem.Stats = { ["Damage"] = "1", ["DamageMult"] = "0.5" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[7] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Brother Bobby"
IsaacItem.ID = "8"
IsaacItem.Pickup = "Friends 'till the end"
IsaacItem.Desc = "A familiar which follows Isaac and shoots normal tears which do 3.5 damage. Brother Bobby fires tears at a rate of 1 tear per second."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[8] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Skatole"
IsaacItem.ID = "9"
IsaacItem.Pickup = "Fly love"
IsaacItem.Desc = "All fly enemies are no longer aggressive towards Isaac. Is only available from the shell game in the arcade. Can be won from the arcade skull game. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive"}
TFABOI.Items[9] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Halo of Flies"
IsaacItem.ID = "10"
IsaacItem.Pickup = "Projectile protection"
IsaacItem.Desc = "Gives Isaac 2 orbital flies which block enemy shots. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[10] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "1UP"
IsaacItem.ID = "11"
IsaacItem.Pickup = "Extra life"
IsaacItem.Desc = "Gives the player an extra life When revived, the green mushroom that follows Isaac will disappear and he will respawn with the same amount of red heart containers at full health. Resurrection takes place before all other items which give you an extra live, except Guppy's Collar."
IsaacItem.Type = {"Passive"}
TFABOI.Items[11] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Magic Mushroom"
IsaacItem.ID = "12"
IsaacItem.Pickup = "All stats up!"
IsaacItem.Desc = "+1 Health Up. +0.3 Damage Up. +50% / 1.5 times Damage Multiplier (Does not stack with the multipliers from Cricket's Head / Blood of The Martyr + Book of Belial). +5.25 Range Up. +0.3 Speed Up. +0.5 Tear Height. Increases the size of your player sprite, but doesn't increase the hitbox. Similar to the original game, the Magic Mushroom does not give a tears up despite saying 'All Stats Up'. Fully restores all red heart containers. Can be dropped when exploding mushrooms in the Caves/Catacombs."
IsaacItem.Stats = { ["Damage"] = "0.3", ["DamageMult"] = "0.5", ["Range"] = "5.25", ["Speed"] = "0.3" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[12] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Virus"
IsaacItem.ID = "13"
IsaacItem.Pickup = "Poison touch"
IsaacItem.Desc = "Deals poison damage on contact with enemies (Damage over time 4 or 6 per tick). -0.1 Speed Down. (Cached: Only applied after the speed stat is next updated) Has a chance to drop from the Lust miniboss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[13] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Roid Rage"
IsaacItem.ID = "14"
IsaacItem.Pickup = "Speed and range up"
IsaacItem.Desc = "+0.6 Speed Up. +5.25 Range Up. +0.5 Shot Height."
IsaacItem.Stats = { ["Speed"] = "0.6", ["Range"] = "5.25" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[14] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "<3"
IsaacItem.ID = "15"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up Fully restores all red heart containers Has a chance to drop from the Gluttony miniboss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[15] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Raw Liver"
IsaacItem.ID = "16"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+2 Health Up. Full red heart heal."
IsaacItem.Type = {"Passive"}
TFABOI.Items[16] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Skeleton Key"
IsaacItem.ID = "17"
IsaacItem.Pickup = "99 keys"
IsaacItem.Desc = "+99 Keys"
IsaacItem.Type = {"Passive"}
TFABOI.Items[17] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "A Dollar"
IsaacItem.ID = "18"
IsaacItem.Pickup = "$$$"
IsaacItem.Desc = "+99 coins. Can drop from an exploding slot machine while playing it."
IsaacItem.Type = {"Passive"}
TFABOI.Items[18] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Boom!"
IsaacItem.ID = "19"
IsaacItem.Pickup = "10 bombs"
IsaacItem.Desc = "+10 Bombs"
IsaacItem.Type = {"Passive"}
TFABOI.Items[19] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Transcendence"
IsaacItem.ID = "20"
IsaacItem.Pickup = "We all float down here..."
IsaacItem.Desc = "Gives Isaac the ability to fly."
IsaacItem.Player = {["Fly"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[20] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Compass"
IsaacItem.ID = "21"
IsaacItem.Pickup = "The end is near"
IsaacItem.Desc = "Shows all icons on the map (e.g. Shop) Does not show the layout of the map. Room icons will not show if a Curse of the Lost is in effect on the current floor."
IsaacItem.Type = {"Passive"}
TFABOI.Items[21] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lunch"
IsaacItem.ID = "22"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[22] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dinner"
IsaacItem.ID = "23"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[23] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dessert"
IsaacItem.ID = "24"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[24] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Breakfast"
IsaacItem.ID = "25"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[25] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Rotten Meat"
IsaacItem.ID = "26"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up"
IsaacItem.Type = {"Passive"}
TFABOI.Items[26] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Wooden Spoon"
IsaacItem.ID = "27"
IsaacItem.Pickup = "Speed up"
IsaacItem.Desc = "+0.3 Speed Up."
-- IsaacItem.Stats = { ["Speed"] = "0.3" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[27] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Belt"
IsaacItem.ID = "28"
IsaacItem.Pickup = "Speed up"
IsaacItem.Desc = "+0.3 Speed Up."
-- IsaacItem.Stats = { ["Speed"] = "0.3" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[28] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Underwear"
IsaacItem.ID = "29"
IsaacItem.Pickup = "Range Up"
IsaacItem.Desc = "+5.25 Range Up +0.5 Tear Height."
IsaacItem.Stats = { ["Range"] = "5.25" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[29] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Heels"
IsaacItem.ID = "30"
IsaacItem.Pickup = "Range up"
IsaacItem.Desc = "+5.25 Range Up +0.5 Tear Height."
IsaacItem.Stats = { ["Range"] = "5.25" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[30] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Lipstick"
IsaacItem.ID = "31"
IsaacItem.Pickup = "Range up"
IsaacItem.Desc = "+5.25 Range Up +0.5 Tear Height."
IsaacItem.Stats = { ["Range"] = "5.25" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[31] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Wire Coat Hanger"
IsaacItem.ID = "32"
IsaacItem.Pickup = "Tears up"
IsaacItem.Desc = "+0.7 Tears Up."
IsaacItem.Stats = { ["Tears"] = "0.7" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[32] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Bible"
IsaacItem.ID = "33"
IsaacItem.Pickup = "Temporary flight"
IsaacItem.Desc = "Gives Isaac angel wings for the current room, allowing him to fly. If used during the Mom's Foot or Mom's Heart boss fights, The Bible will kill Mom instantly. If used during the Satan fight, The Bible will instantly kill Isaac."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms."
TFABOI.Items[33] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Book of Belial"
IsaacItem.ID = "34"
IsaacItem.Pickup = "Temporary DMG up"
IsaacItem.Desc = "Upon use, gives +2 damage up which lasts for the current room. +50% / 1.5 times Damage Multiplier if you also have Blood of the Martyr (Does not stack with Magic Mushroom or Cricket's Head multipliers). Guaranteed Devil or Angel Room if you have it when you kill the boss on all floors where it's possible to get one. Judas starts with this item."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[34] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Necronomicon"
IsaacItem.ID = "35"
IsaacItem.Pickup = "Mass room damage"
IsaacItem.Desc = "Deals 40 damage to everything in the room when used."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[35] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Poop"
IsaacItem.ID = "36"
IsaacItem.Pickup = "Plop!"
IsaacItem.Desc = "Drops a poop on the floor. Blue Baby starts with this item. Can be placed next to a pit and exploded to make a bridge. Can be placed over a broken red poop to overwrite it, causing it to no longer regenerate."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[36] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mr. Boom"
IsaacItem.ID = "37"
IsaacItem.Pickup = "Reusable bomb buddy"
IsaacItem.Desc = "Drops a large bomb below the player which does 110 damage. Has a chance to drop from the Wrath miniboss fight."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[37] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tammy's Head"
IsaacItem.ID = "38"
IsaacItem.Pickup = "Reusable tear burst"
IsaacItem.Desc = "Fires 10 tears in a circle around Isaac. Each tear is equal to your damage stat + 25 flat damage. The tears spawned from Tammy's Head retain tear effects of Isaac's tears, such as poison or homing. Synergizes extremely well with Brimstone due to how the damage from both items is calculated when combined."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[38] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Bra"
IsaacItem.ID = "39"
IsaacItem.Pickup = "Mass fear"
IsaacItem.Desc = "When used, freezes all enemies in the current room temporarily."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[39] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Kamikaze"
IsaacItem.ID = "40"
IsaacItem.Pickup = "Become the bomb!"
IsaacItem.Desc = "Causes an explosion near the player which takes away half a heart and does 40 damage all enemies in close proximity."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[40] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Pad"
IsaacItem.ID = "41"
IsaacItem.Pickup = "Gross..."
IsaacItem.Desc = "When used, causes all enemies in the current room to run away from Isaac in fear for a few seconds."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[41] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bob's Rotten Head"
IsaacItem.ID = "42"
IsaacItem.Pickup = "Reusable ranged bomb"
IsaacItem.Desc = "A poison bomb which can be thrown and leaves a poison effect on any enemies within the blast radius. The bomb deals 50 damage on hit and leaves a damage over time poison effect that does 6 or 8 damage per tick. Synergizes with tear modifying items such as My Reflection or Tiny Planet. Has a chance to drop from the Sloth miniboss fight."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[42] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Teleport"
IsaacItem.ID = "44"
IsaacItem.Pickup = "Teleport!"
IsaacItem.Desc = "Teleports Isaac to a random location on the map."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[44] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Yum Heart"
IsaacItem.ID = "45"
IsaacItem.Pickup = "Reusable regeneration"
IsaacItem.Desc = "Heals Isaac for one whole red heart. Maggy starts with this item. Has a chance to drop from the Super Lust miniboss fight."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[45] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lucky Foot"
IsaacItem.ID = "46"
IsaacItem.Pickup = "Luck up"
IsaacItem.Desc = "+1.0 Luck Up. Better chance to win while gambling. Does not make all pills positive or neutral like the original game."
-- IsaacItem.Stats = { ["Luck"] = "1" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[46] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Doctor's Remote"
IsaacItem.ID = "47"
IsaacItem.Pickup = "Reusable air strike"
IsaacItem.Desc = "A target is placed on the floor which can be controlled. After a few seconds a huge missile hits the target and deals 70 damage to anything nearby. The damage dealt from this item scales with your damage stat. Essentially a one-time more powerful use of the Epic Fetus item."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[47] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cupid's Arrow"
IsaacItem.ID = "48"
IsaacItem.Pickup = "Piercing shots"
IsaacItem.Desc = "Isaac's tears now have a piercing effect which allows them to travel through enemies whilst damaging them."
IsaacItem.Tear = { ["Piercing"] = true }
IsaacItem.Type = {"Passive"}
TFABOI.Items[48] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Shoop Da Whoop"
IsaacItem.ID = "49"
IsaacItem.Pickup = "BLLLARRRRGGG!"
IsaacItem.Desc = "When used, fires a high damage laser in a straight line across the room in a similar way to Brimstone. The laser deals damage equal to your tear damage * 4, at 7 ticks per laser, meaning the maximum potential damage per laser is your tear damage * 28. Has a chance to drop from the Envy and Super Envy miniboss fights."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[49] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Steven"
IsaacItem.ID = "50"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+1 Damage Up. Has a small chance to drop from the Steven boss fight."
IsaacItem.Stats = { ["Damage"] = "1" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[50] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pentagram"
IsaacItem.ID = "51"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+1.0 Damage Up. Higher chance of a Devil Deal opening after the boss fight (Approximately +20% through testing)."
IsaacItem.Stats = { ["Damage"] = "1" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[51] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dr. Fetus"
IsaacItem.ID = "52"
IsaacItem.Pickup = "???"
IsaacItem.Desc = "Instead of tears, Isaac now shoots bombs from his eyes, which explode dealing damage to anything nearby. Bomb damage = damage * 5 + 30. Tears Down (Tear delay * 2.5). Bombs will also synergize with other bomb items and tear modifiers, including Sad Bombs, Mr. Mega and many more."
IsaacItem.Stats = { ["TearDelayMult"] = "1.5" }
IsaacItem.Tear = {  ["Bombs"] = true }
IsaacItem.Color = { [48] = {50,50,50}}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[52] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Magneto"
IsaacItem.ID = "53"
IsaacItem.Pickup = "Item snatcher"
IsaacItem.Desc = "Causes pickups on the floor move towards the player."
IsaacItem.Type = {"Passive"}
TFABOI.Items[53] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Treasure Map"
IsaacItem.ID = "54"
IsaacItem.Pickup = "Full visible map"
IsaacItem.Desc = "Reveals the entire map for every floor not including both secret room locations. Does not show the icons for any unknown rooms. Can still help you to guess which direction the boss room is in, due to the fact that the Boss Room is usually in the room furthest away from the first room."
IsaacItem.Type = {"Passive"}
TFABOI.Items[54] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Eye"
IsaacItem.ID = "55"
IsaacItem.Pickup = "Eye in the back of your head"
IsaacItem.Desc = "Isaac has a random chance to fire another tear out the back of his head. The chance to fire the second tear can improve based on your luck stat and will always activate at +2 Luck. Synergizes very well with a lot of items. If used with Brimstone you have a 100% chance to fire a laser out the back of your head."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[55] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lemon Mishap"
IsaacItem.ID = "56"
IsaacItem.Pickup = "Oops..."
IsaacItem.Desc = "When used, drops a pool of 'lemonade' on the floor which damages any enemies that come into contact with it for 8 damage per tick."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[56] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Distant Admiration"
IsaacItem.ID = "57"
IsaacItem.Pickup = "Attack fly"
IsaacItem.Desc = "Gives Isaac an orbiting fly which deals 5 contact damage to enemies per tick. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[57] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Book of Shadows"
IsaacItem.ID = "58"
IsaacItem.Pickup = "Temporary invincibility"
IsaacItem.Desc = "Gives the player an invulnerability effect which lasts for a few seconds."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[58] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Ladder"
IsaacItem.ID = "60"
IsaacItem.Pickup = "Building bridges"
IsaacItem.Desc = "Allows Isaac to walk over gaps with a width of one tile."
IsaacItem.Type = {"Passive"}
TFABOI.Items[60] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Charm of the Vampire"
IsaacItem.ID = "62"
IsaacItem.Pickup = "Kills heal"
IsaacItem.Desc = "Heals half a heart after every 13 enemies killed."
IsaacItem.Type = {"Passive"}
TFABOI.Items[62] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Battery"
IsaacItem.ID = "63"
IsaacItem.Pickup = "Stores energy"
IsaacItem.Desc = "All spacebar items can now be 'overcharged', allowing them to be charged up twice instead of once. The extra charges appear in yellow on top of the normal green bars. Has no effect with items which recharge over time instead of on a per-room basis."
IsaacItem.Type = {"Passive"}
TFABOI.Items[63] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Steam Sale"
IsaacItem.ID = "64"
IsaacItem.Pickup = "50% off"
IsaacItem.Desc = "Items in the shop are now -50% off, rounded down to the nearest whole number. Has a chance to drop from the Greed miniboss fight or when bombing the shopkeeper. This item is called Steamy Sale on PS4, PS Vita, Xbox One and Switch versions, probably due to copyright reasons."
IsaacItem.Type = {"Passive"}
TFABOI.Items[64] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Anarchist's Cookbook"
IsaacItem.ID = "65"
IsaacItem.Pickup = "Summon bombs"
IsaacItem.Desc = "Spawns troll bombs at random locations around the room. Bombs are effected by other passive bomb items. Has a chance to drop from the Pride miniboss fight."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms."
TFABOI.Items[65] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Hourglass"
IsaacItem.ID = "66"
IsaacItem.Pickup = "Temporary enemy slowdown"
IsaacItem.Desc = "When used, slows down all enemies in the current room and their projectiles for a short period of time."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[66] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sister Maggy"
IsaacItem.ID = "67"
IsaacItem.Pickup = "Friends 'till the end"
IsaacItem.Desc = "A familiar which follows Isaac around and shoots blood tears that deal 3.5 damage. The tears appear red but have no additional damage. Sister Maggy fires tears at a rate of 1 tear per second."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[67] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Technology"
IsaacItem.ID = "68"
IsaacItem.Pickup = "Laser tears"
IsaacItem.Desc = "Isaac's tears are replaced with a laser that has unlimited range and can only fire at right angles. Lasers travel through enemies but not obstacles in the room."
IsaacItem.Color = { [46] = {255,0,0} }
IsaacItem.Tear = {  ["Technology"] = true, ["Piercing"] = true }
IsaacItem.Ent = { [5] = "_laser" }
IsaacItem.Stats = { ["ShotSpeed"] = "2" }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[68] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Chocolate Milk"
IsaacItem.ID = "69"
IsaacItem.Pickup = "Charge shots"
IsaacItem.Desc = "Isaac can now charge shots for more damage by holding down the fire button. At full charge, your tears do 4 times more damage. Tears fired at the minimum possible charge do roughly 1/3 of your normal damage. Tears up - Spamming the fire button allows for rapid fire shots at normal damage."
-- IsaacItem.Tear = {  ["Charging"] = true }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[69] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Growth Hormones"
IsaacItem.ID = "70"
IsaacItem.Pickup = "DMG up + speed up"
IsaacItem.Desc = "+1.0 Damage Up +0.4 Speed Up"
-- IsaacItem.Stats = { ["Damage"] = "1", ["Speed"] = "0.4" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[70] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mini Mush"
IsaacItem.ID = "71"
IsaacItem.Pickup = "Speed + range up"
IsaacItem.Desc = "+0.3 Speed Up Decreases range stat by -4.25 but increases your tear height by 1.5, increasing your actual tear range. Causes Isaac to shrink in size (including hitbox slightly). Can be dropped when exploding mushrooms in the environment that are usually found in the Caves/Catacombs and in secret rooms."
-- IsaacItem.Stats = { ["Speed"] = "0.3", ["Range"] = "-4.25" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[71] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Rosary"
IsaacItem.ID = "72"
IsaacItem.Pickup = "Faith up"
IsaacItem.Desc = "+3 Soul Hearts. Adds several instances of The Bible item into the Boss Room, Shop, Beggar, Secret Room, Gold Chest and Devil Pools."
IsaacItem.Type = {"Passive"}
TFABOI.Items[72] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cube of Meat"
IsaacItem.ID = "73"
IsaacItem.Pickup = "Gotta meat em all"
IsaacItem.Desc = "An orbital which blocks shots and damages enemies it comes into contact with for 7 damage per tick. Exclusively drops from one of the horsemen bosses. 2 cubes of meat transform the orbital into a meat head which fires blood tears which deal 3.5 damage each. 3 cubes of meat transform it into a meat boy familiar that walks around and deals 3.5 contact damage per tick to enemies. 4 cubes of meat cause the meat boy familiar to grow in size and do 5.5 damage per tick instead. Any further cubes of meat past 4 will start the cycle again."
IsaacItem.Type = {"Passive"}
TFABOI.Items[73] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "A Quarter"
IsaacItem.ID = "74"
IsaacItem.Pickup = "+25 coins"
IsaacItem.Desc = "+25 Coins Has a very small chance to drop after destroying one of the pots that appear in the Basement and Cellar floors. Has a chance to drop from the Super Greed miniboss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[74] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "PhD"
IsaacItem.ID = "75"
IsaacItem.Pickup = "Better pills"
IsaacItem.Desc = "All pills now have a positive or neutral effect. Pills are identified before using them. Drops one pill on pickup. Heals for 2 full red hearts."
IsaacItem.Type = {"Passive"}
TFABOI.Items[75] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "X-Ray Vision"
IsaacItem.ID = "76"
IsaacItem.Pickup = "I've seen everything"
IsaacItem.Desc = "Reveals the entrance to secret rooms and automatically opens the hole, removing the need for bombs to enter."
IsaacItem.Type = {"Passive"}
TFABOI.Items[76] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "My Little Unicorn"
IsaacItem.ID = "77"
IsaacItem.Pickup = "Temporary badass"
IsaacItem.Desc = "Gives Isaac temporary invincibility and allows him to do 40 contact damage to enemies per hit."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[77] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Book of Revelations"
IsaacItem.ID = "78"
IsaacItem.Pickup = "Reusable soul protection"
IsaacItem.Desc = "Upon use, gives Isaac an extra Soul heart. Using this item gives you a higher chance of finding a horsemen boss at the end of the floor. +25% chance of a Devil Deal opening after the boss fight"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[78] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Mark"
IsaacItem.ID = "79"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+1.0 Damage Up. +0.2 Speed Up. +1 Soul Heart."
IsaacItem.Stats = { ["Damage"] = "1", ["Speed"] = "0.2" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[79] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Pact"
IsaacItem.ID = "80"
IsaacItem.Pickup = "DMG + tears up"
IsaacItem.Desc = "+0.5 Damage Up. +0.7 Tears Up. +2 Soul Hearts."
IsaacItem.Stats = { ["Damage"] = "0.5", ["Tears"] = "0.7" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[80] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Cat"
IsaacItem.ID = "81"
IsaacItem.Pickup = "9 lives"
IsaacItem.Desc = "Isaac's health is set to 1 and he also gains 9 extra lives. Each time Isaac dies, he will respawn with 1 Health. Has a chance to drop from the Super Pride mini boss. The floating Dead Cat head that follows you will disappear when you are on your last life (Very useful for The Lost) This is one of the items which allows you to transform into Guppy."
IsaacItem.Type = {"Passive"}
TFABOI.Items[81] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lord of the Pit"
IsaacItem.ID = "82"
IsaacItem.Pickup = "Demon wings"
IsaacItem.Desc = "Gives Isaac demon wings and the ability to fly. +0.3 Speed Up (Only applied after the speed stat is next updated)."
-- IsaacItem.Player = {["Fly"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[82] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Nail"
IsaacItem.ID = "83"
IsaacItem.Pickup = "Temporary demon form"
IsaacItem.Desc = "+0.7 Damage Up. -0.18 Speed Down. +1 Soul Heart Gives you the ability to crush rocks by walking over them. Allows Isaac to deal contact damage to enemies for the current room. Does not prevent Isaac from taking contact damage. All the above effects are only active when the item is used for the current room."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[83] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "We Need To Go Deeper"
IsaacItem.ID = "84"
IsaacItem.Pickup = "Reusable level skip"
IsaacItem.Desc = "Spawns a trapdoor at Isaac's feet which allows him to travel to the next floor. The trapdoor has a 10% chance to become a Black Market. Has no effect in Sheol, Cathedral, Chest and Dark Room. Cannot spawn a trapdoor directly infront of a secret room entrance. Can destroy rocks if used when Isaac is flying over a rock."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[84] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Deck of Cards"
IsaacItem.ID = "85"
IsaacItem.Pickup = "Reusable card generator"
IsaacItem.Desc = "Gives Isaac a random tarot card on use."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[85] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Monstro's Tooth"
IsaacItem.ID = "86"
IsaacItem.Pickup = "Summon monstro"
IsaacItem.Desc = "When used, spawns a Monstro which will jump on a random enemy in the room, dealing 120 damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[86] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Loki's Horns"
IsaacItem.ID = "87"
IsaacItem.Pickup = "Cross tears"
IsaacItem.Desc = "Everytime you fire a tear, there is a chance that you will also fire three more tears in all cardinal directions. The chance to fire 4-way tears is affected by your luck stat and at +7 Luck it will activate every time."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[87] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Little Chubby"
IsaacItem.ID = "88"
IsaacItem.Pickup = "Attack buddy"
IsaacItem.Desc = "A familiar that follows Isaac and charges forwards, dealing 3.5 damage per tick to any enemies it comes into contact with."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[88] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spider Bite"
IsaacItem.ID = "89"
IsaacItem.Pickup = "Slow effect"
IsaacItem.Desc = "Tears now have a chance of slowing enemies and their projectiles for 2.5 seconds. The chance to slow enemies is affected by your luck stat and at +15 Luck it will activate every time."
IsaacItem.Tear = { ["Slow"] = true }
IsaacItem.Type = {"Passive"}
TFABOI.Items[89] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Small Rock"
IsaacItem.ID = "90"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+1.0 Damage Up. +0.2 Tears Up. (Only applied after the tears stat is next updated) -0.2 Speed Down. (Only applied after the speed stat is next updated) Has a chance to drop when exploding a tinted rock."
IsaacItem.Stats = { ["Damage"] = "1", ["Tears"] = "0.2", ["Speed"] = "-0.2" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[90] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spelunker Hat"
IsaacItem.ID = "91"
IsaacItem.Pickup = "See-through doors"
IsaacItem.Desc = "Reveals the location of the Secret Room and Super Secret Room when you are in a room directly next to them."
IsaacItem.Type = {"Passive"}
TFABOI.Items[91] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Super Bandage"
IsaacItem.ID = "92"
IsaacItem.Pickup = "+2 hearts"
IsaacItem.Desc = "+1 Health Up. +2 Soul Hearts"
IsaacItem.Type = {"Passive"}
TFABOI.Items[92] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Gamekid"
IsaacItem.ID = "93"
IsaacItem.Pickup = "Temporary Man-Pac"
IsaacItem.Desc = "When used Isaac transforms into pacman, which makes him invincible and does 40 contact damage to enemies per chomp. Everytime you 'eat' an enemy, you regain some health."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[93] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sack of Pennies"
IsaacItem.ID = "94"
IsaacItem.Pickup = "Gives money"
IsaacItem.Desc = "A bag that floats around following Isaac and drops a random coin every 2 rooms."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[94] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Robo-Baby"
IsaacItem.ID = "95"
IsaacItem.Pickup = "Friends till the bzzzttt"
IsaacItem.Desc = "A familiar which follows Isaac and shoots lasers, similar to the Technology item. Robo-Baby's laser is spectral and piercing (It will pass through rocks and objects in the environment) Robo-Baby's lasers deal 3.5 damage per hit."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[95] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Little C.H.A.D."
IsaacItem.ID = "96"
IsaacItem.Pickup = "Gives kisses"
IsaacItem.Desc = "A familiar which follows Isaac and drops half a red heart every 3 rooms."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[96] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Book of Sin"
IsaacItem.ID = "97"
IsaacItem.Pickup = "Reusable item generator"
IsaacItem.Desc = "Spawns a random pickup on the floor. The possible pickups from this item include: Bombs, hearts, keys, coins, pills, batteries or tarot cards."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[97] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Relic"
IsaacItem.ID = "98"
IsaacItem.Pickup = "Soul generator"
IsaacItem.Desc = "A blue cross that follows Isaac and drops a soul heart every 4 rooms."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[98] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Little Gish"
IsaacItem.ID = "99"
IsaacItem.Pickup = "Sticky friend"
IsaacItem.Desc = "A familiar that follows Isaac and fires black tar tears, which slow enemy movement and projectile speed for a few seconds. Little Gish's tears do 3.5 damage. Little Gish fires tears at a rate of 1 tear per second. A Guaranteed drop from the Gish boss fight."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[99] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Little Steven"
IsaacItem.ID = "100"
IsaacItem.Pickup = "Psychic friend"
IsaacItem.Desc = "A familiar that follows Isaac and fires homing tears that deal 3.5 damage each. Has a high chance to drop from the Steven boss fight. Little Steven fires tears at a rate of 1 tear per second with a slightly longer range than other familiars."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[100] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Halo"
IsaacItem.ID = "101"
IsaacItem.Pickup = "All stats up"
IsaacItem.Desc = "+1 Health Up. +0.3 Damage Up. +0.2 Tears Up. +0.25 Range Up. +0.3 Speed Up. +0.5 Tear Height."
IsaacItem.Stats = { ["Damage"] = "0.3", ["Tears"] = "0.2", ["Range"] = "0.25", ["Speed"] = "0.3" }
IsaacItem.Type = {"Passive"}
TFABOI.Items[101] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Bottle of Pills"
IsaacItem.ID = "102"
IsaacItem.Pickup = "Reusable pill generator"
IsaacItem.Desc = "When used, gives Isaac a random pill."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[102] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Common Cold"
IsaacItem.ID = "103"
IsaacItem.Pickup = "Poison damage"
IsaacItem.Desc = "Tears now have a random chance to apply a poison effect, causing damage to enemies over time. The chance to fire poison shots is affected by your luck stat and at +12 Luck it will activate every time. Gives a big increase in damage to Dr. Fetus bombs."
IsaacItem.Tear = { ["Poison"] = true }
IsaacItem.Type = {"Passive"}
TFABOI.Items[103] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Parasite"
IsaacItem.ID = "104"
IsaacItem.Pickup = "Split shot"
IsaacItem.Desc = "Isaac's tears now split into two upon contact with enemies or the environment. Tears that split off from the main tear do less damage (tear damage * 0.25)."
-- IsaacItem.Tear = { ["Split"] = true }
IsaacItem.Type = {"Passive"}
TFABOI.Items[104] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The D6"
IsaacItem.ID = "105"
IsaacItem.Pickup = "Reroll your destiny"
IsaacItem.Desc = "Upon use, any pedestal item (e.g. an item room item) will be re-rolled into another item. Isaac starts with this item after it is unlocked."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[105] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mr. Mega"
IsaacItem.ID = "106"
IsaacItem.Pickup = "Blast damage"
IsaacItem.Desc = "+5 Bombs Bombs now do 110 damage (+60, up from 50) and have a larger blast radius. Can be found in the secret room. Has a chance to drop from the Super Wrath miniboss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[106] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pinking Shears"
IsaacItem.ID = "107"
IsaacItem.Pickup = "Cut and run"
IsaacItem.Desc = "Cuts Isaac's head from his body for the current room, allowing him to fly and leaving the decapitated body to run around attacking enemies for 5.5 damage per tick."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[107] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Wafer"
IsaacItem.ID = "108"
IsaacItem.Pickup = "Damage resistance"
IsaacItem.Desc = "All damage taken is reduced to half a heart. Damaged reduction is reduced from every source in the game except Devil Deals and health down pills. Does not prevent death (i.e. Suicide King or using The Bible on Isaac, ??? or Satan). The Wafer becomes most effective in the Womb and beyond where enemies all deal a whole heart of damage. The Wafer causes the Sharp Plug item to only cost 1/2 a heart per use."
IsaacItem.Type = {"Passive"}
TFABOI.Items[108] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Money = Power"
IsaacItem.ID = "109"
IsaacItem.Pickup = "$$$ = DMG"
IsaacItem.Desc = "+0.04 Damage Up for every coin you currently have. At 99 coins this item gives +3.96 Damage Up. +0.04 per coin is the amount added before the damage formula is calculated, as this is the only way to show a consistent amount of damage given. You may see more or less than this on the Found HUD overlay, however this number varies based on your other damage increasing items"
IsaacItem.Type = {"Passive"}
TFABOI.Items[109] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Contacts"
IsaacItem.ID = "110"
IsaacItem.Pickup = "Freeze effect"
IsaacItem.Desc = "Tears now have a random chance to freeze enemies in place. The chance to freeze enemies is affected by your luck stat. +0.25 Range Up. (Only applied after the range stat is next updated) +0.5 Tear Height. (Only applied after the height stat is next updated)"
IsaacItem.Tear = { ["Petrify"] = true }
IsaacItem.Color = { [24] = {255,0,0}}
IsaacItem.Type = {"Passive"}
TFABOI.Items[110] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Bean"
IsaacItem.ID = "111"
IsaacItem.Pickup = "Toot on command"
IsaacItem.Desc = "Upon use, this item causes Isaac to fart and poison any enemies in close proximity. The Bean deals 26 damage total (5 initially then 21 in a Damage over Time effect."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room."
TFABOI.Items[111] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Guardian Angel"
IsaacItem.ID = "112"
IsaacItem.Pickup = "Extra protection"
IsaacItem.Desc = "An orbital which does 7 contact damage per tick, blocks shots and increases the speed of all other orbitals."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[112] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Demon Baby"
IsaacItem.ID = "113"
IsaacItem.Pickup = "Auto-turret friend"
IsaacItem.Desc = "A familiar which follows Isaac and automatically fires tears that deal 3 damage each at any enemies in close range."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[113] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Knife"
IsaacItem.ID = "114"
IsaacItem.Pickup = "Stab stab stab"
IsaacItem.Desc = "Tears are replaced with a knife which can be charged and thrown in a boomerang style action. The knife can also do damage without being thrown as a close range melee weapon. When used as a melee weapon, Mom's Knife deals your tear damage * 2 per tick."
-- IsaacItem.Tear = { ["Knife"] = true }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[114] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ouija Board"
IsaacItem.ID = "115"
IsaacItem.Pickup = "Spectral tears"
IsaacItem.Desc = "Gives Isaac spectral tears which allows them to travel through objects in the environment (i.e. rocks)."
IsaacItem.Tear = { ["Spectral"] = true }
IsaacItem.Type = {"Passive"}
TFABOI.Items[115] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "9 Volt"
IsaacItem.ID = "116"
IsaacItem.Pickup = "Quicker charge"
IsaacItem.Desc = "Automatically gives you 1 bar of charge after using your spacebar item. Fully recharges your current spacebar item when picked up. Causes the Sharp Plug item to become useless due to the fact that you can never have 0 charge on your spacebar item. Any items which are normally a 1 room recharge are now timed instead."
IsaacItem.Type = {"Passive"}
TFABOI.Items[116] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Bird"
IsaacItem.ID = "117"
IsaacItem.Pickup = "Protective buddy"
IsaacItem.Desc = "When Isaac takes damage, the dead bird will spawn and attack nearby enemies in the current room for 2 damage per tick. Eve starts with this item."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[117] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Brimstone"
IsaacItem.ID = "118"
IsaacItem.Pickup = "Blood laser barrage"
IsaacItem.Desc = "Tears are replaced with the ability to charge and fire a powerful laser that travels in a straight line across the room, dealing a lot of damage (damage * 13) to any enemies it comes into contact with. Does not directly affect your Damage stat but hits enemies 13 times per charge, spawning Guppy flies with every hit. Synergizes very well with a lot of items including Tammy's Head, Tiny Planet, Inner Eye (Triple Shot), Mutant Spider (Quad Shot) and many others. An item only found in the devil room pool (Note: The Fallen boss pulls items from the Devil Room Pool)"
IsaacItem.Ent = { [1] = "_brimstone" }
IsaacItem.Tear = { ["Brimstone"] = true }
IsaacItem.Color = { [47] = {255,0,0} }
IsaacItem.Laser = { ["Distance"] = "2000", ["DamageMult"] = "1.2", ["Timer"] = "1.1875" }
IsaacItem.Stats = { ["TearDelayMult"] = "8" }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[118] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blood Bag"
IsaacItem.ID = "119"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up +0.3 Speed Up Heals for 5 full red hearts. Has a chance to drop while playing any Blood Donation machine."
IsaacItem.Type = {"Passive"}
TFABOI.Items[119] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Odd Mushroom (Thin)"
IsaacItem.ID = "120"
IsaacItem.Pickup = "Fire rate up"
IsaacItem.Desc = "Gives you a high rate of fire in exchange for a damage down. +1.7 Tears Up. +0.3 Speed Up. Damage Down (damage * 0.9 - 0.4)."
IsaacItem.Stats = { ["Tears"] = "1.7", ["Speed"] = "0.3", ["Damage"] = "-0.4", ["DamageMult"] = "-0.1"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[120] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Odd Mushroom (Thick)"
IsaacItem.ID = "121"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+1 Health Up (The given heart container is empty) +0.3 Damage Up. +0.25 Range Up. -0.1 Speed Down. +0.5 Tear Height."
IsaacItem.Stats = { ["Damage"] = "0.3", ["Range"] = "0.25", ["Speed"] = "0.1"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[121] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Whore of Babylon"
IsaacItem.ID = "122"
IsaacItem.Pickup = "Curse up"
IsaacItem.Desc = "When you only have half a heart remaining or less, you enter a curse state which adds +1.5 damage and +0.3 speed. When playing as Eve, this item activates with one FULL heart remaining or less AND also removes her 0.75 damage multiplier, raising it up to 1.0. The effect is permanently active for characters with no red hearts (e.g. Blue Baby, The Lost). One of Eve's starting items."
-- IsaacItem.Stats = { ["Damage"] = "1.5", ["Speed"] = "0.3"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[122] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Monster Manual"
IsaacItem.ID = "123"
IsaacItem.Pickup = "Temporary buddy generator"
IsaacItem.Desc = "When used, gives a random familiar for the rest of the room."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[123] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Sea Scrolls"
IsaacItem.ID = "124"
IsaacItem.Pickup = "It's a mystery"
IsaacItem.Desc = "Upon use, the dead sea scrolls gives a random spacebar item effect. An item that can be found in the Angel room."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[124] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bobby - Bomb"
IsaacItem.ID = "125"
IsaacItem.Pickup = "Friends till the end"
IsaacItem.Desc = "All of Isaac's bombs now having a homing effect when placed on the floor. +5 Bombs."
IsaacItem.Type = {"Passive"}
TFABOI.Items[125] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Razor Blade"
IsaacItem.ID = "126"
IsaacItem.Pickup = "Feel my pain"
IsaacItem.Desc = "When used, deals damage to Isaac in exchange for +1.2 damage up which lasts for the current room."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[126] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Forget Me Now"
IsaacItem.ID = "127"
IsaacItem.Pickup = "I don't remember..."
IsaacItem.Desc = "Upon use, this item refreshes the current floor with brand new rooms, monsters and items."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant (One time use)"
TFABOI.Items[127] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Forever Alone"
IsaacItem.ID = "128"
IsaacItem.Pickup = "Attack fly"
IsaacItem.Desc = "An orbiting fly which deals 2 contact damage per tick to enemies. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[128] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bucket of Lard"
IsaacItem.ID = "129"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+2 Health Up. -0.2 Speed Down. Of the two heart containers given from this item, only 1/2 a red heart of them is filled. Has a chance to drop from the Super Gluttony miniboss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[129] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "A Pony"
IsaacItem.ID = "130"
IsaacItem.Pickup = "Flight + dash attack"
IsaacItem.Desc = "Allows Isaac to fly while the Pony is held. Sets your speed stat to 1.5 if it isn't already that high. When the active attack is used, Isaac will dash across the screen dealing 40 contact damage to anything he hits. Drops from the Headless Horseman boss fight."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[130] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bomb Bag"
IsaacItem.ID = "131"
IsaacItem.Pickup = "Gives bombs"
IsaacItem.Desc = "A bag of bombs that will drop a bomb pickup every 2 rooms."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[131] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "A Lump of Coal"
IsaacItem.ID = "132"
IsaacItem.Pickup = "My Xmas present"
IsaacItem.Desc = "Tears gain a damage up and increase in size based on the distance they travel. The length of a normal room roughly gives +6 damage, but this can be higher with double rooms or Tiny Planet."
IsaacItem.Tear = { ["Grow"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[132] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Guppy's Paw"
IsaacItem.ID = "133"
IsaacItem.Pickup = "Soul converter"
IsaacItem.Desc = "When used, removes one heart container and gives you 3 soul hearts. This is one of the items which allows you to transform into Guppy."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[133] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Guppy's Tail"
IsaacItem.ID = "134"
IsaacItem.Pickup = "Cursed?"
IsaacItem.Desc = "When picked up, greatly increases your chance of finding chests at the end of a room, while also reducing your chance to find consumables such as keys and bombs. This is one of the items which allows you to transform into Guppy."
IsaacItem.Type = {"Passive"}
TFABOI.Items[134] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "IV Bag"
IsaacItem.ID = "135"
IsaacItem.Pickup = "Portable blood bank"
IsaacItem.Desc = "Upon use, the IV Bag takes half a red heart and spawns some coins (the same effect as a blood donation machine) Can drop from a blood donation machine after playing it."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[135] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Best Friend"
IsaacItem.ID = "136"
IsaacItem.Pickup = "Friends 'till the end"
IsaacItem.Desc = "Places a decoy on the floor which attracts enemies and explodes after a period of time. When it explodes, it deals 110 damage to everything in radius (Same damage as Mr Mega bombs)."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms."
TFABOI.Items[136] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Remote Detonator"
IsaacItem.ID = "137"
IsaacItem.Pickup = "Remote bomb detonation"
IsaacItem.Desc = "+5 Bombs. Bombs no longer automatically explode and will only do so when you activate the remote detonator. Can be used to detonate Dr. Fetus bombs early."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[137] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Stigmata"
IsaacItem.ID = "138"
IsaacItem.Pickup = "DMG + HP up"
IsaacItem.Desc = "+1 Health Up. +0.3 Damage Up."
IsaacItem.Stats = { ["Damage"] = "0.3"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[138] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Purse"
IsaacItem.ID = "139"
IsaacItem.Pickup = "More trinket room"
IsaacItem.Desc = "Isaac can now hold two trinkets at the same time Allows you to pick up more trinkets while also holding The Tick"
IsaacItem.Type = {"Passive"}
TFABOI.Items[139] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bob's Curse"
IsaacItem.ID = "140"
IsaacItem.Pickup = "Poison bombs"
IsaacItem.Desc = "All of Isaac's bombs now leave a poison effect on any enemies within the blast radius. +5 Bombs. As well as dealing the standard 60 damage for a bomb, it will apply a Damage over Time effect that does 4 or 6 damage per tick. Has a chance to drop from the Super Sloth miniboss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[140] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pageant Boy"
IsaacItem.ID = "141"
IsaacItem.Pickup = "Ultimate grand supreme"
IsaacItem.Desc = "Spawns 7 random coins around Isaac on the floor. Isaac wears a pink crown on his head."
IsaacItem.Type = {"Passive"}
TFABOI.Items[141] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Scapular"
IsaacItem.ID = "142"
IsaacItem.Pickup = "You have been blessed"
IsaacItem.Desc = "Once per room when you are damaged down to half a heart, you gain 1 soul heart."
IsaacItem.Type = {"Passive"}
TFABOI.Items[142] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Speed Ball"
IsaacItem.ID = "143"
IsaacItem.Pickup = "Speed + shot speed up"
IsaacItem.Desc = "+0.3 Speed Up. +0.2 Shot Speed Up."
IsaacItem.Stats = { ["Speed"] = "0.3", ["ShotSpeed"] = "0.2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[143] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bum Friend"
IsaacItem.ID = "144"
IsaacItem.Pickup = "He's Greedy"
IsaacItem.Desc = "A beggar who follows Isaac around and automatically picks up nearby coins. After picking up a coin he has a random chance to drop pickups, including hearts, keys, bombs, coins, pills, cards or trinkets."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[144] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Guppy's Head"
IsaacItem.ID = "145"
IsaacItem.Pickup = "Reusable fly hive"
IsaacItem.Desc = "When used, spawns between 2-4 blue flies. This is one of the items which allows you to transform into Guppy. Blue Flies do 2.0x of Isaac's damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[145] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Prayer Card"
IsaacItem.ID = "146"
IsaacItem.Pickup = "Reusable eternity"
IsaacItem.Desc = "Gives Isaac an eternal heart when used. Taking an eternal heart to the next floor or collecting two on the same floor gives you an extra heart container."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[146] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Notched Axe"
IsaacItem.ID = "147"
IsaacItem.Pickup = "Rocks didn't stand a chance"
IsaacItem.Desc = "Each charge of this item allows Isaac to break all rocks, pots and secret room doors in the current room. Cannot break the stone blocks which appear in the environment. If Isaac is damaged while the effect is active, it will deactivate."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[147] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Infestation"
IsaacItem.ID = "148"
IsaacItem.Pickup = "They grow inside"
IsaacItem.Desc = "When Isaac gets hit, a few blue flies will randomly spawn. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies. Blue Flies do 2.0x of Isaac's damage."
IsaacItem.Type = {"Passive"}
TFABOI.Items[148] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ipecac"
IsaacItem.ID = "149"
IsaacItem.Pickup = "Explosive shots"
IsaacItem.Desc = "Isaac's tears are replaced with explosive poison bombs, which will arc upwards and explode on contact with the floor, dealing huge damage and leaving a poison effect on enemies in range. Ipecac shots are given a flat +40 Damage on top of the normal 3.5 base damage. Tears Down (Tear delay * 2 + 10). +13.0 Tear Height. Shots will damage Isaac if he is in the blast radius when they explode."
IsaacItem.Tear = {["Explosive"] = true, ["Poison"] = true}
IsaacItem.Color = { [30] = {0,255,0}}
IsaacItem.Stats = {["TearDelayMult"] = "1", ["TearDelayExtra"] = "10"}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[149] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tough Love"
IsaacItem.ID = "150"
IsaacItem.Pickup = "Tooth shot"
IsaacItem.Desc = "Isaac has a random chance to fire a tooth shot instead of a tear sometimes. Teeth shots deal damage equal to your tear damage * 3.2. The chance to fire a tooth is affected by your luck stat and at +9 Luck it will activate every time. Synergizes well with some tear modifiers such as Ipecac, which causes it to do massive damage."
IsaacItem.Tear = {["Tooth"] = true}
IsaacItem.Color = { [49] = {255,255,255}}
IsaacItem.Stats = {["DamageMult"] = "2.2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[150] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Mulligan"
IsaacItem.ID = "151"
IsaacItem.Pickup = "They grow inside"
IsaacItem.Desc = "Isaac has a 1/6 chance to spawn a blue fly when one of his tears hits an enemy. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies. Blue Flies do 2.0x of Isaac's damage. The chance to activate this effect is not changed with your Luck stat."
IsaacItem.Type = {"Passive"}
TFABOI.Items[151] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Technology 2"
IsaacItem.ID = "152"
IsaacItem.Pickup = "Laser"
IsaacItem.Desc = "Isaac now also has a laser with unlimited range which fires continuously and does damage very rapidly. -35% Damage Down (0.65 damage multiplier)."
-- IsaacItem.Tear = {["Technology2"] = true}
-- IsaacItem.Stats = {["DamageMult"] = "-0.35"}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[152] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mutant Spider"
IsaacItem.ID = "153"
IsaacItem.Pickup = "Quad Shot"
IsaacItem.Desc = "Tears now shoot 4 at a time (Quad Shot) Tears Down significantly (Tear delay * 2.1 + 3)."
IsaacItem.Stats = {  ["TearsShot"] = "4", ["TearDelayMult"] = "1.1", ["TearDelayExtra"] = "3", ["TearSpread"] = "80" }
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[153] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Chemical Peel"
IsaacItem.ID = "154"
IsaacItem.Pickup = "DMG up"
IsaacItem.Desc = "+2 Damage Up for tears fired from Isaac's left eye. If you have an item which modifies which eye you fire tears from, each shot has a 50% chance to do +2 Damage."
-- IsaacItem.Stats = {  ["Damage"] = "2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[154] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Peeper"
IsaacItem.ID = "155"
IsaacItem.Pickup = "Plop!"
IsaacItem.Desc = "Gives Isaac an eye companion that floats around the room and deals 8 damage per tick on contact with enemies."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[155] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Habit"
IsaacItem.ID = "156"
IsaacItem.Pickup = "Item martyr"
IsaacItem.Desc = "When you take damage, this item recharges one room's worth of charge to your spacebar item. For example, with the D6 you would need to take damage 6 times to fully recharge it."
IsaacItem.Type = {"Passive"}
TFABOI.Items[156] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bloody Lust"
IsaacItem.ID = "157"
IsaacItem.Pickup = "RAGE!"
IsaacItem.Desc = "Each time you take damage, you gain a damage up which lasts for the rest of the floor and turn a darker red colour each time. After taking 6 hits Bloody Lust doesn't give you any further damage increases. Damage given for each hit increases as follows: +0.5, +0.5, +0.5, +33%, +33%, +33%. The maximum effect is (damage + 1.5) * 2, resulting in more than double your original damage and stacking with other damage increasing items. Bloody lust works differently in Rebirth compared to Wrath of the Lamb - Damage is given for taking damage and is persistent for the entire floor."
IsaacItem.Type = {"Passive"}
TFABOI.Items[157] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Crystal Ball"
IsaacItem.ID = "158"
IsaacItem.Pickup = "I see my future"
IsaacItem.Desc = "Upon use, reveals the entire map and gives the player a random tarot card, mystic rune or soul heart. Has a chance to drop from playing a fortune machine."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[158] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spirit of the Night"
IsaacItem.ID = "159"
IsaacItem.Pickup = "Scary"
IsaacItem.Desc = "Gives Isaac the ability to fly and spectral tears."
IsaacItem.Tear = {["Spectral"] = true}
IsaacItem.Player = {["Fly"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[159] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Crack The Sky"
IsaacItem.ID = "160"
IsaacItem.Pickup = "Holy white death"
IsaacItem.Desc = "Creates 5 beams of light from the sky that deal damage equal to your tear damage + 20 to any enemies which come into contact with them. The beams now have improved targetting and will attempt to spawn on top of enemies where possible."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[160] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ankh"
IsaacItem.ID = "161"
IsaacItem.Pickup = "Eternal life?"
IsaacItem.Desc = "Upon death, the player respawns as Blue Baby with three Soul hearts. This is a one time use item and all new heart containers will be soul hearts. Can be used to unlock some of Blue Baby's secrets before having the character available."
IsaacItem.Type = {"Passive"}
TFABOI.Items[161] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Celtic Cross"
IsaacItem.ID = "162"
IsaacItem.Pickup = "You feel blessed"
IsaacItem.Desc = "Upon taking damage, you have a chance to gain an invulnerability shield for a few seconds. The chance to gain a shield is affected by your luck stat and at +27 Luck it will activate every time."
IsaacItem.Type = {"Passive"}
TFABOI.Items[162] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ghost Baby"
IsaacItem.ID = "163"
IsaacItem.Pickup = "Spectral buddy"
IsaacItem.Desc = "A familiar which follows Isaac and shoots spectral tears that deal 3.5 damage. Ghost Baby fires tears at a rate of 1 tear per second. Can drop while destroying skulls in the Depths and Necropolis floors."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[163] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Candle"
IsaacItem.ID = "164"
IsaacItem.Pickup = "Reusable flame"
IsaacItem.Desc = "A spacebar item which allows Isaac to fire a blue flame that damages anything in its path for 23 damage per tick. Can cause up to a total of 184 potential damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Timed (A few seconds)"
TFABOI.Items[164] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cat-O-Nine-Tails"
IsaacItem.ID = "165"
IsaacItem.Pickup = "Shot speed up + DMG up"
IsaacItem.Desc = "+1.0 Damage Up. +0.23 Shot Speed Up. An item only found in the Boss room pool."
IsaacItem.Stats = {["Damage"] = "1", ["ShotSpeed"] = "0.23"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[165] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D20"
IsaacItem.ID = "166"
IsaacItem.Pickup = "Reroll the basics"
IsaacItem.Desc = "Upon use, re-rolls all pickup consumables in the current room into another random kind of pickup. This includes hearts, bombs, keys, coins, pills, tarot cards, chests and trinkets."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[166] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Harlequin Baby"
IsaacItem.ID = "167"
IsaacItem.Pickup = "Double shot buddy"
IsaacItem.Desc = "A familiar which follows Isaac and shoots two normal tears at once in a V-shaped pattern. Each of Harlequin Baby's tears deal 4 damage. Harlequin Baby fires tears at a rate of 1 tear per second."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[167] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Epic Fetus"
IsaacItem.ID = "168"
IsaacItem.Pickup = "On-demand air strike"
IsaacItem.Desc = "Tears now become missiles which deal huge damage to anything nearby. Missiles damage = damage * 20. This item places a controllable red target on the ground which will cause a missile to fall from the sky and hit it after a short period of time."
-- IsaacItem.Tear = {["Missile"] = true}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[168] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Polyphemus"
IsaacItem.ID = "169"
IsaacItem.Pickup = "Mega tears"
IsaacItem.Desc = "High Damage Up - 2 * (damage + 4). Tears Down significantly (Tear delay * 2.1 + 3). If a tear kills an enemy, it continues to travel forward with the leftover damage."
IsaacItem.Stats = {["Damage"] = 4, ["TearDelayMult"] = "1.1", ["TearDelayExtra"] = 3}
IsaacItem.Type = {"Passive"}
TFABOI.Items[169] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Daddy Longlegs"
IsaacItem.ID = "170"
IsaacItem.Pickup = "Daddy's love"
IsaacItem.Desc = "A shadow follows Isaac and stomps on enemies randomly, dealing 40 damage per stomp (2 damage ticks at 20 damage each)."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[170] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spider Butt"
IsaacItem.ID = "171"
IsaacItem.Pickup = "Mass enemy slowdown + damage"
IsaacItem.Desc = "Upon use, does 10 damage to all enemies in the room and gives them a slowing effect."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[171] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sacrificial Dagger"
IsaacItem.ID = "172"
IsaacItem.Pickup = "My fate protects me"
IsaacItem.Desc = "Gives Isaac an orbital knife that does 15 damage per tick on contact with enemies. The Sacrificial Dagger DOES block shots in Rebirth, unlike the original game. Synergises very well with invulnerability items such as Book of Shadows."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[172] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mitre"
IsaacItem.ID = "173"
IsaacItem.Pickup = "You feel blessed"
IsaacItem.Desc = "Gives Isaac a much higher chance to find soul hearts"
IsaacItem.Type = {"Passive"}
TFABOI.Items[173] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Rainbow Baby"
IsaacItem.ID = "174"
IsaacItem.Pickup = "Random buddy"
IsaacItem.Desc = "A familiar the follows Isaac and fires random tears. Rainbow Baby's tears can choose from any of the other familiars, such as homing, spectral, tar shots etc."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[174] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dad's Key"
IsaacItem.ID = "175"
IsaacItem.Pickup = "Opens all doors..."
IsaacItem.Desc = "Upon use, opens all closed doors in the current room, including the ones which require a key to enter and secret room doors. Can be used to open the golden door that appears in the Dark Room or the Chest."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[175] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Stem Cells"
IsaacItem.ID = "176"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up. +0.16 Shot Speed Up."
IsaacItem.Stats = {["ShotSpeed"] = "0.16"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[176] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Portable Slot"
IsaacItem.ID = "177"
IsaacItem.Pickup = "Gamble 24/7"
IsaacItem.Desc = "Using the portable slot takes a coin and has a chance to give a pickup - Exactly the same as how the normal slot machines work."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[177] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Holy Water"
IsaacItem.ID = "178"
IsaacItem.Pickup = "Splash!"
IsaacItem.Desc = "When Isaac takes damage, the bottle breaks and leaves a pool on the floor which deals 8 damage per tick to enemies which walk over it."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[178] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Fate"
IsaacItem.ID = "179"
IsaacItem.Pickup = "Flight eternal"
IsaacItem.Desc = "Gives Isaac an eternal heart and the ability to fly. Taking an eternal heart to the next floor or collecting two on the same floor gives you an extra heart container."
-- IsaacItem.Player = {["Fly"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[179] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Black Bean"
IsaacItem.ID = "180"
IsaacItem.Pickup = "Toot on touch"
IsaacItem.Desc = "Upon taking damage, Isaac will fart, causing all enemies in close proximity to become poisoned. Black Bean deals 26 damage total (5 initially then 21 in a Damage over Time effect."
IsaacItem.Type = {"Passive"}
TFABOI.Items[180] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "White Pony"
IsaacItem.ID = "181"
IsaacItem.Pickup = "Flight + holy death"
IsaacItem.Desc = "Allows Isaac to fly while the White Pony is held. While held, sets your speed stat to 1.5 if it isn't already that high. If your speed stat is already higher then that value is still used. Upon use, Isaac charges in the direction the pony is facing, becoming invulnerable during the charge and damaging enemies while also casting the effect of Crack The Sky. The charge of the spacebar attack deals 40 damage on contact with enemies and the beams deal damage equal to your tear damage + 20. Drops from the Conquest boss fight."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[181] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sacred Heart"
IsaacItem.ID = "182"
IsaacItem.Pickup = "Homing shots + DMG up"
IsaacItem.Desc = "Tears are now white, do a lot more damage and move slower across the screen with a homing effect. Health Up. Damage Up (damage * 2.3 + 1). -0.4 Tears Down. -0.25 Shot Speed Down. +0.375 Range Up. +0.75 Tear Height. Full red heart heal."
IsaacItem.Stats = {["DamageMult"] = "1.3", ["Damage"] = "1", ["Range"] = "4.125", ["Tears"] = "-0.4", ["ShotSpeed"] = "-0.25"}
IsaacItem.Tear = {["Homing"] = true}
IsaacItem.Color = { [29] = {255,255,255}}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[182] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Toothpicks"
IsaacItem.ID = "183"
IsaacItem.Pickup = "Tears + shot speed up"
IsaacItem.Desc = "+0.7 Tears Up. +0.16 Shot Speed Up. Does not increase your damage, simply makes your tears red."
IsaacItem.Stats = {["Tears"] = "0.7", ["ShotSpeed"] = "0.16"}
IsaacItem.Color = { [28] = {255,0,0}}
IsaacItem.Type = {"Passive"}
TFABOI.Items[183] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Holy Grail"
IsaacItem.ID = "184"
IsaacItem.Pickup = "Flight + HP up"
IsaacItem.Desc = "+1 Health Up Gives Isaac the ability to fly."
IsaacItem.Type = {"Passive"}
TFABOI.Items[184] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Dove"
IsaacItem.ID = "185"
IsaacItem.Pickup = "Flight + spectral tears"
IsaacItem.Desc = "Gives Isaac the ability to fly and spectral tears. An item only found in the Angel room."
IsaacItem.Tear = {["Spectral"] = true}
IsaacItem.Player = {["Fly"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[185] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blood Rights"
IsaacItem.ID = "186"
IsaacItem.Pickup = "Mass enemy damage at a cost"
IsaacItem.Desc = "Upon use, takes away one full heart and deals 40 damage to the entire room. With the Isaac's Heart item, you can use Blood Rights without taking damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant."
TFABOI.Items[186] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Guppy's Hairball"
IsaacItem.ID = "187"
IsaacItem.Pickup = "Swing it"
IsaacItem.Desc = "Follows behind Isaac and can be swung back and forth, dealing 3 contact damage per tick to anything it hits. Every time the hairball kills an enemy, it grows in size allowing it to deal more damage. This is one of the items which allows you to transform into Guppy."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[187] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Abel"
IsaacItem.ID = "188"
IsaacItem.Pickup = "Mirrored buddy"
IsaacItem.Desc = "A familiar that mirrors the player's movements and shoots tears directly at Isaac. Abel's tears do the same as Isaac's base damage (3.5). In larger rooms, Abel will mirror to the other side of the screen instead of the entire room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[188] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "SMB Super Fan"
IsaacItem.ID = "189"
IsaacItem.Pickup = "All stats up"
IsaacItem.Desc = "Isaac turns red like Meatboy. +1 Health Up. +0.3 Damage Up. +0.2 Tears Up. +0.5 Range Up. +0.2 Speed Up. +1.0 Tear Height. Full red heart heal."
IsaacItem.Stats = {["Damage"] = "0.3", ["Tears"] = "0.2", ["Range"] = "0.5", ["Speed"] = "0.2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[189] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pyro"
IsaacItem.ID = "190"
IsaacItem.Pickup = "99 bombs"
IsaacItem.Desc = "+99 Bombs."
IsaacItem.Type = {"Passive"}
TFABOI.Items[190] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "3 Dollar Bill"
IsaacItem.ID = "191"
IsaacItem.Pickup = "Rainbow tears"
IsaacItem.Desc = "Random tear effect for every room. Possible tear effects: Fire Mind, Spoon Bender, My Reflection, Ouija Board, 20/20, Inner Eye, Iron Bar, Death's Touch, Tough Love, Proptosis, Number One, Mom's Contacts or Dark Matter."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[191] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Telepathy for Dummies"
IsaacItem.ID = "192"
IsaacItem.Pickup = "Temporary psychic shot"
IsaacItem.Desc = "When used, Isaac gains homing shots for the current room."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[192] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "MEAT!"
IsaacItem.ID = "193"
IsaacItem.Pickup = "DMG + HP up"
IsaacItem.Desc = "+1 Health Up. +0.3 Damage Up."
IsaacItem.Stats = {["Damage"] = "0.3"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[193] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Magic 8 Ball"
IsaacItem.ID = "194"
IsaacItem.Pickup = "Shot speed up"
IsaacItem.Desc = "+0.16 Shot Speed Up. Gives Isaac a random tarot card when picked up."
IsaacItem.Stats = {["ShotSpeed"] = "0.2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[194] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Coin Purse"
IsaacItem.ID = "195"
IsaacItem.Pickup = "What's all this...?"
IsaacItem.Desc = "Drops 4 random pills on the floor around Isaac."
IsaacItem.Type = {"Passive"}
TFABOI.Items[195] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Squeezy"
IsaacItem.ID = "196"
IsaacItem.Pickup = "Tears up"
IsaacItem.Desc = "+2 Soul Hearts. +0.4 Tears Up."
IsaacItem.Stats = {["Tears"] = "0.4"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[196] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Jesus Juice"
IsaacItem.ID = "197"
IsaacItem.Pickup = "Damage + range up"
IsaacItem.Desc = "+0.5 Damage Up. +0.25 Range Up. +0.5 Tear Height."
IsaacItem.Stats = {["Damage"] = "0.5", ["Range"] = "0.25"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[197] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Box"
IsaacItem.ID = "198"
IsaacItem.Pickup = "Stuff"
IsaacItem.Desc = "Spawns one of each type of pickup. Pickups spawned: 1 heart, 1 key, 1 bomb, 1 coin, 1 card, 1 pill and 1 trinket."
IsaacItem.Type = {"Passive"}
TFABOI.Items[198] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Key"
IsaacItem.ID = "199"
IsaacItem.Pickup = "Less is more now +2 keys"
IsaacItem.Desc = "+2 Keys Higher chance to get more consumable drops from chests."
IsaacItem.Type = {"Passive"}
TFABOI.Items[199] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Eyeshadow"
IsaacItem.ID = "200"
IsaacItem.Pickup = "Charm tears"
IsaacItem.Desc = "Tears have a random chance to charm enemies. Charmed enemies will prioritize attacking other enemies in the room, otherwise they will still attack Isaac. The chance to charm enemies is affected by your luck stat and at +27 Luck it will activate every time."
IsaacItem.Type = {"Passive"}
TFABOI.Items[200] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Iron Bar"
IsaacItem.ID = "201"
IsaacItem.Pickup = "Concussive tears"
IsaacItem.Desc = "+0.3 Damage Up. Tears now have a chance to concuss enemies, causing them to walk around dazed and confused for a short period of time. The chance to concuss enemies is affected by your luck stat and at +27 Luck it will activate every time."
-- IsaacItem.Stats = {["Damage"] = "0.3"}
-- IsaacItem.Tear = {["Concuss"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[201] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Midas Touch"
IsaacItem.ID = "202"
IsaacItem.Pickup = "Golden touch"
IsaacItem.Desc = "Isaac's touch now petrifies enemies, turning them to gold for a few seconds.  If an enemy is killed while it is golden, it will drop between 1-4 coins. Contact damage is also dealt to enemies equal to the amount of coins Isaac is currently holding. Has a synergy with The Poop item, which gives it a high chance to spawn golden poops."
IsaacItem.Type = {"Passive"}
TFABOI.Items[202] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Humbleing Bundle"
IsaacItem.ID = "203"
IsaacItem.Pickup = "1+1free 4evar!"
IsaacItem.Desc = "All future pennies, keys, bombs and hearts will drop in pairs. Does not work for soul hearts, nickels, dimes, cards or pills."
IsaacItem.Type = {"Passive"}
TFABOI.Items[203] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Fanny pack"
IsaacItem.ID = "204"
IsaacItem.Pickup = "Filled with goodies"
IsaacItem.Desc = "When Isaac is hit, there is a chance he will drop a pickup (i.e. coin, bomb, key)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[204] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sharp plug"
IsaacItem.ID = "205"
IsaacItem.Pickup = "Charge with blood"
IsaacItem.Desc = "When your spacebar item is out of charge, you can press spacebar to use it at the cost of 2 health. This item only costs 1/2 a heart to use if you have The Wafer or the Cancer item. The Sharp Plug will take health from Soul/Black hearts (if any) before taking red hearts."
IsaacItem.Type = {"Passive"}
TFABOI.Items[205] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Guillotine"
IsaacItem.ID = "206"
IsaacItem.Pickup = "An out-of-body experience"
IsaacItem.Desc = "+1.0 Damage Up. -1 Tear Delay (Tears Up). Causes Isaac's head to detach and orbit his body, blocking shots and dealing 7 contact damage per tick. BFFs will cause the Guillotine head to do double damage (14 damage per tick) Tears are still fired from Isaac's head but the hitbox remains around his body."
-- IsaacItem.Stats = {["Damage"] = "1", ["TearDelayExtra"] = "-1"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[206] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ball of Bandages"
IsaacItem.ID = "207"
IsaacItem.Pickup = "Gotta lick em all"
IsaacItem.Desc = "Gives Isaac an orbital ball of bandages that deals 7 contact damage per tick. Unlike the Cube of Meat, it does not block enemy shots. Collecting a second Ball of Bandages in the run turns the orbital into a pink head that shoots tears that deal 7 damage each and have a chance to charm enemies. Getting a third Ball of Bandages will transform the head into bandage girl which will chase enemies dealing 3.5 contact damage per tick while firing charm tears. A fourth Ball of Bandages will make the Bandage Girl bigger and stronger, making her deal 5.5 damage per tick instead. Any further Ball of Bandages will repeat the cycle. Charmed enemies will prioritize attacking other enemies in the room, otherwise they will still attack Isaac."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[207] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Champion Belt"
IsaacItem.ID = "208"
IsaacItem.Pickup = "DMG + Challenge up"
IsaacItem.Desc = "+1.0 Damage Up. Increases the chance of champion enemies appearing. An item only found in the Shop room pool."
IsaacItem.Stats = {["Damage"] = "1"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[208] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Butt Bombs"
IsaacItem.ID = "209"
IsaacItem.Pickup = "Toxic blast +5 bombs"
IsaacItem.Desc = "+5 bombs. Bombs now become poop bombs, which deal 10 damage to all enemies in the room and daze them for a short period of time."
IsaacItem.Type = {"Passive"}
TFABOI.Items[209] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Gnawed Leaf"
IsaacItem.ID = "210"
IsaacItem.Pickup = "Unbreakable"
IsaacItem.Desc = "If Isaac stands still for a second, he turns to stone, making him invincible until he moves again. This item is a reference to the Tanuki suit in Super Mario 3."
IsaacItem.Type = {"Passive"}
TFABOI.Items[210] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spiderbaby"
IsaacItem.ID = "211"
IsaacItem.Pickup = "Spider revenge"
IsaacItem.Desc = "Creates friendly attack spiders when Isaac is damaged."
IsaacItem.Type = {"Passive"}
TFABOI.Items[211] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Guppy's Collar"
IsaacItem.ID = "212"
IsaacItem.Pickup = "Eternal life?"
IsaacItem.Desc = "When Isaac dies, he has a 50% chance to respawn with 1/2 a heart. This is one of the items which allows you to transform into Guppy."
IsaacItem.Type = {"Passive"}
TFABOI.Items[212] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lost Contact"
IsaacItem.ID = "213"
IsaacItem.Pickup = "Shielded tears"
IsaacItem.Desc = "All of Isaac's tears now have a shield, allowing them to block an enemy projectile. If a tear blocks something, both Isaac's and the enemies tears are destroyed. -0.15 Shot Speed Down."
IsaacItem.Type = {"Passive"}
TFABOI.Items[213] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Anemic"
IsaacItem.ID = "214"
IsaacItem.Pickup = "Toxic blood"
IsaacItem.Desc = "+5 Range Up. When Isaac takes damage, he will start to leave a trail of blood creep behind him as he walks for the current room. Lazarus' revived form (Lazarus II) respawns with this item."
-- IsaacItem.Stats = {["Range"] = "5"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[214] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Goat Head"
IsaacItem.ID = "215"
IsaacItem.Pickup = "He accepts your offering"
IsaacItem.Desc = "Gives Isaac a guaranteed devil or angel room on every floor they can appear, even if you have already beaten the boss and it didn't show up originally. Taking the Goat Head (or any other item) in a Devil Deal bars you from encountering Angel Rooms naturally. After which, the only way to access an Angel Room is via the Sacrifice Room."
IsaacItem.Type = {"Passive"}
TFABOI.Items[215] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ceremonial Robes"
IsaacItem.ID = "216"
IsaacItem.Pickup = "Sin up"
IsaacItem.Desc = "+3 Black Hearts. +1 Damage Up. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect."
-- IsaacItem.Stats = {["Damage"] = "1"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[216] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Wig"
IsaacItem.ID = "217"
IsaacItem.Pickup = "You feel itchy"
IsaacItem.Desc = "Isaac now has a chance to create friendly attack spiders everytime he fires a tear. Can create up to a maximum of 5 spiders in the room at one time. The Hive Mind item allows Mom's Wig to spawn a maximum of 10 spiders at once instead of 5. The chance to create a spider is affected by your luck stat and at +10 Luck it will activate every time. Heals you for 1 red heart when picked up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[217] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Placenta"
IsaacItem.ID = "218"
IsaacItem.Pickup = "HP up + regen"
IsaacItem.Desc = "+1 Health Up. Gives the player health regeneration over time. It's possible to find this item by blowing up Polyps (the weird red rocks found in the Womb floors)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[218] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Old Bandage"
IsaacItem.ID = "219"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up. The given heart container is empty. When you get hit, you will sometimes cause hearts to drop on the floor."
IsaacItem.Type = {"Passive"}
TFABOI.Items[219] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sad Bombs"
IsaacItem.ID = "220"
IsaacItem.Pickup = "Tear blast +5 bombs"
IsaacItem.Desc = "+5 Bombs Everytime a bomb explodes, it will release a circle of tears outwards, much like the Tammy's Head effect. The tears from each bomb are affected by any tear modifiers Isaac has on his own tears. The tears caused by Sad Bombs are much larger and do a lot more damage than Isaac's normal tears."
IsaacItem.Type = {"Passive"}
TFABOI.Items[220] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Rubber Cement"
IsaacItem.ID = "221"
IsaacItem.Pickup = "Bouncing tears"
IsaacItem.Desc = "Isaac's tears now bounce off walls and objects in the environment, such as rocks and pots. Allows tears to hit the same enemy multiple times. If you also have Lost Contact, tears will bounce off enemy projectiles instead of being destroyed."
IsaacItem.Tear = {["Bounce"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[221] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Anti-Gravity"
IsaacItem.ID = "222"
IsaacItem.Pickup = "Antigravity tears + tears up"
IsaacItem.Desc = "-2 Tear Delay (Tears Up). As you hold down the fire button, shots will float in the same place until you release the fire key again. Allows you to store up a lot of tears in the air and release them all at once. When the tears are released, they will fire off in the direction that Isaac was originally facing when it was created."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[222] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pyromaniac"
IsaacItem.ID = "223"
IsaacItem.Pickup = "Hurts so good +5 bombs"
IsaacItem.Desc = "+5 Bombs All explosions now heal Isaac for 1 heart instead of hurting him. Isaac will also be healed by other sources such as Mom's leg stomp, Satan's leg stomp."
IsaacItem.Type = {"Passive"}
TFABOI.Items[223] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cricket's Body"
IsaacItem.ID = "224"
IsaacItem.Pickup = "Splash damage + tears up"
IsaacItem.Desc = "-1 Tear Delay (Tears Up). -10.0 Range Down. Makes tears break into 4 smaller tears on impact with anything which deal half of your damage."
IsaacItem.Type = {"Passive"}
TFABOI.Items[224] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Gimpy"
IsaacItem.ID = "225"
IsaacItem.Pickup = "Sweet suffering"
IsaacItem.Desc = "When getting hit, this item has a chance to drop a soul heart or black heart. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect. The chance to spawn a heart is affected by your luck stat and at +22 Luck it will activate 50% of the time. Due to a bug, if you have more than 22 luck, Gimpy won't drop any Soul or Black hearts (This bug has been fixed in Afterbirth+). Enemies have a chance to drop half a heart when killed."
IsaacItem.Type = {"Passive"}
TFABOI.Items[225] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Black Lotus"
IsaacItem.ID = "226"
IsaacItem.Pickup = "HP up x3"
IsaacItem.Desc = "+1 Health Up. +1 Soul Heart. +1 Black Heart. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect. An item only found in the secret room pool."
IsaacItem.Type = {"Passive"}
TFABOI.Items[226] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Piggy Bank"
IsaacItem.ID = "227"
IsaacItem.Pickup = "My life savings"
IsaacItem.Desc = "+3 Coins when picked up. When you take damage, 1 or 2 coins will drop on the floor. When playing as the Keeper, this item drops 0-1 coins instead."
IsaacItem.Type = {"Passive"}
TFABOI.Items[227] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Perfume:"
IsaacItem.ID = "228"
IsaacItem.Pickup = "Fear shot"
IsaacItem.Desc = "-1 Tear Delay (Tears Up). Isaac's tears have a 15% chance of causing a fear effect. Feared enemies will run away from Isaac temporarily. The chance to fear enemies is affected by your luck stat and at +85 Luck it will activate every time."
IsaacItem.Type = {"Passive"}
TFABOI.Items[228] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Monstro's Lung"
IsaacItem.ID = "229"
IsaacItem.Pickup = "Charged attack"
IsaacItem.Desc = "Tears can now be charged and released in a shotgun style effect, much like Monstro's main attack."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[229] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Abaddon"
IsaacItem.ID = "230"
IsaacItem.Pickup = "Evil up + DMG up + fear shot"
IsaacItem.Desc = "On pickup removes all of your red hearts and gives you 6 black hearts. +1.5 Damage Up. +0.2 Speed Up. Tears now have a chance to induce the fear effect, causing enemies to run away from Isaac for a short period. The chance to fear enemies is affected by your luck stat and at +85 Luck it will activate every time. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect."
IsaacItem.Type = {"Passive"}
TFABOI.Items[230] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ball of Tar"
IsaacItem.ID = "231"
IsaacItem.Pickup = "Sticky feet..."
IsaacItem.Desc = "Isaac leaves a trail of tar behind him which will slow down enemies that walk over it. Tears have a chance to slow enemies and their projectiles for a short period of time. The chance to slow enemies can improve based on your luck stat and will always slow enemies at +18 Luck."
IsaacItem.Type = {"Passive"}
TFABOI.Items[231] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Stop Watch"
IsaacItem.ID = "232"
IsaacItem.Pickup = "Let's slow this down a bit"
IsaacItem.Desc = "+0.3 Speed Up. After you get hit the Stop Watch applies a slowing effect for the rest of the room to all enemies and their projectiles. The effect will still activate when hit while the Holy Mantle effect is active. The slowing effect has a reduced effect against Brimstone lasers fired by enemies."
IsaacItem.Type = {"Passive"}
TFABOI.Items[232] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tiny Planet"
IsaacItem.ID = "233"
IsaacItem.Pickup = "Orbiting tears + range up"
IsaacItem.Desc = "+7.0 Tear Height. Tears now revolve around Isaac's Body at a fixed distance until they hit the ground. Aiming in the opposite direction is often better due to how the tears circle around Isaac. Causes a lot of great synergies with items such as Lump of Coal, Brimstone, Rubber Cement, Technology and most of the worm trinkets. "
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[233] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Infestation 2"
IsaacItem.ID = "234"
IsaacItem.Pickup = "Infestation shot"
IsaacItem.Desc = "Creates 1-2 friendly spiders when you kill an enemy. Spiders are spawned at the location where the enemy died."
IsaacItem.Type = {"Passive"}
TFABOI.Items[234] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "E. Coli"
IsaacItem.ID = "236"
IsaacItem.Pickup = "Turdy Touch"
IsaacItem.Desc = "E. Coli turns normal enemies into poop if they touch you. Enemies can turn into poop even if they do not do contact damage, allowing you to apply the effect without taking damage. Can be combined with Midas Touch to turn enemies into Golden Poop. This does not work on mini-bosses and bosses."
IsaacItem.Type = {"Passive"}
TFABOI.Items[236] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Death's Touch"
IsaacItem.ID = "237"
IsaacItem.Pickup = "Penetrative shots + DMG up"
IsaacItem.Desc = "+1.5 Damage Up. -0.3 Tears Down. Isaac's tears turn into large scythes that penetrate through enemies (Similar to how Death's scythes look)."
-- IsaacItem.Stats = {["Damage"] = "1.5", ["Tears"] = "-0.3"}
-- IsaacItem.Tear = {["Piercing"] = true, ["Scythe"] = true}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[237] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Key Piece #1"
IsaacItem.ID = "238"
IsaacItem.Pickup = "???"
IsaacItem.Desc = "Increases your chances to find an Angel Room instead of a Devil Room. See the dedicated Devil room page for more details. First half of the key required to enter the door to the Mega Satan boss. Drops from one of the angels which appear by bombing the statue in an angel room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[238] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Key Piece #2"
IsaacItem.ID = "239"
IsaacItem.Pickup = "???"
IsaacItem.Desc = "Increases your chances to find an Angel Room instead of a Devil Room. See the dedicated Devil room page for more details. Second half of the key required to enter the door to the Mega Satan boss. Drops from one of the angels which appear by bombing the statue in an angel room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[239] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Experimental Treatment"
IsaacItem.ID = "240"
IsaacItem.Pickup = "All stats up! ... and then shuffled"
IsaacItem.Desc = "When picked up, this item will increase or decrease each one of your stats by a random amount. The flavour text for this item is slightly misleading, it is not an all stats up, however will average out as a slight increase overall. All 6 stats are affected by this item, including shot speed and luck. At least one stat is reduced but no more than 3 stats are reduced. Can kill Blue Baby if it removes health, but not other characters (This exception has been fixed for Afterbirth+)."
IsaacItem.Type = {"Passive"}
TFABOI.Items[240] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Contract From Below"
IsaacItem.ID = "241"
IsaacItem.Pickup = "Wealth, but at what cost?"
IsaacItem.Desc = "Doubles your pickup drops including chests, soul hearts and all other consumables which spawn at the end of a room."
IsaacItem.Type = {"Passive"}
TFABOI.Items[241] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Infamy"
IsaacItem.ID = "242"
IsaacItem.Pickup = "Damage reduction"
IsaacItem.Desc = "Puts a shield on Isaac's face making it so he has a high chance to not take damage to projectiles from any direction."
IsaacItem.Type = {"Passive"}
TFABOI.Items[242] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Trinity Shield"
IsaacItem.ID = "243"
IsaacItem.Pickup = "You feel guarded"
IsaacItem.Desc = "Puts a shield in front of Isaac which blocks projectiles. The shield will rotate based on the direction in which Isaac is firing tears."
IsaacItem.Type = {"Passive"}
TFABOI.Items[243] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tech.5"
IsaacItem.ID = "244"
IsaacItem.Pickup = "It's still being tested"
IsaacItem.Desc = "Gives Isaac a laser which is positioned in the centre of his head and will fire at random intervals while firing tears. Each laser does damage equal to your current tear damage. The laser will occasionally fire with one of these effects: Hook Worm, Spoon Bender or Tiny Planet. Luck has no effect on the rate at which Tech.5 fires and does not scale with items that increase your tears stat."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[244] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "20/20"
IsaacItem.ID = "245"
IsaacItem.Pickup = "Double shot"
IsaacItem.Desc = "Isaac now shoots from both eyes at the same time. Unlike the Inner Eye and Mutant Spider items, this double shot item does not give a tears down, effectively giving you double damage per second potential."
IsaacItem.Stats = {["TearsShot"] = "2", ["TearSpread"] = "50"}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[245] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blue Map"
IsaacItem.ID = "246"
IsaacItem.Pickup = "Secrets"
IsaacItem.Desc = "Reveals the locations of the secret and super secret room for the current floor and all future floors."
IsaacItem.Type = {"Passive"}
TFABOI.Items[246] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "BFFS!"
IsaacItem.ID = "247"
IsaacItem.Pickup = "Your friends rule!"
IsaacItem.Desc = "Makes all of Isaac's familiars much bigger, making them deal more damage. Causes all familiars to deal double damage (x2 / +100%). Has no effect on Rotten Baby, which instead benefits from Hive Mind."
IsaacItem.Type = {"Passive"}
TFABOI.Items[247] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Hive Mind"
IsaacItem.ID = "248"
IsaacItem.Pickup = "Giant spiders and flies"
IsaacItem.Desc = "Causes your friendly blue spiders and flies to become bigger and do 2x more damage. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies. Allows Mom's Wig to spawn a maximum of 10 spiders at once instead of 5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[248] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "There's Options"
IsaacItem.ID = "249"
IsaacItem.Pickup = "More options"
IsaacItem.Desc = "Two items now spawn after beating a boss fight and the boss rush, however only one can be taken and the other will disappear. The additional item will always pick from the Boss Item Pool. Appears in the shop item pool. Does nothing after the Krampus fight. Unlocked by donating to the donation machine in the shop."
IsaacItem.Type = {"Passive"}
TFABOI.Items[249] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bogo Bombs"
IsaacItem.ID = "250"
IsaacItem.Pickup = "1+1 bombs"
IsaacItem.Desc = "All bomb pickups are now 1+1 bombs. An item only found in the Shop item pool."
IsaacItem.Type = {"Passive"}
TFABOI.Items[250] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Starter Deck"
IsaacItem.ID = "251"
IsaacItem.Pickup = "Extra card room"
IsaacItem.Desc = "Isaac can now hold 2 tarot cards at once. All future pill drops (including Mom's Coin Purse) will now instead become Tarot card drops. An item only available in the Shop room."
IsaacItem.Type = {"Passive"}
TFABOI.Items[251] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Little Baggy"
IsaacItem.ID = "252"
IsaacItem.Pickup = "Extra pill room"
IsaacItem.Desc = "Allows for 2 pills to be held. Drops a pill on the floor when picked up. All future tarot card drops will now instead become pill drops. following items: Roid Rage, The Virus, Growth Hormones, Experimental Treatment or Speed Ball."
IsaacItem.Type = {"Passive"}
TFABOI.Items[252] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Magic Scab"
IsaacItem.ID = "253"
IsaacItem.Pickup = "HP + luck up"
IsaacItem.Desc = "+1 Health Up. +1.0 Luck Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[253] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blood Clot"
IsaacItem.ID = "254"
IsaacItem.Pickup = "DMG + range up"
IsaacItem.Desc = "+1.0 Damage Up (Left eye only). +5 Range Up (Left eye only). The above stats only apply to tears fired from Isaac's left eye or with a 50% chance if you have an item which causes you to fire from a single source only."
IsaacItem.Type = {"Passive"}
TFABOI.Items[254] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Screw"
IsaacItem.ID = "255"
IsaacItem.Pickup = "Tears + shot speed up"
IsaacItem.Desc = "+0.5 Tears Up +0.2 Shot Speed Up"
IsaacItem.Stats = {["Tears"] = 0.5, ["ShotSpeed"] = "0.2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[255] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Hot Bombs"
IsaacItem.ID = "256"
IsaacItem.Pickup = "Burning blast +5 bombs"
IsaacItem.Desc = "+5 Bombs Gives all bombs a burning effect when they explode, leaving fire on the floor which deals 22 damage to enemies."
IsaacItem.Type = {"Passive"}
TFABOI.Items[256] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Fire Mind"
IsaacItem.ID = "257"
IsaacItem.Pickup = "Flaming tears"
IsaacItem.Desc = "Isaac's tears now set enemies on fire, leaving a damage over time effect that does 4 or 6 damage per tick. There is a chance that tears that hit enemies will explode, leaving a small fire on the floor that damages enemies. Exploding tears deal damage * 2 + 22. The chance for tears to explode is affected by your luck stat and at +13 Luck it will activate every time."
IsaacItem.Color = { [27] = {255,125,0}}
IsaacItem.Tear = {["Fire"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[257] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Missing No."
IsaacItem.ID = "258"
IsaacItem.Pickup = "Syntax error"
IsaacItem.Desc = "At the start of each floor this item rerolls all your current items, giving you a new item to over-ride each of the one you had. A reference to the infamous 'Missingno' glitch from Pokemon."
IsaacItem.Type = {"Passive"}
TFABOI.Items[258] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dark Matter"
IsaacItem.ID = "259"
IsaacItem.Pickup = "Fear shot"
IsaacItem.Desc = "Tears now have a chance to apply the fear effect to enemies, which causes them to run away from Isaac. +1.0 Damage Up. Reduced tear size. The chance to fear enemies is affected by your luck stat and at +20 Luck it will activate every time. An item only found in the devil room pool (Note: The Fallen boss pulls items from the Devil Room Pool)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[259] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Black Candle"
IsaacItem.ID = "260"
IsaacItem.Pickup = "Curse of immunity + evil up"
IsaacItem.Desc = "+1 Black Heart. Immunity to all floor curses (e.g. Curse of the Lost) When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect. An item that can appear in the shop room or in a Curse Room. Black Candle removes the teleportation effect of Cursed Eye, and the Curse of the Tower's bomb spawning effect. +30% Higher chance of a Devil Deal opening after the boss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[260] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Proptosis"
IsaacItem.ID = "261"
IsaacItem.Pickup = "Short range mega tears"
IsaacItem.Desc = "Gives Isaac high damage tears with a short range. Tear size and damage falls off very fast with this item, the further the tear travels the less damage it does. Tear damage starts at double (+100%) and decreases over range to roughly (+30%). Despite the very small tears visually, Proptosis is always a damage up at any range for tears. However with lasers such as Brimstone this point is no longer true."
IsaacItem.Stats = { ["DamageMult"] = "1"}
IsaacItem.Tear = { ["Shrink"] = true}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[261] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Missing Page 2"
IsaacItem.ID = "262"
IsaacItem.Pickup = "Evil up + your enemies will pay"
IsaacItem.Desc = "+1 Black Heart. Upon taking damage, if the total sum of Isaac's red hearts + soul hearts is under one and a half hearts, the necronomicon effect will activate, dealing 40 damage to the entire room. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect."
IsaacItem.Type = {"Passive"}
TFABOI.Items[262] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Smart Fly"
IsaacItem.ID = "264"
IsaacItem.Pickup = "Revenge fly"
IsaacItem.Desc = "A yellow orbital fly that will block shots and when Isaac gets hit, will seek out the nearest enemy and attack it. If the fly is in its attacking state and there are no longer any enemies in range, it will return to Isaac and go back to being a defensive orbital. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[264] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dry Baby"
IsaacItem.ID = "265"
IsaacItem.Pickup = "Immortal friend"
IsaacItem.Desc = "A familiar that follows Isaac and blocks any shots that hit it. If a projectile is blocked by Dry Baby, he has a high chance to activate the Necronomicon effect, dealing 40 damage to the entire room. The chance to activate the effect is not changed by your Luck stat. Can drop while destroying skulls in the Depths and Necropolis floors."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[265] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Juicy Sack"
IsaacItem.ID = "266"
IsaacItem.Pickup = "Sticky babies"
IsaacItem.Desc = "A familiar that follows isaac around dropping white creep which slows down enemies that walk over it. Spawns a familiar blue spider sometimes when you finish a room. Blue Spiders do 2.5x of Isaac's damage."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[266] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Robo-Baby 2.0"
IsaacItem.ID = "267"
IsaacItem.Pickup = "We worked out all the kinks"
IsaacItem.Desc = "A familiar that is controlled via the arrow keys and will automatically fire a laser if anything is in its line of sight. Robo-Baby 2.0's lasers deal 3.5 damage per hit."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[267] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Rotten Baby"
IsaacItem.ID = "268"
IsaacItem.Pickup = "Infested friend"
IsaacItem.Desc = "A familiar which follows Isaac and spawns a blue flies. Rotten Baby can only create one fly at a time, meaning if he has created a fly he cannot make another until it is used. Blue Flies do 2.0x of Isaac's damage. The Hive Mind item will cause Rotten Baby's flies to deal double damage."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[268] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Headless Baby"
IsaacItem.ID = "269"
IsaacItem.Pickup = "Bloody friend"
IsaacItem.Desc = "A familiar that follows Isaac and leaves blood creep on the floor as it floats, hurting enemies that walk over it."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[269] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Leech"
IsaacItem.ID = "270"
IsaacItem.Pickup = "Blood sucker"
IsaacItem.Desc = "Spawns a familiar leech on the ground that hunts down enemies and heals you for half a heart each time it eats one. The Leech deals 1.5 contact damage per tick."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[270] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mystery Sack"
IsaacItem.ID = "271"
IsaacItem.Pickup = "?"
IsaacItem.Desc = "A bag that follows Isaac and drops a random pickup every few rooms (Fixed in patch v1.04). Can drop any kind of heart, coin, bomb or key."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[271] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "BBF"
IsaacItem.ID = "272"
IsaacItem.Pickup = "Big beautiful fly"
IsaacItem.Desc = "A large familiar black fly that bounces around the room, exploding on contact with enemies dealing 70 damage. Does not explode if it hits Isaac, however if it explodes on an enemy while Isaac is in range, he will take damage. Respawns after 10 seconds or by moving to another room. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[272] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bob's Brain"
IsaacItem.ID = "273"
IsaacItem.Pickup = "Explosive thoughts"
IsaacItem.Desc = "A green brain that launches in the direction you are firing your tears and will explode on contact with enemies, dealing damage and poisoning anything in the blast radius. Bob's Brain deals 60 damage and applies a poison damage over time effect, which will scale with damage upgrades. Regenerates over time. Will hurt Isaac if he is in the blast radius."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[273] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Best Bud"
IsaacItem.ID = "274"
IsaacItem.Pickup = "Sworn protector"
IsaacItem.Desc = "When Isaac takes damage, a white attack fly will spawn that orbits him at a similar distance to the Distant Admiration fly. The fly orbits a lot faster than Distant Admiration or Forever Alone and deals 5 damage per tick. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[274] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil' Brimstone"
IsaacItem.ID = "275"
IsaacItem.Pickup = "Evil friend"
IsaacItem.Desc = "A familiar that follows Isaac and can fire up and charge brimstone shots, exactly how the normal Brimstone item works but with less damage. A fully charged laser deals 31.5 damage. A familiar found in the devil room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[275] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Isaac's Heart"
IsaacItem.ID = "276"
IsaacItem.Pickup = "Protect it"
IsaacItem.Desc = "Prevents Isaac from taking any damage, but instead summons a familiar heart that follows you around. If the heart is hit, Isaac will take damage. Sharp Plug becomes useless with this item, due to how damage is prevented on Isaac's body."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[276] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil' Haunt"
IsaacItem.ID = "277"
IsaacItem.Pickup = "Fear him"
IsaacItem.Desc = "A familiar ghost that follows Isaac around and chases enemies close-by, damaging them for 2 contact damage and causing a fear effect."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[277] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dark Bum"
IsaacItem.ID = "278"
IsaacItem.Pickup = "He wants to take your life"
IsaacItem.Desc = "A familiar beggar similar to Bum Friend that follows Isaac and collects red hearts, giving Isaac soul hearts or spiders in return. Soul hearts are the most common payout with only a small chance to spawn friendly or hostile spiders. Dark Bum has a small chance to give a black heart instead of a soul heart. For every 1.5 red hearts he takes, he will give 1 heart/spider in return."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[278] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Big Fan"
IsaacItem.ID = "279"
IsaacItem.Pickup = "Fat protector"
IsaacItem.Desc = "A very large orbital that moves around Isaac very slowly, blocking shots and dealing 2 contact damage per tick. Affects the speed of all other orbitals, slowing them down a lot (NOTE: This effect does not happen until you get a new orbital after Big Fan). Does not count as one of your three standard orbitals, allowing you to have a total of 4. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[279] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sissy Long Legs"
IsaacItem.ID = "280"
IsaacItem.Pickup = "She loves you"
IsaacItem.Desc = "An adorable friendly blue spider that walks around the room laying other blue spiders which attack enemies. Blue Spiders do 2.5x of Isaac's damage. She can only spawn a maximum of up to 5 spiders at a time and will only do so while there are enemies in the room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[280] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Punching Bag"
IsaacItem.ID = "281"
IsaacItem.Pickup = "Scape goat"
IsaacItem.Desc = "Spawns a friendly Mulligan that walks around the room. Mulligan can be hit by enemy projectiles, making him a good shield. Enemies will sometimes target the Mulligan if he is closer."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[281] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "How To Jump"
IsaacItem.ID = "282"
IsaacItem.Pickup = "It's time you learned how"
IsaacItem.Desc = "When used, makes Isaac leap in the air, similar to the leaper enemies. Maintains momentum if you are already moving in the same direction. If you already have an item which gives you flying, this item becomes a dash effect instead. Can be used in the Isaac boss fight to jump over the beams of light he spawns."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[282] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D100"
IsaacItem.ID = "283"
IsaacItem.Pickup = "REEROLLLLL!"
IsaacItem.Desc = "When used, rerolls each item you currently own into another item room pool item and any pedestal items and pickups in the room. Has the combined uses of the D4, D6 and D20."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[283] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D4"
IsaacItem.ID = "284"
IsaacItem.Pickup = "Reroll into something else"
IsaacItem.Desc = "When used, the D4 re-rolls each item you currently have into another random item from the item room pool. Each time an item is generated by the D4, it is also removed from the pool. When the pool is empty, it will eventually re-roll all your items into heart containers. Cannot remove Azazel's Brimstone laser."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[284] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D10"
IsaacItem.ID = "285"
IsaacItem.Pickup = "Rerolls enemies"
IsaacItem.Desc = "When used, rerolls all enemies in the room which are currently alive into another random type of enemy from any floor. Dangerous to use in early floors, it could replace a basement enemy with something usually found in the Womb only. Cannot reroll mini-bosses or bosses."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[285] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blank Card"
IsaacItem.ID = "286"
IsaacItem.Pickup = "Card Mimic"
IsaacItem.Desc = "When used, copies the effect of the tarot card you are currently holding without consuming it. The Blank Card can also be used to mimic mystic runes as well as tarot cards. An item that often appears in the shop."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms."
TFABOI.Items[286] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Book of Secrets"
IsaacItem.ID = "287"
IsaacItem.Pickup = "??????"
IsaacItem.Desc = "When used, you have a chance of getting one of the three following effects: Treasure Map (floor layout), Compass (map icons) or Blue Map (secret room locations)"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[287] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Box of Spiders"
IsaacItem.ID = "288"
IsaacItem.Pickup = "It's a box of spiders"
IsaacItem.Desc = "When used, spawns 2-4 friendly blue spiders on the floor. Blue Spiders do 2.5x of Isaac's damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[288] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Red Candle"
IsaacItem.ID = "289"
IsaacItem.Pickup = "Flame on"
IsaacItem.Desc = "Allows you to fire a red flame infront of you, similar to the Blue Candle item, however the flame will stay for the current room. Each flame deals 125 total damage. The flame will shrink in size when deals damage to something and eventually disappear."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Timed (A few seconds)"
TFABOI.Items[289] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Jar"
IsaacItem.ID = "290"
IsaacItem.Pickup = "Save your life"
IsaacItem.Desc = "Isaac can now pick up hearts while at full health, which will be stored in the Jar and can be spawned again using the spacebar. Up to 4 hearts can be stored in The Jar. Soul hearts and black hearts cannot be stored. If used in a Black heart or Eternal heart super secret room, it will spawn the relevant heart."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[290] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "FLUSH!"
IsaacItem.ID = "291"
IsaacItem.Pickup = "..."
IsaacItem.Desc = "When used, turns every normal enemy in the room into poop! Does not work on mini-bosses and bosses. Kills poop bosses when used."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[291] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Satanic Bible"
IsaacItem.ID = "292"
IsaacItem.Pickup = "Reusable evil"
IsaacItem.Desc = "When used, gives Isaac +1 Black Heart. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[292] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Head of Krampus"
IsaacItem.ID = "293"
IsaacItem.Pickup = "Krampus rage"
IsaacItem.Desc = "When used, fires a 4 way brimstone laser in all cardinal directions, dealing a lot of damage to any enemies. Maximum potential damage is 462 (20-21 ticks of 22 damage if the laser makes contact the whole duration) Laser damage does not scale with your damage stat. Has a chance to drop after you beat Krampus. If you get close enough to an enemy that has a large hitbox, you can hit it with 2 of the laser beams, allowing you to deal a lot more damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[293] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Butter Bean"
IsaacItem.ID = "294"
IsaacItem.Pickup = "Reusable knockback"
IsaacItem.Desc = "When used, farts on nearby enemies and knocks them backwards away from Isaac. Allows you to reflect projectiles away from Isaac (Afterbirth only feature)"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Timed (A few seconds)"
TFABOI.Items[294] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Magic Fingers"
IsaacItem.ID = "295"
IsaacItem.Pickup = "Pay to play"
IsaacItem.Desc = "Upon use, consumes a coin and deals damage to everything in the room. Damage dealt is equal to your tear damage * 2."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[295] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Converter"
IsaacItem.ID = "296"
IsaacItem.Pickup = "Convert your soul"
IsaacItem.Desc = "When used, converts 2 soul or black hearts into 1 red heart container. This item will take from your soul hearts first."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[296] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pandora's Box"
IsaacItem.ID = "297"
IsaacItem.Pickup = "? ?"
IsaacItem.Desc = "When used, this item will spawn a set of items or consumables based on which floor you are currently on. Basement 1: 2 Soul hearts. Basement 2: 2 Bombs + 2 Keys. Caves 1: 1 Boss Item. Caves 2: 1 Boss Item + 2 Soul Hearts. Depths 1: 4 Soul hearts. Depths 2: 20 coins. Womb 1: 2 Boss Items. Womb 2: Bible. Blue Womb: Nothing! Sheol: 1 Devil Room Item + 1 Black Heart. Cathedral: 1 Angel Room Item + 1 Eternal Heart. Chest: 1 coin. Dark Room: Nothing! The Void: Nothing! Pandora's Box considers XL floors to always be the first floor of a chapter."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "One time use"
TFABOI.Items[297] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Unicorn Stump"
IsaacItem.ID = "298"
IsaacItem.Pickup = "You feel stumped"
IsaacItem.Desc = "When used, turns Isaac invincible and gains +0.28 speed for a 5 seconds. You cannot fire tears while the stump is active. Very similar to the My Little Unicorn item but does not deal contact damage. When used with Mom's Knife, you can still deal contact damage but will be unable to change the way the knife faces while the effect is active."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[298] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Taurus"
IsaacItem.ID = "299"
IsaacItem.Pickup = "Speed down + rage is building"
IsaacItem.Desc = "-0.3 Speed Down. While in a hostile room your speed raises at a rate of +0.065 per second. When you hit a speed stat of 2.0, Isaac will gain the My Little Unicorn invincibility effect for a few seconds, increasing speed and allowing him to run into enemies to deal 40 contact damage per hit. The time it takes for the effect to activate becomes shorter with a higher base Speed stat. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[299] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Aries"
IsaacItem.ID = "300"
IsaacItem.Pickup = "Ramming speed"
IsaacItem.Desc = "+0.25 Speed up. Gives huge horns which stick out, allowing you to deal 18 contact damage if you hit something with enough speed. Will not deal contact damage unless you are moving fast enough, but does not prevent you from taking damage yourself. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[300] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cancer"
IsaacItem.ID = "301"
IsaacItem.Pickup = "HP up + you feel protected"
IsaacItem.Desc = "+3 Soul Hearts After getting hit once, you gain a damage reduction for the rest of the room similar to The Wafer item (-50% damage taken). One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[301] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Leo"
IsaacItem.ID = "302"
IsaacItem.Pickup = "Stompy"
IsaacItem.Desc = "Isaac gets a lion's mane and now has the ability to crush rocks by walking over them. Crushed rocks and poop can fill holes if you walk in their direction. Allows you to crush Red Poops and sometimes not take damage. However, If you also have flying you will always take damage. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[302] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Virgo"
IsaacItem.ID = "303"
IsaacItem.Pickup = "You feel refreshed and protected"
IsaacItem.Desc = "A random chance when you take damage to get an invincibility shield for a few seconds (Similar to the Celtic Cross effect but more likely). The chance to get an invincibility shield is affected by your luck stat and at +10 Luck it will activate every time you get hit. Converts all stat down pills into stat up pills. 'Bad Trip' turns into 'Balls of Steel' and 'Amnesia' turns into 'I can see forever'. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[303] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Libra"
IsaacItem.ID = "304"
IsaacItem.Pickup = "You feel balanced"
IsaacItem.Desc = "Gives you 6 keys, 6 bombs and 6 coins. Balances out your stats to bring the high and low stats closer to an average value. All future stat upgrading items will now instead spread out across all other stats. For example, an item which usually gives +1 Damage would instead give a small 'all stats up'. Stats effected by this item are: Damage, Tears, Range, Speed. When taken with another item which gives an extreme value in a certain stat (e.g. Soy Milk) can lead to interesting synergies. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[304] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Scorpio"
IsaacItem.ID = "305"
IsaacItem.Pickup = "Poison tears"
IsaacItem.Desc = "Isaac's tears turn bright green and always apply a poison effect to enemies which deals 4 or 6 damage per tick. This is essentially a superior version of The Common Cold item. Gives Dr. Fetus bombs a big increase in damage. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[305] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sagittarius"
IsaacItem.ID = "306"
IsaacItem.Pickup = "Penetrative shot + speed up"
IsaacItem.Desc = "+0.2 Speed Up. Tears now turn into arrow heads and pierce through enemies. Tears do not travel through rocks with this item. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[306] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Capricorn"
IsaacItem.ID = "307"
IsaacItem.Pickup = "All stats up"
IsaacItem.Desc = "+1 Health Up. +0.5 Damage Up. -1 Tear Delay (Tears Up). +0.1 Speed Up. +1.5 Range Up. +1 Key, +1 Bomb, +1 Coin. One of the twelve zodiac items available in the game."
IsaacItem.Stats = {["Damage"] = "0.5", ["TearDelayExtra"] = "-1", ["Range"] = "1.5"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[307] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Aquarius"
IsaacItem.ID = "308"
IsaacItem.Pickup = "A trail of tears"
IsaacItem.Desc = "Leaves a trail of tears on the floor behind Isaac which damages enemies that walk over it for 2 damage per tick. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[308] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pisces"
IsaacItem.ID = "309"
IsaacItem.Pickup = "Tears up + knockback shot"
IsaacItem.Desc = "-1 Tear Delay (Tears Up). Tears now have a knockback effect, which pushes enemies backwards. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[309] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Eve's Mascara"
IsaacItem.ID = "310"
IsaacItem.Pickup = "Shot speed down + DMG up"
IsaacItem.Desc = "x2 Damage Multiplier. Tears Down by exactly half (Tear delay * 2) -0.5 Shot Speed Down. The tears down from this item is a x2.0 multiplier after the formula, meaning it will always halve your tear rate (Unless you have Monstro's Lung or Soy Milk)."
IsaacItem.Stats = {["DamageMult"] = "1", ["TearDelayMult"] = "1"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[310] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Judas' Shadow"
IsaacItem.ID = "311"
IsaacItem.Pickup = "Sweet revenge"
IsaacItem.Desc = "When you die with this item, you respawn in the previous room as Black Judas with 2 black hearts for health. Black Judas has a damage multiplier of 2.00 (double Isaac's damage) and an additional +0.1 Speed. Black Judas is considered a separate character by the game, however he can be used to unlock Judas' secrets/achievements."
IsaacItem.Type = {"Passive"}
TFABOI.Items[311] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Maggy's Bow"
IsaacItem.ID = "312"
IsaacItem.Pickup = "HP up + you feel healthy"
IsaacItem.Desc = "+1 Health Up. All future red hearts now heal for double. Half hearts heal a whole heart and full hearts heal 2 red hearts."
IsaacItem.Type = {"Passive"}
TFABOI.Items[312] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Holy Mantle"
IsaacItem.ID = "313"
IsaacItem.Pickup = "Holy shield"
IsaacItem.Desc = "Each time you enter a new room, damage is negated for the first time you get hit. Can be used to go in and out of a Curse Room without taking damage."
IsaacItem.Type = {"Passive"}
TFABOI.Items[313] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Thunder Thighs"
IsaacItem.ID = "314"
IsaacItem.Pickup = "HP + speed down + you feel strong"
IsaacItem.Desc = "+1 Health Up. -0.4 Speed Down. You can now break obstacles by walking over them. Holes in the ground can be filled by crushing adjacent rocks, similar to how this can be done with bombs. Allows you to crush Red Poops and sometimes not take damage. However, If you also have flying you will always take damage."
IsaacItem.Type = {"Passive"}
TFABOI.Items[314] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Strange Attractor"
IsaacItem.ID = "315"
IsaacItem.Pickup = "Magnetic tears"
IsaacItem.Desc = "Enemies and pickups (keys, bombs etc.) are now magnetically attracted to Isaac's tears. Can cause some enemies to have unpredictable movement."
IsaacItem.Type = {"Passive"}
TFABOI.Items[315] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cursed Eye"
IsaacItem.ID = "316"
IsaacItem.Pickup = "Cursed charged shot"
IsaacItem.Desc = "Tears are now charged up and fired rapidly in a burst of up to 4 shots at once. The amount of tears fired in the charge depends on how long you charge for. The eye has three states, white (not firing), black (first second of charging) and blinking between black and white. If you get hit while Cursed eye is a solid black colour you are guaranteed to be teleported to another random room on the floor. If you get hit in either of the other 2 states you will not be teleported. The Black Candle item will remove the Cursed Eye's teleportation effect"
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[316] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mysterious Liquid"
IsaacItem.ID = "317"
IsaacItem.Pickup = "Toxic splash damage"
IsaacItem.Desc = "When Isaac's tears hit anything, they leave a green toxic creep on the floor that damages enemies."
IsaacItem.Type = {"Passive"}
TFABOI.Items[317] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Gemini"
IsaacItem.ID = "318"
IsaacItem.Pickup = "Conjoined friend"
IsaacItem.Desc = "A familar that is attached to Isaac, which will seek out and damage any enemies close by for 3 contact damage. One of the twelve zodiac items available in the game."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[318] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cain's Other Eye"
IsaacItem.ID = "319"
IsaacItem.Pickup = "Near sighted friend"
IsaacItem.Desc = "A familiar eye that bounces around the room slowly and fires tears in the same direction as Isaac. Cain's Other Eye deals scaling damage equal to Isaac's tear damage."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[319] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "???'s Only Friend"
IsaacItem.ID = "320"
IsaacItem.Pickup = "Controlled friend"
IsaacItem.Desc = "A familiar fly that can be moved around via use of the arrow keys dealing 2.5 contact damage per tick, similar to the Ludovico Technique's mechanic. Picking up this item as well as 2 other fly-type items will allow you to transform into Lord of the Flies."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[320] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Samson's Chains"
IsaacItem.ID = "321"
IsaacItem.Pickup = "The ol' ball and chain"
IsaacItem.Desc = "An iron ball and chain attached to Isaac, similar to Guppy's Hairball that you can fling around to deal 5 damage per tick. The ball will block enemy shots and can also destroy environmental objects such as rocks, mushrooms and skulls. Does not decrease your movement speed stat at all however the ball has to be dragged around causing Isaac to slow down slightly when the chain is fully extended."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[321] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mongo Baby"
IsaacItem.ID = "322"
IsaacItem.Pickup = "Mongo friend"
IsaacItem.Desc = "A familiar that will follow Isaac and copy the effect of one of your other familiars. If you don't have any other familiars, he will just shoot normal tears."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[322] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Isaac's Tears"
IsaacItem.ID = "323"
IsaacItem.Pickup = "Collected tears"
IsaacItem.Desc = "A spacebar item that fires 8 of Isaac's tears in a circle around him."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 bar per tear fired"
TFABOI.Items[323] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Undefined"
IsaacItem.ID = "324"
IsaacItem.Pickup = "Undefined"
IsaacItem.Desc = "Upon use, teleports you to one of the following rooms at random: Item room, Secret room, Super secret room, the I AM ERROR room or the Black Market (very low chance). Allows you to loop through the final floor infinitely. If you can get Undefined to teleport you to an I AM ERROR room, there will be a beam of light that takes you back to a new Chest/Dark Room floor with the same layout and refreshed rooms. longer allows you to loop through the final floor, as the I AM ERROR rooms have been removed from those floors."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[324] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Scissors"
IsaacItem.ID = "325"
IsaacItem.Pickup = "Lose your head"
IsaacItem.Desc = "Similar to the Pinking Shears, when used will cut your head from your body, however this item allows you to control Isaac's body. Isaac's detached head will remain stationary and shoot tears in the direction you are firing."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[325] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Breath of Life"
IsaacItem.ID = "326"
IsaacItem.Pickup = "Invincibility at a cost"
IsaacItem.Desc = "While you hold the spacebar down with this item, it will de-charge gradually and when the charge bar gets to zero it will grant you a brief period of invincibility. If the spacebar is held for too long (about 1 second) when it has no charge, you will take damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Timed (1 bar per second)"
TFABOI.Items[326] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Polaroid"
IsaacItem.ID = "327"
IsaacItem.Pickup = "Fate chosen"
IsaacItem.Desc = "Gives Isaac an invincibility shield for a few seconds when hit down to 1/2 heart remaining. Gives you access to the Chest floor. When unlocked, is guaranteed to drop after the Mom's Foot boss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[327] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Negative"
IsaacItem.ID = "328"
IsaacItem.Pickup = "Fate chosen"
IsaacItem.Desc = "Damages all enemies in the room for 40 damage when hit down to 1/2 heart remaining. Gives you access to the Dark Room floor. When unlocked, is guaranteed to drop after the Mom's Foot boss fight."
IsaacItem.Type = {"Passive"}
TFABOI.Items[328] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Ludovico Technique"
IsaacItem.ID = "329"
IsaacItem.Pickup = "Controlled tears"
IsaacItem.Desc = "You no longer shoot tears and instead now control a single large tear with the arrow keys. Items which increase your tears stat will cause the tear to deal damage at a faster rate. Items which increase your shot speed cause the tear to travel faster across the screen. Ludo and Brimstone create a large controllable red ring of death that does massive damage to anything in its path. Taking this with Mom's Knife allows you to remote control the knife around the room, dealing huge damage."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[329] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Soy Milk"
IsaacItem.ID = "330"
IsaacItem.Pickup = "DMG down + tears way up"
IsaacItem.Desc = "Very high Tears Up: (delay /4) - 2 -80% Damage Down."
IsaacItem.Stats = {["TearDelayDiv"] = "4", ["TearDelayExtra"] = "-1" ,["DamageMult"] = "-0.8"}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[330] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "GodHead"
IsaacItem.ID = "331"
IsaacItem.Pickup = "God tears"
IsaacItem.Desc = "Isaac's tears become homing and have a large aura around them, which will deal a lot of damage to anything inside its radius. +0.5 Damage Up. +1.2 Range Up. -0.3 Tears Down. -0.3 Shot Speed Down +0.8 Tear Height."
-- IsaacItem.Stats = {["Damage"] = "0.5", ["Tears"] = "-0.3", ["Range"] = "1.2", ["ShotSpeed"] = "0.3"}
-- IsaacItem.Tear = {["Homing"] = true , ["God"] = true}
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[331] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lazarus' Rags"
IsaacItem.ID = "332"
IsaacItem.Pickup = "Eternal life?"
IsaacItem.Desc = "Gives Isaac an extra life on death, exactly the same as Lazarus' default respawn effect. When you die with this item, you respawn in the same room with 1 heart and the Anemic item. The game considers you to be a different character (Lazarus II) when this effect activates."
IsaacItem.Type = {"Passive"}
TFABOI.Items[332] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Mind"
IsaacItem.ID = "333"
IsaacItem.Pickup = "I know all"
IsaacItem.Desc = "Gives Isaac a full mapping effect, revealing the entire floor and locations of all secret rooms."
IsaacItem.Type = {"Passive"}
TFABOI.Items[333] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Body"
IsaacItem.ID = "334"
IsaacItem.Pickup = "I feel all"
IsaacItem.Desc = "+3 Health Up. The three heart containers are pre-filled with red hearts."
IsaacItem.Type = {"Passive"}
TFABOI.Items[334] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Soul"
IsaacItem.ID = "335"
IsaacItem.Pickup = "I am all"
IsaacItem.Desc = "+2 Soul Hearts. Enemy projectiles will now slowly curve away from Isaac and avoid hitting him."
IsaacItem.Type = {"Passive"}
TFABOI.Items[335] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Onion"
IsaacItem.ID = "336"
IsaacItem.Pickup = "Toxic aura tears"
IsaacItem.Desc = "Isaac's tears become large, brown and will penetrate all objects and enemies (piercing + spectral). -0.25 Range Down. -0.4 Shot Speed Down. -0.5 Tear Height. Despite the increase in tear size, Dead Onion does NOT increase your damage stat."
IsaacItem.Type = {"Passive"}
TFABOI.Items[336] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Broken Watch"
IsaacItem.ID = "337"
IsaacItem.Pickup = "I think its broken"
IsaacItem.Desc = "Upon entering a new room, you now have a chance to randomly slow down or speed up all enemies in the room. An item only found in the Shop item pool."
IsaacItem.Type = {"Passive"}
TFABOI.Items[337] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Boomerang"
IsaacItem.ID = "338"
IsaacItem.Pickup = "It will never leave you"
IsaacItem.Desc = "A blue boomerang which can be thrown in a similar fashion to Mom's Knife, to stun any enemies it hits and deal damage. The damage dealt by the Boomerang is equal to double your tear damage. The boomerang can also be used to grab pickups and consumables from a distance, similar to the legend of zelda boomerang. The range of the boomerang is affected by range, with number one the distance is very short and makes the item a lot less effective. The Boomerang can be used to kill shopkeeper corpses, allowing you to farm their drops for coins, items, Steam Sale etc."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Timed (A few seconds)"
TFABOI.Items[338] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Safety Pin"
IsaacItem.ID = "339"
IsaacItem.Pickup = "Evil up + range + shot speed"
IsaacItem.Desc = "+5.25 Range Up. +0.16 Shot Speed Up. +1 Black Heart. +0.5 Tear Height. When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect."
IsaacItem.Stats = {["Range"] = "5.25", ["ShotSpeed"] = "0.16"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[339] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Caffeine Pill"
IsaacItem.ID = "340"
IsaacItem.Pickup = "Speed up + size down"
IsaacItem.Desc = "+0.3 Speed Up. Decreases the size of your player sprite, but doesn't decrease the hitbox. Gives you a random pill when picked up. An item only found in the boss room pool."
IsaacItem.Type = {"Passive"}
TFABOI.Items[340] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Torn Photo"
IsaacItem.ID = "341"
IsaacItem.Pickup = "Tears + shot speed up"
IsaacItem.Desc = "+0.7 Tears Up. +0.16 Shot Speed Up."
IsaacItem.Stats = {["Tears"] = "0.7", ["ShotSpeed"] = "0.16"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[341] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blue Cap"
IsaacItem.ID = "342"
IsaacItem.Pickup = "HP + tears + shot speed down"
IsaacItem.Desc = "+1 Health Up. +0.7 Tears Up. -0.16 Shot Speed Down. An item only found in the Boss Room pool."
-- IsaacItem.Stats = {["Tears"] = "0.7", ["ShotSpeed"] = "2"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[342] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Latch Key"
IsaacItem.ID = "343"
IsaacItem.Pickup = "Luck up"
IsaacItem.Desc = "+1 Luck Up. +1 Soul Heart. Spawns 2 keys on the ground."
IsaacItem.Type = {"Passive"}
TFABOI.Items[343] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Match Book"
IsaacItem.ID = "344"
IsaacItem.Pickup = "Evil up"
IsaacItem.Desc = "+1 Black Heart +3 Bombs When depleted, Black Hearts deal 40 damage to the entire room, in a Necronomicon style effect."
IsaacItem.Type = {"Passive"}
TFABOI.Items[344] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Synthoil"
IsaacItem.ID = "345"
IsaacItem.Pickup = "DMG up + range"
IsaacItem.Desc = "+1.0 Damage Up. +5.25 Range Up. +0.5 Tear Height."
IsaacItem.Stats = {["Damage"] = "1", ["Range"] = "5.25"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[345] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "A Snack"
IsaacItem.ID = "346"
IsaacItem.Pickup = "HP up"
IsaacItem.Desc = "+1 Health Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[346] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Diplopia"
IsaacItem.ID = "347"
IsaacItem.Pickup = "Double item vision"
IsaacItem.Desc = "A one-time use item which when used, will duplicate any pedestal items or consumables in the current room. If used in a shop, the duplicated items can be taken for free. If used on a trinket, another random trinket will spawn instead of a duplicate. If used in the Boss Rush, all the duplicates can be taken for free as well as one of the original items."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant (One time use)"
TFABOI.Items[347] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Placebo"
IsaacItem.ID = "348"
IsaacItem.Pickup = "Pill mimic"
IsaacItem.Desc = "When used, copies the effect of the pill you are currently holding without consuming it. Does not copy effects of Cards or Runes. Can be used to generate infinite batteries with the 48 hour energy pill."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[348] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Wooden Nickel"
IsaacItem.ID = "349"
IsaacItem.Pickup = "Flip a coin"
IsaacItem.Desc = "When used, has a 50% chance to drop one random type of coin (penny, nickel or dime)"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[349] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Toxic Shock"
IsaacItem.ID = "350"
IsaacItem.Pickup = "Mass poison"
IsaacItem.Desc = "With this item, at the start of every room you will deal double your tear damage to the entire room in a poison effect. Enemies killed now also leave a pool of creep on the ground where they died. High tear damage will cause this item to become very powerful for rooms with a lot of enemies, since they can die instantly and render the room harmless. Enemies which spawn after the first few seconds of each room are not affected by this item, e.g. Flies spawned from a Mulligan dying."
IsaacItem.Type = {"Passive"}
TFABOI.Items[350] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mega Bean"
IsaacItem.ID = "351"
IsaacItem.Pickup = "Giga fart!"
IsaacItem.Desc = "When used, the Mega Bean will freeze all enemies in the current room for a couple of seconds, deal 5 damage and poison any enemies in close proximity and send a wave of spikes across the room in the direction you are facing. The enemies in close range will take 5 damage then have a poison over time effect which deals your tear damage 4 or 6 times. The spike wave will deal 10 damage to any enemies in contact with it. Can be used to open secret rooms."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[351] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Glass Cannon"
IsaacItem.ID = "352"
IsaacItem.Pickup = "Be gentle..."
IsaacItem.Desc = "When used, reduces your health to half a heart and fires one large piercing spectral tear that does a lot of damage. This will affect all hearts including red, soul and black, reducing all of them down to half of one heart. The damage done by Glass Cannon is calculated as follows: dmg = (dmg + 1) * 10 (i.e. at base damage of 3.5, that's 45 damage)."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "5 seconds"
TFABOI.Items[352] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bomber Boy"
IsaacItem.ID = "353"
IsaacItem.Pickup = "Explosive blast!"
IsaacItem.Desc = "+5 bombs Isaac's bombs will now explode in a large cross-shaped pattern (roughly 5 bombs explosions wide). This also affects troll bombs."
IsaacItem.Type = {"Passive"}
TFABOI.Items[353] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Crack Jacks"
IsaacItem.ID = "354"
IsaacItem.Pickup = "Don't swallow the prize!"
IsaacItem.Desc = "+1 Health Up Spawns a random trinket on the floor."
IsaacItem.Type = {"Passive"}
TFABOI.Items[354] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Pearls"
IsaacItem.ID = "355"
IsaacItem.Pickup = "Range + luck up"
IsaacItem.Desc = "+1.25 Range Up. +0.5 Tear Height. +1 Luck Up."
IsaacItem.Type = {"Passive"}
TFABOI.Items[355] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Car Battery"
IsaacItem.ID = "356"
IsaacItem.Pickup = "Double charge!"
IsaacItem.Desc = "The Car Battery causes your spacebar item to activate twice on each use. For example, with Yum Heart you would heal 2 full red hearts instead of 1."
IsaacItem.Type = {"Passive"}
TFABOI.Items[356] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Box of Friends"
IsaacItem.ID = "357"
IsaacItem.Pickup = "Double your friends"
IsaacItem.Desc = "Upon use, gives you a duplicate of each familiar you have for the current room. It will not 'double' your familiars in the sense that if you have 2 of one kind, it will only give you an extra one. If the familiar only appears when taking damage (i.e. Dead Bird) then Box of Friends will cause it to spawn but won't create duplicates. This can be used multiple times in the same room to generate more familiars, meaning you can get a level 4 meatboy or bandage girl by using this item 3 times in the same room. If used when you have no familiars, it will give you a Demon Baby temporarily. Lilith starts with this item."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[357] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "The Wiz"
IsaacItem.ID = "358"
IsaacItem.Pickup = "Double wiz shot!"
IsaacItem.Desc = "Isaac wears a dunce hat and fires 2 tears at once diagonally, similar to the R U A WIZARD pill tear pattern. Gives Isaac spectral tears which allows them to travel through objects in the environment (i.e. rocks)."
IsaacItem.Type = {"Passive"}
TFABOI.Items[358] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "8 Inch Nails"
IsaacItem.ID = "359"
IsaacItem.Pickup = "Stick it to 'em!"
IsaacItem.Desc = "+1.5 Damage Up. Replaces Isaac's tears with nails, which have increased knockback. The increased knockback will also affect Brimstone, which usually has no knockback at all."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[359] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Incubus"
IsaacItem.ID = "360"
IsaacItem.Pickup = "Dark friend"
IsaacItem.Desc = "Gives you a familiar demon incubus that follows you and shoots tears exactly the same as Isaac's in terms of damage, stats and also effects. It will mimic any tear effects you currently have and also copy your current stats, meaning it will fire with the same damage, fire rate and range. Incubus' tear damage will scale with any future damage ups and stat upgrades you take. Lilith starts with this item."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[360] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Fate's Reward"
IsaacItem.ID = "361"
IsaacItem.Pickup = "Your fate beside you"
IsaacItem.Desc = "A familiar blue head that will follow Isaac and fire tears copying his tear damage. This familiar is very similar to Incubus, however it only copies damage and is not affected by tears or range upgrades."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[361] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil Chest"
IsaacItem.ID = "362"
IsaacItem.Pickup = "What's in the box?"
IsaacItem.Desc = "A familiar chest that follows Isaac and will drop a random pickup every few rooms."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[362] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sworn Protector"
IsaacItem.ID = "363"
IsaacItem.Pickup = "Protective friend"
IsaacItem.Desc = "An orbital angel which does 7 contact damage per tick and blocks shots. The angel will attract bullets towards it and block them. After blocking a tear, this orbital has a chance to drop an eternal heart. Visually this is almost identical to the Guardian Angel item, but without a face."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[363] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Friend Zone"
IsaacItem.ID = "364"
IsaacItem.Pickup = "Friendly fly"
IsaacItem.Desc = "A white orbiting fly which deals 3 contact damage per tick to enemies. This familiar orbits Isaac at a middle length distance somewhere between Distant Admiration and Forever Alone"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[364] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lost Fly"
IsaacItem.ID = "365"
IsaacItem.Pickup = "Lost protector"
IsaacItem.Desc = "A familiar fly that moves in a straight line and attaches itself to the first obstacle or wall it comes into contact with in each room. If any enemies walk into its path, it will deal 7 contact damage per tick. If the obstacle it is attached to is destroyed then it will continue rolling in the direction it was previously travelling until it meets another wall or obstacle."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[365] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Scatter Bombs"
IsaacItem.ID = "366"
IsaacItem.Pickup = "We put bombs in your bombs!"
IsaacItem.Desc = "+5 bombs Causes your bombs to explode into 4 tiny bombs"
IsaacItem.Type = {"Passive"}
TFABOI.Items[366] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sticky Bombs"
IsaacItem.ID = "367"
IsaacItem.Pickup = "Egg sack bombs!"
IsaacItem.Desc = "When one of your bombs kills an enemy, a bunch of blue spiders are spawned to fight by your side. This item also causes your bombs to stick to enemies."
IsaacItem.Type = {"Passive", "Bomb Modifier"}
TFABOI.Items[367] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Epiphora"
IsaacItem.ID = "368"
IsaacItem.Pickup = "Intensifying tears"
IsaacItem.Desc = "Shooting in one direction increases your fire rate until a cap is reached. The maximum effect is to halve your delay, which takes roughly 10 seconds to achieve. The accuracy of your tears is also reduced as your fire rate increases. As soon as you change direction or interupt shooting, your fire rate is reset to its normal amount."
IsaacItem.Type = {"Passive"}
TFABOI.Items[368] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Continuum"
IsaacItem.ID = "369"
IsaacItem.Pickup = "Transcendent tears"
IsaacItem.Desc = "+2.25 Range Up. +1.5 Tear Height. Tears will now travel through walls and appear out of the opposite wall, similar to a portal-type mechanic. Your tears can now also travel over rocks and objects in the environment."
IsaacItem.Stats = {["Range"] = "2.25"}
IsaacItem.Tear = {["Spectral"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[369] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mr. Dolly"
IsaacItem.ID = "370"
IsaacItem.Pickup = "Range + tears up"
IsaacItem.Desc = "+0.7 Tears Up. +5.25 Range Up. +0.5 Tear Height. Spawns 3 random types of hearts on the floor when picked up"
IsaacItem.Stats = {["Tears"] = "0.7", ["Range"] = "5.25"}
IsaacItem.Type = {"Passive"}
TFABOI.Items[370] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Curse of The Tower"
IsaacItem.ID = "371"
IsaacItem.Pickup = "You feel cursed..."
IsaacItem.Desc = "Causes Isaac to spawn 6 troll bombs on the floor every time he gets hit, similar to the Anarchist Cookbook mechanic."
IsaacItem.Type = {"Passive"}
TFABOI.Items[371] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Charged Baby"
IsaacItem.ID = "372"
IsaacItem.Pickup = "Bbbzzzzzt!"
IsaacItem.Desc = "A familiar baby that has a random chance to drop a battery pickup or freeze all enemies in the room for a short while. Charged Baby also has a chance to add one charge to your spacebar item. These effects can only occur while in a hostile room with enemies."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[372] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Eye"
IsaacItem.ID = "373"
IsaacItem.Pickup = "Accuracy brings power!"
IsaacItem.Desc = "Gives Isaac a +12.5% or +25% damage up for every tear that successfully hits an enemy. Most enemies give the +25% bonus, however some objects (e.g. successfully hitting a fire place) will give the smaller +12.5% bonus The bonus from Dead Eye maxes out at double your damage (+100%). If a tear misses an enemy, there is a chance for the multiplier to be reset back to 1. Piercing shots work with this item and multiple hits with a single tear will each give a damage bonus."
IsaacItem.Type = {"Passive"}
TFABOI.Items[373] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Holy Light!"
IsaacItem.ID = "374"
IsaacItem.Pickup = "Holy shot!"
IsaacItem.Desc = "Isaac has a random chance to fire a Holy tear, which when it hits an enemy, will spawn a Crack the Sky style light beam on the same enemy, dealing damage. The beams from this item deal damage equal to 400% of your tear damage (4x damage multiplier for the beams only). The chance to fire a Holy tear is affected by your luck stat, maxing out at a 50% chance."
IsaacItem.Type = {"Passive"}
TFABOI.Items[374] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Host Hat"
IsaacItem.ID = "375"
IsaacItem.Pickup = "Nice hat!"
IsaacItem.Desc = "A familiar host that sits on Isaac's head and has a random chance to deflect some tears so that they don't hit you. Causes you to become immune to explosions. Stomp damage (i.e. Mom's Foot boss) counts as an explosion and is therefore prevented by Host Hat."
IsaacItem.Type = {"Passive"}
TFABOI.Items[375] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Restock"
IsaacItem.ID = "376"
IsaacItem.Pickup = "Never ending stores!"
IsaacItem.Desc = "Causes your shops to instantly restock their items when you buy them."
IsaacItem.Type = {"Passive"}
TFABOI.Items[376] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bursting Sack"
IsaacItem.ID = "377"
IsaacItem.Pickup = "Spider love"
IsaacItem.Desc = "Spider enemies no longer target or deal contact damage to Isaac. This is very similar to a Skatole for spiders instead of flies."
IsaacItem.Type = {"Passive"}
TFABOI.Items[377] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "No. 2"
IsaacItem.ID = "378"
IsaacItem.Pickup = "Uh oh..."
IsaacItem.Desc = "Continuously firing or charging tears for 3 seconds causes Isaac to drop a Butt Bomb Only 1 Butt Bomb can be dropped per charge, so you'll need to stop firing then start again to drop another one. Butt Bombs explode for 50 damage like normal bombs, but also deal 10 damage to all enemies in the room and daze them for a short period of time."
IsaacItem.Type = {"Passive"}
TFABOI.Items[378] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pupula Duplex"
IsaacItem.ID = "379"
IsaacItem.Pickup = "Wide shot"
IsaacItem.Desc = "Transforms Isaac's tears into a wide arc shape which gives them a much larger hitbox. Gives Isaac spectral tears which allows them to travel through objects in the environment (i.e. rocks)."
IsaacItem.Tear = {["Spectral"] = true, ["Wide"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[379] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pay To Play"
IsaacItem.ID = "380"
IsaacItem.Pickup = "Money talks"
IsaacItem.Desc = "+5 coins. This item turns all doors that require a key into doors which need a coin to enter instead. This affects shops, item rooms, libraries and other key doors."
IsaacItem.Type = {"Passive"}
TFABOI.Items[380] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Eden's Blessing"
IsaacItem.ID = "381"
IsaacItem.Pickup = "Your future shines brighter"
IsaacItem.Desc = "+0.7 Tears Up. Gives you a random item at the start of your next run (You need to start a fresh run to receive the item)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[381] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Friendly Ball"
IsaacItem.ID = "382"
IsaacItem.Pickup = "Gotta fetch 'em all!"
IsaacItem.Desc = "When used, can be thrown at enemies to capture them (similar to a Poké Ball). After capturing an enemy, the next use of the Friendly Ball will re-spawn the same enemy as a friendly companion which will attack other enemies. The companion will persist between rooms and floors until it dies by taking enough damage."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms."
TFABOI.Items[382] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tear Detonator"
IsaacItem.ID = "383"
IsaacItem.Pickup = "Remote tear detonation"
IsaacItem.Desc = "When used, will detonate any tears currently on the screen and cause each one to split into 6 more tears which will fire in a circle, similar to Tammy's Head."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room."
TFABOI.Items[383] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil Gurdy"
IsaacItem.ID = "384"
IsaacItem.Pickup = "A gurd of your own!"
IsaacItem.Desc = "Gives Isaac a familiar Gurdy that will charge around the room dealing contact damage to enemies. The Gurdy is charged by holding down the fire button and letting go. The longer the button is held the faster Gurdy will fling itself across the screen. Lil Gurdy can glide over the top of objects and obstacles in the room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[384] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bumbo"
IsaacItem.ID = "385"
IsaacItem.Pickup = "Bumbo want coin!"
IsaacItem.Desc = "A beggar head which floats around the room and picks up any near-by coins. Every 6 coins Bumbo will evolve to a new form except for level 4 which takes 12 coins. Level 2: Bumbo gains a body and crawls around the room, sometimes dropping random pickups. Level 3: It now fires tears in the same direction Isaac does. Level 4: Bumbo no longer fires tears but instead will chase enemies slowly and deal contact damage. It will also sometimes randomly drop bombs. After reaching level 4 (and at a much lower chance before level 4), Bumbo will also continue to collect coins and drop random pickups, similar to the Bum Friend item, but can also drop pedestal items very rarely. "
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[385] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D12"
IsaacItem.ID = "386"
IsaacItem.Pickup = "Rerolls rocks"
IsaacItem.Desc = "When used, the D12 re-rolls any rocks into another random type of object (e.g. poop, pots, TNT, red poop, stone blocks etc.)"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[386] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Censer"
IsaacItem.ID = "387"
IsaacItem.Pickup = "Peace be with you"
IsaacItem.Desc = "Gives Isaac a familiar golden Censer which creates a huge aura of light that slows down any enemies inside it."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[387] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Key Bum"
IsaacItem.ID = "388"
IsaacItem.Pickup = "He wants your keys!"
IsaacItem.Desc = "A familiar beggar similar to Bum Friend that follows Isaac and collects keys, giving random chests in return. One of the 3 items required to create the Super Bum familiar transformation."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[388] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Rune Bag"
IsaacItem.ID = "389"
IsaacItem.Pickup = "Rune generator"
IsaacItem.Desc = "A bag that follows Isaac and drops a random mystic rune every 3 rooms."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[389] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Seraphim"
IsaacItem.ID = "390"
IsaacItem.Pickup = "Sworn friend"
IsaacItem.Desc = "A familiar angel which follows Isaac and fires Sacred Heart tears which deal 10 damage at -25% shot speed and a reduced fire rate."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[390] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Betrayal"
IsaacItem.ID = "391"
IsaacItem.Pickup = "Turn your enemy"
IsaacItem.Desc = "Every time Isaac takes damage, a charm effect is applied to every enemy in the room, causing them to attack each other rather than Isaac. The effect will not trigger if there are less than 2 enemies in the room."
IsaacItem.Type = {"Passive"}
TFABOI.Items[391] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Zodiac"
IsaacItem.ID = "392"
IsaacItem.Pickup = "The heavens will change you"
IsaacItem.Desc = "Zodiac will give you a random zodiac item effect that changes after every floor. Possible item effects include: Taurus, Aries, Cancer, Leo, Virgo, Libra, Scorpio, Sagittarius, Capricorn, Aquarius, Gemini or Pisces."
IsaacItem.Type = {"Passive"}
TFABOI.Items[392] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Serpent's Kiss"
IsaacItem.ID = "393"
IsaacItem.Pickup = "The kiss of death"
IsaacItem.Desc = "Tears now have a random chance to apply a poison effect, causing 4 or 6 damage per tick to enemies (Similar to The Common Cold item). Isaac now deals poison damage on contact with enemies similar to The Virus item (Damage over time 4 or 6 per tick). Enemies that were poisoned have a chance to drop a black sin heart when killed."
-- IsaacItem.Tear = {["Poison"] = true}
IsaacItem.Type = {"Passive"}
TFABOI.Items[393] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Marked"
IsaacItem.ID = "394"
IsaacItem.Pickup = "Directed tears"
IsaacItem.Desc = "Isaac will now fire tears automatically directed at a red target on the ground which is controlled by the player. This allows for a full 360 degree tear firing radius. Can be overridden by other tear modifiers such as Mom's Knife or Brimstone. +0.7 Tears Up. +0.3 Tear Height. +3.15 Range Up. Has no effect with Lilith's Incubus"
IsaacItem.Type = {"Passive"}
TFABOI.Items[394] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tech X"
IsaacItem.ID = "395"
IsaacItem.Pickup = "Laser ring tears"
IsaacItem.Desc = "Tears are replaced with the ability to charge and fire a laser ring that travels across the room. The size of the ring will depend on how long you charge it. The laser ring does damage equal to your normal tears rapidly to any enemies inside the ring."
IsaacItem.Type = {"Passive", "Tear modifier"}
TFABOI.Items[395] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ventricle Razor"
IsaacItem.ID = "396"
IsaacItem.Pickup = "Short cutter"
IsaacItem.Desc = "Allows you to create one brown tunnel and one blue tunnel in the floor, that can be used to teleport between wherever you placed each one. This item will let you port out of the devil room but not back into it. Very useful in the boss rush and challenge rooms."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[396] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tractor Beam"
IsaacItem.ID = "397"
IsaacItem.Pickup = "Controlled tears"
IsaacItem.Desc = "Isaac's tears now travel directly forwards following a beam of light, but will also move sideways based on your player movement. +0.5 Tears Up. +5.25 Range Up. +0.16 Shot Speed Up. +0.5 Tear Height. Allows for more accurate correction when firing tears, as their direction can be controlled even after they have been fired. If you switch the direction in which you are firing tears, the beam of light and all your tears will also be transported to the new direction "
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[397] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "God's Flesh"
IsaacItem.ID = "398"
IsaacItem.Pickup = "Shrink shot!"
IsaacItem.Desc = "Tears now have a random chance to apply a shrinking effect, causing enemies to shrink in size and also run away from Isaac. Shrunk enemies can be crushed and killed by walking over them."
IsaacItem.Type = {"Passive"}
TFABOI.Items[398] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Maw of The Void"
IsaacItem.ID = "399"
IsaacItem.Pickup = "Consume thy enemy!"
IsaacItem.Desc = "+1.0 Damage Up. +0.5 Tear Height. After firing tears for 3 seconds, a red cross appears on Isaac's head that, upon releasing the fire button, creates a black ring which deals a lot of damage to any enemies inside it. The ring deals damage equal to your tear damage rapidly to any enemies in contact with it. Enemies killed with the black ring have a chance to drop Black hearts. You have to keep the fire button held down for the full 3 seconds to cause this effect."
IsaacItem.Type = {"Passive"}
TFABOI.Items[399] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spear of Destiny"
IsaacItem.ID = "400"
IsaacItem.Pickup = "Your destiny"
IsaacItem.Desc = "In addition to tears, Isaac now holds a spear infront of him which deals damage equal to 2 times your tear damage. The spear cannot be thrown like Mom's Knife but deals damage while it is in contact with an enemy."
IsaacItem.Type = {"Passive"}
TFABOI.Items[400] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Explosivo"
IsaacItem.ID = "401"
IsaacItem.Pickup = "Sticky bomb shot!"
IsaacItem.Desc = "Tears now have a random chance to become sticky bombs, which will attach to enemies and explode after a few seconds. The bomb explosion deals your tear damage + 60."
IsaacItem.Type = {"Passive"}
TFABOI.Items[401] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Chaos"
IsaacItem.ID = "402"
IsaacItem.Pickup = "!!!"
IsaacItem.Desc = "Causes all item pedestals to be chosen from a random item pool instead of the pre-defined ones which normally exist. If an item is chosen from an exhausted pool, it will spawn a Breakfast item instead. When picked up also drops between 1-6 random pickups on the floor."
IsaacItem.Type = {"Passive"}
TFABOI.Items[402] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Spider Mod"
IsaacItem.ID = "403"
IsaacItem.Pickup = "Mod buddy!"
IsaacItem.Desc = "A familiar grey spider that wanders around and allows you to see your tear damage and the health bars of all enemies. The spider will inflict a random status effect on any enemies it comes into contact with (e.g. slow, shrink, fear). Spider Mod will also randomly drop battery consumables. For the sake of simplicity for players, all damage values displayed are multiplied by 10 and rounded to the nearest number. The actual damage values are in reality about 1/10. This item is a reference to Spider853, creator of Spidermod for the original game and one of the lead developers that worked on Rebirth and Afterbirth."
IsaacItem.Type = {"Passive"}
TFABOI.Items[403] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Farting Baby"
IsaacItem.ID = "404"
IsaacItem.Pickup = "He farts!"
IsaacItem.Desc = "A familiar that follows Isaac and blocks tears. If a tear hits Farting Baby, there is a high chance for it to fart, which deals damage to nearby enemies and charms them."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[404] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "GB Bug"
IsaacItem.ID = "405"
IsaacItem.Pickup = "Game breaking bug, right away!"
IsaacItem.Desc = "A glitch familiar that bounces around the room and applies a random status effect to any enemies it comes into contact with (e.g. slow, burning) If the GB Bug passes over a consumable, it has a chance to reroll it into another random consumable."
IsaacItem.Type = {"Passive"}
TFABOI.Items[405] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D8"
IsaacItem.ID = "406"
IsaacItem.Pickup = "Reroll stats"
IsaacItem.Desc = "When used, the D8 rerolls all of your stats! Will only effect your damage, tears, range and speed stats."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 Rooms"
TFABOI.Items[406] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Purity"
IsaacItem.ID = "407"
IsaacItem.Pickup = "Aura stat boost"
IsaacItem.Desc = "Purity will boost one of Isaac's stats depending on the colour of the aura around him. When you take damage, the aura will be removed and replaced with another random one when you enter the next room. Colour code is as follows: Red = +4.0 Damage Blue = -4 Tear Delay Yellow = +0.5 Speed Up Orange = +7.5 Range Up"
IsaacItem.Type = {"Passive"}
TFABOI.Items[407] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Athame"
IsaacItem.ID = "408"
IsaacItem.Pickup = "Call to the void"
IsaacItem.Desc = "Now when you take damage, a black ring will appear around Isaac that damages any enemies in contact with it. Enemies killed with the black ring have a chance to drop black hearts."
IsaacItem.Type = {"Passive"}
TFABOI.Items[408] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Empty Vessel"
IsaacItem.ID = "409"
IsaacItem.Pickup = "I reward an empty vessel"
IsaacItem.Desc = "+2 Black Hearts When Isaac has no red hearts, this item gives Isaac the ability to fly and chance to trigger a shield that nullifies all types of damage for 10 seconds. As soon as Isaac has half a red heart or more, this item deactivates."
IsaacItem.Type = {"Passive"}
TFABOI.Items[409] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Evil Eye"
IsaacItem.ID = "410"
IsaacItem.Pickup = "Eye shot!"
IsaacItem.Desc = "While firing tears this item gives you a chance to fire an eye across the screen with a very slow shot speed, which will fire tears of its own in the same direction as Isaac. The evil eye shots will be destroyed if they come into contact with enemies or obstacles."
IsaacItem.Type = {"Passive"}
TFABOI.Items[410] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lusty Blood"
IsaacItem.ID = "411"
IsaacItem.Pickup = "Their blood brings rage!"
IsaacItem.Desc = "Each time Isaac kills an enemy, you get a temporary damage up which lasts for the current room. Each subsequent kill will stack further damage up to a maximum of +5 Damage Up after 9 kills. This item is the same principle as the Bloody Lust item from the original flash game."
IsaacItem.Type = {"Passive"}
TFABOI.Items[411] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cambion Conception"
IsaacItem.ID = "412"
IsaacItem.Pickup = "Feed them hate"
IsaacItem.Desc = "After taking enough damage you will gain a permanent demon familiar. Possible familiars include: Dark Bum, Demon Baby, Leech, Lil' Brimstone, Succubus, Incubus. The effect is shown visually in 3 stages with the character's belly getting larger each time until it finally gives birth to a familiar. This item is the demonic counterpart to Immaculate Conception. Cambion Conception cannot grant more than 4 familiars in total. Lilith starts with this item."
IsaacItem.Type = {"Passive"}
TFABOI.Items[412] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Immaculate Conception"
IsaacItem.ID = "413"
IsaacItem.Pickup = "Feed them love"
IsaacItem.Desc = "After picking up enough hearts, Isaac gains a permanent angelic familiar. Possible familiars include: Holy Water, Guardian Angel, Sworn Protector, The Relic and Seraphim It is possible to get multiple followers by continuing to pick up hearts. This item is the angelic counterpart to Cambion Conception."
IsaacItem.Type = {"Passive"}
TFABOI.Items[413] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "More Options"
IsaacItem.ID = "414"
IsaacItem.Pickup = "There are even more options!"
IsaacItem.Desc = "Two items now spawn in each of your item rooms, however only one can be taken and the other will disappear"
IsaacItem.Type = {"Passive"}
TFABOI.Items[414] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Crown of Light"
IsaacItem.ID = "415"
IsaacItem.Pickup = "The untainted gain power"
IsaacItem.Desc = "+2 Soul Hearts. A crown that replaces normal tears with blue diamond tears while you don't have any empty red heart containers. While the effect is active, tears do double damage. The crown will glow blue while active, if inactive it will appear grey. The effect will also deactivate for the rest of the current room when you take damage, regardless of your health."
IsaacItem.Type = {"Passive"}
TFABOI.Items[415] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Deep Pockets"
IsaacItem.ID = "416"
IsaacItem.Pickup = "More stuff to carry!"
IsaacItem.Desc = "Allows you to carry two cards/pills/runes at the same time."
IsaacItem.Type = {"Passive"}
TFABOI.Items[416] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Succubus"
IsaacItem.ID = "417"
IsaacItem.Pickup = "Damage booster"
IsaacItem.Desc = "A flying familiar that bounces around the room with a damaging aura, dealing rapid damage to any enemies inside it and boosting Isaac's tear damage. While standing in the black aura, Isaac has a temporary 1.5x damage multiplier (this will stack if you have more than one Succubus')"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[417] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Fruit Cake"
IsaacItem.ID = "418"
IsaacItem.Pickup = "Rainbow effects!"
IsaacItem.Desc = "Gives you a different tear effect with every tear that you fire. Tear effects include: Anti-Gravity, GodHead, Proptosis, Tiny Planet, Holy Light, Soy Milk, Cricket's Body, Explosivo, Continuum, My Reflection, Ring Worm, Hook Worm, Wiggle Worm, Flat Worm. With Dr. Fetus, this item will also cycle through random Bomb Modifiers (e.g. Butt Bombs, Hot Bombs)."
IsaacItem.Type = {"Passive", "Tear Modifier"}
TFABOI.Items[418] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Teleport 2.0"
IsaacItem.ID = "419"
IsaacItem.Pickup = "I-teleport!"
IsaacItem.Desc = "When used will teleport you to another random room that has not been explored yet. After all the normal rooms have been explored, the hierarchy of rooms chosen is: Super Secret Room, Shop, Item Room, Secret Room, Curse Room, Sacrifice Room, Devil/Angel Room, I Am Error. This ordering means a Devil and I Am Error room can both be forced if all others have been visited. If used in a normal room with enemies it will teleport you out and back into the exact same room."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[419] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Black Powder"
IsaacItem.ID = "420"
IsaacItem.Pickup = "Spin the black circle!"
IsaacItem.Desc = "Walking in a circle will spawn a pentagram symbol on the floor, which deals 10 damage per tick to any enemies inside it. The trail of black powder left on the floor will quickly disappear, meaning you are limited on the size of the pentagram symbol you can create."
IsaacItem.Type = {"Passive"}
TFABOI.Items[420] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Kidney Bean"
IsaacItem.ID = "421"
IsaacItem.Pickup = "Love toots!"
IsaacItem.Desc = "When used, applies the charm effect to any enemies in close range. Charmed enemies will prioritize attacking other enemies in the room, otherwise they will still attack Isaac."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 Rooms"
TFABOI.Items[421] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Glowing Hour Glass"
IsaacItem.ID = "422"
IsaacItem.Pickup = "Turn back time"
IsaacItem.Desc = "When used, this item will rewind time and put you back in the previous room, in the same state you were in at that moment. This means any damage taken or consumables used in the current room will be reset back to the previous state."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[422] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Circle of Protection"
IsaacItem.ID = "423"
IsaacItem.Pickup = "Protect me from myself"
IsaacItem.Desc = "Gives Isaac a large white halo around him, that deals a bit of damage to any enemies in contact with the ring. Every time an enemy bullet enters the ring, there is a chance it will reflect a homing tear back at the enemy."
IsaacItem.Type = {"Passive"}
TFABOI.Items[423] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sack Head"
IsaacItem.ID = "424"
IsaacItem.Pickup = "More sacks!"
IsaacItem.Desc = "All bomb, coin, key, and battery pickups pickups now have a chance to be replaced with a sack that contains multiple pickups. Can lead to game-breaking combinations with the D20 due to the amount of consumables and batteries spawned by the item sacks."
IsaacItem.Type = {"Passive"}
TFABOI.Items[424] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Night Light"
IsaacItem.ID = "425"
IsaacItem.Pickup = "Scared of the dark?"
IsaacItem.Desc = "Gives Isaac a cone of light infront of him that slows any enemies inside it and their tears. The light faces the direction that you are facing, not the direction you are firing. Removes Curse of Darkness for the current floor, if picked up on a floor where the curse is active."
IsaacItem.Type = {"Passive"}
TFABOI.Items[425] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Obsessed Fan"
IsaacItem.ID = "426"
IsaacItem.Pickup = "Follows my every move..."
IsaacItem.Desc = "A purple familiar fly that follows your exact movement on a 3 second delay and deals contact damage to enemies."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[426] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mine Crafter"
IsaacItem.ID = "427"
IsaacItem.Pickup = "Booom!"
IsaacItem.Desc = "When used, places an explosive TNT barrel next to you. The TNT barrel can be pushed and used to explode rocks or damage enemies. If used a second time in the same room while the last TNT barrel is still there, it will remotely explode the first TNT and not spawn another. "
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "1 room"
TFABOI.Items[427] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "PJs"
IsaacItem.ID = "428"
IsaacItem.Pickup = "You feel cozy"
IsaacItem.Desc = "+4 Soul Hearts Fully restores your red health."
IsaacItem.Type = {"Passive"}
TFABOI.Items[428] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Head of the Keeper"
IsaacItem.ID = "429"
IsaacItem.Pickup = "Penny tears!"
IsaacItem.Desc = "Isaac's tears become coins and now have a chance to drop pennies on the floor upon successfully hitting an enemy. Has a chance to drop when exploding a dead shopkeeper and also appear in the Gold Chest pool."
IsaacItem.Type = {"Passive"}
TFABOI.Items[429] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Papa Fly"
IsaacItem.ID = "430"
IsaacItem.Pickup = "Turret follower"
IsaacItem.Desc = "A familiar blue fly that will follow Isaac's movement pattern but delayed by 3 seconds. Papa Fly will fire tears at nearby enemies that deal damage equal to Isaac's tear damage."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[430] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Multidimensional Baby"
IsaacItem.ID = "431"
IsaacItem.Pickup = "ydduB Buddy"
IsaacItem.Desc = "A familiar baby that will follow your movement pattern on a 3 second delay. Tears that pass through the baby will double up and increase in damage while flashing black &amp; white."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[431] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Glitter Bombs"
IsaacItem.ID = "432"
IsaacItem.Pickup = "Prize bombs!"
IsaacItem.Desc = "Isaac's normal bombs become pink and causes them to drop random pickups when they explode (e.g. keys, coins, bombs)."
IsaacItem.Type = {"Passive", "Bomb Modifier"}
TFABOI.Items[432] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "My Shadow"
IsaacItem.ID = "433"
IsaacItem.Pickup = "Me! And my shaaaadow!"
IsaacItem.Desc = "Each time you take damage, My Shadow will apply a fear effect to all enemies in the room and spawn a familiar black charger that will attack for you. The charger will be killed if it is damaged too much."
IsaacItem.Type = {"Passive"}
TFABOI.Items[433] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Jar of Flies"
IsaacItem.ID = "434"
IsaacItem.Pickup = "Gotta catch 'em all?"
IsaacItem.Desc = "Every time you kill an enemy a fly will be added to the Jar, allowing you to stack up to 20. Using the Jar of Flies will release all the flies that are currently in the jar as friendly flies that will damage enemies."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Instant"
TFABOI.Items[434] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil Loki"
IsaacItem.ID = "435"
IsaacItem.Pickup = "4-way buddy!"
IsaacItem.Desc = "A Loki familiar that follows Isaac and shoots tears 4 tears in a cross pattern."
IsaacItem.Type = {"Passive"}
TFABOI.Items[435] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Milk!"
IsaacItem.ID = "436"
IsaacItem.Pickup = "Dont cry over it..."
IsaacItem.Desc = "Gives Isaac a familiar glass of milk that follows him and spills on the floor upon taking damage. After being spilt, the milk gives you a -2 Tear Delay (Tears up) for the rest of the room."
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[436] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D7"
IsaacItem.ID = "437"
IsaacItem.Pickup = "Reroll rewards!"
IsaacItem.Desc = "When used, the D7 will restart the current room and bring back all enemies once again, enabling you to farm rewards that spawn at the end after beating the room. Can be used to generate infinite consumable combinations, gaining as many coins/keys/bombs as you need. Will teleport you to out of the room if used in a Boss Room or Devil Room. If used in a greed fight it can be used to reroll the room into a Shop."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "3 rooms"
TFABOI.Items[437] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Binky"
IsaacItem.ID = "438"
IsaacItem.Pickup = "Memories..."
IsaacItem.Desc = "+1 Soul heart +0.7 Tears Up. Makes Isaac very small like a baby, reducing his hitbox size."
IsaacItem.Type = {"Passive"}
TFABOI.Items[438] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Box"
IsaacItem.ID = "439"
IsaacItem.Pickup = "What's inside?"
IsaacItem.Desc = "When used, Mom's Box will drop a random trinket on the ground. +1 Luck while held. While held, doubles the effect of trinkets which make sense to be doubled (e.g. +4 damage from Curved Horn instead of 2, -4 Tear Delay from Cancer instead of 2)"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[439] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Kidney Stone"
IsaacItem.ID = "440"
IsaacItem.Pickup = "Matt's kidney stone"
IsaacItem.Desc = "Randomly while firing tears, Isaac will stop firing and turn red, where he will charge and release a lot of 'tears' in one go. In the burst of tears is a kidney stone which deals a lot of damage. -0.2 Speed Down. -15 Range Down. +2.0 Tear height  The large decrease in range and tear height increase cause this item to overall be a slight range down."
IsaacItem.Type = {"Passive"}
TFABOI.Items[440] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mega Blast"
IsaacItem.ID = "441"
IsaacItem.Pickup = "Laser breath"
IsaacItem.Desc = "Upon use, fires a huge Mega Satan laser for 15 seconds, dealing massive damage to anything in its path and pushing Isaac back by the force. The laser persists for the entire 15 seconds even between rooms and floors. This item appears in the Devil Room but is weighted to be about 5 times rarer than all other devil room items."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "12 rooms."
TFABOI.Items[441] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dark Princes Crown"
IsaacItem.ID = "442"
IsaacItem.Pickup = "Loss is power"
IsaacItem.Desc = "A crown appears above your head and while at exactly 1 full red heart of health, you gain a +1.5 Range Up, +0.7 Tears Up and +0.20 Shot Speed Up Any time your health changes to be not exactly 1 red heart you lose the effect This item does nothing with The Lost Similar to other Tears Up (not Tear Delay) items, if you are already at the soft tear rate cap this item does not give you a tears up. "
IsaacItem.Type = {"Passive"}
TFABOI.Items[442] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Apple!"
IsaacItem.ID = "443"
IsaacItem.Pickup = "Trick or treat?"
IsaacItem.Desc = "Gives you a random chance to fire a razor blade which deals 400% damage instead of your normal tears +0.3 Tears Up. This item also turns your tears red, but does not change your actual damage stat or the damage your normal tears do The chance to fire a razor blade depends on your luck stat, and at +14 luck you will fire a razor blade every time"
IsaacItem.Type = {"Passive"}
TFABOI.Items[443] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lead Pencil"
IsaacItem.ID = "444"
IsaacItem.Pickup = "Hes a bleeder!"
IsaacItem.Desc = "With every 15 tears fired, Isaac will fire a cluster of tears instead of your normal tear Causes your normal tears to fire out of one eye, which means tears will fire in a near-perfect line instead of slightly off-center. Each of the tears in the cluster deals double damage"
IsaacItem.Type = {"Passive"}
TFABOI.Items[444] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dog Tooth"
IsaacItem.ID = "445"
IsaacItem.Pickup = "Bark at the moon!"
IsaacItem.Desc = "+0.3 Damage Up +0.1 Speed Up When entering a room connected to a Secret Room or Super Secret Room, a howling sound will play When entering a room with a crawl space trapdoor in it, a barking sound will play"
IsaacItem.Type = {"Passive"}
TFABOI.Items[445] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dead Tooth"
IsaacItem.ID = "446"
IsaacItem.Pickup = "Halitosis"
IsaacItem.Desc = "While firing, you gain a green aura that poisons any enemies which touch it Has no effect on Lilith, as she cannot fire tears"
IsaacItem.Type = {"Passive"}
TFABOI.Items[446] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Linger Bean"
IsaacItem.ID = "447"
IsaacItem.Pickup = "Crying makes me toot"
IsaacItem.Desc = "While firing tears, you have a small chance to spawn a poop cloud, which deals periodic damage to any enemies which come near it The cloud can be pushed slightly by firing tears at it"
IsaacItem.Type = {"Passive"}
TFABOI.Items[447] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Shard of Glass"
IsaacItem.ID = "448"
IsaacItem.Pickup = "Blood and guts!"
IsaacItem.Desc = "Upon taking damage, this item gives a chance to drop a full red heart, gain 5 range, and leave a trail of damaging red creep for the current room."
IsaacItem.Type = {"Passive"}
TFABOI.Items[448] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Metal Plate"
IsaacItem.ID = "449"
IsaacItem.Pickup = "It itches..."
IsaacItem.Desc = "+1 Soul Heart Enemy bullets have a chance to be deflected back at the enemy, which will hurt them and apply the concussive status effect, causing it to be stunned for a few seconds"
IsaacItem.Type = {"Passive"}
TFABOI.Items[449] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Eye of Greed"
IsaacItem.ID = "450"
IsaacItem.Pickup = "Gold tears!"
IsaacItem.Desc = "Every 20th tear fired will also fire a golden coin tear at the same time. This tear turns enemies to gold for a few seconds and causes them to drop 1-4 coins if killed while golden (similar to the Midas' Touch item) When the Midas Touch tear effect triggers, it will remove 1 coin from your current total The golden tear deals double your tear damage The effect can still trigger even if you have no held coins"
IsaacItem.Type = {"Passive"}
TFABOI.Items[450] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tarot Cloth"
IsaacItem.ID = "451"
IsaacItem.Pickup = "I see the future"
IsaacItem.Desc = "Drops a random card or rune on pickup Doubles the effect of certain tarot cards For some cards this does not double the effect (e.g. Stars card only teleports you once)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[451] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Varicose Veins"
IsaacItem.ID = "452"
IsaacItem.Pickup = "I'm leaking..."
IsaacItem.Desc = "Every time you take damage, 10 high damage tears are fired in a circle around you (similar to the Tammy's Head effect) Similar to Tammy's Head, this item synergizes with a lot of items (i.e. with Brimstone it fires 10 lasers)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[452] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Compound Fracture"
IsaacItem.ID = "453"
IsaacItem.Pickup = "Bone tears!"
IsaacItem.Desc = "Turns your tears into bones, which shatter into 1-3 smaller bone shards upon hitting any object or enemy. The smaller bone shards deal damage equal to half your normal tear damage +1.5 Range Up"
IsaacItem.Type = {"Passive"}
TFABOI.Items[453] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Polydactyly"
IsaacItem.ID = "454"
IsaacItem.Pickup = "Hold me!"
IsaacItem.Desc = "Allows Isaac to carry two cards, runes or pills (or any combination of these) at the same time. Drops a random card, pill or rune on pickup"
IsaacItem.Type = {"Passive"}
TFABOI.Items[454] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dad's Lost Coin"
IsaacItem.ID = "455"
IsaacItem.Pickup = "I remember this..."
IsaacItem.Desc = "+1.5 Range Up Drops a lucky penny"
IsaacItem.Type = {"Passive"}
TFABOI.Items[455] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Moldy Bread"
IsaacItem.ID = "456"
IsaacItem.Pickup = "Midnight snack!"
IsaacItem.Desc = "+1 Health Up"
IsaacItem.Type = {"Passive"}
TFABOI.Items[456] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Cone Head"
IsaacItem.ID = "457"
IsaacItem.Pickup = "Hard headed!"
IsaacItem.Desc = "+1 Soul Heart Each time you take damage from any source, Cone Head has a chance to prevent it from reducing your health (similar to the Infamy item) Isaac flashes blue very briefly when damage is negated by this item"
IsaacItem.Type = {"Passive"}
TFABOI.Items[457] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Belly Button"
IsaacItem.ID = "458"
IsaacItem.Pickup = "Whats in there?"
IsaacItem.Desc = "Drops one random trinket on pickup Gives you an extra trinket slot (same effect as Mom's Purse)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[458] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sinus Infection"
IsaacItem.ID = "459"
IsaacItem.Pickup = "Booger tears!"
IsaacItem.Desc = "Isaac's tears have a random chance to be a booger instead, which stick on to enemies and deal periodic poison damage until they die Each tick of poison damage is equal to your normal tear damage Each booger persists until the enemy is dead or 60 seconds has passed"
IsaacItem.Type = {"Passive"}
TFABOI.Items[459] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Glaucoma"
IsaacItem.ID = "460"
IsaacItem.Pickup = "Blind tears!"
IsaacItem.Desc = "Adds a chance to shoot a concussive tear, which will cause enemies to walk around dazed in confusion. The daze effect is effectively permanent for normal enemies, and has a much longer duration for bosses compared to other status effects The visual effect of a Glaucoma tear is hard to notice, however it is slightly lighter than normal tears and is not a perfect circle shape "
IsaacItem.Type = {"Passive"}
TFABOI.Items[460] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Parasitoid"
IsaacItem.ID = "461"
IsaacItem.Pickup = "Egg tears!"
IsaacItem.Desc = "This item gives you a chance that instead of firing tears you will fire an egg sack, which slows enemies on hit and drops a pool of white slowing creep below them If a parasitoid shot successfully hits an enemy, a blue friendly fly or spider is spawned"
IsaacItem.Type = {"Passive"}
TFABOI.Items[461] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Eye of Belial"
IsaacItem.ID = "462"
IsaacItem.Pickup = "Possessed tears!"
IsaacItem.Desc = "Causes your tears to become piercing, allowing them to travel through enemies After hitting its first enemy, each tear will double in damage and gain a homing effect +1.5 Range Up"
IsaacItem.Type = {"Passive"}
TFABOI.Items[462] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sulfuric Acid"
IsaacItem.ID = "463"
IsaacItem.Pickup = "Acid tears!"
IsaacItem.Desc = "+0.3 Damage Up Each tear has a chance to become acidic, allowing it to break rocks, pots and other breakable objects Acidic tears can also be used to open secret rooms"
IsaacItem.Type = {"Passive"}
TFABOI.Items[463] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Glyph of Balance"
IsaacItem.ID = "464"
IsaacItem.Pickup = "A gift from above"
IsaacItem.Desc = "+2 Soul Hearts This item will modify drops from champion enemies based on your current player state. The priority list of what will drop from champion enemies in order is as follows: Soul Hearts - When you have no red heart containers and less than 2 soul hearts Red Hearts (Full hearts) - While at 0.5 red hearts Keys - When you have no keys. Bombs - When you have no Bombs Red Hearts (Full hearts) - When you have at least half a red heart container empty Coins - While at less than 15 cents Keys - When you have less than 5 keys. Bombs - When you have less than 5 bombs Trinkets - If you have no trinkets and there are no trinkets on the ground in the room Soul Hearts - When you have less than 6 total heart containers of any kind If none of the above conditions are true, champions will resume dropping their regular pickups"
IsaacItem.Type = {"Passive"}
TFABOI.Items[464] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Analog Stick"
IsaacItem.ID = "465"
IsaacItem.Pickup = "360 tears!"
IsaacItem.Desc = "+0.3 Tears Up Allows you to fire tears diagonally by holding down two of the fire buttons at once If you are using a gamepad, this item allows you to fire in any direction"
IsaacItem.Type = {"Passive"}
TFABOI.Items[465] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Contagion"
IsaacItem.ID = "466"
IsaacItem.Pickup = "Outbreak!"
IsaacItem.Desc = "The first enemy you kill in each new room will now explode and poison all nearby enemies, causing them to take periodic damage until they also die and explode If you have lots of enemies near each other this can cause a chain reaction, killing lots of enemies in one go"
IsaacItem.Type = {"Passive"}
TFABOI.Items[466] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Finger!"
IsaacItem.ID = "467"
IsaacItem.Pickup = "Watch where you point that!"
IsaacItem.Desc = "Gives Isaac a finger which floats infront of him and points in the same direction he is facing or firing. The finger deals 10% of your normal damage to all enemies in the same direction that the finger is pointing. The finger will also deal damage to entities such as fires and poops Applies on-hit status effects such as the burning debuff from Fire Mind Spawns guppy flies if you have the Guppy transformation"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[467] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Shade"
IsaacItem.ID = "468"
IsaacItem.Pickup = "It follows"
IsaacItem.Desc = "Isaac gains a shadow familiar that will follow Isaac's movement pattern delayed by 1 second and deal contact damage to enemies"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[468] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Depression"
IsaacItem.ID = "469"
IsaacItem.Pickup = ":("
IsaacItem.Desc = "Isaac gains a cloud familiar that follows him and leaves a trail of tears on the floor which damages enemies for 2 damage per tick Enemies touching the cloud have a chance to activate the Crack the Sky effect, which spawns a light beam that deals damage equal to your tear damage + 20"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[469] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Hushy"
IsaacItem.ID = "470"
IsaacItem.Pickup = "Lil hush!"
IsaacItem.Desc = "Gives Isaac a small Hush familiar that bounces around the room dealing 2 contact damage per tick While firing tears Hushy will stop moving, which allows you to keep it in one place Hushy will block enemy tears and projectiles"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[470] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil Monstro"
IsaacItem.ID = "471"
IsaacItem.Pickup = "Ain't he cute?"
IsaacItem.Desc = "Gives Isaac a small Monstro familar, who's tears can be charged and released in a shotgun style effect, much like Monstro's main attack Lil Mosntro's tears each deal base damage (3.5) and does not scale with damage upgrades"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[471] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "King Baby"
IsaacItem.ID = "472"
IsaacItem.Pickup = "Lord of the dead!"
IsaacItem.Desc = "A baby familiar that follows you and causes other familiars to follow it. It stops moving while Isaac is firing tears and upon releasing the fire button, King Baby will teleport back to your location. King Baby will always appear first in the queue of familiars"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[472] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Big Chubby"
IsaacItem.ID = "473"
IsaacItem.Pickup = "Chub chub"
IsaacItem.Desc = "A familiar that follows Isaac and charges forwards very slowly, dealing 2.7 damage per tick to any enemies it comes into contact with. Almost identical to the Little Chubby familiar, but this one moves much more slowly and deals less damage"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[473] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Tonsil"
IsaacItem.ID = "474"
IsaacItem.Pickup = "Gross..."
IsaacItem.Desc = "Gives you a Tonsil familiar, which follows Isaac and blocks enemy projectiles Does not deal contact damage to enemies The Tonsil familiar counts as a passive item but does not appear in any item pools, meaning the only ways to find it and make it appear in your Items Collection page are a) hold the Tonsil trinket and trigger the effect, or b) start with it randomly as Eden"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[474] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Plan C"
IsaacItem.ID = "475"
IsaacItem.Pickup = "Use with caution"
IsaacItem.Desc = "Upon use, this item deals 9,999,999 damage to all enemies in the room and then kills you 3 seconds later This is a single use active item, meaning it is destroyed after using it Does not kill both phases of multi-phase bosses like Hush or Ultra Greed If used to kill a boss, the kill still counts as a victory for post-it note completion marks, but the run will still get a game over. Delirium's death animation takes longer than 3 seconds, meaning you will die before it can count as a completion mark. One exception to this is if you are playing as Lazarus or have Lazarus' Rags - you will respawn in the same room and get the kill. "
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "One time use"
TFABOI.Items[475] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D1"
IsaacItem.ID = "476"
IsaacItem.Pickup = "What will it be?"
IsaacItem.Desc = "When used, the D1 duplicates 1 random pickup in the current room, including cards, runes, chests and trinkets If you drop your current card, rune or pill and duplicate it, this item can effectively act similar to the Blank Card and Placebo items Jera runes cannot be duplicated using the D1 Duplicated chests can turn into another kind of chest randomly (e.g. Red chests) Can be used in a shop to duplicate pickups which have not yet been purchased, and take the duplicate pickup for free"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[476] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Void"
IsaacItem.ID = "477"
IsaacItem.Pickup = "Consume"
IsaacItem.Desc = "When used, Void will consume any pedestal items in the current room If an active item is consumed, its effect will be added to Void's effect when used, allowing you to consume multiple items and combine their effects If a passive item is consumed, you gain a small stat upgrade to a random stat Possible stat changes include: +1.0 flat damage, +0.5 tears, +0.2 speed, +0.2 shot speed, +0.5 range, +1.0 luck Void does not work on devil deal or shop items unless they have been bought first Using Void to absorb items in Boss Rush or Challenge Rooms counts as taking the items and will cause the encounter to start Using Void on one time use items such as Mama Mega or Diplopia will cause their effect to instantly trigger and will not give you further uses through activating Void again."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[477] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pause"
IsaacItem.ID = "478"
IsaacItem.Pickup = "Stop!"
IsaacItem.Desc = "Upon use, this item freezes all enemies in the room until you press the fire button again or 30 seconds passes (whichever happens first) Unlike other active items, bosses are not immune to this effect Touching a frozen enemy will still hurt you This item doesn not affect troll bombs - they will still explode"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[478] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Smelter"
IsaacItem.ID = "479"
IsaacItem.Pickup = "Trinket melter!"
IsaacItem.Desc = "Upon use, the Smelter will destroy your currently held trinket and give you the effect permanently, allowing you to stack up lots of different trinket effects If a trinket has been smelted, it won't appear a second time unless the entire trinket pool is exhausted or you restart the run (e.g. by doing a victory lap)"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[479] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Compost"
IsaacItem.ID = "480"
IsaacItem.Pickup = "Gain more friends!"
IsaacItem.Desc = "When used, Compost doubles up the current number of blue flies and spiders you have. Compost will also destroy every consumable on the ground in the current room and turn each of them into a blue fly or blue spider. If you have no pickups on the ground in the current room and no other flies or spiders, Compost will spawn 1 blue fly or blue spider"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[480] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dataminer"
IsaacItem.ID = "481"
IsaacItem.Pickup = "109"
IsaacItem.Desc = "When used, this item will distort all the sprites and music, rotating graphics 90 degrees and translating them diagonally up/left, while leaving the hitbox in the same place. This can make it confusing while navigating the room. Enemy hitboxes remain the same Dataminer will randomly increase or decrease one of your stats by a small amount when used Gives you the Fruit Cake effect for the room when used, which will give a random tear effect with every tear fired All visual and tear effects reset after leaving the room"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[481] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Clicker"
IsaacItem.ID = "482"
IsaacItem.Pickup = "Change"
IsaacItem.Desc = "When used, this item will randomly change you into another character and remove the last item you picked up All stat changes of the new character are applied (e.g. character damage multipliers) This item can only reduce your heart containers and will not increase them if you change back into a character with more health. This means if you roll into The Lost, changing back to another character will leave you with only 1/2 of a soul heart Cannot turn you into a character that isn't unlocked yet Also includes Lazarus II (Lazarus' revived form) and Black Judas (effect of Judas' Shadow) It's also possible that this item will pick the same character, making it seem like nothing happened"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[482] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "MaMa Mega!"
IsaacItem.ID = "483"
IsaacItem.Pickup = "BOOOOOOOOOM!"
IsaacItem.Desc = "A one time use item that when used will explode all objects (i.e. rocks, poop) in the room and deal 200 damage to all enemies in the current room, as well as every other room for the remainder of the floor Also opens the boss rush door after Mom's Foot, blue womb door after Mom's Heart, secret rooms and super secret rooms Like all single-use items, this item cannot be absorbed and used multiple times by the Void item Entering a room with an angel statue will destroy it and automatically spawn one of the Angel mini bosses"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "One time use"
TFABOI.Items[483] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Wait What?"
IsaacItem.ID = "484"
IsaacItem.Pickup = "I can't believe it's not butter bean!"
IsaacItem.Desc = "Upon use, this item will fart, pushing enemies away and causing a wave of rocks to spawn that spread outwards from Isaac in a circle, dealing 10 damage per hit to any enemies caught in it Can be used to open secret rooms Visually this item is very similar to Butter Bean The rock waves can destroy destructible objects, e.g. poop"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "8 seconds"
TFABOI.Items[484] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Crooked Penny"
IsaacItem.ID = "485"
IsaacItem.Pickup = "50/50"
IsaacItem.Desc = "When used, you have a 50% chance to double all items, consumables and chests in the current room If the effect fails, all pickups and items are deleted and Crooked Penny spawns 1 coin If there are no consumables currently on the floor, Crooked Penny spawns 1 coin This item works with items which can be purchased such as shop items, allowing you to spawn a free version if the effect triggers If used in a shop and the effect fails, a Restock box can be used to restore the shop items. This mechanic is very useful on Greed and Greedier modes"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[485] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dull Razor"
IsaacItem.ID = "486"
IsaacItem.Pickup = "I feel numb..."
IsaacItem.Desc = "Upon use this item hurts Isaac without actually taking health away, allowing you to activate any items which trigger when taking damage without losing health"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[486] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Potato Peeler"
IsaacItem.ID = "487"
IsaacItem.Pickup = "A pound of flesh..."
IsaacItem.Desc = "When used, this item permanently removes one of your red heart containers and gives you a flat +0.2 Damage Up, +0.5 Range Up and a Cube of Meat The range increase will only last for the current room, but the Cube of Meat and Damage Up are both permanent Only works for red hearts and has no effect when used if you only have soul/black hearts Has no recharge time and can be used as often as you like It is possible to generate multiple meatboys by stacking more than 4 Cubes of Meat"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "None"
TFABOI.Items[487] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Metronome"
IsaacItem.ID = "488"
IsaacItem.Pickup = "Waggles a finger"
IsaacItem.Desc = "When used, this item gives you the effect of a random item for the rest of the room Using this item multiple times in the same room will replace the previous item's effect with a new one Certain items can be activated with this item which have unexpected effects and many items will do nothing Items do not grant consumable drops which would normally occur when that item is picked up Most flight-granting items have cosmetic effects only, and will not allow you to fly Items that usually give HP up will not give extra health when gained from Metronome"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[488] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "D infinity"
IsaacItem.ID = "489"
IsaacItem.Pickup = "Reroll forever"
IsaacItem.Desc = "When picked up, this item gives you a random Dice active item, which will transform into another random dice upon use Possible dice include: D4, D6, D8, D10, D12, D20, D100 All dice given by this item have a 2 room recharge time"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 rooms"
TFABOI.Items[489] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Eden's Soul"
IsaacItem.ID = "490"
IsaacItem.Pickup = "..."
IsaacItem.Desc = "A one time use active item that when used, will spawn 2 random item pedestals from the item pool associated with the current room (e.g. in an Angel room, this will spawn 2 Angel room items) Starts with 0 charge and requires 12 charges to use"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "12 rooms (one time use)"
TFABOI.Items[490] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Acid Baby"
IsaacItem.ID = "491"
IsaacItem.Pickup = "Pills pills pills!"
IsaacItem.Desc = "Every 2 rooms Acid Baby will drop a random pill Every time you use a pill, Acid Baby will poison all enemies in the room, dealing double your tear damage to each of them"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[491] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "YO LISTEN!"
IsaacItem.ID = "492"
IsaacItem.Pickup = "Yo listen!"
IsaacItem.Desc = "A familiar fairy that will float around the room and highlight the location of any secret room doors, tinted rocks or trapdoors under rocks Upon entering a new room, if there is an undiscovered secret room or tinted rock, it will move directly to the point of interest, otherwise it will just randomly fly around the room +1 Luck Up"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[492] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Adrenaline"
IsaacItem.ID = "493"
IsaacItem.Pickup = "Panic - power"
IsaacItem.Desc = "For every empty red heart container, Isaac gains +0.2 Damage Up and his body increases in size Only works on full hearts - damage does not change if Isaac is missing 1/2 of a heart in one container. Healing empty red heart containers will remove the damage increases Has no effect for The Lost and ???, as they cannot gain red heart containers (except for counting towards the Spun transformation)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[493] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Jacob's Ladder"
IsaacItem.ID = "494"
IsaacItem.Pickup = "Electric tears"
IsaacItem.Desc = "Isaac gains electric tears, which fire 1-2 sparks of electricty in random directions upon hitting any object or enemy The electricty deals half of your normal tear damage Tear effects will still apply to your electricty sparks in a lot of cases (e.g. Spoon Bender will give them a homing effect) Tears which fall naturally to the floor at max range do not generate sparks"
IsaacItem.Type = {"Passive"}
TFABOI.Items[494] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Ghost Pepper"
IsaacItem.ID = "495"
IsaacItem.Pickup = "Flame tears"
IsaacItem.Desc = "Each tear now has a small chance to be a fire instead, which deals 23 damage to enemies that come in contact with it. The fire will remain in place and shrink in size when deals damage to something. After dealing enough damage it will eventually disappear "
IsaacItem.Type = {"Passive"}
TFABOI.Items[495] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Euthanasia"
IsaacItem.ID = "496"
IsaacItem.Pickup = "Needle shot"
IsaacItem.Desc = "Each tear now has a small chance to be a needle instead, which deals 3 times your tear damage. If a needle hits a non-boss enemy it will instantly kill it and will explode into a circle of 10 more needles The 10 spawned needles will also deal 3 times your tear damage, but won't instantly kill enemies or explode into more needles The chance to for each tear to become a needle is affected by your luck stat and at +15 Luck it will activate every time"
IsaacItem.Type = {"Passive"}
TFABOI.Items[496] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Camo Undies"
IsaacItem.ID = "497"
IsaacItem.Pickup = "Camo kid"
IsaacItem.Desc = "Upon entering a new room, Isaac will become camouflaged and enemies won't attack until you start firing tears Bosses are immune to this effect"
IsaacItem.Type = {"Passive"}
TFABOI.Items[497] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Duality"
IsaacItem.ID = "498"
IsaacItem.Pickup = "You feel very balanced"
IsaacItem.Desc = "Any time a devil or angel room door opens after a boss, the other one will also spawn The extra door will only spawn if a devil or angel room was randomly chosen to spawn already After entering one of the doors, the other will disappear If there isn't an available wall for the extra door to spawn on, only one door will spawn (i.e. in a small boss room)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[498] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Eucharist"
IsaacItem.ID = "499"
IsaacItem.Pickup = "Peace be with you"
IsaacItem.Desc = "Gives you a 100% chance to find an Angel Room on every valid floor after defeating the boss Doesn't spawn an angel room on any floor where it is normally not possible to find one (e.g. Basement 1, Cathedral, Sheol etc.) Keeps the chance at 100% even after entering and leaving the angel room, meaning the door will not close after visiting Makes it impossible to find Devil Rooms again, unless you find a way to remove or reroll this item away, or find the Duality item"
IsaacItem.Type = {"Passive"}
TFABOI.Items[499] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sack of Sacks"
IsaacItem.ID = "500"
IsaacItem.Pickup = "Gives Sacks!"
IsaacItem.Desc = "A sack familiar that has a random chance to drop a sack at the end of each room"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[500] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Greed's Gullet"
IsaacItem.ID = "501"
IsaacItem.Pickup = "Money = Health!"
IsaacItem.Desc = "Gives you an extra heart container for every 25 coins you are currently holding, up to a maximum of 4 extra HP at 99 coins held If your coin counter goes below the required amount for a heart container, you will lose it again This item works for the Keeper, allowing him to exceed his usual 2 health containers. However, if Keeper drops to under 2 health coins as a result of Greed's Gullet, he is unable to use a HP Up to increase his health back to 2, and has to regain the lost coins to do so."
IsaacItem.Type = {"Passive"}
TFABOI.Items[501] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Large Zit"
IsaacItem.ID = "502"
IsaacItem.Pickup = "Creep shots"
IsaacItem.Desc = "Gives you a random chance while firing tears to also fire a creep shot, which deals double your tear damage and places white creep on the floor infront of you that slows enemies down if they walk through it Unlike some similar tear effects, your luck stat does not alter the chance for this effect to activate"
IsaacItem.Type = {"Passive"}
TFABOI.Items[502] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Little Horn"
IsaacItem.ID = "503"
IsaacItem.Pickup = "Science!"
IsaacItem.Desc = "While firing tears you have a chance to fire a piercing void tear, that will instantly kill any non-boss enemy it comes into contact with Isaac also grows a horn on his head, which causes you to deal contact damage to enemies by running into them (this effect deals base damage of 3.5)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[503] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Brown Nugget"
IsaacItem.ID = "504"
IsaacItem.Pickup = "Friendly Fly"
IsaacItem.Desc = "When used, will spawn a fly turret that doesn't move and fires tears at nearby enemies Only persists for the current room The fly's bullets deal 2 damage each and do not scale with your own damage stat"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "7 seconds"
TFABOI.Items[504] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Poke Go"
IsaacItem.ID = "505"
IsaacItem.Pickup = "Gotta catch em..."
IsaacItem.Desc = "At the start of each new hostile room, you have a chance to gain a random charmed familiar which will fight for you The charmed enemy has its own health bar and will die if it takes enough damage Charmed enemies persist between each room and floor for as long as they stay alive Allows you to have more than one charmed familiar at a time if you can keep them alive"
IsaacItem.Type = {"Passive"}
TFABOI.Items[505] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "BackStabber"
IsaacItem.ID = "506"
IsaacItem.Pickup = "Watch your back!"
IsaacItem.Desc = "Every time one of your tears hits an enemy, it has a chance to start bleeding, which will cause it to take damage equal to 10% of its maximum health every 5 seconds. Damaging enemies from behind gives the bleed effect a 100% chance to apply The tear that inflicts the bleed effect also deals double damage The bleed effect cannot be applied to immune enemies (e.g. bosses and mini bosses)"
IsaacItem.Type = {"Passive"}
TFABOI.Items[506] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sharp Straw"
IsaacItem.ID = "507"
IsaacItem.Pickup = "More blood!"
IsaacItem.Desc = "When used, Sharp Straw will deal damage to all enemies in the room The damage dealt is equal to Isaac's current tear damage plus 10% of the enemy's max health Every time this item deals damage to an enemy, it has a chance to drop 1/2 red hearts or 1/2 soul hearts."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "8 seconds"
TFABOI.Items[507] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Razor"
IsaacItem.ID = "508"
IsaacItem.Pickup = "It's sharp!"
IsaacItem.Desc = "A razor blade orbital that deals contact damage and applies the bleeding status effect to enemies, which will cause them to take damage equal to 10% of their total health every 5 seconds The contact damage dealt by Mom's Razor is equal to 20% of your current tear damage (scales with damage upgrades) Does not block enemy shots The bleed effect does not affect bosses Its speed is not affected by the Guardian Angel item"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[508] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bloodshot Eye"
IsaacItem.ID = "509"
IsaacItem.Pickup = "Bloody friend"
IsaacItem.Desc = "An eye orbital that shoots a tear every 2 seconds that deals 3.5 damage and deals 2 contact damage per tick to enemies Tears will fire in the direction it is currently facing and do not target enemies Unlike other orbitals, this item does not block enemy projectiles The damage dealt by this orbital does not scale with damage upgrades Its speed is not affected by the Guardian Angel item"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[509] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Delirious"
IsaacItem.ID = "510"
IsaacItem.Pickup = "Unleash the power!"
IsaacItem.Desc = "When used, spawns a charmed random white delirium version of a boss, that will fight for you and kill other enemies for the rest of the current room Possible bosses spawned include most bosses in the game Some bosses' effects can harm Isaac. For example if the spawned boss leaves creep, it can damage Isaac"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "12 rooms"
TFABOI.Items[510] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Angry Fly"
IsaacItem.ID = "511"
IsaacItem.Pickup = "He's violent"
IsaacItem.Desc = "A familiar fly that orbits around a random enemy in the room until that enemy dies, dealing 2 contact damage to other enemies Angry Fly will move to the next enemy after the one it is currently orbiting dies, until the room is cleared, at which point it will return to orbiting Isaac Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Custom Phase"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[511] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Black Hole"
IsaacItem.ID = "512"
IsaacItem.Pickup = "Nothing can escape"
IsaacItem.Desc = "A throwable active item that places a black hole on the ground where it lands, sucking all enemies into it for 6 seconds Enemies stuck inside the black hole take rapid damage over time The Black Hole will also suck Isaac into it, but with a much weaker effect than to enemies The Black Hole will destroy nearby obstacles such as rocks and pots Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Custom Phase"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[512] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Bozo"
IsaacItem.ID = "513"
IsaacItem.Pickup = "Party time!"
IsaacItem.Desc = "+0.1 Damage Up +1 Soul Heart Adds a random chance for an enemy in the current room to become charmed or feared briefly Adds a random chance to spawn a rainbow poop upon taking damage Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Electoon"
IsaacItem.Type = {"Passive"}
TFABOI.Items[513] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Broken Modem"
IsaacItem.ID = "514"
IsaacItem.Pickup = "LAG!"
IsaacItem.Desc = "Causes random enemies to 'lag' at random intervals, causing them to freeze in place for a second The lag effect can also apply to tears, projectiles and consumables on the ground Isaac's Luck stat affects how often the lag effect occurs Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Freezenification"
IsaacItem.Type = {"Passive"}
TFABOI.Items[514] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mystery Gift"
IsaacItem.ID = "515"
IsaacItem.Pickup = "Wrapped up nice for you!"
IsaacItem.Desc = "A one-time use item that spawns a random item from the current room's item pool, with a chance for it to spawn Lump of Coal or The Poop instead Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Mills"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "One time use"
TFABOI.Items[515] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sprinkler"
IsaacItem.ID = "516"
IsaacItem.Pickup = "Sprinkles."
IsaacItem.Desc = "When used, spawns a Sprinkler that rotates in a circle, spraying tears in all directions. Will also synergize with some other items, such as Mom's Eye, Brimstone, Dr. Fetus, Tech X or Loki's Horns Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Kieran and Stewartisme"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[516] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Fast Bombs"
IsaacItem.ID = "517"
IsaacItem.Pickup = "Faster Bomb Drops!"
IsaacItem.Desc = "+7 Bombs Allows you to rapidly place bombs on the ground Added as part of the Afterbirth+ Booster Pack #1"
IsaacItem.Type = {"Passive"}
TFABOI.Items[517] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Buddy in a Box"
IsaacItem.ID = "518"
IsaacItem.Pickup = "What could it be?!"
IsaacItem.Desc = "When picked up, gives Isaac a random familiar which has a random sprite and tear effect The familiar will be fully randomized again upon entering the next floor The appearance is chosen from a random co-op baby sprite Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Ashkait and Scayze"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[518] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil Delirium"
IsaacItem.ID = "519"
IsaacItem.Pickup = "He's Delirious"
IsaacItem.Desc = "A familiar that will transform into another random familiar every 10 seconds, copying their behaviour and effect Can be any other familiar, including (but not limited to) Lil' Brimstone, Bob's Brain, BBF, Meatboy, Rotten Baby Familiars appear as a white Delirium version of the original Added as part of the Afterbirth+ Booster Pack #1 and based on the Steam Workshop mod created by Ashkait and Scayze"
IsaacItem.Type = {"Passive", "Familiar"}
TFABOI.Items[519] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Jumper Cables"
IsaacItem.ID = "520"
IsaacItem.Pickup = "Bloody recharge!"
IsaacItem.Desc = "This item gives you 1 bar of charge on your active item for every 15 enemies you kill Added as part of the Afterbirth+ Booster Pack #2 and based on the Steam Workshop mod created by Ashkait and Scayze"
IsaacItem.Type = {"Passive"}
TFABOI.Items[520] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Coupon"
IsaacItem.ID = "521"
IsaacItem.Pickup = "Allow 6 weeks for delivery"
IsaacItem.Desc = "When used, the coupon causes one random item in the shop to become free While held, guarantees a random item or pickup from the shop to be half price The effect of this item also works in Devil Rooms, allowing you to take one random item for free Added as part of the Afterbirth+ Booster Pack #2 and based on the Steam Workshop mod created by Plumbo"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "6 rooms"
TFABOI.Items[521] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Telekinesis"
IsaacItem.ID = "522"
IsaacItem.Pickup = "The power of mind!"
IsaacItem.Desc = "An active that causes all enemy tears to be held in place and then thrown back away from Isaac for a period of 3 seconds Has a recharge time of about 2 seconds Added as part of the Afterbirth+ Booster Pack #2"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "2 seconds"
TFABOI.Items[522] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Moving Box"
IsaacItem.ID = "523"
IsaacItem.Pickup = "Pack and unpack"
IsaacItem.Desc = "When used, the box will pick up a maximum of 6 items. Using the box again will put the picked up items back on the floor again, allowing you to move things between rooms Can move any of the following: Batteries, Items, Trinkets, Hearts, Keys, Bombs, Coins, Chests and more Using Moving Box with Car Battery will trigger 2 interactions at the same time: First it will drop all items currently inside the box and secondly will then pick up the current room's contents. When used in a room with 2 items you can choose from (e.g. There's Options, Double item room, Boss Rush) the Moving Box will pick only one of the items at random Added as part of the Afterbirth+ Booster Pack #2 and based on the Steam Workshop mod created by HurleyFarrill"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[523] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Technology Zero"
IsaacItem.ID = "524"
IsaacItem.Pickup = "Static tears!"
IsaacItem.Desc = "Your tears will now be connected together by beams of electricity which deals damage to enemies they hit Added as part of the Afterbirth+ Booster Pack #2 and based on the Steam Workshop mod created by Ashkait and Scayze"
IsaacItem.Type = {"Passive"}
TFABOI.Items[524] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Leprosy"
IsaacItem.ID = "525"
IsaacItem.Pickup = "You're tearing me apart!"
IsaacItem.Desc = "Taking damage will spawn an orbital that rotates around Isaac, dealing contact damage to enemies and blocking enemy projectiles A maximum of 3 Leprocy orbitals can be active at one time Using the orbital to deal damage to enemies can cause it to break Added as part of the Afterbirth+ Booster Pack #2. Based loosely on the Steam Workshop mod created by Extreme Ninja Home Makeover with changes by Edmund McMillen"
IsaacItem.Type = {"Passive"}
TFABOI.Items[525] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "7 Seals"
IsaacItem.ID = "526"
IsaacItem.Pickup = "Lil Harbingers!"
IsaacItem.Desc = "Gives you a random Harbinger familiar that changes every 10 seconds. Each harbinger behaves differently, based on any of the original 5 horsemen bosses Added as part of the Afterbirth+ Booster Pack #3. Based on the Steam Workshop mod created by by Scayze and Ashkait"
IsaacItem.Type = {"Passive"}
TFABOI.Items[526] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mr. ME!"
IsaacItem.ID = "527"
IsaacItem.Pickup = "Caaan Do!"
IsaacItem.Desc = "Upon use, this item summons a ghost near Isaac that will follow him around. Also summons a blue crosshair which can be moved around freely. After a few seconds, the crosshair will disappear, and the Ghost will do certain things based on what you targeted: Items, pickups, trinkets: Brings them to Isaac. Works in shops and devil deals as well, allowing you to take them for no cost. Stealing an item has a chance to fail (a buzzer sound will play if it fails) Buttons: Presses the button Enemies: Attacks the enemy until either the ghost or the enemy dies Doors: Opens the door, even if it is locked Secret room entrances: Explodes and opens the entrance Slot machines, dead shopkeepers: Charges towards them and explodes them Added as part of the Afterbirth+ Booster Pack #3. Based on the Steam Workshop mod created by Jean-Alphonse"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[527] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Angelic Prism"
IsaacItem.ID = "528"
IsaacItem.Pickup = "Eclipsed by the moon"
IsaacItem.Desc = "Grants a prism orbital with a large orbital radius Isaac's tears that pass through the prism split into four multi-colored tears Does not deal contact damage to enemies that it passes over Added as part of the Afterbirth+ Booster Pack #3. Based on the Steam Workshop mod created by electoon and Erfly"
IsaacItem.Type = {"Passive", "Orbital"}
TFABOI.Items[528] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pop!"
IsaacItem.ID = "529"
IsaacItem.Pickup = "Eyeball tears!"
IsaacItem.Desc = "Replaces Isaac's tears with eyeballs that can bounce off of each other Issac's tears are no longer limited by range, and will instead dissipate when they stop moving or when hitting an enemy or obstacle Added as part of the Afterbirth+ Booster Pack #3. Based on the Steam Workshop mod created by Scayze and Ashkait"
IsaacItem.Tear = {["Eyeball"] = true}
IsaacItem.Color = { [45] = {255,255,255}}
IsaacItem.Type = {"Passive"}
TFABOI.Items[529] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Death's List"
IsaacItem.ID = "530"
IsaacItem.Pickup = "Just hope you're not next"
IsaacItem.Desc = "Upon entering a room, a skull appears over a random enemy's head. Killing the marked enemy will cause the skull to move to a different enemy. If all enemies in the room are cleared in the order they are marked, Isaac gains a random reward from one of the following: Soul heart, Key, Pill, Bomb, Nickel, +0.2 Speed, +0.5 Range, +0.5 Tears, +1 Flat damage or +1 luck Killing enemies in the wrong order will end the streak and deny you any extra rewards. Added as part of the Afterbirth+ Booster Pack #4. Based on the Steam Workshop mod created by Merlo."
IsaacItem.Type = {"Passive"}
TFABOI.Items[530] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Haemolacria"
IsaacItem.ID = "531"
IsaacItem.Pickup = "I'm seeing red..."
IsaacItem.Desc = "With Haemolacria, Isaac's tears become bloody and now fire by in the air in an arc. Upon hitting the floor, an obstacle or enemy, the bloody tear will burst and fire lots of smaller tears at random directions around the impact point Tears Down (-25 Tear Delay) Your damage stat is unaffected by this item, however the large bloody tear does +31% of your tear damage and the smaller scattering tears deal 50-80% of your tear damage. Added as part of the Afterbirth+ Booster Pack #4. Based on the Steam Workshop mod (originally called Water Balloon) created by HiHowAreYou."
IsaacItem.Type = {"Passive"}
TFABOI.Items[531] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lachryphagy"
IsaacItem.ID = "532"
IsaacItem.Pickup = "Feed them!"
IsaacItem.Desc = "Isaac's tears slow down over time while moving across the room, and upon stopping completely or hitting an object will burst into 8 smaller tears which fire in all directions. This item will also allow you to 'feed' a tear with other tears. Doing so will cause it to increase in size, and also increase their damage and the damage of the burst tears. Once a tear is fed 5 times, it will immediately burst Tears in the burst will deal half the damage the main tear would have. Tears which hit an enemy do not burst Added as part of the Afterbirth+ Booster Pack #4. Based on the Steam Workshop mod (originally called Hungry Tears) created by Echo"
IsaacItem.Type = {"Passive"}
TFABOI.Items[532] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Trisagion"
IsaacItem.ID = "533"
IsaacItem.Pickup = "Smite thy enemy"
IsaacItem.Desc = "Isaac's tears are replaced with piercing holy flashes of light, which travel across the room in a similar speed to regular tears. Trisagion tears deal roughly 33% of your usual tear damage, however due to the size of the holy flash it is likely to hit enemies multiple times Trisagion tears cause no knockback on enemies and simply travel through them (piercing tears) Added as part of the Afterbirth+ Booster Pack #4. Based on the Steam Workshop mod (originally called Lightshot) created by Wyvern and TRPG"
IsaacItem.Type = {"Passive"}
TFABOI.Items[533] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Schoolbag"
IsaacItem.ID = "534"
IsaacItem.Pickup = "Extra active item room"
IsaacItem.Desc = "Gives you an extra active item slot Pressing the CTRL key allows you to switch active items Functions exactly the same as the Antibirth item with the same name Added as part of the Afterbirth+ Booster Pack #4."
IsaacItem.Type = {"Passive"}
TFABOI.Items[534] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Blanket"
IsaacItem.ID = "535"
IsaacItem.Pickup = "You feel safe"
IsaacItem.Desc = "+1 Soul Heart Heals 1 red heart when picked up Grants you a shield when entering the Boss Room, which prevents damage from 1 hit, then disappears Added as part of the Afterbirth+ Booster Pack #5. Based on the Steam Workshop mod created by Ratlah"
IsaacItem.Type = {"Passive"}
TFABOI.Items[535] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Sacrificial Altar"
IsaacItem.ID = "536"
IsaacItem.Pickup = "He demands a sacrifice"
IsaacItem.Desc = "When used, this item will sacrifice up to 2 of your familiars (chosen at random), and spawn a random Devil Room item for each familar sacrificed this way In addition to the familiars, any blue flies or spiders will be converted to 1 coin each. If Guardian Angel, Sworn Protector, or Seraphim is sacrificed, Satan will be extra happy and reward you with 2 black hearts. Incubus won't be sacrificed if you're playing as Lilith If used while you have no familiar, this item will do nothing and won't consume the item Added as part of the Afterbirth+ Booster Pack #5. Based on the Steam Workshop mod created by Niro"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "Single use"
TFABOI.Items[536] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Lil Spewer"
IsaacItem.ID = "537"
IsaacItem.Pickup = "Puking buddy"
IsaacItem.Desc = "A familiar with a charged attack, that spawns a line of creep on the floor which damages enemies that walk over it Spawns 1 random pill when picked up The familiar and its creep will change randomly when Isaac uses a pill. Possible creep types include green (deals damage), black (slows enemies), red (deals damage, forms a line with a larger puddle), yellow (deals damage, forms a short-range cone) and white (slows enemies, forms a ring) Added as part of the Afterbirth+ Booster Pack #5. Based on the Steam Workshop mod created by Strawrat and Aczom"
IsaacItem.Type = {"Passive"}
TFABOI.Items[537] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Marbles"
IsaacItem.ID = "538"
IsaacItem.Pickup = "Choking hazard"
IsaacItem.Desc = "Spawns 3 random trinkets when picked up Upon taking damage, you have a random chance to consume one of your currently held trinkets, gaining its effect permanently Added as part of the Afterbirth+ Booster Pack #5. Based on the Steam Workshop mod created by Amethyst"
IsaacItem.Type = {"Passive"}
TFABOI.Items[538] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mystery Egg"
IsaacItem.ID = "539"
IsaacItem.Pickup = "Sacrificial insemination"
IsaacItem.Desc = "A familiar which follows Isaac and, upon taking damage, will spawn a charmed enemy that will fight for you When the charmed enemy is spawned the egg will crack, but regenerate in the next room Added as part of the Afterbirth+ Booster Pack #5. Based on the Steam Workshop mod created by Strawrat and Aczom"
IsaacItem.Type = {"Passive"}
TFABOI.Items[539] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Flat Stone"
IsaacItem.ID = "540"
IsaacItem.Pickup = "Skipping tears"
IsaacItem.Desc = "Flat Stone causes your tears to bounce across the room Whenever a tear bounces, it deals splash damage to nearby enemies for 25% of your tear damage Added as part of the Afterbirth+ Booster Pack #5. Based on the Steam Workshop mod created by Maddogs"
IsaacItem.Type = {"Passive"}
TFABOI.Items[540] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Marrow"
IsaacItem.ID = "541"
IsaacItem.Pickup = "HP up?"
IsaacItem.Desc = "+1 Bone Heart Spawns 3 red hearts on the ground when picked up Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[541] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Slipped Rib"
IsaacItem.ID = "542"
IsaacItem.Pickup = "Projectile shield"
IsaacItem.Desc = "This item gives you an orbital, which will reflect projectiles back at enemies Unlike some other orbitals, Slipped Rib doesn't deal contact damage to enemies Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[542] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Hallowed Ground"
IsaacItem.ID = "543"
IsaacItem.Pickup = "Portable sanctuary"
IsaacItem.Desc = "A familiar which follows Isaac and spawns a white poop when you take damage The white poop gives an aura that cuts your tear delay in half (Tears up) and has a chance to block damage The aura disappears if the poop is destroyed Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[543] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Pointy Rib"
IsaacItem.ID = "544"
IsaacItem.Pickup = "Stabbing time"
IsaacItem.Desc = "A familiar that can be aimed with the fire buttons similar to the Finger item, dealing contact damage to enemies equal to your tear damage Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[544] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Book of the Dead"
IsaacItem.ID = "545"
IsaacItem.Pickup = "Rise from the grave"
IsaacItem.Desc = "When used, this item will spawn a bone orbital or charmed Bony for each enemy killed in the current room. The orbitals and charmed enemies persist when travelling between rooms. Bone orbitals break after dealing enough damage or blocking too many shots. Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[545] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Dad's Ring"
IsaacItem.ID = "546"
IsaacItem.Pickup = "Father's blessing"
IsaacItem.Desc = "A passive item that puts a yellow ring around Isaac. Enemies are frozen in place while touching the yellow ring Enemies touching the ring will stay permanently frozen until you move away, except for bosses which only get a temporary freeze effect after touching it Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[546] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Divorce Papers"
IsaacItem.ID = "547"
IsaacItem.Pickup = "Tears up + you feel empty"
IsaacItem.Desc = "+1 Bone Heart +0.7 Tears Up When you pick this item up, the Mysterious Paper trinket is spawned on the ground Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[547] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Jaw Bone"
IsaacItem.ID = "548"
IsaacItem.Pickup = "Fetch"
IsaacItem.Desc = "A familiar that flies across the room every few seconds while firing and damages enemies (2x your tear damage) Can also be used like the Boomerang to pick up consumables on the ground Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[548] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Brittle Bones"
IsaacItem.ID = "549"
IsaacItem.Pickup = "Everything hurts"
IsaacItem.Desc = "When picked up, this item replaces all of your red heart containers with 6 Bone Hearts Every time you lose a bone heart, lots of bones fire in all directions damaging any enemies hit and you gain a permenent +0.5 Tears Up For the Lost and Keeper characters, this item simply gives a permanent Tears Up. Added as part of the Afterbirth+ Booster Pack #5."
IsaacItem.Type = {"Passive"}
TFABOI.Items[549] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Broken Shovel"
IsaacItem.ID = "550"
IsaacItem.Pickup = "It feels cursed"
IsaacItem.Desc = "Obtained by beating the Basement 1 boss within 1 minute, then bombing the large shadow that appears in the middle of the starting room While held, Mom's Foot will stomp on you from above twice every few seconds, and she will continue to stomp for as long as you hold this item. Using the Broken Shovel will stop Mom stomping you for the rest of the current room (or current wave if you're in the boss rush or challenge room). Beating the Boss Rush while holding this item will drop the second half of the Broken Shovel, which combine to create Mom's Shovel, which is used to unlock The Forgotten character Dropping the Broken Shovel will cause it to disappear if you leave the room NOTE: This item will not drop unless you have beaten The Lamb at least once Added as part of the Afterbirth+ Booster Pack #5 and used in the quest to unlock The Forgotten character"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[550] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Broken Shovel"
IsaacItem.ID = "551"
IsaacItem.Pickup = "Lost but not forgotten"
IsaacItem.Desc = "Drops after beating the Boss Rush while holding the other half of the Broken Shovel (see previous item for more details) Combines with the first Broken Shovel piece to create Mom's Shovel (see next item for more details) Added as part of the Afterbirth+ Booster Pack #5 and used in the quest to unlock The Forgotten character"
IsaacItem.Type = {"Passive"}
TFABOI.Items[551] = IsaacItem

IsaacItem = {}
IsaacItem.Name = "Mom's Shovel"
IsaacItem.ID = "552"
IsaacItem.Pickup = "Lost but not forgotten"
IsaacItem.Desc = "When used, spawns a trapdoor that leads to the next floor (has a 10% chance to be a crawl space instead) Unlocks The Forgotten character when used on a mound of dirt that appears in a room in The Dark Room floor Obtained by combining the two Broken Shovel pieces. The first piece drops by beating the first floor boss within 1 minute then bombing the shadow in the first room. The second piece drops after beating the Boss Rush as long as you are holding the first Broken Shovel piece (see previous 2 items for full details). After The Forgotten is unlocked, using it on the mound of dirt again just spawns a random type of chest Added as part of the Afterbirth+ Booster Pack #5 and used in the quest to unlock The Forgotten character"
IsaacItem.Type = {"Active"}
IsaacItem.Recharge = "4 rooms"
TFABOI.Items[552] = IsaacItem

IsaacItem = {}

local number = 0
for k,v in pairs(TFABOI.Items) do
	TFABOI.Items[k].Num = number
	number = number + 1
end

local number2 = 0
for k,v in pairs(TFABOI.Items) do
	if TFABOI.Items[k].Stats or TFABOI.Items[k].Tear or TFABOI.Items[k].Ent or TFABOI.Items[k].Player then
		TFABOI.Items2[k] = v
		TFABOI.Items2[k].Num2 = number2
		number2 = number2 + 1
	end
end