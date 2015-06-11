//
//  ViewController.m
//  TipCalculator
//
//  Created by Sean Zeng on 6/6/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()

- (void)updateValues;

@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;

@end

@implementation ViewController

- (instancetype)init
{
    NSLog(@"init");
    self = [super init];
    if (self) {
        NSLog(@"self exists");
        self.currencyFormatter = [[NSNumberFormatter alloc] init];
        [self.currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"view did load");
    
    [self init]; // ???
    
    self.title = @"Some Title";
    
    [self updateValues];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL darkMode = [userDefaults boolForKey:@"darkMode"];
    
    if (darkMode) {
        [self setDarkModeAttributes];
    } else {
        [self setLightModeAttributes];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    // not work!
    //float appDelegateBillAmount = [(AppDelegate *)[[UIApplication sharedApplication] delegate] billAmount];
    //appDelegateBillAmount = billAmount;
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.billAmount = billAmount;
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //[numberFormatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    //[numberFormatter setGroupingSize:3];
    //[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    //[numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
    
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    //self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
     
    self.tipLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    //[self.navigationController pushViewController:[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil] animated:YES];
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)setDarkModeAttributes
{
    //NSLog(@"setDarkModeAttributes");

    self.view.backgroundColor = [UIColor blackColor];
    self.billTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.currencyFormatter currencySymbol] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.3]}];
    self.billTextField.backgroundColor = [UIColor grayColor];
    self.billTextField.keyboardAppearance = UIKeyboardAppearanceDark;
    self.billTextField.textColor = [UIColor whiteColor];
    //self.billTextField.tintColor = [UIColor colorWithWhite:1 alpha:0.3];
    self.billTitleLabel.textColor = [UIColor whiteColor];

    self.tipLabel.textColor = [UIColor whiteColor];
    self.tipTitleLabel.textColor = [UIColor whiteColor];
    
    self.totalLabel.textColor = [UIColor whiteColor];
    self.totalTitleLabel.textColor = [UIColor whiteColor];
    
    NSDictionary *normalAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil];
    [_tipControl setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [_tipControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
}

- (void)setLightModeAttributes
{
    //NSLog(@"setLightModeAttributes");

    self.view.backgroundColor = [UIColor whiteColor];
    self.billTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.currencyFormatter currencySymbol] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:0.3]}];
    self.billTextField.backgroundColor = [UIColor whiteColor];
    self.billTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.billTextField.textColor = [UIColor blackColor];
    //self.billTextField.tintColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.billTitleLabel.textColor = [UIColor blackColor];

    self.tipLabel.textColor = [UIColor blackColor];
    self.tipTitleLabel.textColor = [UIColor blackColor];
    
    self.totalLabel.textColor = [UIColor blackColor];
    self.totalTitleLabel.textColor = [UIColor blackColor];
    
    NSDictionary *normalAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13], UITextAttributeFont, [UIColor blackColor], UITextAttributeTextColor, nil];
    [_tipControl setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
    [_tipControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
}

@end
