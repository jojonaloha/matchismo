//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jonathan Jordan on 8/17/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *matchLogLabel;
@property (strong, nonatomic) NSString *matchText;
@end

@implementation CardGameViewController


- (NSString *)matchText {
    if (!_matchText) _matchText = [[NSString alloc] init];
    return _matchText;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [self newGame];
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)newGame {
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    game.numCardsToMatch = self.matchModeControl.selectedSegmentIndex + 2;
    self.matchModeControl.enabled = YES;
    return game;
}

- (IBAction)changeMatchModeControl:(UISegmentedControl *)sender {
    self.game.numCardsToMatch = sender.selectedSegmentIndex + 2;
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    self.game = [self newGame];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.matchModeControl.enabled = NO;
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    self.matchText = [[NSString alloc] init];
    NSLog(@"last move: %@", self.game.lastMove);
    if ([self.game.lastMove[@"wasMatch"] boolValue] == YES) {
        self.matchText = [self.matchText stringByAppendingString:@"Matched "];
        for (Card *aCard in [self.game.lastMove objectForKey:@"cards"]) {
            self.matchText = [self.matchText stringByAppendingString:[NSString stringWithFormat:@"%@ ", aCard.contents]];
        }
        self.matchText = [self.matchText stringByAppendingString:[NSString stringWithFormat:@"for %@ points.", self.game.lastMove[@"matchScore"]]];
    }
    else {
        for (Card *aCard in [self.game.lastMove objectForKey:@"cards"]) {
            self.matchText = [self.matchText stringByAppendingString:[NSString stringWithFormat:@"%@ ", aCard.contents]];
        }
        int compared = [self.game.lastMove[@"matchScore"] compare:@0];
        NSLog(@"comparison of %@ and %@: %d", self.game.lastMove[@"matchScore"], @0, compared);
        if (compared < 0) {
            self.matchText = [self.matchText stringByAppendingString:@"don't match!"];
        }
    }
    self.matchLogLabel.text = self.matchText;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
