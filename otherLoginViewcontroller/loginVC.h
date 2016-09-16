//
//  loginVC.h
//  loginViewController
//
//  Created by Dong Quoc on 9/9/16.
//  Copyright © 2016 Dong Quoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "logmeinvc.h"
#import "registervc.h"

#define loginInputTag 11122123
#define scalef [UIScreen mainScreen].bounds.size.height/568

@interface loginVC : UIViewController<UITextFieldDelegate> {
    UITextField *username;
    UITextField *password;
    UIButton *loginbtn;
}

@end
