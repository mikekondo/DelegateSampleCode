import UIKit

// 1-
print("1-start")
// 目的: 足し算を行うクラス、引き算を行うクラスを使用して、計算を行うプログラムを開発しよう！
class AdditonCalculator{
    // ここではクラス内の関数をメンバ関数と呼びます
    func printResult(value1: Int,value2: Int){
        let result = value1+value2
        let calculateName = "足し算"
        print("\(value1)と\(value2)の\(calculateName)の結果は\(result)です")
    }
}
class SubtractionCalculator{
    func printResult(value1: Int,value2: Int){
        let result = value1 - value2
        let calculateName = "引き算"
        print("\(value1)と\(value2)の\(calculateName)の結果は\(result)です")
    }
}

var calculator = AdditonCalculator()
calculator.printResult(value1: 2, value2: 1)
// calculator = SubtractionCalculator() // Error: calculatorはAdditionCalculator型なので代入ができない

// 問題点: calculatorというインスタンスを生成できたものの、
// 足し算を行うためには足し算用のインスタンスを、引き算を行うためには引き算用のインスタンスを作成しなければいけない
print("1-end\n")
// 1-

// 2-
print("2-start")
protocol CalculateDelegate{
    func resultPrint(value1: Int,value2: Int)
}

class AdditionCalculator2: CalculateDelegate{
    func resultPrint(value1: Int, value2: Int) {
        let calculateName = "足し算"
        let calculatedResult = value1 + value2
        print("\(value1)と\(value2)を\(calculateName)した結果は\(calculatedResult)です")
    }
}

class SubtractionCalculator2: CalculateDelegate{
    func resultPrint(value1: Int, value2: Int) {
        let calculateName = "引き算"
        let calculatedResult = value1 - value2
        print("\(value1)と\(value2)を\(calculateName)した結果は\(calculatedResult)です")
    }
}

// CalculateDelegateの型を明示することで、CalculateDelegate型に対応している型だったら自由に差し替えができるようになる。
var calculator2: CalculateDelegate = AdditionCalculator2()
calculator2.resultPrint(value1: 20, value2: 10)

calculator2 = SubtractionCalculator2()
calculator2.resultPrint(value1: 20, value2: 10)

print("2-end\n")
// 2-

// 3--
print("3-start")
// さて、TableViewっぽく実装してみましょう！命名はTableViewっぽくします！

//　命名はUITableViewDelegateのパクリです。
protocol UICalculateViewDelegate {
    // 下記のメンバ関数はtableViewだとnumberOfRowInSectionとかdidSelectRowAtとかのメンバ関数に該当します

    func calculateResult(value1: Int,value2: Int) -> Int
    func calculateName() -> String
    func delegateMethodHatudou()
}

// プロトコルを実際に使用するクラスです。命名はUITableViewのパクリです。
class UICalculateView{
    // このdelegateがtableView.delegate = selfの正体です。
    // UICalculateViewDelegateという型を明示したdelegateというプロパティは、UICalculateViewDelegate型に対応している型だったら差し替えが可能なのである。のちにself(ViewController)に差し変えられる。
    var delegate: UICalculateViewDelegate?
    func printer(value1: Int,value2: Int){
        let calculateName = delegate?.calculateName()
        let result = delegate?.calculateResult(value1: value1, value2: value2)
        if let calculateName = calculateName, let result = result{
            print("\(value1)と\(value2)を\(calculateName)した結果は\(result)です")
        }
        // よくAPI通信とかで任意のタイミングで関数を発動するアレです。
        delegate?.delegateMethodHatudou()
    }
}

// class ViewController: UICalculateViewDelgateと書いた時点でビルドしてくだせい。Tyep~みたいなエラーを修正すればdelegateメソッドが保管されます！
class ViewController: UIViewController,UICalculateViewDelegate{
    func delegateMethodHatudou() {
        print("delegateMethod発動！！")
    }
    
    // tableViewのIBOutletみたいなものです。
    var calculateView =  UICalculateView()
    override func viewDidLoad() {
        // self(ViewController)はUICalculateViewDelegate型に対応しているクラスなので、UICalculateViewDelegateという型を明示したdelegate
        calculateView.delegate = self
    }
    func calculateResult(value1: Int, value2: Int) -> Int {
        return value1+value1+value2+value2
    }
    func calculateName() -> String {
        return "オリジナル計算"
    }
}

let viewController = ViewController()
viewController.viewDidLoad()
viewController.calculateView.printer(value1: 10, value2: 10)

print("3-end\n")
// 3--



