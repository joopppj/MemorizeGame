//
//  Array+Only.swift
//  Memorize
//
//  Created by キラ on 2021/02/05.
//  Copyright © 2021 Kira. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
