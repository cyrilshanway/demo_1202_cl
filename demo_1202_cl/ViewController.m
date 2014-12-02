//
//  ViewController.m
//  demo_1202_cl
//
//  Created by Cyrilshanway on 2014/12/2.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    UITextField  *email;
    UITextField  *user_password;
    UITextField  *user_confirm;
    
    UITextField  *first_name;
    UITextField  *last_name;
    
    UITextField  *gender;
    
    NSArray      *genderData;
    UIPickerView *genderPicker;
    
    UIDatePicker *birthdayPicker;
    
    UITextField  *birthday;
    UITextField  *tel_1;
    UITextField  *tel_2;
    UITextField  *address;
    
    //CALayer *_border;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
    
    
    // Customer the title View put in navigation bar
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    imageView.image = [UIImage imageNamed:@"alpha"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.center = navView.center;
    
    [navView addSubview:imageView];
    self.navigationItem.titleView = navView;
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    email.placeholder = @"會員登入帳號";
    email.textColor = [UIColor lightGrayColor];
    email.delegate = self;
    email.textAlignment = NSTextAlignmentRight;
    email.font = [UIFont systemFontOfSize:13];
    email.tag = 101;
    
    user_password = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    user_password.placeholder = @"6-12位英數字，不含標點符號";
    user_password.textColor = [UIColor lightGrayColor];
    user_password.delegate = self;
    user_password.textAlignment = NSTextAlignmentRight;
    [user_password setSecureTextEntry:YES];
    user_password.font = [UIFont systemFontOfSize:13];
    user_password.tag = 102;
    
    user_confirm = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    user_confirm.placeholder = @"再次輸入同樣密碼";
    user_confirm.textColor = [UIColor lightGrayColor];
    user_confirm.delegate = self;
    user_confirm.textAlignment = NSTextAlignmentRight;
    [user_confirm setSecureTextEntry:YES];
    user_confirm.font = [UIFont systemFontOfSize:13];
    user_confirm.tag = 103;
    
    last_name = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    last_name.textColor = [UIColor lightGrayColor];
    last_name.delegate = self;
    last_name.textAlignment = NSTextAlignmentRight;
    last_name.font = [UIFont systemFontOfSize:13];
    last_name.tag = 104;
    
    first_name = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    first_name.textColor = [UIColor lightGrayColor];
    first_name.delegate = self;
    first_name.textAlignment = NSTextAlignmentRight;
    first_name.font = [UIFont systemFontOfSize:13];
    first_name.tag = 105;
    
    gender = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    gender.textColor = [UIColor lightGrayColor];
    gender.delegate = self;
    gender.textAlignment = NSTextAlignmentRight;
    gender.font = [UIFont systemFontOfSize:13];
    gender.tag = 106;
    
    genderData = @[@"請選擇",@"男",@"女"];
    
    birthday = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 160, 40)];
    birthday.placeholder = @"會員登入帳號";
    birthday.textColor = [UIColor lightGrayColor];
    birthday.delegate = self;
    birthday.textAlignment = NSTextAlignmentRight;
    birthday.font = [UIFont systemFontOfSize:13];
    birthday.tag = 107;
    
    tel_1 = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    tel_1.textColor = [UIColor lightGrayColor];
    tel_1.delegate = self;
    tel_1.textAlignment = NSTextAlignmentRight;
    tel_1.font = [UIFont systemFontOfSize:13];
    tel_1.tag = 108;
    tel_1.placeholder = @"驗證碼將傳送至此";
    
    tel_1.keyboardType = UIKeyboardTypePhonePad;
    
    tel_2 = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    tel_2.textColor = [UIColor lightGrayColor];
    tel_2.delegate = self;
    tel_2.textAlignment = NSTextAlignmentRight;
    tel_2.font = [UIFont systemFontOfSize:13];
    tel_2.tag = 109;
    
    tel_2.keyboardType = UIKeyboardTypePhonePad;
    
    address = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 40)];
    address.textColor = [UIColor lightGrayColor];
    address.delegate = self;
    address.textAlignment = NSTextAlignmentRight;
    address.font = [UIFont systemFontOfSize:13];
    address.tag = 110;
    
    
    //點到螢幕任何地方都會把鍵盤下降 Add Gesture
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [gestureRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self registerForKeyboardNotifications];
}

