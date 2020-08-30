#import <string.h>
#import <dlfcn.h>
#import "../headers/NSTask.h"
#define FLAG_PLATFORMIZE (1 << 1)

@interface CCUIModuleCollectionViewController : UIViewController
- (void)viewDidLoad;
- (void)dealloc;
- (void)startCommandModule:(NSNotification *)notification;
@end

//preference vars
NSString * host;
NSInteger port;
NSString *topic;
NSString *msg;
NSInteger qos;

static NSString *bundleIdentifier = @"ch.jesseb0rn.mqttprefs";
static NSMutableDictionary *settings;

%group ios13 
%hook CCUIModuleCollectionViewController
- (void)viewDidLoad {
    %orig;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishMqtt:) name:@"ch.jesseb0rn.mqttmodule.run" object:nil];
}

- (void)dealloc {
    %orig;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
%new
- (void)publishMqtt:(NSNotification *)notification { //this method is run upon receiving the notification that the user invoked my tweak

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MQTTModule" message: [NSString stringWithFormat:@"/usr/bin/mqtt %@ %ld %@ %@ %ld", host, port, topic, msg, qos] preferredStyle:UIAlertControllerStyleAlert];
   
    
    [self presentViewController:alert animated:YES completion:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) { //must dispatch_async so the UI doesn't freeze while the script is running
        
            NSTask* task = [[NSTask alloc] init];
	        [task setLaunchPath:@"/usr/bin/mqttmoduled"];
	        [task setArguments: @[[NSString stringWithFormat:@"%@", host], [NSString stringWithFormat:@"%ld", port], [NSString stringWithFormat:@"%@", topic], [NSString stringWithFormat:@"%@", msg], [NSString stringWithFormat:@"%ld", qos]]];
	        [task launch];

            while ([task isRunning]) {
	            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
            }

            dispatch_sync(dispatch_get_main_queue(), ^{                                         //once the script is finished, update the UI
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            });
        }];
    }
%end
%end

%ctor {

	CFArrayRef keyList = CFPreferencesCopyKeyList((CFStringRef)bundleIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (keyList) {
	    settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, (CFStringRef)bundleIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
	    CFRelease(keyList);
	} else {
		settings = nil;
	}
	if (!settings) {
		settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/ch.jesseb0rn.mqttprefs.plist"]];
	}

    host = [settings valueForKey:@"host"];
    port = [[settings valueForKey:@"port"] integerValue];
    topic = [settings valueForKey:@"topic"];
    msg = [settings valueForKey:@"msg"];
    qos = [[settings valueForKey:@"qos"] integerValue];

     %init(ios13);

}
