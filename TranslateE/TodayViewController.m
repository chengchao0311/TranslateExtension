//
//  TodayViewController.m
//  TranslateE
//
//  Created by Xinqi Chan on 5/4/15.
//  Copyright (c) 2015 Xinqi Chan. All rights reserved.
//

#import "TodayViewController.h"
#import "UIView+Addition.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>{
    NSArray * array;
    NSArray * array2;
    NSArray * array3;
    NSArray * bigArray;
    NSString * string;
    UILabel * resultLabel;
}

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    array = @[@"q", @"w", @"e", @"r",@"t",@"y",@"u", @"i", @"o", @"p"];
    array2 = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    array3 = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    
    string = @"";
    
    self.preferredContentSize = CGSizeMake(0, 260);
    
    self.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textFiled.delegate = self;
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    
    [self addButton];
    
}


- (void)addButton{
    CGFloat width = (self.view.frame.size.width - 62)/10;
    
    CGFloat x = 0;
    CGFloat x2 = x + width/2;
    CGFloat x3 = x2 + width/2;
    
    
    for (int i=0, count = 10; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(x, self.textFiled.frame.origin.y + self.textFiled.frame.size.height + 10 , width, 44)];
        NSString * word = [array[i] uppercaseString];
        
        [btn setTitle:word forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.mark = array[i];
        btn.layer.cornerRadius = 8.0;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        x += (width + 1);
    }
   
    for (int i=0, count = 9;  i< count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(x2, self.textFiled.frame.origin.y + self.textFiled.frame.size.height + 10 + 44 + 2 , width, 44)];
        NSString * word = [array2[i] uppercaseString];
        
        [btn setTitle:word forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 10;
         btn.layer.cornerRadius = 8.0;
        btn.mark = array2[i];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        x2 += (width + 1);
    }
    
    for (int i=0, count = 7;  i< count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(x3, self.textFiled.frame.origin.y + self.textFiled.frame.size.height + 10 + 44 + 2 + 2 + 44 , width, 44)];
        NSString * word = [array3[i] uppercaseString];
        
        [btn setTitle:word forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 10 + 9;
         btn.layer.cornerRadius = 8.0;
        btn.mark = array3[i];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        x3 += (width + 1);
    }
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(x3 + 2, self.textFiled.frame.origin.y + self.textFiled.frame.size.height + 10 + 44 + 2 + 2 + 44, width*2, 44);
    [deleteBtn setTitle:@"DEL" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setBackgroundColor:[UIColor whiteColor]];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteBtn.layer.cornerRadius = 8.0;
    [self.view addSubview:deleteBtn];
    
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(x3 - 30, self.textFiled.frame.origin.y + self.textFiled.frame.size.height + 10 + 44 + 2 + 2 + 44 + 20 + 44, width*2 + 30, 40);
    [doneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor whiteColor]];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.layer.cornerRadius = 8;
    [self.view addSubview:doneBtn];
    
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, self.textFiled.frame.origin.y + self.textFiled.frame.size.height + 10 + 44 + 2 + 2 + 44 + 20 + 44, 100, 44)];
    [resultLabel setTextColor:[UIColor whiteColor]];
    [resultLabel setHidden:YES];
    
    self.ac = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.ac.frame = resultLabel.frame;
    [self.ac setHidden:YES];
    [self.view addSubview:resultLabel];
    [self.view addSubview:self.ac];

}

- (void)btnClick:(id)sender{
    UIButton * btn = (UIButton*)sender;
    NSString * currword = btn.mark;
    string = [string stringByAppendingString:currword];
    NSLog(@"%@", string);
    [self.textFiled setText:string];
    
}

- (void)delete{
    if (string.length > 0) {
        string = [string substringToIndex:string.length - 1];
        [self.textFiled setText:string];
    }else{
         [self.textFiled setText:@""];
          string = @"";
    }
}

- (void)done{
    string = @"";
    [self.ac setHidden:NO];
    [self.ac startAnimating];
    NSString * urlString = [NSString stringWithFormat:@"http://fanyi.youdao.com/openapi.do?keyfrom=Alfred&key=1963786550&type=data&doctype=json&version=1.1&q=%@", self.textFiled.text];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    string = @"";
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.ac setHidden:YES];
    [resultLabel setHidden:NO];
    NSError * error;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@", dict);
  
    NSString * result = [[dict objectForKey:@"translation"] objectAtIndex:0];
    if (result) {
        [resultLabel setText:result];
    }else{
        [resultLabel setText:@"查询不到结果"];
    }

}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
