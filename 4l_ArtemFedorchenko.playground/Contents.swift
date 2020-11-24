import UIKit

enum EEngineState {
    case engineOn, engineOff
}

enum EWindowsState {
    case closedWindows, openedWindows
}

enum ETrunkState {
    case loadTrunk(Int), unloadTrunk(Int)
}

enum ETrailerState {
    case tailerAttached, trailerUncoupled
}

enum ESportActions {
    case setEnginState(EEngineState)
    case setWindowsState(EWindowsState)
}

enum ETruckActions {
    case setTrunkState(ETrunkState)
    case setTrailerState(ETrailerState)
}

class AnyCar {
    var model: String
    var manufacture: Int
    var hp: Int
    var weight: Int
    
    func sayAbout() {}
    
    init(model: String, manufacture: Int, hp: Int, weight: Int) {
        self.model = model
        self.manufacture = manufacture
        self.hp = hp
        self.weight = weight
    }
}

class SportCar: AnyCar {
    var engineState: EEngineState
    var windowsState: EWindowsState
    var raceStarted: Bool
    
    // ECarActions.ESportActions //MARK: - error: 'ESportActionsc' is not a member type of 'ECarActions' - баг свифта
    // Типы без дженериков переопределить не получится, отсюда и реальзация переопределения по типам выкенет ошибку мб подошло бы associatedtype
    // https://bugs.swift.org/browse/SR-6179
    
    func makeAction(action: ESportActions) {
        switch action {
            case .setEnginState(let state):
                switch state {
                case .engineOn:
                    self.engineState = .engineOn
                case .engineOff:
                    self.engineState = .engineOff
                }
        case .setWindowsState(let state):
            switch state {
            case .openedWindows:
                self.windowsState = .openedWindows
            case .closedWindows:
                self.windowsState = .closedWindows
            }
        }
    }
    
    override func sayAbout() {
        print("Модель: \(model)")
        print("Лошадинных сил: \(hp)")
        print("Масса: \(weight)")
        print("Дата производства: \(manufacture)")
        print("Статус двигателя: \(engineState == .engineOn ? "работает" : "заглушен")")
        print("Позиция окон: \(windowsState == .openedWindows ? "открыты" : "закрыты")")
    }
    
    init(model: String, manufacture: Int, hp: Int, weight: Int, raceStarted: Bool, engineState: EEngineState, windowsState: EWindowsState) {
        self.raceStarted = raceStarted
        self.engineState = engineState
        self.windowsState = windowsState
        super.init(model: model, manufacture: manufacture, hp: hp, weight: weight)
    }
    
}

class TruckCar: AnyCar {
    var loadTruckStarted: Bool
    var trailerState: ETrailerState
    var loaded: Int = 0
    var loadedTrunk: Int {
        get {
            return self.loaded
        }
    }
    
    func makeAction(action: ETruckActions) {
        switch action {
        case .setTrailerState(let state):
            switch state {
            case .tailerAttached:
                self.trailerState = .tailerAttached
            case .trailerUncoupled:
                self.trailerState = .trailerUncoupled
            }
        case .setTrunkState(let state):
            switch state {
            case .loadTrunk(let weight):
                self.loaded += weight
            case .unloadTrunk(let weight):
                self.loaded -= weight
            }
        }
    }
    
    override func sayAbout() {
        print("Модель: \(model)")
        print("Лошадинных сил: \(hp)")
        print("Масса: \(weight)")
        print("Дата производства: \(manufacture)")
        print("Статус прицепа: \(trailerState == .tailerAttached ? "присоединен" : "не присоединен")")
        print("Загружено: \(loadedTrunk) килограмм")
    }
    
    init(model: String, manufacture: Int, hp: Int, weight: Int, loadTruckStarted: Bool, trailerState: ETrailerState) {
        self.loadTruckStarted = loadTruckStarted
        self.trailerState = trailerState
        super.init(model: model, manufacture: manufacture, hp: hp, weight: weight)
    }
}


var ferrari = SportCar(model: "Ferrari 488 Pista", manufacture: 2019, hp: 780, weight: 1500, raceStarted: false, engineState: .engineOff, windowsState: .closedWindows)
var porshe = SportCar(model: "Porshe 911 Turbo S", manufacture: 2018, hp: 690, weight: 1680, raceStarted: true, engineState: .engineOn, windowsState: .closedWindows)

ferrari.makeAction(action: .setEnginState(.engineOn))
ferrari.raceStarted = true
ferrari.makeAction(action: .setWindowsState(.openedWindows))
ferrari.engineState
ferrari.windowsState


var volvo = TruckCar(model: "VOLVO FH 6X4", manufacture: 2018, hp: 465, weight: 8000, loadTruckStarted: true, trailerState: .trailerUncoupled)
var fred = TruckCar(model: "FREIGHTLINER FLA", manufacture: 2010, hp: 700, weight: 10000, loadTruckStarted: false, trailerState: .tailerAttached)

volvo.makeAction(action: .setTrunkState(.loadTrunk(1000)))
volvo.sayAbout()
volvo.makeAction(action: .setTrunkState(.unloadTrunk(400)))
volvo.makeAction(action: .setTrailerState(.tailerAttached))
print("\n")
volvo.sayAbout()
