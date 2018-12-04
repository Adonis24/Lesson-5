//
//  main.swift
//  Lesson-5
//
//  Created by Чернецова Юлия on 04/12/2018.
//  Copyright © 2018 Чернецов Роман. All rights reserved.
//

import Foundation

//Перечисления
//1. Двигатель (включен/выключен)
enum EngineState: String {
    case on = "двигатель включен"
    case off = "двигатель выключен"
}

//2.  Окна автомобилей
enum WindowState: String{
    case open = "окна открыты"
    case close = "окна закрыты"
}
enum TrunkMode: String{
    case light = "Грузоподъемность до 2.5"
    case midle = "Грузоподъемность от 2.5 до 10 тонн"
    case hard = "Грузоподъемность свыше 10 тонн"
}

enum SportMode:String{
    case turnOn = "Спорт режим включен"
    case turnOff = "Спорт режим выключен"
}

protocol Car {
    //Свойства
    var yearOfManufacture: Int {get set} // год выпуска
    var maxTrunkVolume: Double {get set} // грузоподъемность
    var mark: String {get set} // Марка
    var engineState: EngineState {get set}
    var windowState: WindowState {get set}
    
    //Действие
    func changeCarState()

    
    }
// Расширения протокола - методы вкл/выкл двигатель; открыть/закрыть двери
extension Car{
    
    var engineState: EngineState{
        get {return engineState}
        set {engineState = newValue}
    }
//    mutating func turnOnEngine(){
//
//        engineState =  EngineState.on
//    }
    
    mutating func turnOffEngine(){
         engineState =  EngineState.off
    }
    
    mutating func openWindow(){
        windowState =  WindowState.open
    }
    
    mutating func closeWindow(){
        windowState =  WindowState.close
    }
}



//Создаем класс грузовой автомобиль
class trunkCar:Car{

    
    //общие свойства
    var yearOfManufacture: Int
    var maxTrunkVolume: Double
    var mark: String
    var engineState: EngineState
    var windowState: WindowState
    //специфические свойства
    let  heightWork:Int // высота кузова
    var  trunMode: TrunkMode //Текущий режим грузоподъемности
    var  carrying:Double //Текущий вес груза
    {
        didSet {
            print("Загрузили \(carrying) кг.")
        }
    }
    //реальная номинальная грузоподъемность
    
    func changeCarState(){
        if carrying>=0.0 && carrying<=2500.0 {
            trunMode = TrunkMode.light}
        else if carrying>2500.0 && carrying<=10000.0 {
            trunMode = TrunkMode.midle
        }
        else if carrying>10000.0 {
            trunMode = TrunkMode.hard
        }
        print("\(trunMode.rawValue)")
    }
   
    
    init(yearOfManufacture: Int, maxTrunkVolume: Double, mark: String, engineState: EngineState, windowState: WindowState,heightWork:Int,trunMode:TrunkMode,carrying:Double){
        self.heightWork = heightWork
        self.trunMode = trunMode
        self.carrying = carrying
        
        self.yearOfManufacture = yearOfManufacture
        self.maxTrunkVolume = maxTrunkVolume
        self.mark = mark
        self.engineState = engineState
        self.windowState = windowState
   
    }
}
extension trunkCar: CustomStringConvertible{  // имплементируем протокол для вывода в консоль
    var description: String{
        return """
        Марка: \(mark),
        высота кузова: \(heightWork),
        режим грузоподъемности:\(trunMode.rawValue),
        текущий вес груза: \(carrying),
        год выпуска: \(yearOfManufacture),
        максимальная грузоподъемность: \(maxTrunkVolume),
        состояние двигателя: \(engineState.rawValue),
        состояние окон: \(windowState.rawValue)
        """ // определяем, что именно будет выводиться
    }
    
}
class sportCar:Car{

    var yearOfManufacture: Int
    var maxTrunkVolume: Double
    var mark: String
    var engineState: EngineState
    var windowState: WindowState
    
    let  countHorsePower: Int
    var  sportMode: SportMode
    
   
    

    //Для спорткара запрещено открывать окна в спортрежиме
    func changeCarState() {
        
        if (windowState == .open) && (sportMode == SportMode.turnOn)
        {
            print("Запрещается открывать окна в спорт режиме")}
        }
    
    init(yearOfManufacture: Int, maxTrunkVolume: Double, mark: String, engineState: EngineState, windowState: WindowState,countHorsePower:Int,sportMode:SportMode){
        self.countHorsePower = countHorsePower
        self.sportMode = sportMode
        
        self.yearOfManufacture = yearOfManufacture
        self.maxTrunkVolume = maxTrunkVolume
        self.mark = mark
        self.engineState = engineState
        self.windowState = windowState
        
    }
}
    extension sportCar: CustomStringConvertible{  // имплементируем протокол для вывода в консоль
        var description: String{
            return """
            Марка: \(mark),
            лошадиных сил: \(countHorsePower),
            спорт режим :\(sportMode.rawValue),
            год выпуска: \(yearOfManufacture),
            максимальная грузоподъемность: \(maxTrunkVolume),
            состояние двигателя: \(engineState.rawValue),
            состояние окон: \(windowState.rawValue)
            """
        }
}

var car1 = trunkCar(yearOfManufacture: 2012, maxTrunkVolume: 30_000.0, mark: "Man", engineState: EngineState.off, windowState: WindowState.close, heightWork: 250, trunMode: TrunkMode.light, carrying: 2_000.0)
print("Грузовой автомобиль")
print(car1)
print("\n")
print("Заводим двигатель")
car1.engineState = .on
print(car1)
print("\n")
print("Выключаем двигатель")
car1.turnOffEngine()
print(car1)
print("\n")
print("Открываем окна")
car1.openWindow()
print(car1)
print("\n")
print("Спортивный автомобиль")

var car2 = sportCar(yearOfManufacture: 2014, maxTrunkVolume: 200.0, mark: "Opel", engineState: EngineState.on, windowState: WindowState.open, countHorsePower: 250, sportMode: SportMode.turnOff)
print(car2)
print("\n")
print("Включаем спорт режим")
car2.sportMode = .turnOn
car2.changeCarState()
print("\n")
print(car2)
