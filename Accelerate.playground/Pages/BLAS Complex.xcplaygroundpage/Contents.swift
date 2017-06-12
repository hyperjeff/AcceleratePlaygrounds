//: [Previous](@previous) | [Next](@next)
//:# Complex Numbers with BLAS
import Accelerate
//:## How to define an array of complex numbers in BLAS:
var z:[Float] = [ -3,  4,  5, -7  ]  // element 0 = -3 + 4i, element 1 = 5 - 7i

/*:
## How to read "cblas_scasum":
### "cblas_" just means we're using the BLAS library within Accelerate
### "s" = single-precision (i.e., Float)
### "c" = complex numbers
### "asum" = sum of absolute values
*/
cblas_scasum( 2, &z, 1 )     // |-3| + |4| + |5| + |-7|  =  19
//:## Multiplying-Add: a * x + y
var x:[Float] = [ 1,  2,  3, 4 ]  // [ 1 + 2i,  3 + 4i ]
var y:[Float] = [ 1, -2, -3, 4 ]  // [ 1 - 2i, -3 + 4i ]
var a: Float = 10

//:### "cblas_ c ax p y" ➜ Complex  a * x + y
cblas_caxpy( 2, &a, &x, 1, &y, 1 )
//:### And, as is common in BLAS, the answer is returned in the y vector (destroynig what was there!)
y          // = [ 11 + 18i, 27 + 44i ]

//:## Make a nice complex struct
struct Complex {
	var real: Float
	var imag: Float
	
	var description: String {
		let (absReal, absImag) = (fabsf(real), fabsf(imag))
		
		let imgString = (0 < imag ? "+" : "-") + " \(absImag)"
		
		if absReal > 0.00000001 && absImag > 0.00000001 {
			return "\(real) \(imgString) i"
		}
		else if absImag > 0.00000001 {
			return "\(imgString) i"
		}
		else {
			return "\(real) + 0 i"
		}
	}
}

var c: [Complex] = [ Complex(real: 1, imag: 2), Complex(real: 3, imag: 4) ]
var d: [Complex] = [ Complex(real: 1, imag:-2), Complex(real:-3, imag: 4) ]

cblas_caxpy( 2, &a, &c, 1, &d, 1 )

d[0].description
d[1].description

//:## And using the convenience operators:
//:### note: "¡" is typable and cannot get confused with "i" by Xcode
postfix operator ¡

extension Complex {
	static func + (lhs: Float, rhs: Complex) -> Complex {
		return Complex(real: lhs + rhs.real, imag:rhs.imag)
	}
	static func + (lhs: Complex, rhs: Complex) -> Complex {
		return Complex(real: lhs.real + rhs.real, imag: lhs.imag + rhs.imag)
	}
	static func - (lhs: Float, rhs: Complex) -> Complex {
		return Complex(real: lhs - rhs.real, imag:-1 * rhs.imag)
	}
	static func - (lhs: Complex, rhs: Complex) -> Complex {
		return Complex(real: lhs.real - rhs.real, imag: lhs.imag - rhs.imag)
	}
	static func * (lhs: Complex, rhs: Complex) -> Complex {
		return Complex(
			real: (lhs.real * rhs.real) - (lhs.imag * rhs.imag),
			imag: (lhs.real * rhs.imag) + (lhs.imag * rhs.real)
		)
	}
	static func * (lhs: Float, rhs: Complex) -> Complex {
		return Complex(real: lhs * rhs.real, imag: lhs * rhs.imag)
	}
}

extension Float {
	static postfix func ¡ (x: Float) -> Complex {
		return Complex(real: 0, imag: x)
	}
}

var e: [Complex] = [ 1 + 2¡, 3 + 4¡ ]
var f: [Complex] = [ 5 - 6¡, 7 - 8¡ ]

cblas_caxpy( 2, &a, &e, 1, &f, 1 )

f[0].description
f[1].description

//:## Dot product of complex vectors:
var g: [Complex] = [ 1 + 2¡,  3 + 4¡ ]
var h: [Complex] = [ 5 - 6¡, -7 - 8¡ ]

var dotProduct = 0¡

cblas_cdotu_sub(2, &g, 1, &h, 1, &dotProduct)

((g[0] * h[0]) + (g[1] * h[1])).description

dotProduct.description
