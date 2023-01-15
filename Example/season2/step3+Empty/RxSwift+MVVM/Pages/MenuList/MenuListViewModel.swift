//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by admin on 2023/01/29.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift


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
    
    var menusObservable = PublishSubject<[Menu]>()
    
    lazy var itemsCount = menusObservable
        .map{
            $0.map{$0.count}.reduce(0,+)
        }
    lazy var totalPrice = menusObservable
        .map{
            $0.map{$0.price * $0.count}.reduce(0,+)
        }
    
    init(){
        var menus : [Menu] = [
            Menu(name: "튀김1", price: 100, count: 0),
            Menu(name: "튀김1", price: 100, count: 0),
            Menu(name: "튀김1", price: 100, count: 0),
            Menu(name: "튀김1", price: 100, count: 0)
        ]
        menusObservable.onNext(menus)
    }
    
}

