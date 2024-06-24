local blind = {
	loc_txt =  	{
        name = 'The Norm',
        text = { 'Ranks in played hands', 'can\'t exceed 21' }
    },
    boss = { min = 2, max = 10 },
    boss_colour = HEX("43a595"),
    atlas = "mathblinds",
    pos = { x = 0, y = 0}
}

blind.debuff_hand = function(self, cards, hand, handname, check)
    self.triggered = false
    local total = 0
    for _, v in ipairs(cards) do
        total = total + ((v.ability.effect == 'Stone Card' and 0) or v.base.nominal)
    end
    if total > 21 then
        return true
    end
end

return blind