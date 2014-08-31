//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/30/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
