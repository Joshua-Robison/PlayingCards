module PlayingCards

export Suit,   ♣,       ♢,      ♡,      ♠
export       Clubs, Diamonds, Hearts, Spades
export       clubs, diamonds, hearts, spades

export Rank, ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
export       Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King

export Card, name
export Deck, Hand, shuffle, deal

include("card.jl")
include("deck.jl")
include("hand.jl")

end # module
