//
//  SortType.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/30.
//

enum SortType: Int, CaseIterable, CustomStringConvertible {
    case desc
    case asc
    
    var description: String {
        switch self {
        case .desc:
            return "최신순"
        case .asc:
            return "오래된순"
        }
    }
}
