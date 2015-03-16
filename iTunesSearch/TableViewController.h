//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) UITextField *textfield;
@property (strong, nonatomic) UIButton *buttonSearch;
-(IBAction)buttonTouchUpInside:(id)sender;
@end

