//
//  iOSHelper.cpp
//  cocos2dx-store
//
//  Created by Refael Dakar on 10/27/12.
//
//

#include "MacHelper.h"
    
void MacHelper::LogMessage(const char* msg) {
    NSString *message = [[NSString alloc] initWithBytes:msg length:strlen(msg) encoding:NSUTF8StringEncoding];
    NSLog(@"%@", message);
}
