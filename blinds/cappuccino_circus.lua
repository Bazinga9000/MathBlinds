local blind = {
	loc_txt =  	{
        name = 'Cappuccino Circus',
        text = { 'Leftmost and rightmost jokers',  'are disabled each hand' }
    },
    dollars = 8,
    --boss = {min = 1, max = 10 }, -- for testing purposes
    boss = {showdown = true, min = 10, max = 10 },
    boss_colour = HEX("9b7960"),
    atlas = "mathblinds",
    pos = { x = 0, y = 15}
}

blind.press_play = function(self, blind)
    blind.prepped = true
end

blind.drawn_to_hand = function(self, blind)
    if G.jokers then
        if G.jokers.cards[1] and not G.jokers.cards[1].debuff and blind.prepped then
            for _, card in ipairs(G.jokers.cards) do
                card:set_debuff(false)
            end
            G.jokers.cards[1]:set_debuff(true)
            G.jokers.cards[1]:juice_up()
            blind:wiggle()
            local last = #G.jokers.cards
            if last > 1 and G.jokers.cards[last] and not G.jokers.cards[last].debuff and blind.prepped then
                G.jokers.cards[last]:set_debuff(true)
                G.jokers.cards[last]:juice_up()
                blind:wiggle()
            end
        end
        blind.prepped = false
    end 
end

return blind