import UIKit


//MARK: - ENums

enum EEngineState {
    case engineOff, engineOn
}

enum EWindowsState {
    case closedWindows, openedWindows
}

enum ETrunkState {
    case loadTrunk(Int), unloadTrunk(Int)
}

enum ECarActions {
    case setTrunkState(ETrunkState)
    case setEnginState(EEngineState)
    case setWindowsState(EWindowsState)
}


//MARK: - Protocol

protocol AnyCar {
    var model: String {get set}
    var manufacture: Int {get set}
    var engineState: EEngineState {get set}
    var windowsState: EWindowsState {get set}
    var trunk: Int {get set}
    var loadedTrunk: Int {get set}
    var hp: Int {get set}
    var weight: Int {get set}
    
    mutating func makeAction(action: ECarActions)
    func sayAbout()
    
    init(model: String, manufacture: Int, engineState: EEngineState, windowsState: EWindowsState, trunk: Int, loadedTrunk: Int, hp: Int, weight: Int)
}


//MARK: - Main Class

class Car: AnyCar {
    var model: String
    var manufacture: Int
    var engineState: EEngineState
    var windowsState: EWindowsState
    var trunk: Int
    var loadedTrunk: Int
    var hp: Int
    var weight: Int
    
    func makeAction(action: ECarActions) {
        switch action {
        case .setEnginState(let state):
            switch state {
            case .engineOn:
                engineState = .engineOn
            case .engineOff:
                engineState = .engineOff
            }
        case .setTrunkState(let state):
            switch state {
            case .loadTrunk(let litres):
                if (litres <= trunk && (litres + loadedTrunk <= trunk)) {
                    loadedTrunk += litres
                    print("Загружено \(litres) литров")
                } else {
                    print("Не влазит, можно положить еще \(trunk - loadedTrunk) литров")
                }
            case .unloadTrunk(let litres):
                if (litres <= loadedTrunk) {
                    loadedTrunk -= litres
                    print("Выгружено \(litres) литров, осталось \(loadedTrunk)")
                } else {
                    print("Ну мы же не волшебники")
                }
            }
        case .setWindowsState(let state):
            switch state {
            case .openedWindows:
                windowsState = .openedWindows
            case .closedWindows:
                windowsState = .closedWindows
            }
            
        }
    }
    
    func sayAbout() {
        print("Модель: \(model)")
        print("Лошадинных сил: \(hp)")
        print("Масса: \(weight)")
        print("Дата производства: \(manufacture)")
        print("Статус двигателя: \(engineState == .engineOn ? "работает" : "заглушен")")
        print("Позиция окон: \(windowsState == .openedWindows ? "открыты" : "закрыты")")
        print("Объем багажника: \(trunk) литров")
        print("В багажнике: \(loadedTrunk) литров")
    }
    
    required init(model: String, manufacture: Int, engineState: EEngineState, windowsState: EWindowsState, trunk: Int, loadedTrunk: Int, hp: Int, weight: Int) {
        self.model = model
        self.manufacture = manufacture
        self.engineState = engineState
        self.windowsState = windowsState
        self.trunk = trunk
        self.loadedTrunk = loadedTrunk
        self.hp = hp
        self.weight = weight
    }
}


//MARK: - Sport Car Class

class Sport: Car {
    required init(model: String, manufacture: Int, engineState: EEngineState, windowsState: EWindowsState, trunk: Int, loadedTrunk: Int, hp: Int, weight: Int) {
        super.init(model: model, manufacture: manufacture, engineState: engineState, windowsState: windowsState, trunk: trunk, loadedTrunk: loadedTrunk, hp: hp, weight: weight)
    }
}


//MARK: - Cargo Car Class

class Truck: Car  {
    override func sayAbout() {
        print("Модель: \(model)")
        print("Лошадинных сил: \(hp)")
        print("Масса: \(weight)")
        print("Дата производства: \(manufacture)")
        print("Статус двигателя: \(engineState == .engineOn ? "работает" : "заглушен")")
        print("Позиция окон: \(windowsState == .openedWindows ? "открыты" : "закрыты")")
        print("Объем фуры: \(trunk) килограмм")
        print("Загружено: \(loadedTrunk) килограмм")
    }

