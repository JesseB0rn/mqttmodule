#include "jmpRootListController.h"

@interface NSTask : NSObject

-(id)init;
-(void)setArguments:(NSArray *)arg1 ;
-(void)setLaunchPath:(id)arg1 ;
-(void)launch;
@end

@implementation jmpRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
- (void) respring {
	NSTask* task = [[NSTask alloc] init];
	[task setLaunchPath:@"/bin/bash"];
	[task setArguments:@[ @"-c", @"/usr/bin/killall SpringBoard" ]];
	[task launch];
}
- (void) github {
     	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://github.com/jesseb0rn/mqttmodule"]
	options:@{}
	completionHandler:nil];
}
- (void) donate {

	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://bit.ly/jb0donate"]
	options:@{}
	completionHandler:nil];

}
@end
