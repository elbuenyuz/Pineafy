#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FauxPasAnnotations.h"
#import "STPAddCardViewController.h"
#import "STPAddress.h"
#import "STPAPIClient+ApplePay.h"
#import "STPAPIClient.h"
#import "STPAPIResponseDecodable.h"
#import "STPApplePayPaymentMethod.h"
#import "STPBackendAPIAdapter.h"
#import "STPBankAccount.h"
#import "STPBankAccountParams.h"
#import "STPBlocks.h"
#import "STPCard.h"
#import "STPCardBrand.h"
#import "STPCardParams.h"
#import "STPCardValidationState.h"
#import "STPCardValidator.h"
#import "STPConnectAccountParams.h"
#import "STPCoreScrollViewController.h"
#import "STPCoreTableViewController.h"
#import "STPCoreViewController.h"
#import "STPCustomer.h"
#import "STPCustomerContext.h"
#import "STPEphemeralKeyProvider.h"
#import "STPFile.h"
#import "STPFormEncodable.h"
#import "STPImageLibrary.h"
#import "STPLegalEntityParams.h"
#import "STPPaymentActivityIndicatorView.h"
#import "STPPaymentCardTextField.h"
#import "STPPaymentConfiguration.h"
#import "STPPaymentContext.h"
<<<<<<< HEAD
=======
#import "STPPaymentIntent.h"
#import "STPPaymentIntentEnums.h"
#import "STPPaymentIntentParams.h"
>>>>>>> 6955d9fa30d1b4dfe0d146cf03cb639fe1cf5925
#import "STPPaymentMethod.h"
#import "STPPaymentMethodsViewController.h"
#import "STPPaymentResult.h"
#import "STPRedirectContext.h"
#import "STPShippingAddressViewController.h"
#import "STPSource.h"
#import "STPSourceCardDetails.h"
#import "STPSourceEnums.h"
#import "STPSourceOwner.h"
#import "STPSourceParams.h"
#import "STPSourceProtocol.h"
#import "STPSourceReceiver.h"
#import "STPSourceRedirect.h"
#import "STPSourceSEPADebitDetails.h"
#import "STPSourceVerification.h"
#import "STPTheme.h"
#import "STPToken.h"
#import "STPUserInformation.h"
#import "Stripe.h"
#import "StripeError.h"
#import "UINavigationBar+Stripe_Theme.h"

FOUNDATION_EXPORT double StripeVersionNumber;
FOUNDATION_EXPORT const unsigned char StripeVersionString[];

