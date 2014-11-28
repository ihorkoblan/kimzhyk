//
//  KZSettings.h
//  Synthezier
//
//  Created by ihor on 07.07.14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KZIntrumentTypePiano,
    KZIntrumentTypeAccordeon,
    KZIntrumentTypeChurchOrgan,
    KZIntrumentTypeAccousticGuitar,
    KZIntrumentTypeElectricGuitar,
    KZIntrumentTypeFlute,
    KZIntrumentTypeTennorSax,
    KZIntrumentTypeCello,
    KZIntrumentTypeViolin,
    KZIntrumentTypeTrumpet,
    KZIntrumentTypeString
} KZIntrumentType;

@interface KZSettings : NSObject

@property (nonatomic, assign) KZIntrumentType instrumentType;
@property (nonatomic, assign) NSUInteger volume;
@property (nonatomic, assign) NSInteger transpose;

+ (KZSettings *)settings;

@end
