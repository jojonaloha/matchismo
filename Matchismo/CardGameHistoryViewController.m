//
//  CardGameHistoryViewController.m
//  Matchismo
//
//  Created by Jonathan Jordan on 9/6/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import "CardGameHistoryViewController.h"
#import "Card.h"
#import "Move.h"

@interface CardGameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyText;
@end

@implementation CardGameHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /* Testing
    Card *aCard = [[Card alloc] init];
    Card *bCard = [[Card alloc] init];
    Card *cCard = [[Card alloc] init];
    Card *dCard = [[Card alloc] init];
    Card *eCard = [[Card alloc] init];
    Card *fCard = [[Card alloc] init];
    aCard.contents = @"A";
    bCard.contents = @"B";
    cCard.contents = @"C";
    dCard.contents = @"D";
    eCard.contents = @"E";
    fCard.contents = @"F";
    self.moves = @[
        [[Move alloc] initWithCards:@[aCard, bCard] score:10],
        [[Move alloc] initWithCards:@[cCard, dCard] score:-5],
        [[Move alloc] initWithCards:@[eCard, fCard] score:15],
    ];
    */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSArray *)moves
{
    if (!_moves) _moves = [[NSArray alloc] init];
    return _moves;
}

- (NSDictionary *)attributedStringAttributesForCard: (Card *)card
{
    return @{};
}

- (NSAttributedString *)titleForCard: (Card *)card
{
    NSDictionary *attributes = @{};
    if ([self.formatter respondsToSelector:@selector(attributedStringAttributesForCard:)]) {
        attributes = [self.formatter performSelector:@selector(attributedStringAttributesForCard:) withObject:card];
    }
    return [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
}

- (void)updateUI
{
    NSMutableAttributedString *matchText = [[NSMutableAttributedString alloc] init];
    for (id obj in self.moves) {
        if ([obj isKindOfClass:[Move class]]) {
            Move *move = (Move *)obj;
            if (move.wasMatch) {
                [matchText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Matched "]];
                for (Card *card in move.cards) {
                    [matchText appendAttributedString: [self titleForCard:card]];
                }
                [matchText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points.\n", move.score]]];
            }
            else {
                for (Card *card in move.cards) {
                    [matchText appendAttributedString:[self titleForCard:card]];
                }
                [matchText appendAttributedString:[[NSAttributedString alloc] initWithString:@"don't match!\n"]];
            }
        }
    }
    self.historyText.attributedText = matchText;
}

@end
