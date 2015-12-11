#import "ScoringObject.h"

@implementation ScoringObject


- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.Criteria = [coder decodeObjectForKey:@"Criteria"];
        self.Sophisticated = [coder decodeObjectForKey:@"Sophisticated"];
        self.Competent = [coder decodeObjectForKey:@"Competent"];
        self.NotYetCompetent = [coder decodeObjectForKey:@"NotYetCompetent"];
        self.Weight = [coder decodeIntForKey:@"Weight"];
        self.Points = [coder decodeIntForKey:@"Points"];
        
    }
    
    return self;
    
    
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.Criteria forKey:@"Criteria"];
    [coder encodeObject: self.Sophisticated forKey:@"Sophisticated"];
    [coder encodeObject: self.Competent forKey:@"Competent"];
    [coder encodeObject: self.NotYetCompetent forKey:@"NotYetCompetent"];
    [coder encodeInt: self.Weight forKey:@"Weight"];
    [coder encodeInt: self.Points forKey:@"Points"];
    
}



- (id)initWithData:(NSString *) criteria textSophisticated:(NSString *) sophis textCompetent:(NSString *) comp
textNotYetCompetent:(NSString *) notyet Weight:(int) weight{
    self = [super init];
    if (self) {
        self.Criteria = criteria;
        self.Sophisticated = sophis;
        self.Competent = comp;
        self.NotYetCompetent = notyet;
        self.Weight = weight;
        self.Points = 1;
    }
    return self;
}
@end
