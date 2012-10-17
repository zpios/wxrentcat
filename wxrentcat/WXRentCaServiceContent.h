//
//  WXRentCaServiceContent.h
//  wxrentcat
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WXRentCaServiceContent : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
}

- (id)initWithServiceEntryInfo:(NSDictionary *)entryInfo andEntryID:(NSInteger)entryId;

@end
