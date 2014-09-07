//
//  Move.m
//  Matchismo
//
//  Created by Jonathan Jordan on 9/6/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "Move.h"
#import "Card.h"

@interface Move()

@property (strong, nonatomic, readwrite) NSArray *cards; // of Card
@property (readwrite) int score;
@property (nonatomic, getter = wasMatch, readwrite) BOOL matched;

@end

@implementation Move

- (NSArray *)cards {
    if (!_cards) _cards = [[NSArray alloc] init];
    return _cards;
}

- (instancetype)initWithCards:(NSArray *)cards score:(int)score {
    self = [super init]; // super's designated initializer
    
    if (self) {
        for (id obj in cards) {
            if (![obj isKindOfClass:[Card class]]) {
                self = nil;
                break;
            }
        }
        self.cards = cards;
        self.score = score;
        if (self.score > 0) {
            self.matched = YES;
        }
        else {
            self.matched = NO;
        }
    }
    
    return self;
}

@end
