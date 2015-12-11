#import <Foundation/Foundation.h>

@interface ScoringObject : NSObject
@property (nonatomic, retain) NSString *Criteria;
@property (nonatomic, retain) NSString *Sophisticated;
@property (nonatomic, retain) NSString *Competent;
@property (nonatomic, retain) NSString *NotYetCompetent;
@property (nonatomic, assign) int Points;
@property (nonatomic, assign) int Weight;


- (id)initWithData:(NSString *) criteria textSophisticated:(NSString *) sophis textCompetent:(NSString *) comp
textNotYetCompetent:(NSString *) notyet Weight:(int) weight;

@end
