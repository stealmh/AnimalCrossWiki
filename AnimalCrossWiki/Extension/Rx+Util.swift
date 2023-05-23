//
//  Rx+Util.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/05/23.
//

import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func add(element: Element.Element) {
        var array = self.value
        array.append(element)
        self.accept(array)
    }
}
