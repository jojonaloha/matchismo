//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/17/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (id otherCard in otherCards) {
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *) otherCard;
            if (playingCard.rank == self.rank) {
                score += 4;
            } else if ([playingCard.suit isEqualToString:self.suit]) {
                score += 1;
            }
        }
    }
    
    if ([otherCards count] > 1) {
        Card *otherCard = [otherCards firstObject];
        NSMutableArray *matchCards = [[NSMutableArray alloc] init];
        for (int i = 1; i < [otherCards count]; i++) {
            [matchCards addObject:[otherCards objectAtIndex:i]];
        }
        score += [otherCard match:matchCards];
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"❤️", @"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
