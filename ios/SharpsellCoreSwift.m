//
//  SharpsellCore.m
//  SampleReact
//
//  Created by soham pandya on 20/02/24.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SharpsellCoreSwift, NSObject)

RCT_EXTERN_METHOD(open:(NSDictionary *)options)
RCT_EXTERN_METHOD(initialiseEngine:(NSDictionary *)options)
RCT_EXTERN_METHOD(createEngine)
RCT_EXTERN_METHOD(logoutSharpsell)

@end
