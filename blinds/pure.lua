local blind = {
	loc_txt =  	{
        name = 'The Pure',
        text = { 'Cards changed from or added to', 'the starting deck are debuffed' }
    },
    boss = { min = 1, max = 10 },
    boss_colour = HEX("5851a0"),
    atlas = "mathblinds",
    pos = { x = 0, y = 11},
}

blind.debuff_card = function(self, blind, card, from_blind)
    if card.the_pure_data then
        local orig = card.the_pure_data
        if card.base.value ~= orig.value then -- check rank
            return true
        elseif card.base.suit ~= orig.suit then -- check suit
            return true
        elseif card.config.center ~= orig.enhancement then -- check enhancement
            return true
        elseif card.edition ~= orig.edition then -- check edition
            return true
        elseif card.seal ~= orig.seal then -- check seal
            return true
        else
            return false
        end
    else
        return true
    end
end

--[[
    hook into the apply to run function so that 
    we make a copy of the card's original data AFTER
    any deck modifications have been applied 
    (e.g erratic randomization), and so that
    cards added to the deck later lack the
    pure_data field which can be checked for
    to debuff cards added to the deck
]]--
orig_back_apply_to_run = Back.apply_to_run
Back.apply_to_run= function(self)
    orig_back_apply_to_run(self)
    G.E_MANAGER:add_event(Event({
        func = function()
            for _, v in pairs(G.playing_cards) do
                local pure_data = {
                    value = v.base.value,
                    suit = v.base.suit,
                    edition = v.edition,
                    enhancement = v.config.center,
                    seal = v.seal
                }
                v.the_pure_data = pure_data
            end
            return true
        end
    })) 
end

return blind