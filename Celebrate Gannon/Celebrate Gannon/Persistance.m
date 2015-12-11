#import "Persistance.h"

static Persistance *inst = nil;

@implementation Persistance


- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.comLogin = [coder decodeObjectForKey:@"comLogin"];
        self.comPassword = [coder decodeObjectForKey:@"comPassword"];

        self.lstJudges = [coder decodeObjectForKey:@"lstJudges"];
        self.lstPresenters = [coder decodeObjectForKey:@"lstPresenters"];
        self.lstStudents = [coder decodeObjectForKey:@"lstStudents"];
        
    }
    
    return self;
    
    
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.comLogin forKey:@"comLogin"];
    [coder encodeObject: self.comPassword forKey:@"comPassword"];

    [coder encodeObject: self.lstStudents forKey:@"lstStudents"];
    [coder encodeObject: self.lstJudges forKey:@"lstJudges"];
    [coder encodeObject: self.lstPresenters forKey:@"lstPresenters"];
    
}


+(Persistance *) sharedInstance {
    if(inst == nil){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"Persistance"])
        {
            NSData *dataPersis = [defaults objectForKey:@"Persistance"];
            inst= [NSKeyedUnarchiver unarchiveObjectWithData:dataPersis];
            
        }else{
            inst = [Persistance new];
            inst.comLogin = @"admin";
            inst.comPassword = @"admin";
            inst.lstJudges = [NSMutableArray new];
            inst.lstPresenters = [NSMutableArray new];
            inst.lstStudents = [NSMutableArray new];
        }
    }
    
    return inst;
    
}

-(void) synchronize{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [defaults setObject:data forKey:@"Persistance"];
    [defaults synchronize];
    
}

@end
