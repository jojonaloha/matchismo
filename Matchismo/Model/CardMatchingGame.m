//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/17/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Move.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *chosenCards; // of Card
@property (nonatomic, strong, readwrite) NSArray *moves; // of Move;
@end

@implementation CardMatchingGame

@synthesize numCardsToMatch = _numCardsToMatch;

- (NSUInteger) numCardsToMatch {
    if (!_numCardsToMatch) _numCardsToMatch = 2;
    return _numCardsToMatch;
}

- (void) setNumCardsToMatch:(NSUInteger)numCardsToMatch {
    if (numCardsToMatch >= 2) {
        _numCardsToMatch = numCardsToMatch;
    }
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards {
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (NSArray *)moves {
    if (!_moves) _moves = [[NSArray alloc] init];
    return _moves;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init]; // super's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            int chosenIndex = [self.chosenCards indexOfObject:card];
            if (chosenIndex >= 0) {
                [self.chosenCards removeObjectAtIndex:chosenIndex];
            }
        } else {
            if ([self.chosenCards count] == self.numCardsToMatch - 1) {
                int matchScore = [card match:self.chosenCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in self.chosenCards) {
                        otherCard.matched = YES;
                    }
                    [self.chosenCards addObject:card];
                    // Add move that was a match.
                    self.moves = [self.moves arrayByAddingObject:[[Move alloc] initWithCards:[self.chosenCards copy] score:matchScore * MATCH_BONUS]];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    [self.chosenCards addObject:card];
                    // Add move that was not a match.
                    self.moves = [self.moves arrayByAddingObject:[[Move alloc] initWithCards:[self.chosenCards copy] score:-MISMATCH_PENALTY]];
                }
                // Remove all previously chosen cards.
                [self.chosenCards removeAllObjects];
                // The current card will remain chosen if not matched
                if (!card.isMatched) {
                    [self.chosenCards addObject:card];
                }
            } else {
                [self.chosenCards addObject:card];
            }
            
            self.score -= COST_TO_CHOOSE;
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    otherCard.chosen = NO;
                }
            }
            card.chosen = YES;
            for (Card *otherCard in self.chosenCards) {
                otherCard.chosen = YES;
            }
        }
    }
}

@end
