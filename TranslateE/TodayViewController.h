//
//  TodayViewController.h
//  TranslateE
//
//  Created by Xinqi Chan on 5/4/15.
//  Copyright (c) 2015 Xinqi Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController<NSURLConnectionDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end
