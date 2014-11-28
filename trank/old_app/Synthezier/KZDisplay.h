//
//  KZDisplay.h
//  Synthezier
//
//  Created by ihor on 08.07.14.
//
//

#import <UIKit/UIKit.h>

@interface KZDisplay : UIView {
    UILabel *_volumeValueLabel;
    UILabel *_transposeValueLabel;
    UILabel *_noteValueLabel;
}

@property (nonatomic, assign) NSUInteger volume;
@property (nonatomic, assign) NSInteger transpose;
@property (nonatomic, strong) NSString *note;

@end
