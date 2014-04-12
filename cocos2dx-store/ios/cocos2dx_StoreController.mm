/*
 * Copyright (C) 2012 Soomla Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "cocos2dx_StoreController.h"
#import "StoreController.h"
#import "exceptions/VirtualItemNotFoundException.h"
#import "exceptions/InsufficientFundsException.h"
#import "exceptions/NotEnoughGoodsException.h"
//#import "MyStoreAssets.h"
#import "cocos2dx_EventDispatcher.h"
#import "domain/PurchasableVirtualItem.h"
#import "data/StoreInfo.h"
#import "PurchaseTypes/PurchaseWithMarket.h"
#import "domain/AppStoreItem.h"

/**
 * This implementation is used to let cocos2dx functions perform actions on StoreController.
 *
 * You can see the documentation of every function in StoreController.
 */


void cocos2dx_StoreController::storeOpening() {
    [[StoreController getInstance] storeOpening];
}

void cocos2dx_StoreController::storeClosing() {
    [[StoreController getInstance] storeClosing];
}

void cocos2dx_StoreController::initialize(string customSecret) {
    /**
     * We initialize StoreController when the application loads !
     *
     */
	Class MyStoreAssets = NSClassFromString(@"MyStoreAssets");
	if (MyStoreAssets) {
		NSString * str = [[NSString alloc] initWithBytes:customSecret.c_str() length:strlen(customSecret.c_str()) encoding:NSUTF8StringEncoding];
		[[StoreController getInstance] initializeWithStoreAssets:[[MyStoreAssets alloc] init] andCustomSecret:str];
		
		[cocos2dx_EventDispatcher initialize];
	}
}

void cocos2dx_StoreController::buyMarketItem(string productId) throw(cocos2dx_VirtualItemNotFoundException&) {
    @try {
        NSString * str = [[NSString alloc] initWithBytes:productId.c_str() length:strlen(productId.c_str()) encoding:NSUTF8StringEncoding];
        PurchasableVirtualItem* pvi = [[StoreInfo getInstance] purchasableItemWithProductId:str];
        if ([pvi.purchaseType isKindOfClass:[PurchaseWithMarket class]]) {
            [[StoreController getInstance] buyInAppStoreWithAppStoreItem:((PurchaseWithMarket*)pvi.purchaseType).appStoreItem];
        } else {
            throw cocos2dx_VirtualItemNotFoundException();
        }
    }
    @catch (VirtualItemNotFoundException *exception) {
        throw cocos2dx_VirtualItemNotFoundException();
    }
}

void cocos2dx_StoreController::restoreTransactions() {
    @try {
        [[StoreController getInstance] restoreTransactions];
    }
    @catch (VirtualItemNotFoundException *exception) {
        throw cocos2dx_VirtualItemNotFoundException();
    }
}



