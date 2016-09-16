//
//  registervc.h
//  otherLoginViewcontroller
//
//  Created by Dong Quoc on 9/16/16.
//  Copyright © 2016 Dong Quoc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define loginInputTag 11122123
#define scalef [UIScreen mainScreen].bounds.size.height/568

@interface registervc : UIViewController<UITextFieldDelegate> {
    UITextField *username;
    UITextField *password;
    UIButton *loginbtn;
}

@end
