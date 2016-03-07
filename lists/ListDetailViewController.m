//
//  ListDetailViewController.m
//  lists
//
//  Created by Sid Jha on 2016-02-24.
//  Copyright © 2016 Mesh8. All rights reserved.
//

#import "ListDetailViewController.h"
#import "ListTextItemTableViewCell.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.allowsSelection = NO;
    self.navigationController.toolbarHidden = NO;
    
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc]initWithTitle:@"Add New Item" style:UIBarButtonItemStylePlain target:self action:@selector(addNewItem:)];
    
    [self setToolbarItems:[NSArray arrayWithObject:newButton]];
    
    [self configureDataSource];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureDataSource {
    
    self.listItems = [NSMutableArray arrayWithObjects:@"Lorem lorem ipsum ipsum Lorem lorem ipsum ipsum", @"lorem lorem ipsum 2 ipsum two ipsum two", @"lorem lorem ipsum 3 ipsum three ipsum three", @"lorem lorem ipsum 4 ipsum four ipsum four", nil];
}

- (void) addNewItem:(id)sender {
    [self.listItems addObject:[NSString stringWithFormat:@"Hello"]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.listItems.count - 1 inSection:0];
    [self.tableView
     insertRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return [self.listItems count] + 1;
    return [self.listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"listItemCell";
    
    ListTextItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    //if (indexPath.row == [self.listItems count]) {
    //    [cell.editableText setText:@"Add new item"];
   // } else {
    [cell.editableText setText:[self.listItems objectAtIndex:indexPath.row]];
   // }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    //   [self performSegueWithIdentifier:@"ssegue" sender:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
