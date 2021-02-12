local function checkForTFA()
	if TFA and TFA_BASE_VERSION and TFA_BASE_VERSION >= 4 then return end -- we're 100% good

	if CLIENT then
		Derma_Query(
			"The weapon(s) you have installed requires a really 'optimized' base. Use the button below to install it.",
			"Install the TFA Base",
			"Workshop",
			function() gui.OpenURL("http://steamcommunity.com/workshop/filedetails/?id=415143062") end
		)
	else
		print("########################### Warning ###############################")
		print("The weapon(s) you have installed requires a really 'optimized' base")
		print("http://steamcommunity.com/workshop/filedetails/?id=415143062")
		print("########################### Warning ###############################")
	end
end

hook.Add("InitPostEntity", "INSTALL TFA BASE", checkForTFA)