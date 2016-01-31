//
//  UIViewController+Navigation.m
//  EverPobreCurso
//
//  Created by Izabela on 25/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)
-(UINavigationController *) wrappedInNavigation{
    //Creamos navigation Controller
    UINavigationController *nav = [UINavigationController new];
    [nav pushViewController:self animated:NO];
    
    return nav;
    
}

@end
