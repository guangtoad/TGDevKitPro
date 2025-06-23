//
//  RowsViewController.m
//  TGCodeRows
//
//  Created by toad on 2022/05/07.
//

#import "RowsMainViewController.h"
#import "DragDropView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <PPCounter.h>
#import "TGFileList.h"
#import "EditInfoCell.h"
#define KEY_FILENAME @"fileName"
#define KEY_PATH @"filePath"
#define KEY_ROW @"row"
#define KEY_EDITROW @"editRow"

@interface RowsMainViewController ()<DragDropViewDelegate,NSTableViewDelegate,NSTableViewDataSource,NSTokenFieldDelegate>{
}

@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong) NSMutableArray *ignoreFolders;
@property (nonatomic,strong) NSMutableArray *files;
@property (nonatomic,strong) NSArray *fileTypes;
@property (nonatomic,strong) IBOutlet NSTableView *tableView;
@property (nonatomic,strong) IBOutlet NSTokenField *txtEditCodes;
@property (nonatomic,assign) BOOL abac;
@property (nonatomic,assign) NSUInteger macFileNumber;
@property (nonatomic,strong) NSArray *editCodes;

@property (weak) IBOutlet NSTextField *txtFilesNumber;
/** 参与计算的所有文件*/
@property (weak) IBOutlet NSTextField *txtTotalFiles;
/** 所有代码行数*/
@property (weak) IBOutlet NSTextField *txtTotalRows;
/** 所有代码行数*/
@property (weak) IBOutlet NSTextField *txtTotalEditRows;

@property (weak) IBOutlet NSTextField *txtqueue;

@property (weak) IBOutlet NSTextView *logView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSUInteger totalRow;
@property (nonatomic,assign) NSUInteger fileNumber;
@property (atomic,assign) NSUInteger TotalEditRow;

@property (nonatomic,strong) NSMutableString *outString;

@property (atomic,assign) NSUInteger readNumber;
@property (nonatomic,strong) NSMutableArray *fileList;

@property (weak) IBOutlet NSTableView *listHist;
@property (nonatomic,strong) NSMutableArray<NSDictionary *> *codesList;

@end

@implementation RowsMainViewController

- (NSMutableArray *)codesList{
    if (!_codesList) {
        _codesList = [[NSMutableArray alloc] init];
    }
    return _codesList;
}

- (NSMutableArray *)files{
    if (!_files) {
        _files = [[NSMutableArray alloc] init];
    }
    return _files;
}

- (void) reloadView{
    NSString *totalRowStr = [NSString stringWithFormat:@"代码行：%ld",self.totalRow];
    NSString *fileNumberStr = [NSString stringWithFormat:@"统计文件：%ld",self.fileNumber];
    NSString *editNumberStr = [NSString stringWithFormat:@"修改行：%ld",self.TotalEditRow];
    NSString *OperationStr = [NSString stringWithFormat:@"线程数：%ld/%ld",self.queue.operationCount,self.queue.maxConcurrentOperationCount];
    self.txtFilesNumber.stringValue = [NSString stringWithFormat:@"统计状态：%lu/%lu",self.macFileNumber - self.readNumber,(unsigned long)self.macFileNumber];
    [self.txtTotalRows setStringValue:totalRowStr];
    [self.txtTotalRows updateConstraints];
    [self.txtTotalFiles setStringValue:fileNumberStr];
    [self.txtTotalFiles updateConstraints];
    [self.txtTotalEditRows setStringValue:editNumberStr];
    [self.txtTotalEditRows updateConstraints];
    [self.txtqueue setStringValue:OperationStr];
    [self.tableView reloadData];
    [self.tableView scrollRowToVisible:self.tableView.numberOfRows-1];
}

- (void) addFile:(NSString *)path Row:(NSUInteger)row fileNumber:(NSUInteger)fileNumber totalEditRow:(NSUInteger)totalEditRow{
    @synchronized (self) {
        self.totalRow += row;
        self.fileNumber += fileNumber;
        self.TotalEditRow += totalEditRow;
        NSString *outS = [NSString stringWithFormat:@"\n%@,%ld,%ld",path,row,totalEditRow];
        [self.outString appendString:outS];
        [self.codesList addObject:@{
            KEY_FILENAME:[path lastPathComponent],
            KEY_PATH:path,
            KEY_ROW:@(row),
            KEY_EDITROW:@(totalEditRow)
        }];
    }
}
- (void) writeLogToView:(NSString *)message{
//    self.logView.string = [self.logView.string stringByAppendingString:[@"\n" stringByAppendingString:message]];
    
    if (![self.logView isEditable]) {
//        [self.logView scrollRangeToVisible:NSMakeRange(self.logView.string.length, 1)];
    }
}

