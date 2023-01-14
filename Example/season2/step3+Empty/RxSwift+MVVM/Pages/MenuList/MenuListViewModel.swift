//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by admin on 2023/01/29.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift


class MenuListViewModel{
    var menus : [Menu] = [
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김1", price: 100, count: 0)
    ]
    
    var itemsCount : Int = 5
    var totalPrice : Observable<Int> = Observable.just(10_000)
}
