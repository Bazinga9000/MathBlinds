local HAND_DELTA = 5
local blind = {
	loc_txt =  	{
        name = 'Emerald Embedding',
        text = { '+5 hand size,',  'absurdly large blind' }
    },
    mult = 10,
    dollars = 8,
    --boss = {min = 1, max = 10 }, -- for testing purposes
    boss = {showdown = true, min = 10, max = 10 },
    boss_colour = HEX("6dc45e"),
    atlas = "mathblinds",
    pos = { x = 0, y = 9}
}

blind.set_blind = function(self, reset, silent)
    if not G.GAME.blind.disabled then
        G.hand:change_size(HAND_DELTA)
    end
end

blind.disable = function(self, silent)
    G.hand:change_size(-HAND_DELTA)
    G.GAME.blind.chips = blind.chips/5
    G.GAME.blind.chip_text = number_format(blind.chips)
end

blind.defeat = function(self, silent)
    if not G.GAME.blind.disabled then
        G.hand:change_size(-HAND_DELTA)
    end
end



return blind