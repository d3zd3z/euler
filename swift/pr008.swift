// Problem 8
//
// 11 January 2002
//
// Find the greatest product of five consecutive digits in the 1000-digit
// number.
//
// 40824

func genNumber() -> [UInt8] {
    var buf = [UInt8]()
    buf += "73167176531330624919225119674426574742355349194934".utf8
    buf += "96983520312774506326239578318016984801869478851843".utf8
    buf += "85861560789112949495459501737958331952853208805511".utf8
    buf += "12540698747158523863050715693290963295227443043557".utf8
    buf += "66896648950445244523161731856403098711121722383113".utf8
    buf += "62229893423380308135336276614282806444486645238749".utf8
    buf += "30358907296290491560440772390713810515859307960866".utf8
    buf += "70172427121883998797908792274921901699720888093776".utf8
    buf += "65727333001053367881220235421809751254540594752243".utf8
    buf += "52584907711670556013604839586446706324415722155397".utf8
    buf += "53697817977846174064955149290862569321978468622482".utf8
    buf += "83972241375657056057490261407972968652414535100474".utf8
    buf += "82166370484403199890008895243450658541227588666881".utf8
    buf += "16427171479924442928230863465674813919123162824586".utf8
    buf += "17866458359124566529476545682848912883142607690042".utf8
    buf += "24219022671055626321111109370544217506941658960408".utf8
    buf += "07198403850962455444362981230987879927244284909188".utf8
    buf += "84580156166097919133875499200524063689912560717606".utf8
    buf += "05886116467109405077541002256983155200055935729725".utf8
    buf += "71636269561882670428252483600823257530420752963450".utf8
    return buf
}

class Problem8 {
    let number = genNumber()

    func solve() -> Int {
        var max = 0
        for i in 0 ..< number.count - 5 {
            let len = product(i)
            if len > max {
                max = len
            }
        }
        return max
    }

    func product(pos: Int) -> Int {
        var result = 1
        for b in pos ..< pos + 5 {
            result *= Int(number[b] - 48)
        }
        return result
    }
}

func pr008() -> Int {
    return Problem8().solve()
}