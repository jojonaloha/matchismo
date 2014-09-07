//
//  Move.h
//  Matchismo
//
//  Created by Jonathan Jordan on 9/6/14.
//  Copyright (c) 2014 Metal Toad Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Move : NSObject

@property (strong, nonatomic, readonly) NSArray *cards; // of Card
@property (readonly) int score;
@property (nonatomic, getter = wasMatch, readonly) BOOL matched;

// designated initializer
- (instancetype)initWithCards:(NSArray *)cards score:(int)score;

@end