- (void) writeLog:(NSString *)format, ...{
    va_list args;
    va_start(args, format);

    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self performSelectorOnMainThread:@selector(writeLogToView:) withObject:str waitUntilDone:false];
}

- (NSOperationQueue *)queue{
    if (!_queue) {
        @synchronized (self) {
            if (!_queue) {
                _queue = [[NSOperationQueue alloc] init];
                _queue.maxConcurrentOperationCount = [APPConfig getInstance].threadCount;
            }
        }
    }
    return _queue;
}

- (void) readRowWithFilePath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    // 标记是否为文件夹 <-> Tag is folder
    BOOL isFolder = NO;
    // 标记文件路径是否存在 <-> Tag file path exists
    
    BOOL isExist = [manager fileExistsAtPath:path isDirectory:&isFolder];
    if(!isExist) {
        [self writeLog:[NSString stringWithFormat:@"文件不存在：%@",path]];
        return;
    }
    if (isFolder) {
        NSArray *subFileArray = [manager contentsOfDirectoryAtPath:path error:nil];
        for (NSString *subFileName in subFileArray) {
            // 如果不是要过滤的文件夹
            if (![self.ignoreFolders containsObject:subFileName]) {
                NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(readRowWithFilePath:) object:[path stringByAppendingPathComponent:subFileName]];
                [self.queue addOperation:operation];
            }
        }
    }
    else {
        NSString *extension = [[path pathExtension] lowercaseString];
        APPConfig *config = [APPConfig getInstance];
        if (!config.checkFileTypes || ![config.checkFileTypes containsObject:extension]) {
            return;
        }
        NSError *error = NULL;
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (NULL != error) {
            [self writeLog:@"读取文件失败：%@",path];
            return;
        }
        [self writeLog:@"开始统计文件：%@",path];
        NSArray<NSString *> *array = [content componentsSeparatedByString:@"\n"];
        NSInteger lineNumber = array.count;
        if (config.ignoreBlanks) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^ *$"];
            lineNumber = 0;
            for (NSString *code in array) {
                if ([pred evaluateWithObject:code] == NO) {
                    lineNumber += 1;
                }
            }
        }
        NSArray *eidtCodes = self.editCodes;
        NSUInteger editRows = 0;
        for (NSString *editCode in eidtCodes) {
            NSString *regularStr = [[self regularTemplate] stringByReplacingOccurrencesOfString:@"<$EDITCODE$>" withString:editCode];
            NSError *error = NULL;
            NSRegularExpression * regular = [NSRegularExpression regularExpressionWithPattern:regularStr options:NSRegularExpressionCaseInsensitive error:&error];
            if (NULL != error) {
                continue;
            }
            NSArray *matches = [regular matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, [content length])];
            for (NSTextCheckingResult *match in matches){
                NSString *substringForMatch = [content substringWithRange:match.range];
                NSArray<NSString *> * subArray = [substringForMatch componentsSeparatedByString:@"\n"];
                if (config.ignoreBlanks) {
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^ *$"];
                    for (NSString *editCode in subArray) {
                        if ([pred evaluateWithObject:editCode] == NO) {
                            editRows += 1;
                        }
                    }
                }
                else {
                    editRows += subArray.count;
                }
            }
        }
        [self writeLog:@"统计文件：%@\t 行：%ld",path,lineNumber];
        [self addFile:path Row:lineNumber fileNumber:1 totalEditRow:editRows];
        
        [self performSelectorOnMainThread:@selector(coutRowFiles) withObject:NULL waitUntilDone:false];
//        [self addRow:lineNumber];
    }
}

- (void) dorfile:(NSString *)path{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(readRowWithFilePath:) object:path];
    [self.queue addOperation:operation];
}

- (IBAction)clickStop:(id)sender{
    [self.queue cancelAllOperations];
}

- (void) viewWillAppear{
    [super viewWillAppear];
}

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.txtEditCodes.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickCopyRows:) name:@"CopyRows" object:NULL];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(reloadSettingNotification:) name:kReloadSettingNotification object:NULL];
    
    [notificationCenter addObserver:self selector:@selector(saveAsNotification:) name:@"SaveAsCSV" object:NULL];
    
    APPConfig *config = [APPConfig getInstance];
    self.txtEditCodes.objectValue = config.editCodes;
    
    @weakify(self);
    [RACObserve(self, totalRow) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self performSelectorOnMainThread:@selector(reloadView) withObject:NULL waitUntilDone:false];
    }];
    [RACObserve(self.queue, operationCount) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self performSelectorOnMainThread:@selector(reloadView) withObject:NULL waitUntilDone:false];
    }];
    
}

