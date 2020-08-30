#include <stdio.h>
#import "../headers/NSTask.h"

int main(int argc, char *argv[], char *envp[]) {
	        
       NSString * host  = [NSString stringWithUTF8String:argv[1]];
       NSInteger port = 1883;
       port = strtol(argv[2], NULL, 10);
       NSString *topic = [NSString stringWithUTF8String:argv[3]];
       NSString *msg = [NSString stringWithUTF8String:argv[4]];
       NSInteger qos = 0;
       qos = strtol(argv[5], NULL, 10);
       setuid(0);                                                                                                                           //make us root
       setgid(0);
       if (getuid() != 0) {                                                                                                                 //Check for root permissions
           printf("root accsess denied");
       }
       NSTask *task = [[NSTask alloc] init];
       task.launchPath = @"/usr/bin/mqtt";
       [task setArguments: @[[NSString stringWithFormat:@"%@", host], [NSString stringWithFormat:@"%ld", port], [NSString stringWithFormat:@"%@", topic], [NSString stringWithFormat:@"%@", msg], [NSString stringWithFormat:@"%ld", qos]]];
	[task launch];

       while ([task isRunning]) {                                                                                                           //Wait for task to finnish
	       [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
       }
        
	return 0;
}
