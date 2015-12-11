#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Presenter : NSObject
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *Topic;
@property (nonatomic, retain) NSString *Date;
@property (nonatomic, retain) NSString *Time;
@property (nonatomic, retain) NSString *Location;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableDictionary *rattings;
@property (nonatomic, assign) BOOL isLiked;



@end
