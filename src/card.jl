import Base: *, ==, <, >

@enum Suit ♣=1 ♢ ♡ ♠
const clubs, diamonds, hearts, spades = ♣, ♢, ♡, ♠
const Clubs, Diamonds, Hearts, Spades = ♣, ♢, ♡, ♠

@enum Rank ace=1 two three four five six seven eight nine ten jack queen king
const Ace, Two, Three, Four = ace, two, three, four
const Five, Six, Seven, Eight = five, six, seven, eight
const Nine, Ten, Jack, Queen, King = nine, ten, jack, queen, king

const suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
const ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

struct Card
    rank::Rank
    suit::Suit
    function Card(rank::Int, suit::Int)::Card
        @assert(1 ≤ rank ≤ 13, "Invalid rank!")
        @assert(1 ≤ suit ≤ 4, "Invalid suit!")
        return new(Rank(rank), Suit(suit));
    end
end

@inline Card(rank::Rank, suit::Suit)::Card = Card(Int(rank), Int(suit));
@inline Card(rank::Rank, suit::Int)::Card = Card(Int(rank), suit);
@inline Card(rank::Int, suit::Suit)::Card = Card(rank, Int(suit));
@inline rank::Int * suit::Suit = Card(rank, suit);

@inline Base.show(io::IO, card::Card) = print(io, ranks[Int(card.rank)], card.suit);
@inline Base.in(suit::Suit, card::Card)::Bool = suit == card.suit;
@inline Base.in(rank::Rank, card::Card)::Bool = rank == card.rank;
@inline Base.in(rank::Int, card::Card)::Bool = Rank(rank) == card.rank;

@inline ==(x::Card, y::Card)::Bool = x.rank == y.rank;
@inline ===(x::Card, y::Card)::Bool = (x.rank == y.rank) && (x.suit == y.suit);
@inline Base.isequal(x::Card, y::Card)::Bool = x == y;

@inline <(x::Card, y::Card)::Bool = isless(x, y);
@inline >(x::Card, y::Card)::Bool = isless(y, x);
function Base.isless(x::Card, y::Card)::Bool
    xval = (x.rank == ace) ? Int(x.rank) + 13 : Int(x.rank)
    yval = (y.rank == ace) ? Int(y.rank) + 13 : Int(y.rank)
    return xval < yval;
end

@inline suit(card::Card)::Suit = card.suit;
@inline rank(card::Card)::Rank = card.rank;
@inline capitalize(s::String, i::Int = 1)::String = s[1:i-1] * uppercase(s[i:i]) * s[i+1:end];
@inline name(card::Card)::String = string(capitalize(string(rank(card))), " of ", suits[Int(suit(card))]);
