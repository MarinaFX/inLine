//
//  CallForHelp.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import Foundation

class CallForHelp: Hashable, Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case subject
        case subjectArea
        case status
    }
    
    private var id: String = UUID().uuidString
    
    var name: String = ""
    var subject: String = ""
    var subjectArea: SubjectAreaEnum = .development
    var status: QueueStatusEnum = .pending
    
    //MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.subject)
        hasher.combine(self.subjectArea)
    }
    
    //MARK: - Functions
    func withName(_ name: String) -> CallForHelp {
        self.name = name
        return self
    }
    
    func withSubject(_ subject: String) -> CallForHelp {
        self.subject = subject
        return self
    }
    
    func withSubjectArea(_ subjectArea: SubjectAreaEnum) -> CallForHelp {
        self.subjectArea = subjectArea
        return self
    }
    
    func withStatus(_ status: QueueStatusEnum) -> CallForHelp {
        self.status = status
        return self
    }
    
    //MARK: - Static Functions
    static func == (lhs: CallForHelp, rhs: CallForHelp) -> Bool {
        return lhs.id == rhs.id
    }
}
