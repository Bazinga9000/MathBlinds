local blind = {
	loc_txt =  	{
        name = 'The Tip',
        text = { 'Discarding a card', 'costs $1' }
    },
    boss = { min = 2, max = 10 },
    boss_colour = HEX("d18530"),
    atlas = "mathblinds",
    pos = { x = 0, y = 6}
}

blind.press_play = function(self, blind)
    blind.cards_in_deck = #G.deck.cards
    blind.just_played = true
end

blind.drawn_to_hand = function(self, blind)
    if blind.cards_in_deck then
        local delta_cards = #G.deck.cards - blind.cards_in_deck
        if (delta_cards < 0 and not blind.just_played) then
            ease_dollars(delta_cards)  
            blind:wiggle()
        end
    end
    blind.just_played = nil
    blind.cards_in_deck = #G.deck.cards
end

return blind