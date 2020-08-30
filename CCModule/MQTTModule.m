#import "MQTTModule.h"

@implementation MQTTModule

- (UIImage *)iconGlyph {
    return [UIImage imageNamed:@"ModuleIcon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

- (void)setSelected:(BOOL)selected {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ch.jesseb0rn.mqttmodule.run" object:nil];
}

@end
