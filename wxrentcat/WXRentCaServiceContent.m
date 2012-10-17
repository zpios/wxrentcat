//
//  WXRentCaServiceContent.m
//  wxrentcat
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WXRentCaServiceContent.h"

@interface WXRentCaServiceContent ()
@property (nonatomic, retain) NSString *mName;
@property (nonatomic, retain) NSString *mUrl;
@property (nonatomic, assign) NSInteger mId;
@property (nonatomic, retain) UITableView *mTableView;
@property (nonatomic, retain) NSArray *mResponseItems;
@end

@implementation WXRentCaServiceContent
@synthesize mName;
@synthesize mUrl;
@synthesize mId;
@synthesize mTableView;
@synthesize mResponseItems;



- (void)recivedResponse:(NSNotification *)notification
{
    id responseData = [notification object];
    if (responseData != nil && [responseData isKindOfClass:[NSDictionary class]]) {
        BOOL isOK = [[responseData valueForKey:@"result"] boolValue];
        if (isOK == YES) {
            // load data
            id infos = [responseData valueForKey:@"responseINFO"];
            if (infos != 0 && [infos isKindOfClass:[NSArray class]]) {
                NSLog(@"infos:%@", infos);
                self.mResponseItems = [NSArray arrayWithArray:infos];
                [self.mTableView reloadData];
                [self.mTableView setHidden:NO];
                return;
            }
            
        }
    }
    

    NSLog(@"find error response!!\n%@\n\n", responseData);
    [self.mTableView setHidden:YES];

}

- (id)initWithServiceEntryInfo:(NSDictionary *)entryInfo andEntryID:(NSInteger)entryId
{
    if (self = [self init]) {
        // Custom initialization
        self.mName = [entryInfo objectForKey:@"Description"];
        self.mUrl = [entryInfo objectForKey:@"Url"];
        self.mId = entryId;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"start to load while show");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recivedResponse:) name:kCWXNotificationWebServiceResponse object:nil];
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"type", self.mUrl,@"requstURL",
                              [NSNumber numberWithInteger:self.mId], @"requestID", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCWXNotificationWebServiceRequest object:self
                                                      userInfo:infoDict];
    
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog(@"quit loading while show");
//    [[NSNotificationCenter defaultCenter]  removeObserver:self];
//    NSDictionary *reqDict = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"type",
//                              [NSNumber numberWithInteger:self.mId], @"requestID", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kCWXNotificationWebServiceRequest object:self
//                                                      userInfo:reqDict];
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGBA(252.0, 248.0, 240.0,1.0);
    self.title = self.mName;
    self.mTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,320, 416) style:UITableViewStyleGrouped]  autorelease];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.allowsSelection = NO;
    [self.view addSubview:self.mTableView];
    
//    
//    self.mResponseItems = [NSArray arrayWithObjects:
//        [NSDictionary dictionaryWithObjectsAndKeys:@"wejkfd",@"name", @"jdlkfjdfdalkfjfdlkafjdklfjdaslkfjdklfjdsl;fjdf;jdklfjdfkdjkfdjf;ldjflkdjfd;lfjeiojfdvm.dcdmkldmfdlkfadl;kfdkl;", @"desciption", nil], 
//        [NSDictionary dictionaryWithObjectsAndKeys:@"hometimes",@"name", @"22eddafdfdfjadlkfjdlejeeeek;", @"desciption", nil], 
//                           nil];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.mName = nil;
    self.mUrl = nil;
    self.mTableView = nil;
    self.mResponseItems = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.mResponseItems count] > 0) {
        return 1;
    }
    
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.mResponseItems count];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *itemInfo = [self.mResponseItems objectAtIndex:indexPath.row];
	
	NSString *title =  [[itemInfo allKeys] lastObject]; //[itemInfo objectForKey:@"name"];
	NSString *description = [itemInfo objectForKey:title];

    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:description];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
   
    CGSize descrptSize = [description sizeWithFont:[cell.detailTextLabel font] 
                                 constrainedToSize:CGSizeMake(280, 99999) 
                                     lineBreakMode:UILineBreakModeCharacterWrap];
    
    cell.detailTextLabel.numberOfLines = (int)(descrptSize.height / 15 + 0.5);

    cell.backgroundColor = RGBA(220.0f, 180.0f, 165.0f, 0.5f);
}

// disable this method to get static height = better performance
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{  
	NSDictionary *itemInfo = [self.mResponseItems objectAtIndex:indexPath.row];
    NSString *title =  [[itemInfo allKeys] lastObject]; //[itemInfo objectForKey:@"name"];
	NSString *description = [itemInfo objectForKey:title];

//	NSString *description = [itemInfo objectForKey:@"desciption"];
    
    CGSize descrptSize = [description sizeWithFont:[UIFont systemFontOfSize:15] 
                                          constrainedToSize:CGSizeMake(280, 99999) 
                                     lineBreakMode:UILineBreakModeCharacterWrap];    
    
	return 35 + descrptSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    [self configureCell:cell forIndexPath:indexPath];
    
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSDictionary *serviceInfo = [self.entries objectAtIndex:indexPath.row];
//    if ([[serviceInfo valueForKey:@"Url"] length] > 0) {
//        WXRentCaServiceContent *serviceContent = [[[WXRentCaServiceContent alloc] initWithServiceEntryInfo:serviceInfo] autorelease];
//        [self.navigationController pushViewController:serviceContent animated:YES];
//    }
    
    
}

@end
