#import <Foundation/Foundation.h>
#import "ScoringObject.h"

@interface PlatformScoring : NSObject
@property(nonatomic, retain) NSMutableArray *items;


-(int) getTotal;
-(int) getScore;
@end
