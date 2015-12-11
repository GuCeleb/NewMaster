#import "Presenter.h"

@implementation Presenter

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.Name = [coder decodeObjectForKey:@"Name"];
        self.Topic = [coder decodeObjectForKey:@"Topic"];
        self.Date = [coder decodeObjectForKey:@"Date"];
        self.Time = [coder decodeObjectForKey:@"Time"];
        self.Location = [coder decodeObjectForKey:@"Location"];
        self.image = [coder decodeObjectForKey:@"image"];
        self.rattings = [coder decodeObjectForKey:@"rattings"];
        self.isLiked = [coder decodeBoolForKey:@"isLiked"];
        
    }
    
    return self;
    
    
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.Name forKey:@"Name"];
    [coder encodeObject: self.Topic forKey:@"Topic"];
    [coder encodeObject: self.Date forKey:@"Date"];
    [coder encodeObject: self.Time forKey:@"Time"];
    [coder encodeObject: self.Location forKey:@"Location"];
    [coder encodeObject: self.image forKey:@"image"];
    [coder encodeObject: self.rattings forKey:@"rattings"];
    [coder encodeBool: self.isLiked forKey:@"isLiked"];
    
}


@end
