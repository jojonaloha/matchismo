//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jonathan Jordan on 8/17/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
// subclasses
- (Deck *)createDeck;

@end