-(void)hideKeyboard{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}
//分類
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//欄位高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
//要顯示幾個欄位
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ((section == 0) || (section == 2)) {
        return 3;
    }else{
        return 4;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headerLabel = [[UILabel alloc] init];
    
    headerLabel.frame = CGRectMake(0, 0, 300, 35.0);
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.font = [UIFont systemFontOfSize:12.0f];
    
    if (section == 0) {
        headerLabel.text = @"    設定帳號密碼(紅色圖示為必填欄位)";
    }else if (section == 1){
        headerLabel.text = @"    基本資料";
    }else{
        headerLabel.text = @"    聯絡資訊";
    }
    
    return headerLabel;
}
//底下切掉
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 150.0f;
    }else{
        return 0.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //下一步的btn
    if (section == 2) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        UIButton *addcharity = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [addcharity setTitle:@"下一步" forState:(UIControlStateNormal)];
        [addcharity addTarget:self action:@selector(goNext) forControlEvents:(UIControlEventTouchUpInside)];
        
        [addcharity setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        addcharity.frame = CGRectMake(14, 20, 292, 40);
        addcharity.backgroundColor = [UIColor grayColor];
        
        [addcharity.layer setCornerRadius:5.0f];
        [footView addSubview:addcharity];
        return footView;
    }
    else
        return nil;
}

-(void)goNext{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *requestIdentifier = @"RegisterCell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:requestIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:requestIdentifier];
        cell.textLabel.textColor = [UIColor purpleColor];
        cell.detailTextLabel.textColor =[UIColor brownColor];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font  = [UIFont fontWithName: @"STHeitiSC-Medium" size: 14.0];
        
        cell.detailTextLabel.font = [UIFont fontWithName: @"STHeitiSC-Medium" size: 14.0];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:
                    //cell.imageView.image = [UIImage imageNamed:@""];
                    cell.textLabel.text = @"Email";
                    [cell.contentView addSubview:email];
                    break;
                case 1:
                    cell.textLabel.text = @"密碼";
                    [cell.contentView addSubview:user_password];
                    break;
                case 2:
                    cell.textLabel.text = @"確認密碼";
                    [cell.contentView addSubview:user_confirm];
                    break;
                default:
                    break;
            }
        }
        break;
        case 1:{
            switch (indexPath.row) {
                case 0:
                    //cell.imageView.image = [UIImage imageNamed:@""];
                    cell.textLabel.text = @"中文姓";
                    [cell.contentView addSubview:last_name];
                    break;
                case 1:
                    cell.textLabel.text = @"中文名";
                    [cell.contentView addSubview:first_name];
                    break;
                case 2:
                    cell.textLabel.text = @"性別";
                    [cell.contentView addSubview:gender];
                    gender.placeholder = @"請選擇";
                    break;
                case 3:
                    cell.textLabel.text = @"出生日期";
                    [cell.contentView addSubview:birthday];
                    break;
                default:
                    break;
            }
        }
        break;
            
    }
    
    return cell;
}

-(void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

-(void)keyboardWasShow:(NSNotification *)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

-(void)keyboardWillBeHidden:(NSNotification *)aNotification{
//    NSDictionary *info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, -kbSize.height, 0.0);

    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"You pressed: %ld %ld", indexPath.section, indexPath.row);
    /*
     //不分section累加值
     NSInteger rowNumber = 0;
     
     for (NSInteger i = 0; i < indexPath.section; i++) {
     rowNumber += [self tableView:tableView numberOfRowsInSection:i];
     }
     
     rowNumber += indexPath.row;
     return rowNumber;
     NSLog(@"%ld",rowNumber);
     */
    
}


@end
