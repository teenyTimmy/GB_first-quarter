import UIKit

// MARK: - Quadratic equation
// condition: −7x2 − 13x + 8 = 0

let a: Int = -7
let b: Int = -13
let c: Int = 8

let quad: Double = pow(Double(b),2)
let sqr: Double = sqrt(Double(Int(quad) - (4 * Int(a) * Int(c))))

let x = (-Double(b) - sqr) / Double((2 * a))

let checking = -7 * pow(x, 2) - 13 * x + 8


// MARK: - Right triangle

var triangle: [String: Int] = ["a": 7, "b": 10]
triangle["c"] = Int(
    sqrt(
        pow(Double(triangle["a"]!), 2) + pow(Double(triangle["b"]!), 2)
    )
)
triangle

let S = triangle["a"]! * triangle["b"]! / 2
let P = triangle["a"]! + triangle["b"]! + triangle["c"]!


// MARK: - Deposit interest

let years: Int = 5
let daysInOneYear: Int = 365
let percent: Int = 12

var deposit = 1000000
for i in 1...years {
    deposit += (deposit * percent * daysInOneYear / daysInOneYear) / 100
    
    print("Сумма на счету за \(i)-й год: \(deposit) ₽")
}

/*
    Рассчет производился по формуле с капитализаций на срок 5 лет,
    с ежегодной выплатой суммы накоплений на депозитный счет.
    За основу года было взято стандартное к-во дней, исходя из этого,
    возможна некоторая погрешность на конечные суммы.
 */
