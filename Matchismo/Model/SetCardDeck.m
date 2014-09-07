//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/31/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (NSUInteger rank = 1; rank <= [SetCard maxNumber]; rank++) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSString *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.number = rank;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
