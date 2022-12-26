//
//  QueueStatusEnum.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import Foundation

enum QueueStatusEnum: CustomStringConvertible {
    case all
    case done
    case pending
    
    var description: String {
        switch self {
            case .all:
                return "All"
            case .done:
                return "Done"
            case .pending:
                return "Pending"
        }
    }
}
