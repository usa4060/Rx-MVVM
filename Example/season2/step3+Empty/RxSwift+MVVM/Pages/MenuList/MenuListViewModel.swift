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
import RxCocoa


class MenuListViewModel{
    
    var menusObservable = BehaviorSubject<[Menu]>(value: [])
    
    
    lazy var itemsCount = menusObservable
        .map{$0.map{$0.count}.reduce(0,+)}
    lazy var totalPrice = menusObservable
        .map{$0.map{$0.price * $0.count}.reduce(0,+)}
    
    init(){
        APIService.fetchAllMenusRx()
            .map{ data in
                struct Response : Decodable{
                    let menus : [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                
                return response.menus
            }
            .map{menuItems -> [Menu] in
                var menus : [Menu] = []
                menuItems.enumerated().forEach({ index, item in
                    let menu = Menu.fromMenuItems(id: index, item: item)
                    menus.append(menu)
                })
                return menus
            }
            .take(1)
            .bind(to: menusObservable)
    }
    
    func clearAllItemSelections(){
        menusObservable
            .map {
                $0.map{ m in
                    Menu(id: m.id, name: m.name, price: m.price, count: 0)
                }
            }
            .take(1)
            .subscribe (onNext:{
                self.menusObservable.onNext($0)
            })
    }
    
    func onOrdered(){
        menusObservable
            .onNext([Menu(id: 0, name: "시리", price: 1000, count: Int.random(in: 0...4)),
                     Menu(id: 1, name: "시리", price: 1000, count: Int.random(in: 0...4)),
                     Menu(id: 2, name: "시리", price: 1000, count: Int.random(in: 0...4))
                    ])
    }
    
    func changeCount(item : Menu, increase : Int){
        menusObservable
            .map { items in
                items.map{ m in
                    if m.id == item.id{
                        return Menu(id: m.id, name: m.name, price: m.price, count: max(m.count + increase,0))
                    }else{
                        return Menu(id: m.id, name: m.name, price: m.price, count: m.count)
                    }
                }
            }
            .take(1)
            .subscribe (onNext:{
                self.menusObservable.onNext($0)
            })
        
    }
    
}

