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
    
    init(queue: Deque<CallForHelp> = Deque<CallForHelp>(), completedQueue: Deque<CallForHelp> = Deque<CallForHelp>()) {
        self.load()
        
        if self.queue.isEmpty { self.queue = queue }
        
        if self.completedQueue.isEmpty {
            self.completedQueue = completedQueue
        }
    }
    
    deinit {
        self.save()
    }
    
    //MARK: - Functions
    func addCallForHelp(forStudentName name: String, forSubject subject: String, forSubjectArea subjectArea: SubjectAreaEnum, status: QueueStatusEnum = .pending) {
        let callForHelp = CallForHelp()
            .set(name: name)
            .set(subject: subject)
            .set(subjectArea: subjectArea)
            .set(status: status)
        
        self.queue.append(callForHelp)
        self.save()
    }
    
    func addEmergencyHelp(forStudentName name: String, forSubject subject: String, forSubjectArea subjectArea: SubjectAreaEnum, status: QueueStatusEnum = .pending) {
        let callForHelp = CallForHelp()
            .set(name: name)
            .set(subject: subject)
            .set(subjectArea: subjectArea)
            .set(status: status)
        
        self.queue.prepend(callForHelp)
        self.save()
    }
    
    @discardableResult
    func completeCallForHelp() -> Bool {
        let callForHelp = self.queue.popFirst()
        
        if let callForHelp = callForHelp {
            callForHelp.status = .done
            self.completedQueue.append(callForHelp)
            
            self.save()
            return true
        }
        
        return false
    }
    
    @discardableResult
    func completeCallForHelp(atIndex index: Int) -> Bool {
        let callForHelp = self.queue.remove(at: index)
        if !self.queue.contains(callForHelp) {
            callForHelp.status = .done
            self.completedQueue.append(callForHelp)
            
            self.save()
            return true
        }
        return false
    }
    
    @discardableResult
    func redoRequest(for callForHelp: CallForHelp) -> Bool {
        if self.completedQueue.contains(callForHelp) {
            self.completedQueue.removeAll(where: { $0 == callForHelp })
            callForHelp.status = .pending
            self.queue.append(callForHelp)
            
            self.save()
            return true
        }
        return false
    }
    
    func load() {
        if let pendingQueueData = UserDefaults.standard.object(forKey: UDKeys.pendingQueue.description) as? Data,
           let completedQueueData = UserDefaults.standard.object(forKey: UDKeys.completedQueue.description) as? Data,
           let pendingQueue = try? JSONDecoder().decode(Deque<CallForHelp>.self, from: pendingQueueData),
           let completedQueue = try? JSONDecoder().decode(Deque<CallForHelp>.self, from: completedQueueData) {
            self.queue = pendingQueue
            self.completedQueue = completedQueue
        }
    }
    
    func save() {
        if let encodedPendingQueue = try? JSONEncoder().encode(self.queue),
           let encodedCompletedQueue = try? JSONEncoder().encode(self.completedQueue) {
            UserDefaults.standard.set(encodedPendingQueue, forKey: UDKeys.pendingQueue.description)
            UserDefaults.standard.set(encodedCompletedQueue, forKey: UDKeys.completedQueue.description)
        }
    }
}


enum UDKeys: CustomStringConvertible {
    case pendingQueue
    case completedQueue
    
    var description: String {
        switch self {
            case .pendingQueue:
                return "pendingQueue"
            case .completedQueue:
                return "completedQueue"
        }
    }
}


