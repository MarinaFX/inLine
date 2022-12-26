//
//  SubjectAreaEnum.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import Foundation

enum SubjectAreaEnum: CustomStringConvertible, Codable {
    case design
    case development
    
    var description: String {
        switch self {
            case .design:
                return "Design"
            case .development:
                return "Development"
        }
    }
}
