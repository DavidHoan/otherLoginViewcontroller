
//
//  loginVC.m
//  loginViewController
//
//  Created by Dong Quoc on 9/9/16.
//  Copyright © 2016 Dong Quoc. All rights reserved.
//

#import "logmeinvc.h"

#define RGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface logmeinvc (){
    int screenW;
    int screenH;
}

@end

@implementation logmeinvc

- (void)viewDidLoad {
    [super viewDidLoad];
    screenW = [UIScreen mainScreen].bounds.size.width;
    screenH = [UIScreen mainScreen].bounds.size.height;
    
    [self initBacground];
    
    [self initWellcomeView];
    
    [self initLoginview];
    
    //[self listFontsName];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}


- (void) initBacground
{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.frame];
    bg.image = [UIImage imageNamed:@"loginbg.png"];
    [self.view addSubview:bg];
}

- (void) initWellcomeView
{
    
    UIView *welcomeview = [[UIView alloc] initWithFrame:CGRectMake(0, 50*scalef, screenW, 100)];
    
    [self.view addSubview: welcomeview];
    
    UILabel *welcometext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    welcometext.numberOfLines = 0;
    welcometext.text = @"Welcome to you!";
    [welcometext setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:14]];
    welcometext.textAlignment = NSTextAlignmentCenter;
    welcometext.textColor = [UIColor whiteColor];
    [welcomeview addSubview:welcometext];
    
    UIButton *closemebtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW - 20 - 10, 20 + 10, 20, 20)];
    [closemebtn setBackgroundImage:[UIImage imageNamed:@"closebtn.png"] forState:UIControlStateNormal];
    [self.view addSubview:closemebtn];
    
    [closemebtn addTarget:self action:@selector(closeme) forControlEvents:UIControlEventTouchUpInside];
}

- (void) closeme
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) initLoginview
{
    NSArray* inputholder = @[@"Tên đăng nhập", @"Mật khẩu"];
    
    UIView *loginview = [[UIView alloc] initWithFrame:CGRectMake(0, 108*scalef+100, screenW, 300)];
    
    [self.view addSubview: loginview];
    int posy = 0;
    CGSize itemFrame = CGSizeMake(208, 42);
    for (int i=0; i<2; i++) {
        posy = 32+i*55;
        [self initInputField:loginview top: posy size:CGSizeMake(198, 39) holder:inputholder[i]  tag:i fontSize:16.0f];
    }
    
    [self initLoginbtn:loginview top:posy+90 size:itemFrame titleStr:@"ĐĂNG NHẬP" fontSize:14.0f mybtn:loginbtn bgColor:RGBColor(0x4f9cdf) borderColor:RGBColor(0x4f9cdf) function:@selector(loginfunction)];
    
    
    [self initLoginbtn:loginview top:posy+ 90 +50 size:itemFrame titleStr:@"Quên mật khẩu?" fontSize:14.0f mybtn:loginbtn bgColor:[UIColor clearColor] borderColor:[UIColor clearColor] function:@selector(loginfunction)];
}

- (void) initInputField:(UIView*) mainview top:(int)posY size:(CGSize)inputSize holder:(NSString*)holderStr tag:(int)tag fontSize:(float)fontSize
{
    int paddingLeft = (int)(mainview.frame.size.width - inputSize.width)/2;
    
    int textPadding = paddingLeft;
    if (paddingLeft>40) { textPadding = 20; }
    UIView *inputText = [[UIView alloc] initWithFrame:CGRectMake(paddingLeft, posY, inputSize.width, inputSize.height)];
    /*
     ####bo tròn
     inputText.layer.borderWidth = 0.6f;
     inputText.layer.borderColor = [UIColor whiteColor].CGColor;
     inputText.layer.cornerRadius = inputSize.height/2 - 1;
     */
    
    float borderWidth = 1.0f;
    CALayer *border = [CALayer layer];
    border.backgroundColor = RGBColor(0x776965).CGColor;
    border.frame = CGRectMake(0, inputText.frame.size.height - borderWidth, inputText.frame.size.width, borderWidth);
    [inputText.layer addSublayer:border];
    
    [mainview addSubview:inputText];
    /*
     UIImageView *inputbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, inputSize.width, inputSize.height)];
     inputbg.image = [UIImage imageNamed:imagename];
     [inputText addSubview:inputbg];
     */
    
    UITextField *inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(textPadding, 0, inputSize.width-2*textPadding, inputSize.height)];
    inputTextField.textAlignment = NSTextAlignmentCenter;
    inputTextField.placeholder = holderStr;
    [inputText addSubview:inputTextField];
    inputTextField.tag = loginInputTag+tag;
    inputTextField.delegate=self;
    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if (tag==1) { inputTextField.secureTextEntry = YES;  }
    [inputTextField setValue:RGBColor(0xffffff) forKeyPath:@"_placeholderLabel.textColor"];
    [inputTextField setValue:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize] forKeyPath:@"_placeholderLabel.font"];
    
    inputTextField.font = [UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize];
    inputTextField.textColor = RGBColor(0xffffff);
    
    inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[inputTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

- (void) initLoginbtn:(UIView*) mainview top:(int)posY size:(CGSize)inputSize titleStr:(NSString*)titleStr fontSize:(float)fontSize mybtn:(UIButton*)mybtn bgColor:(UIColor*)bgColor borderColor:(UIColor*)borderColor function:(SEL)selector
{
    int paddingLeft = (int)(mainview.frame.size.width - inputSize.width)/2;
    mybtn = [[UIButton alloc] initWithFrame:CGRectMake(paddingLeft, posY, inputSize.width, inputSize.height)];
    mybtn.layer.borderWidth = 0.6f;
    mybtn.layer.borderColor = borderColor.CGColor;//RGBColor(0x30ad64).CGColor;
    mybtn.layer.cornerRadius = inputSize.height/2 - 1;
    mybtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize];
    [mybtn setTitle:titleStr forState:UIControlStateNormal];
    mybtn.backgroundColor = bgColor;//RGBColor(0x30ad64);
    
    [mainview addSubview:mybtn];
    
    [mybtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void) initTextLabel:(UIView*) mainview top:(int)posY size:(CGSize)labelSize textStr:(NSString*)textStr fontSize:(float)fontSize textColor:(UIColor*)textColor textAlign:(NSTextAlignment)myTextAlign
{
    UILabel *mylabel = [[UILabel alloc] initWithFrame:CGRectMake(0, posY, labelSize.width, labelSize.height)];
    mylabel.text = textStr;
    [mylabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize]];
    [mylabel setTextColor:textColor];
    mylabel.textAlignment = myTextAlign;
    mylabel.numberOfLines = 0;
    [mainview addSubview:mylabel];
}


- (void)loginfunction
{
    NSLog(@"Login now");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) listFontsName
{
    for (NSString *familyName in [UIFont familyNames]){
        NSLog(@"Family name: %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"--Font name: %@", fontName);
        }
    }
}



#pragma UITextField move up when keyboard present

/*
 *  Delegate thằng input nào muốn đẩy
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // dismiss the keyboard
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textViewDidBeginEditing");
    [self animateTextField: textField up: YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textViewDidEndEditing : %@", textField.text);
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        self.view.frame = CGRectOffset(self.view.frame, movement, 0);
    } else {
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }
    
    [UIView commitAnimations];
}


@end
