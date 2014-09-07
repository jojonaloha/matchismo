//
//  CardGameHistoryViewController.h
//  Matchismo
//
//  Created by Jonathan Jordan on 9/6/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGameViewController.h"

@interface CardGameHistoryViewController : UIViewController

@property (strong, nonatomic) NSArray *moves; // of Moves
@property (strong, nonatomic) id formatter; // An object that defines a function that returns a dictionary appropriate for an NSAttributedString.
// - (NSDictionary *)attributedStringAttributesForCard: (Card *)card

- (NSAttributedString *)titleForCard: (Card *)card;

@end
