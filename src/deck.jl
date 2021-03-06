import Base: +, -
import Random: shuffle!

struct Deck
    cards::Array{Card, 1}
    function Deck()::Deck
        cards = Card[]
        for rank in 1:13
            for suit in 1:4
                push!(cards, Card(rank, suit))
            end
        end
        return new(cards);
    end
end

@inline Base.length(deck::Deck)::Int = length(deck.cards);
@inline Base.firstindex(deck::Deck)::Int = 1;
@inline Base.lastindex(deck::Deck)::Int = length(deck);
@inline Base.getindex(deck::Deck, i::Int64)::Card = deck.cards[i];
@inline Base.getindex(deck::Deck, I::UnitRange{Int64})::Array{Card, 1} = [deck[i] for i in I];
@inline Base.getindex(deck::Deck, I::Array{Int64, 1})::Array{Card, 1} = [deck[i] for i in I];
@inline Base.iterate(deck::Deck, i::Int64 = 1) = (i > length(deck)) ? nothing : (deck[i], i + 1);

function Base.show(io::IO, deck::Deck)::Nothing
    for card in deck
        print(io, card, " ")
    end
    return nothing;
end

@inline +(deck::Deck, card::Card) = push!(deck.cards, card);
@inline +(deck::Deck, cards::Array{Card, 1}) = append!(deck.cards, cards);
@inline -(deck::Deck, card::Card) = try deleteat!(deck.cards, findall(x -> x === card, deck.cards)) catch end;
function -(deck::Deck, cards::Array{Card, 1})
    for card in cards
        deck - card
    end
    return deck;
end

function shuffle(deck::Deck)::Deck
    shuffle!(deck.cards)
    return deck;
end

@inline deal(deck::Deck)::Card = popfirst!(deck.cards);
function deal(deck::Deck, n::Int64)::Array{Card, 1}
    @assert(1 ≤ n ≤ length(deck.cards), "Invalid number of cards!")
    cards = Card[]
    for _ in 1:n
        push!(cards, deal(deck))
    end
    return cards;
end
