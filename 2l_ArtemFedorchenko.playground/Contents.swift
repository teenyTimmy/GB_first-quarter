import UIKit

//MARK: -  Написать функцию, которая определяет, четное число или нет

func getEvenNumber(number: Int) -> String {
    return number % 2 == 0 ? "Число \(number) четное" : "Число \(number) нечетное"
}


//MARK: - Написать функцию, которая определяет, делится ли число без остатка на 3

func getOddNumber(number: Int) -> String {
    return number % 3 == 0 ? "Число \(number) делится на 3" : "Число \(number) не делится на 3, остаток: \(number % 3)"
}


//MARK: - Создать возрастающий массив из 100 чисел

let startNumber: Int = 105 // Начальное число массива

func getHundredNums(_ startNumber: Int) -> Array<Int> {
    var hundredArray: Array<Int> = [];
    
    for num in startNumber..<(100 + startNumber) {
        hundredArray.append(num)
    }
    
    return hundredArray
}

func getNumbers(_ array: Array<Int>) -> [String:Array<Int>] {
    let evenNums = array.filter{$0 % 2 == 0}
    let oddNums = array.filter{$0 % 3 == 0}
    let otherNums = array.filter{$0 % 2 != 0 && $0 % 3 != 0}
    
    return ["evenNums": evenNums, "oddNums": oddNums, "otherNums": otherNums]
}

let numbersDict: [String:Array<Int>] = getNumbers(getHundredNums(startNumber))


//MARK: - Функция добавляющая в массив новое число Фибоначчи

var fibonacciNums = [Int]()

func fibonacci(n: Int) -> Int {
    var a = 0
    var b = 1
    for _ in 0..<n {
         let temp = a
         a = b
         b = temp + b
     }
    return a
}

func arrayIntAppend(n: Int) -> [Int] {
    var array = [Int]()
    for i in 0..<n {
        array.append(fibonacci(n: i))
    }
    return array
}
arrayIntAppend(n: 50)


//MARK: -  Простые числа

var simpleNumbers: Array<Int> = []

func isPrime(_ number: Int) -> Bool {
    return number > 1 && !(2..<number).contains{ number % $0 == 0 }
}

for number in getHundredNums(1) {
    if isPrime(number) {
        simpleNumbers.append(number)
    }
}

print(getEvenNumber(number: 1243482733))
print("\n")
print(getOddNumber(number: 107))
print("\n")
print("Четные числа:\n", numbersDict["evenNums"]!)
print("\n")
print("Нечетные числа:\n", numbersDict["oddNums"]!)
print("\n")
print("Не четные, не делятся на 3:\n", numbersDict["otherNums"]!)
print("\n")
print("Числа Фибоначчи:\n", arrayIntAppend(n: 50))
print("\n")
print("Простые числа:\n", simpleNumbers)
