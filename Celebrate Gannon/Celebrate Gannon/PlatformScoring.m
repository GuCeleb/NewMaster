#import "PlatformScoring.h"

@implementation PlatformScoring
@synthesize items;

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.items = [coder decodeObjectForKey:@"items"];
        
    }
    
    return self;
    
    
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.items forKey:@"items"];
    
}



- (id)init {
    self = [super init];
    if (self) {
        items = [NSMutableArray new];
        ScoringObject *obj1 = [[ScoringObject alloc] initWithData:@"ORGANIZATION" textSophisticated:@"Presentation is clear, logical and organized.\nListener can follow the line of reasoning." textCompetent:@"Presentation is generally clear and well organized.\nA few minor points may be confusing." textNotYetCompetent:@"Listener can follow presentation only with effort.\nSome arguments are not clear.\nOrganization seems haphazard." Weight:3];
        
        
        ScoringObject *obj2 = [[ScoringObject alloc] initWithData:@"STYLE" textSophisticated:@"Level of presentation is appropriate for the audience.\nPresentation is a planned conversation, paced for audience understanding. It is not a reading of a paper. \nSpeaker is clearly comfortable in front of the group and can be heard by all.\n" textCompetent:@"Level of presentation is generally appropriate. Pacing is sometimes too fast or slow. \nThe presenter seems slightly uncomfortable at times, and the audience occasionally has trouble hearing him/her.\n" textNotYetCompetent:@"Aspects of presentation are too elementary or too sophisticated for audience. \nPresenter seems uncomfortable and can be heard only if listener is very attentive.\nMuch of the information is read.\n" Weight:2];
        
        ScoringObject *obj3 = [[ScoringObject alloc] initWithData:@"USE OF COMMUNICATION AIDS" textSophisticated:@"Communication aids enhance the presentation. They are prepared in a professional manner.\nFont on visuals is large enough to be seen by all.\nInformation is organized to maximize audience understanding.\nDetails are minimized so that the main points stand out.\n" textCompetent:@"Communication aids contribute to the quality of the presentation.\nFont size is appropriate for reading. \nAppropriate information is included. \nSome material is not supported by visual aids.\n" textNotYetCompetent:@"Communication aids are poorly prepared or used inappropriately. \nFont is too small to be easily seen.\nToo much information is included.\nUnimportant material is highlighted. Listeners may beconfused.\n" Weight:2];

        ScoringObject *obj4 = [[ScoringObject alloc] initWithData:@"DEPTH OF CONTENT" textSophisticated:@"Speaker provides an accurate and complete explanation of key concepts and theories, drawing upon the relevant literature.\nApplications of theory are included to illuminate issues.\nListeners gain insight.\n" textCompetent:@"For the most part, explanations of concepts and theories are accurate and complete. \nSome helpful applications are included.\n" textNotYetCompetent:@"Explanations of concepts and/or theories are inaccurate or incomplete. \nLittle attempt is made to tie theory to practice. \nListeners gain little from the presentation.\n" Weight:7];
        
        
        ScoringObject *obj5 = [[ScoringObject alloc] initWithData:@"GRAMMAR AND WORD CHOICE" textSophisticated:@"Sentences are complete, grammatically correct and flow together easily.\nWords are chosen for their precise meaning\n" textCompetent:@"For the most part, sentences are complete, grammatically correct and flow together easily.\nWith a few exceptions, words are chosen for their precise meaning\n" textNotYetCompetent:@"Listeners can follow the presentation, but they are distracted by some grammatical errors and use of slang.\nSome sentences are incomplete/halting/, and/or vocabulary is somewhat limited or inappropriate\n" Weight:2];
        
        
        ScoringObject *obj6 = [[ScoringObject alloc] initWithData:@"PERSONAL APPEARANCE" textSophisticated:@"Personal appearance is completely appropriate for the occasion and the audience.\n" textCompetent:@"Personal appearance is generally appropriate for the occasion and audience. \n" textNotYetCompetent:@"However, some aspects of appearance reflect a lack of sensitivity to nuances of the occasion or expectations of the audience.\nPersonal appearance is inappropriate for the occasion and audience.\n" Weight:2];
        
        
        
        ScoringObject *obj7 = [[ScoringObject alloc] initWithData:@"VERBAL INTERACTION" textSophisticated:@"Consistently clarifies, restates, and responds to questions.\nSummarizes when needed.\n" textCompetent:@"Generally responds to audience comments, questions and needs.\nMisses some opportunities for interaction.\n" textNotYetCompetent:@"Responds to questions inadequately.\n" Weight:2];
        
        [items addObject:obj1];
        [items addObject:obj2];
        [items addObject:obj3];
        [items addObject:obj4];
        [items addObject:obj5];
        [items addObject:obj6];
        [items addObject:obj7];
    }
    return self;
}

-(int) getTotal{
    int score = 0;
    for(int i=0; i<items.count; i++){
        ScoringObject *obj = [items objectAtIndex:i];
        score += obj.Weight * 5;
    }
    return score;
}

-(int) getScore{
    int score = 0;
    for(int i=0; i<items.count; i++){
        ScoringObject *obj = [items objectAtIndex:i];
        score += obj.Weight * obj.Points;
    }
    return score;
}

@end