- (void) dealloc{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

- (void) cancelAndClear{
    self.outString = [NSMutableString stringWithString:@"文件,代码行,修改行"];
    [self.queue cancelAllOperations];
    self.totalRow = 0;
    self.fileNumber = 0;
    self.TotalEditRow = 0;
    [self.codesList removeAllObjects];
    [self.files removeAllObjects];
    [self reloadView];
}

- (void) coutRowFiles{
    @synchronized (self) {
        NSLog(@"运行状态 NO:%ld   %ld/%ld",self.readNumber,self.queue.operationCount,self.queue.maxConcurrentOperationCount);
        for (NSUInteger i = self.queue.operationCount; i < self.queue.maxConcurrentOperationCount && self.readNumber < self.files.count; i++) {
            NSString *path = self.files[self.readNumber];
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(readRowWithFilePath:) object:path];
            [self.queue addOperation:operation];
            self.readNumber = self.readNumber + 1;
        }
        NSLog(@"运行状态 NO:%ld   %ld/%ld",self.readNumber,self.queue.operationCount,self.queue.maxConcurrentOperationCount);
    }
}

- (void) readFileList:(NSArray *)list{
//    NSInvocationOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSUInteger i = 0;
//        while (i < list.count) {
//            if (self.queue.operationCount < self.queue.maxConcurrentOperationCount) {
//                NSString *path = list[i];
//                NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(readRowWithFilePath:) object:path];
//                [self.queue addOperation:operation];
//            }
//            i++;
//        }
//    }];
//    [operation start];
}

- (BOOL) dragDropFilePathList:(nonnull NSArray<NSString *> *)filePathList {
    [self cancelAndClear];
    APPConfig *config = [APPConfig getInstance];
    self.queue.maxConcurrentOperationCount = config.threadCount;
    
    NSMutableArray *fileList = [[NSMutableArray alloc] init];
    for (NSString *path in filePathList) {
        TGFileList *tgFile = [[TGFileList alloc] init];
        NSArray *array = [tgFile arrayWithPath:path];
        if (array.count > 0) {
            [fileList addObjectsFromArray:array];
        }
        self.macFileNumber = array.count;
        self.txtFilesNumber.stringValue = [NSString stringWithFormat:@"统计状态：%lu/%lu",self.readNumber,(unsigned long)self.macFileNumber];
//        [self dorfile:path];
    }
    self.readNumber = 0;
    [self.files removeAllObjects];
    [self.files addObjectsFromArray:fileList];
    [self coutRowFiles];
    NSLog(@"array:%@",fileList);
    return true;
}

- (void) reloadSettingNotification:(NSNotification *)notification{
    self.queue.maxConcurrentOperationCount = [APPConfig getInstance].threadCount;
}

- (NSString *) regularTemplate{
    return @"[ ]*// <$EDITCODE$> BEGIN(([\\s\\S])*?) <$EDITCODE$> END";
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
    self.editCodes = self.txtEditCodes.objectValue;
}


- (IBAction) clickCopyRows:(id)sender{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@\n统计修改Code：%@",self.txtTotalFiles.stringValue,self.txtTotalRows.stringValue,self.txtTotalEditRows.stringValue,self.txtEditCodes.stringValue];
    [pasteboard clearContents];
    [pasteboard writeObjects:@[string]];
}

- (void) saveAsNotification:(NSNotification *)notification{
    if (NULL != notification && NULL != notification.object && [notification.object isKindOfClass:[NSURL class]]) {
        NSError *error;
        if (![self.outString writeToURL:notification.object atomically:true encoding:NSUTF8StringEncoding error:&error]) {
        };
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.codesList.count;
}
- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    NSTableRowView * rowView = [tableView rowViewAtRow:row makeIfNecessary:true];
    
    return rowView;
}
- (void) tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
//    tableColumn.title
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    if ([@"line" isEqualToString:tableColumn.identifier]) {
        return @(row + 1);
    }
    NSDictionary *dict = self.codesList[row];
    if(NULL != tableColumn) {
        return dict[tableColumn.identifier];
    }
    return NULL;
}
- (BOOL)tableView:(NSTableView *)tableView shouldShowCellExpansionForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
    return true;
}
//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//
//    EditInfoCell *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
//    NSDictionary *dict = self.codesList[row];
//    NSString *str = dict[KEY_PATH];
//    cell.titleTxt.stringValue = [str lastPathComponent];
//    cell.infoTxt.stringValue = [NSString stringWithFormat:@"Row：%@,Edit Row：%@",dict[KEY_ROW],dict[KEY_EDITROW]];
////    cell.infoTxt.stringValue =
////    cell.infoTxt.stringValue = self.codesList[row];
////    [cell fillCellWithModel:self.dataSource[row] index:row+1];
////    cell.delegate = self;
//    return cell;
//}

@end
