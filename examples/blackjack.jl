using PlayingCards

function game()
    deck = shuffle(Deck());
    dealer = Hand(cards = deal(deck, 2))
    player = Hand(cards = deal(deck, 2))
    while true
        println("\nPlayer Hand: $player")
        print("Press 'h' to Hit or 'p' to Play: ")
        action = lowercase(readline())
        if action == "h"
            player + deal(deck)
            if score(player) == -1
                println("\nPlayer has: $player")
                println("Player busts! Dealer wins!")
                break;
            end
        elseif action == "p"
            println("\nDealer has: $dealer")
            while score(dealer) < 16
                println("Dealer hits...")
                dealer + deal(deck)
                println("Dealer has: $dealer")
                if score(dealer) == -1
                    println("Dealer busts! Player wins!")
                    break;
                end
            end
            if score(dealer) ≥ score(player)
                println("Dealer wins!")
                break;
            else
                println("Player wins!")
                break;
            end
        else
            println("Not a valid option. Try again!")
            break;
        end
    end
    return nothing;
end

function score(hand::Hand)
    points = [0, 0, -1]
    for card in hand
        option1 = (Int(card.rank) ≥ 10) ? 10 : Int(card.rank)
        points[1] += option1
        option2 = (card.rank == ace) ? 11 : option1
        points[2] += option2
    end
    mask = points .≤ 21
    return max(points[mask]...);
end
