//
//  AdvancedCountdownTimer.swift
//  Loans-164
//
//  Created by Siarhei Lukyanau on 23.11.25.
//

import Foundation

public protocol CountdownDelegate: AnyObject {
    func countdownDidUpdate(minutesLeft: Int)
    func countdownDidFinish()
}

public class AdvancedCountdownTimer {
    private var timer: Timer?
    private var targetDate: Date
    public weak var delegate: CountdownDelegate?
    
    public init(targetDate: Date) {
        self.targetDate = targetDate
    }
    
    private func minutesUntil() -> Int {
        let timeInterval = targetDate.timeIntervalSince(Date())
        let minutes = Int(ceil(timeInterval / 60))
        return max(minutes, 0)
    }
    
    public func start(interval: TimeInterval = 60.0) {
        // Первое обновление
        let initialMinutes = minutesUntil()
        delegate?.countdownDidUpdate(minutesLeft: initialMinutes)
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let minutesLeft = self.minutesUntil()
            self.delegate?.countdownDidUpdate(minutesLeft: minutesLeft)
            
            if minutesLeft == 0 {
                self.delegate?.countdownDidFinish()
                self.stop()
            }
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}

// Использование с делегатом
public class ViewController: CountdownDelegate {
    private var countdownTimer: AdvancedCountdownTimer?
    
    public func startCountdown() {
        let targetDate = Date(timeIntervalSinceNow: 3600) // Через 1 час
        countdownTimer = AdvancedCountdownTimer(targetDate: targetDate)
        countdownTimer?.delegate = self
        countdownTimer?.start()
    }
    
    public func countdownDidUpdate(minutesLeft: Int) {
        print("Минут до события: \(minutesLeft)")
    }
    
    public func countdownDidFinish() {
        print("Обратный отсчет завершен!")
    }
}
