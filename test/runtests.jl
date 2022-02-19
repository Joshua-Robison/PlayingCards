using Test
using PlayingCards

@testset "card.jl" begin
    a = Card(1, 1)
    b = Card(7, ♡)
    c = Card(jack, ♠)
    d = Card(Seven, 2)
    e = Card(Five, clubs)
    f = Card(five, Clubs)
    g = 10♡
    h = 4Diamonds
    i = 6clubs

    @test (a > b) == true
    @test (d < c) == true
    @test (e === f) == true
    @test name(g) === "Ten of Hearts"
    @test name(h) === "Four of Diamonds"
    @test name(i) === "Six of Clubs"
end

@testset "deck.jl" begin
    deck = Deck()

    @test length(deck) == 52
    @test deck[end] == Card(King, ♠)
    @test length(deck[1:10]) == 10
    @test deal(deck) == Card(ace, Clubs)
end

@testset "hand.jl" begin
    deck = Deck()
    hand = Hand(cards = deal(deck, 5))

    @test length(deck) == 47
    @test length(hand) == 5
    @test name(hand[3]) == "Ace of Hearts"
    @test length(hand[1:3]) == 3
end
