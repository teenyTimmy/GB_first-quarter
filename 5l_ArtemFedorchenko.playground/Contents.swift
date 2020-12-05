//MARK: - enums

enum EEngineState {
    case start, stop
}

enum EWindowsState{
    case opened, closed
}

enum ENOS {
    case active, unactive
}

enum ETrunkState {
    case fullTrunk, emptyTrunk
}


//MARK: - protocol

protocol Car {
    var model: String {get}
    var manufacture: Int {get}
    var engineState: EEngineState {get set}
    var windowsState: EWindowsState {get set}
}


//MARK: - extension

extension Car {
    mutating func changeEngineState(engineState: EEngineState){
        self.engineState = engineState
    }
    
    mutating func chageWindowsState(windowsState: EWindowsState){
        self.windowsState = windowsState
    }
}


//MARK: - classes

class BasicCar: Car {
    var model: String
    var manufacture: Int
    var engineState: EEngineState = .stop
    var windowsState: EWindowsState = .closed
    
    init(model: String, manufacture: Int) {
        self.model = model
        self.manufacture = manufacture
    }
}

class SportCar: BasicCar, CustomStringConvertible {
    var NOS: ENOS = .unactive
    
    var description: String {
        return """
        Статус двигателя: \(engineState == .start ? "запущен" : "заглушен");
        статус окон: \(windowsState == .opened ? "открыты" : "закрыты");
        закись азота: \(NOS == .active ? "впрыск" : "не активна");
        дата производства: \(manufacture);
        модель: \(model)
        """
    }
}

class TruckCar: BasicCar, CustomStringConvertible {
    var trunkState: ETrunkState = .emptyTrunk
    
    var description: String {
        return """
        Статус двигателя: \(engineState == .start ? "запущен" : "заглушен");
        статус окон: \(windowsState == .opened ? "открыты" : "закрыты");
        загрузка: \(trunkState == .emptyTrunk ? "пустой" : "загружен");
        дата производства: \(manufacture);
        модель: \(model)
        """
    }
}


//MARK: - actions

var nissan = SportCar(model: "Nissan 240SX", manufacture: 1998)
nissan.changeEngineState(engineState: .start)
nissan.chageWindowsState(windowsState: .opened)
print(nissan.description)
print("\n")

var volvo = TruckCar(model: "VOLVO FH 6X4", manufacture: 2016)
volvo.chageWindowsState(windowsState: .opened)
volvo.trunkState = .fullTrunk
volvo.changeEngineState(engineState: .start)
print(volvo.description)

