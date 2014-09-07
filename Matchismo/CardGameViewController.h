//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jonathan Jordan on 8/17/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

// protected
// subclasses
- (Deck *)createDeck;


- (CardMatchingGame *)newGame;

- (NSAttributedString *)titleForCard:(Card *)card;

- (UIImage *)backgroundImageForCard:(Card *)card;
@end
