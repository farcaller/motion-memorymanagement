#import "MMRuntime.h"

id MMAutoreleased(id(^block)(void))
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    id ret = block();
    
    [pool release];
    return ret;
}