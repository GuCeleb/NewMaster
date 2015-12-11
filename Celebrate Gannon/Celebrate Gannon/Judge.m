#import "Judge.h"

@implementation Judge


- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.Name = [coder decodeObjectForKey:@"Name"];
        self.UserID = [coder decodeObjectForKey:@"UserID"];
        self.Password = [coder decodeObjectForKey:@"Password"];
        
    }
    
    return self;
    
    
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.Name forKey:@"Name"];
    [coder encodeObject: self.UserID forKey:@"UserID"];
    [coder encodeObject: self.Password forKey:@"Password"];
    
}

@end
