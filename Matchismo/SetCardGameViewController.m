//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/31/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (CardMatchingGame *)newGame
{
    CardMatchingGame *game = [super newGame];
    if (game) {
        game.numCardsToMatch = 3;
    }
    return game;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] initWithDictionary:[self attributedStringAttributesForCard:card]];
    
    if (card.isChosen) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor grayColor];
        shadow.shadowBlurRadius = 3.0;
        shadow.shadowOffset = CGSizeMake(1.0, 1.0);
        [attributes setObject:shadow forKey:NSShadowAttributeName];
    }
    
    return [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
}

- (NSDictionary *)attributedStringAttributesForCard: (Card *)card
{
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        UIColor *solidColor;
        if ([setCard.color isEqualToString:@"red"]) {
            solidColor = [UIColor redColor];
        }
        else if ([setCard.color isEqualToString:@"green"]) {
            solidColor = [UIColor greenColor];
        }
        else {
            solidColor = [UIColor purpleColor];
        }
        
        if ([setCard.shading isEqualToString:@"open"] || [setCard.shading isEqualToString:@"striped"]) {
            [attributes setObject:solidColor forKey:NSStrokeColorAttributeName];
            if ([setCard.shading isEqualToString:@"open"]) {
                [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
            }
            else {
                [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
            }
        }
        
        [attributes setObject:solidColor forKey:NSForegroundColorAttributeName];
        if ([setCard.shading isEqualToString:@"striped"]) {
            [attributes setObject:[solidColor colorWithAlphaComponent:0.25] forKey:NSForegroundColorAttributeName];
        }
    }
    
    return attributes;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:@"cardfront"];
}

@end
