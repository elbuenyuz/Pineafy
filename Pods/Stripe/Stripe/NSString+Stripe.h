//
//  NSString+Stripe.h
//  Stripe
//
//  Created by Jack Flintermann on 10/16/15.
//  Copyright © 2015 Stripe, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Stripe)

- (NSString *)stp_safeSubstringToIndex:(NSUInteger)index;
- (NSString *)stp_safeSubstringFromIndex:(NSUInteger)index;
- (NSString *)stp_reversedString;
<<<<<<< HEAD
=======
- (NSString *)stp_stringByRemovingSuffix:(NSString *)suffix;
>>>>>>> 6955d9fa30d1b4dfe0d146cf03cb639fe1cf5925

@end

void linkNSStringCategory(void);
