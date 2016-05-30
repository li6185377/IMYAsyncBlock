# IMYAsyncBlock

使用方法很简单。


```
	///创建一个异步执行block   一个key对应一个block
    NSString *queueKey = NSStringFromSelector(_cmd);
    [NSObject imy_asyncBlock:^{
			///do something
    } onQueue:dispatch_get_global_queue(0, 0) afterSecond:2 forKey:queueKey];
    
	 ///该key 是否还有未执行的Block
    BOOL hasContain = [NSObject imy_hasAsyncBlockForKey:queueKey];
    
    ///取消该block
	[NSObject imy_cancelBlockForKey:queueKey];
    
```