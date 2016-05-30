//
//  NSObject+IMYAsyncBlock.h
//  IMYAsyncBlock
//
//  Created by ljh on 16/5/30.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IMYAsyncBlock)

///可取消的 异步调用block
+ (void)imy_asyncBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterSecond:(double)second forKey:(NSString*)key;

///取消队列中的block
+ (void)imy_cancelBlockForKey:(NSString*)key;

///是否存在这个异步block
+ (BOOL)imy_hasAsyncBlockForKey:(NSString*)key;

@end
