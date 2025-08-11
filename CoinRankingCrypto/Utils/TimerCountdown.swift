//
//  TimerCountdown.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//



import RxCocoa

class TimerCountdown {
    private var timer = Timer()
    private var seconds: Int
    private var currentSeconds: Int
    let timerUpdate = PublishRelay<Int>()

    init(_ seconds: Int) {
        self.seconds = seconds
        currentSeconds = seconds
    }

    func updateSeconds(_ seconds: Int) {
        self.seconds = seconds
        currentSeconds = seconds
    }

    func start() {
        timerUpdate.accept(seconds)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    func reset() {
        currentSeconds = seconds
        start()
    }

    func stop() {
        timer.invalidate()
    }

    @objc private func updateTimer() {
        currentSeconds = currentSeconds - 1
        if currentSeconds < 1 {
            timer.invalidate()
        }
        timerUpdate.accept(currentSeconds)
    }
}
