//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Sean Zeng on 6/7/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic) BOOL darkMode;
@property (nonatomic) NSUserDefaults *userDefaults;

//- (void)themeSwitchDidChange:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.darkMode = [self.userDefaults boolForKey:@"darkMode"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSLog(@"empty cell");
        [tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    */
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell2"];
    
    // configure the cell
    //cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    if ([indexPath section] == 1) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"Dark Theme"];
            
            UISwitch *themeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(310, 6, 0, 0)];
            themeSwitch.on = self.darkMode;
            [themeSwitch addTarget:self action:@selector(themeSwitchDidChange:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:themeSwitch];
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //return [NSString stringWithFormat:@"%d", section];
    if (section == 0) {
        return @"Tip Percentage";
    } else if (section == 1) {
        return @"Appearance";
    } else {
        return 0;
    }
}

- (void)themeSwitchDidChange:(id)sender {
    if([sender isOn]) {
        self.darkMode = YES;
    } else {
        self.darkMode = NO;
    }
    [self saveToSettings];
}

- (void)saveToSettings
{
    NSLog(@"saveToSettings");
    [self.userDefaults setBool:self.darkMode forKey:@"darkMode"];
    //[self.userDefaults synchronize];
}

@end
