# Playing Cards: Playing Hand
import Base: +, -
import Random: shuffle!

struct Hand
    cards::Array{Card, 1}
    function Hand(; cards::Array{Card, 1} = Card[])
        return new(cards);
    end
end

@inline Base.length(hand::Hand) = length(hand.cards);
@inline Base.firstindex(hand::Hand) = 1;
@inline Base.lastindex(hand::Hand) = length(hand);
@inline Base.getindex(hand::Hand, i::Int64) = hand.cards[i];
@inline Base.getindex(hand::Hand, I::UnitRange{Int64}) = [hand[i] for i in I];
@inline Base.getindex(hand::Hand, I::Array{Int64, 1}) = [hand[i] for i in I];
@inline Base.iterate(hand::Hand, i::Int64 = 1) = (i > length(hand)) ? nothing : (hand[i], i + 1);

function Base.show(io::IO, hand::Hand)
    for card in hand
        print(io, card, " ")
    end
    return nothing;
end

@inline +(hand::Hand, card::Card) = push!(hand.cards, card);
@inline +(hand::Hand, cards::Array{Card, 1}) = append!(hand.cards, cards);
@inline -(hand::Hand, card::Card) = try deleteat!(hand.cards, findfirst(x -> x === card, hand.cards)) catch end;
function -(hand::Hand, cards::Array{Card, 1})
    for card in cards
        hand - card
    end
    return hand;
end

function shuffle(hand::Hand)
    shuffle!(hand.cards)
    return hand;
end
