--- STEAMODDED HEADER
--- MOD_NAME: Math Blinds
--- MOD_ID: MathBlinds
--- PREFIX: mathbl
--- MOD_AUTHOR: [Bazinga_9000, tauttie]
--- MOD_DESCRIPTION: Adds more blinds based on mathematical symbols
--- VERSION: 1.2.0
----------------------------------------------
------------MOD CODE -------------------------
local blind_list = {
    "bottom",
    "radical",
    "norm",
    "tip",
    "bar",
    "aggregate",
    "floor",
    "drop",
    "approach",
    "pure",
    "infinite",
    "witness",
    "diamond_difference",
    "mahogany_millennium",
    "vanilla_void",
    "cappuccino_circus",
    "emerald_embedding",
    "waiouru_wreath"
}

local mod_path = SMODS.current_mod.path
SMODS.Atlas({ key = "mathblinds", atlas_table = "ANIMATION_ATLAS", path = "mathblinds.png", px = 34, py = 34, frames = 21 })

-- basically taken from Mystblinds, which was basically taken from 5CEBalatro lol
for k, v in ipairs(blind_list) do
    local blind = NFS.load(mod_path .. "blinds/" .. v .. ".lua")()

    -- don't fuck up the mod
    if not blind then
        sendErrorMessage("[MathBlinds] Cannot find blind with shorthand: " .. v)
    else
        blind.key = v
        blind.discovered = false 

        local blind_obj = SMODS.Blind(blind)

        for k_, v_ in pairs(blind) do
            if type(v_) == 'function' then
                blind_obj[k_] = blind[k_]
            end
        end
    end
end

----------------------------------------------
------------MOD CODE END----------------------