    required init(model: String, manufacture: Int, engineState: EEngineState, windowsState: EWindowsState, trunk: Int, loadedTrunk: Int, hp: Int, weight: Int) {
        super.init(model: model, manufacture: manufacture, engineState: engineState, windowsState: windowsState, trunk: trunk, loadedTrunk: loadedTrunk, hp: hp, weight: weight)
    }
}

//MARK: - Actions

var porshe = Sport(model: "Porshe 911", manufacture: 2019, engineState: .engineOff, windowsState: .openedWindows, trunk: 150, loadedTrunk: 0, hp: 680, weight: 1560)
var ferrari = Sport(model: "Ferrari Berlinetta", manufacture: 2018, engineState: .engineOn, windowsState: .openedWindows, trunk: 100, loadedTrunk: 20, hp: 730, weight: 1500)

print("\n")
print(porshe)
porshe.makeAction(action: .setEnginState(.engineOn))
porshe.makeAction(action: .setTrunkState(.loadTrunk(90)))
porshe.makeAction(action: .setWindowsState(.openedWindows))
porshe.makeAction(action: .setTrunkState(.unloadTrunk(60)))
print("Result =====>\n")
porshe.sayAbout()

print("\n")
print(ferrari)
ferrari.makeAction(action: .setEnginState(.engineOn))
ferrari.makeAction(action: .setTrunkState(.loadTrunk(90)))
ferrari.makeAction(action: .setWindowsState(.openedWindows))
ferrari.makeAction(action: .setTrunkState(.unloadTrunk(120)))
print("Result =====>\n")
ferrari.sayAbout()

var volvo = Truck(model: "VOLVO FH 6X4", manufacture: 2015, engineState: .engineOn, windowsState: .openedWindows, trunk: 70000, loadedTrunk: 8000, hp: 420, weight: 10000)
print("\n")
print(volvo)
volvo.makeAction(action: .setEnginState(.engineOff))
volvo.makeAction(action: .setWindowsState(.closedWindows))
volvo.makeAction(action: .setTrunkState(.loadTrunk(60000)))
print("Result =====>\n")
volvo.sayAbout()


//MARK: - Car Structure

struct HyperCar {
    var model: String
    var manufacture: Int
    var engineState: EEngineState
    var windowsState: EWindowsState
    var trunk: Int
    var loadedTrunk: Int = 0
    var hp: Int
    var weight: Int
    
    mutating func makeAction(action: ECarActions) {
        switch action {
        case .setEnginState(let state):
            switch state {
            case .engineOn:
                engineState = .engineOn
            case .engineOff:
                engineState = .engineOff
            }
        case .setTrunkState(let state):
            switch state {
            case .loadTrunk(let litres):
                if (litres <= trunk && (litres + loadedTrunk <= trunk)) {
                    loadedTrunk += litres
                    print("Загружено \(litres) литров")
                } else {
                    print("Не влазит, можно положить еще \(trunk - loadedTrunk) литров")
                }
            case .unloadTrunk(let litres):
                if (litres <= loadedTrunk) {
                    loadedTrunk -= litres
                    print("Выгружено \(litres) литров, осталось \(loadedTrunk)")
                } else {
                    print("Ну мы же не волшебники")
                }
            }
        case .setWindowsState(let state):
            switch state {
            case .openedWindows:
                windowsState = .openedWindows
            case .closedWindows:
                windowsState = .closedWindows
            }
            
        }
    }
    
    init(model: String, manufacture: Int, engineState: EEngineState, windowsState: EWindowsState, trunk: Int, hp: Int, weight: Int) {
        self.model = model
        self.manufacture = manufacture
        self.engineState = engineState
        self.windowsState = windowsState
        self.trunk = trunk
        self.hp = hp
        self.weight = weight
    }
}

var koenigsegg = HyperCar(model: "Koenigsegg Gemera", manufacture: 2020, engineState: .engineOff, windowsState: .closedWindows, trunk: 200, hp: 1723, weight: 1850)
print("\n")
print(koenigsegg)
koenigsegg.makeAction(action: .setTrunkState(.loadTrunk(50)))
koenigsegg.makeAction(action: .setEnginState(.engineOn))
koenigsegg.makeAction(action: .setWindowsState(.openedWindows))
print("Result =====>\n")
print(koenigsegg)
