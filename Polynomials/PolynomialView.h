//
//  PolynomialView.h
//  Polynomials
//
//  Created by Martin Maciaszek on 13.02.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PolynomialView : NSView {
	NSMutableArray *polynomials;
}
- (IBAction)createNewPolynomial:(id)sender;
- (IBAction)deleteRandomPolynomial:(id)sender;
@end
