# Playing Cards: Classic Game of War!
using PlayingCards

function game()
    rounds = 0
    deck = shuffle(Deck());
    player1 = Hand(cards = deal(deck, div(length(deck), 2)))
    player2 = Hand(cards = deal(deck, length(deck)))
    while true
        if isempty(player1)
            println("Player 2 wins in $rounds rounds!")
            break;
        end
        if isempty(player2)
            println("Player 1 wins in $rounds rounds!")
            break;
        end
        rounds += 1
        play!(player1, player2)
        if rounds == 1500
            println("We have played $rounds rounds, let's stop!")
            break;
        end
        if rounds % 100 == 0
            println("We have played $rounds rounds, let's shuffle our hands!")
            shuffle(player1); shuffle(player2);
        end
    end
    return nothing;
end

function play!(player1::Hand, player2::Hand; cards::Array{Card, 1} = Card[])
    card1 = player1[1]
    card2 = player2[1]
    if card1 > card2
        append!(cards, [card1, card2])
        player1 - card1; player2 - card2;
        player1 + cards
    elseif card2 > card1
        append!(cards, [card1, card2])
        player1 - card1; player2 - card2;
        player2 + cards
    else # card1 == card2
        println("WAR!")
        if length(player1) > 1
            player1 - card1
            push!(cards, card1)
        end
        if length(player2) > 1
            player2 - card2
            push!(cards, card2)
        end
        war!(player1, player2, cards)
    end
    return nothing;
end

function war!(player1::Hand, player2::Hand, cards::Array{Card, 1})
    a = (length(player1) > 3) ? 3 : length(player1) - 1
    b = (length(player2) > 3) ? 3 : length(player2) - 1
    append!(cards, player1[1:a])
    append!(cards, player2[1:b])
    player1 - player1[1:a]
    player2 - player2[1:b]
    play!(player1, player2, cards = cards)
    return nothing;
end
