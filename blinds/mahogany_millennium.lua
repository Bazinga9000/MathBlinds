local blind = {
	loc_txt =  	{
        name = 'Mahogany Millennium',
        text = { 'Non-base edition',  'jokers are disabled' }
    },
    dollars = 8,
    --boss = {min = 1, max = 10 }, -- for testing purposes
    boss = {showdown = true, min = 10, max = 10 },
    boss_colour = HEX("9d3c27"),
    atlas = "mathblinds",
    pos = { x = 0, y = 5}
}

blind.debuff_card = function(self, blind, card, from_blind)
    if card.area == G.jokers then
        if card.edition then
            card:juice_up()
            blind:wiggle()
            return true
        else
            return false
        end
    end
end

return blind