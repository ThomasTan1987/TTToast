//
//  ViewController.m
//  TTToastDemo
//
//  Created by ThoamsTan on 16/7/28.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import "ViewController.h"
#import "TTToast.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtvwContent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showSuccessMsg {
    [TTToast showSuccessMessage:self.txtvwContent.text];
}
- (IBAction)showErrorMsg {
    [TTToast showErrorMessage:self.txtvwContent.text];
}
- (IBAction)showWarningMsg {
    [TTToast showWarningMessage:self.txtvwContent.text];
}
- (IBAction)showActivity {
    [TTToast show];
}
- (IBAction)dismiss {
    [TTToast dismiss];
}

@end
