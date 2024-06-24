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

blind.press_play = function(self)
    G.GAME.blind.cards_in_deck = #G.deck.cards
    G.GAME.blind.just_played = true
end

blind.drawn_to_hand = function(self)
    if G.GAME.blind.cards_in_deck then
        local delta_cards = #G.deck.cards - G.GAME.blind.cards_in_deck
        if (delta_cards < 0 and not G.GAME.blind.just_played) then
            ease_dollars(delta_cards)  
            G.GAME.blind:wiggle()
        end
    end
    G.GAME.blind.just_played = nil
    G.GAME.blind.cards_in_deck = #G.deck.cards
end

return blind