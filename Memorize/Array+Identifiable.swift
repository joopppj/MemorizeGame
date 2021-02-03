//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by キラ on 2021/02/04.
//  Copyright © 2021 Kira. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable{ // add function to Array
    func firstIndex(matching: Element) ->  Int {
        for index in 0..<self.count{
            if self[index].id == matching.id{
                return index
            }
        }
        return 0 // TODO
    }
}
