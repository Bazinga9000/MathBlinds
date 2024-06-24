local blind = {
	loc_txt =  	{
        name = 'The Approach',
        text = { 'If chips are 90-100% of the blind',  'after play, increase blind by 25%' }
    },
    boss = {min = 2, max = 10 }, 
    boss_colour = HEX("e5c3ed"),
    atlas = "mathblinds",
    pos = { x = 0, y = 10}
}

blind.set_blind = function(self, reset, silent)
    if not G.GAME.blind.disabled then
        G.GAME.blind.backup_chips = blind.chips
    end
end


blind.press_play = function(self)
    G.GAME.blind.prepped = true
end

local RATIO_THRESHOLD = 0.9
blind.drawn_to_hand = function(self)
    if G.GAME.blind.prepped then
        local ratio = G.GAME.chips / G.GAME.blind.chips
        -- talisman compat
        if type(ratio) == "table" then
            ratio = ratio:to_number()
        end
        if ratio > RATIO_THRESHOLD and ratio < 1.0 then
            local new_chips = math.floor(G.GAME.blind.chips * 1.25)
            G.GAME.blind:wiggle()
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blocking = false,
                ref_table = blind,
                ref_value = 'chips',
                ease_to = new_chips,
                delay =  0.5,
                func = (function(t)     G.GAME.blind.chip_text = number_format(G.GAME.blind.chips); return math.floor(t) end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    return true
                end
            }))
        end
    end
end

blind.disable = function(self, silent)
    G.GAME.blind.chips = G.GAME.blind.backup_chips
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind.backup_chips = nil
end

return blind