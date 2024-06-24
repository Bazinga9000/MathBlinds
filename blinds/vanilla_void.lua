local blind = {
	loc_txt =  	{
        name = 'Vanilla Void',
        text = { 'Cards give 0 chips',  'when scored' }
    },
    dollars = 8,
    --boss = {min = 1, max = 10 }, -- for testing purposes
    boss = {showdown = true, min = 10, max = 10 },
    boss_colour = HEX("fff8e7"),
    atlas = "mathblinds",
    pos = { x = 0, y = 8}
}

blind.set_blind = function(self, reset, silent)
    for _, card in ipairs(G.playing_cards) do 
        card.backup_get_chip_bonus = card.get_chip_bonus
        card.get_chip_bonus = function() blind:wiggle(); return 0 end
    end
end

blind.disable = function(self)
    for _, card in ipairs(G.playing_cards) do 
        if card.backup_get_chip_bonus then
            card.get_chip_bonus = card.backup_get_chip_bonus
            card.backup_get_chip_bonus = nil
        end
    end
end

blind.press_play = function(self)
    G.GAME.blind.triggered = true
end

blind.defeat = blind.disable

return blind