Config = {}

-- ============================================
-- Money
-- ============================================
-- Bets are taken with whip's ChargePlayer and paid with PayPlayer, so every one is on the activity log.
--   method:   'cash', 'bank' or 'auto' (cash if they carry enough, else the bank)
--   currency: an item that counts as money instead of cash, e.g. 'casino_chips' once there's a cashier. nil = cash.
Config.Money = {
    method   = 'cash',
    currency = 'casino_chips',   -- bets are in chips, bought at the cashier. nil: plain cash instead
}

-- The chips: an item this resource registers (its picture is casinochips.png here).
Config.ChipItem = {
    key  = 'casino_chips',
    name = 'Casino Chips',
    desc = 'One chip, one dollar. Cash them in at the casino cashier.',
}

-- ============================================
-- The cashier
-- ============================================
-- Placed with /bjcashier (dev: a ghost of the cashier to put where they stand), kept in cashiers.json.
-- /bjcashierremove takes away the one nearest you.
Config.Cashier = {
    model     = 'u_f_m_casinocash_01',
    label     = 'Casino Cashier',
    buyPrice  = 1.0,       -- dollars for one chip
    sellPrice = 1.0,       -- dollars back for one chip
    payWith   = 'auto',    -- buying chips: 'cash', 'bank' or 'auto' (cash if they carry enough, else the bank)
    payOut    = 'cash',    -- cashing chips in: 'cash' or 'bank'
    min       = 10,        -- chips in one go
    max       = 1000000,
    reach     = 2.5,       -- metres from the cashier to buy or sell
    -- What a cashier does where they're placed: chosen in /bjcashier, with a live preview to set the height (a seat).
    -- scenario: a GTA scenario played at the spot (seat = true for the sitting ones). Neither: just stands.
    poses = {
        { id = 'stand',  label = 'Standing' },
        { id = 'stool',  label = 'Sitting on a stool',    scenario = 'PROP_HUMAN_SEAT_BAR',             seat = true },
        { id = 'chair',  label = 'Sitting on a chair',    scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',   seat = true },
        { id = 'lean',   label = 'Leaning on the counter', scenario = 'PROP_HUMAN_BUM_SHOPPING_CART' },
        { id = 'wait',   label = 'Waiting, hands folded', scenario = 'WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT' },
        { id = 'phone',  label = 'On the phone',          scenario = 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT' },
    },
}

-- ============================================
-- The rules
-- ============================================
Config.Rules = {
    decks             = 6,      -- in the shoe
    penetration       = 0.75,   -- how much of the shoe is dealt before it's shuffled again
    shuffleEveryRound = false,  -- true: a fresh shoe every round (no counting at all)
    hitSoft17         = false,  -- false: the dealer stands on every 17
    blackjackPays     = 1.5,    -- 3:2. A natural only: 21 on two cards, not after a split
    insurance         = true,   -- offered when the dealer shows an ace (costs half the bet, pays 2:1)
    surrender         = true,   -- late surrender: half the bet back, first two cards only, not after a split
    doubleAfterSplit  = true,
    splitAcesOneCard  = true,   -- split aces get one card each, and that's it
    -- One split per player (two hands): the table's own animations have places for two.
}

-- ============================================
-- Timing (seconds unless it says ms)
-- ============================================
Config.Timing = {
    betSeconds       = 15,   -- the betting window, from the first bet
    allInSeconds     = 3,    -- once everyone seated has bet, the window shrinks to this
    turnSeconds      = 20,   -- to decide on a hand; time out and you stand
    insuranceSeconds = 8,
    dealMs           = 2300, -- between cards: the dealer's deal animation plays out before the next
}

-- ============================================
-- Tables
-- ============================================
-- coords is the table's origin (on the floor), heading which way it faces.
-- spawn = true: we place the table. false: it's already in the map (an MLO's own table), and we find it there.
-- model: 'vw_prop_casino_blckjack_01' (normal) or 'vw_prop_casino_blckjack_01b' (high limit).
-- texture: the felt, 0 green, 1 red, 2 blue, 3 purple.
-- min / max: bet limits. step: how much the arrows change your bet (default the min).
-- /bjhere (dev) prints a line for where you stand.
--
-- These are k4mb1-casino's own tables, read out of its map files (stream/casino2/k4mb1_casino2.ytyp, placed by
-- k4mb1_casino2_milo_.ymap; the penthouse's from vw_vwdlc_int_02.ytyp). spawn = false: the map has them, we find
-- them. No texture: the felt stays as the map made it.
Config.Tables = {
    -- The main floor (casino2)
    { label = 'Blackjack',            coords = vec3(1001.859, 61.971, 79.993), heading = 58.0,  model = 'vw_prop_casino_blckjack_01',  spawn = false, min = 100,  max = 5000 },
    { label = 'Blackjack',            coords = vec3(996.231, 52.963, 79.993),  heading = 58.0,  model = 'vw_prop_casino_blckjack_01',  spawn = false, min = 100,  max = 5000 },
    { label = 'Blackjack',            coords = vec3(958.045, 67.729, 80.002),  heading = 58.0,  model = 'vw_prop_casino_blckjack_01',  spawn = false, min = 100,  max = 5000 },
    { label = 'Blackjack',            coords = vec3(947.809, 65.060, 79.989),  heading = 58.0,  model = 'vw_prop_casino_blckjack_01',  spawn = false, min = 100,  max = 5000 },
    { label = 'Blackjack',            coords = vec3(962.055, 32.245, 79.991),  heading = 328.0, model = 'vw_prop_casino_blckjack_01',  spawn = false, min = 100,  max = 5000 },
    { label = 'High Limit Blackjack', coords = vec3(942.256, 43.203, 79.985),  heading = 328.0, model = 'vw_prop_casino_blckjack_01b', spawn = false, min = 2000, max = 50000, step = 1000 },
    { label = 'High Limit Blackjack', coords = vec3(999.104, 57.561, 79.993),  heading = 58.0,  model = 'vw_prop_casino_blckjack_01b', spawn = false, min = 2000, max = 50000, step = 1000 },
    -- The penthouse lounge (its Blackjack entity set, k4mb1_apart_lounge_room_01, is on in k4mb1's client2.lua)
    { label = 'Penthouse Blackjack',  coords = vec3(967.315, 32.215, 115.172), heading = 238.0, model = 'vw_prop_casino_blckjack_01',  spawn = false, min = 1000, max = 25000, step = 500 },
}

-- The dealer's animations number the seats their own way: [our seat] = the animation's seat. Our seats are the
-- table's chairs (Chair_Base_01-04, and "Seat N" in /bjedit); the animations count them from the other end.
-- If the dealer turns to the wrong chair, change this: { 1, 2, 3, 4 } is the same numbering, { 4, 3, 2, 1 } mirrored.
Config.AnimSeats = { 4, 3, 2, 1 }

-- The dealers: each restart, every table gets one of these at random, with its own face and hair (every player
-- sees the same one). female = true uses the female dealer moves where the game has them.
Config.Dealers = {
    { model = 's_m_y_casino_01', voice = 'S_M_Y_CASINO_01_WHITE_01' },
    { model = 's_m_y_casino_01', voice = 'S_M_Y_CASINO_01_WHITE_02' },
    { model = 's_m_y_casino_01', voice = 'S_M_Y_CASINO_01_ASIAN_01' },
    { model = 's_m_y_casino_01', voice = 'S_M_Y_CASINO_01_ASIAN_02' },
    { model = 's_m_y_casino_01', voice = 'S_M_Y_CASINO_01_LATINO_01' },
    { model = 's_f_y_casino_01', voice = 'S_F_Y_CASINO_01_ASIAN_01',  female = true },
    { model = 's_f_y_casino_01', voice = 'S_F_Y_CASINO_01_LATINA_01', female = true },
    { model = 's_f_y_casino_01', voice = 'S_F_Y_CASINO_01_WHITE_01',  female = true },
}

-- ============================================
-- Where things go on the felt
-- ============================================
-- Worked out from the table's own chair bones, so it fits however the table is turned. All in metres, in the
-- table's own frame. If cards or chips land off their printed spots, tune here: /bjlayout (dev) draws every spot.
Config.Layout = {
    centre       = vec2(0.0, 0.0),  -- the middle of the felt, from the table's origin
    surface      = 0.95,            -- the felt's height above the origin
    cardAt       = 0.40,            -- a seat's cards: this far from the middle towards its chair (0 middle, 1 chair)
    chipAt       = 0.52,            -- a seat's chips: the same, on the printed diamond
    cardSpread   = 0.045,           -- each extra card steps sideways this much
    splitGap     = 0.10,            -- a split's two hands sit this far apart, either side
    dealerStand  = 0.82,            -- the dealer stands this far behind the middle
    dealerLift   = 1.0,             -- the dealer's hips above the floor (a ped stands on its hips' height)
    dealerCardAt = 0.15,            -- the dealer's cards: this far from the middle towards the dealer
    chipHeight   = 0.0072,          -- one chip's thickness, for stacking
    seatTurn     = 0.0,             -- degrees: turn a seated player if the chairs face off

    -- Cards and chips land where the animations put them, and each game remembers it (/bjforget clears it).
    -- These numbers above are only used until a spot has been seen once.
    dealerHand   = 28422,           -- the hand the dealer deals with (28422 right, 60309 left)
    playerHand   = 28422,           -- the hand a player puts chips down with
    grabPhase    = 0.12,            -- how far into a deal the card is in the dealer's hand (0-1)
    dropBand     = 0.10,            -- a hand this close above the felt is putting something down
    seatChairs   = nil,             -- { 4, 3, 2, 1 }: which chair each of the dealer's seats is, if you know.
                                    -- nil: learnt from the first card dealt to each seat.
}

-- Chips on the felt for a bet: the biggest that fit, stacked. Value -> model.
Config.Chips = {
    { 10000, 'vw_prop_chip_10kdollar_x1' },
    { 5000,  'vw_prop_chip_5kdollar_x1' },
    { 1000,  'vw_prop_chip_1kdollar_x1' },
    { 500,   'vw_prop_chip_500dollar_x1' },
    { 100,   'vw_prop_chip_100dollar_x1' },
    { 50,    'vw_prop_chip_50dollar_x1' },
    { 10,    'vw_prop_chip_10dollar_x1' },
}

-- ============================================
-- At the table
-- ============================================
-- The camera over your shoulder while seated (C turns it on and off).
Config.Camera = {
    enabled = true,
    back    = 0.55,  -- behind the chair
    up      = 1.45,  -- above the floor
    fov     = 55.0,
}

-- Keys: GTA control ids, keyboard and pad. Shown on screen with whip's key hints.
Config.Keys = {
    up        = { key = 172, pad = 188, text = 'Up',        button = 'dpad_up' },
    down      = { key = 173, pad = 187, text = 'Down',      button = 'dpad_down' },
    min       = { key = 174, pad = 189, text = 'Left',      button = 'dpad_left' },
    max       = { key = 175, pad = 190, text = 'Right',     button = 'dpad_right' },
    accept    = { key = 191, pad = 201, text = 'Enter',     button = 'a' },        -- bet, hit, take insurance
    stand     = { key = 22,  pad = 203, text = 'Space',     button = 'x' },        -- stand, no insurance
    double    = { key = 45,  pad = 204, text = 'R',         button = 'y' },
    split     = { key = 38,  pad = 206, text = 'E',         button = 'rb' },
    surrender = { key = 23,  pad = 189, text = 'F',         button = 'dpad_left' },
    camera    = { key = 26,  pad = 217, text = 'C',         button = 'view' },
    -- 194 is Backspace alone (177 is Backspace, right mouse and Esc all at once).
    leave     = { key = 194, pad = 202, text = 'Backspace', button = 'b' },        -- take your bet back, or get up
}

-- How far away a table and its game are drawn, and news of it sent.
Config.DrawRange = 45.0
Config.SyncRange = 60.0

-- Getting up: more than this far from your chair (a shove, a teleport) and you've left.
Config.LeaveDistance = 3.5
