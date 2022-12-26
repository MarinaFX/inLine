//
//  ViewModel.swift
//  inLine
//
//  Created by Marina De Pazzi on 26/12/22.
//

import Foundation
import DequeModule

class ViewModel: ObservableObject {
    @Published var queue = Deque<CallForHelp>()
    @Published var completedQueue = Deque<CallForHelp>()
    
    //MARK: - Functions
    func addCallForHelp(forStudentName name: String, forSubject subject: String, forSubjectArea subjectArea: SubjectAreaEnum, status: QueueStatusEnum = .pending) {
        let callForHelp = CallForHelp()
            .withName(name)
            .withSubject(subject)
            .withSubjectArea(subjectArea)
            .withStatus(status)
        
        self.queue.append(callForHelp)
    }
    
    func addEmergencyHelp(forStudentName name: String, forSubject subject: String, forSubjectArea subjectArea: SubjectAreaEnum, status: QueueStatusEnum = .pending) {
        let callForHelp = CallForHelp()
            .withName(name)
            .withSubject(subject)
            .withSubjectArea(subjectArea)
            .withStatus(status)
        
        self.queue.prepend(callForHelp)
    }
    
    @discardableResult
    func completeCallForHelp() -> Bool {
        let callForHelp = self.queue.popFirst()
        
        if let callForHelp = callForHelp {
            self.completedQueue.append(callForHelp)
            return true
        }
        
        return false
    }
}
