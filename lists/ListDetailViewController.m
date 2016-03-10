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

@implementation ListDetailViewController {
    NSMutableDictionary *textViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize instance variables
    textViews = [[NSMutableDictionary alloc]init];
    
    // register handlers/observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    // set tableview properties
    self.tableView.allowsSelection = NO;
    
    [self configureDataSource];
    
    // configure toolbar
    self.navigationController.toolbarHidden = NO;
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc]initWithTitle:@"Add New Item" style:UIBarButtonItemStylePlain target:self action:@selector(addNewItem:)];
    [self setToolbarItems:[NSArray arrayWithObject:newButton]];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureDataSource {
    
    self.listItems = [NSMutableArray arrayWithObjects:@"Lorem lorem ipsum ipsum Lorem lorem ipsum ipsum", @"lorem lorem ipsum 2 ipsum two ipsum two", nil];
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

    return [self.listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"listItemCell";
    
    ListTextItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    [cell.editableText setText:[self.listItems objectAtIndex:indexPath.row]];
    
    [textViews setObject:cell.editableText forKey:indexPath];
    [cell.editableText setDelegate:self];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    //   [self performSegueWithIdentifier:@"ssegue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // check here, if it is one of the cells, that needs to be resized
    // to the size of the contained UITextView
    
    CGFloat height = [self textViewHeightForRowAtIndexPath:indexPath];
    return height;

}

- (CGFloat)textViewHeightForRowAtIndexPath: (NSIndexPath*)indexPath {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7

    UITextView *calculationView = [textViews objectForKey:indexPath];
    CGFloat textViewWidth = calculationView.frame.size.width;
    if (!calculationView.attributedText) {
        // This will be needed on load, when the text view is not inited yet
        
        calculationView = [[UITextView alloc] init];
        UIFont *font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightMedium];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                    forKey:NSFontAttributeName];
        
        // load text from data source and add attributes
        calculationView.attributedText = [[NSAttributedString alloc] initWithString:[self.listItems objectAtIndex:indexPath.row] attributes:attrsDictionary];
        
        textViewWidth = 245.0;
    }

    // sizeThatFits to return the appropriate size of textView
    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
    
    return size.height + 30; // Add 30 because it returns a smaller than expected height for some reason. TODO: figure out why.
}

- (void)textViewDidChange:(UITextView *)textView {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7
    
    [self.tableView beginUpdates]; // This will cause an animated update of
    [self.tableView endUpdates];   // the height of your UITableViewCell
    
    // If the UITextView is not automatically resized (e.g. through autolayout
    // constraints), resize it here
    
    [self scrollToCursorForTextView:textView]; // OPTIONAL: Follow cursor
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7
    [self scrollToCursorForTextView:textView];
}

- (void)scrollToCursorForTextView: (UITextView*)textView {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7
    CGRect cursorRect = [textView caretRectForPosition:textView.selectedTextRange.start];
    
    cursorRect = [self.tableView convertRect:cursorRect fromView:textView];
    
    if (![self rectVisible:cursorRect]) {
        cursorRect.size.height += 8; // To add some space underneath the cursor
        [self.tableView scrollRectToVisible:cursorRect animated:YES];
    }
}

- (BOOL)rectVisible: (CGRect)rect {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7
    CGRect visibleRect;
    visibleRect.origin = self.tableView.contentOffset;
    visibleRect.origin.y += self.tableView.contentInset.top;
    visibleRect.size = self.tableView.bounds.size;
    visibleRect.size.height -= self.tableView.contentInset.top + self.tableView.contentInset.bottom;
    
    return CGRectContainsRect(visibleRect, rect);
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.0, kbSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
    // snippet from http://stackoverflow.com/questions/18368567/uitableviewcell-with-uitextview-height-in-ios-7
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.35];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.0, 0.0, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
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
