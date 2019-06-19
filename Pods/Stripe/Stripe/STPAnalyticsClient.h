//
//  STPAnalyticsClient.h
//  Stripe
//
//  Created by Ben Guo on 4/22/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STPPaymentConfiguration, STPToken;
@protocol STPFormEncodable;

@interface STPAnalyticsClient : NSObject

+ (instancetype)sharedClient;

+ (void)initializeIfNeeded;

+ (NSString *)tokenTypeFromParameters:(NSDictionary *)parameters;

- (void)addAdditionalInfo:(NSString *)info;

- (void)clearAdditionalInfo;

- (void)logTokenCreationAttemptWithConfiguration:(STPPaymentConfiguration *)configuration
                                       tokenType:(NSString *)tokenType;

- (void)logSourceCreationAttemptWithConfiguration:(STPPaymentConfiguration *)configuration
                                       sourceType:(NSString *)sourceType;

<<<<<<< HEAD
=======
- (void)logPaymentIntentConfirmationAttemptWithConfiguration:(STPPaymentConfiguration *)configuration
                                                  sourceType:(NSString *)sourceType;

>>>>>>> 6955d9fa30d1b4dfe0d146cf03cb639fe1cf5925
@end
