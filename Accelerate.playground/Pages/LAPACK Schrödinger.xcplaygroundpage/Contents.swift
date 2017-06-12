//: [Previous](@previous) | [Next](@next)
//:# LAPACK
//:## Schrödinger Solutions for 1-d Square Well
// Source: http://physics-simulation.blogspot.com/2007/10/solving-schrodinger-equation-linear.html
import Accelerate

typealias LAInt = __CLPK_integer

let N = 100
let dx = 10 / Double(N)
let dx² = dx * dx

var hDiag = [Double](repeating: 0, count:  N)
var hOff  = [Double](repeating:-1, count:  N)
var v     = [Double](repeating: 0, count:  N)
var work  = [Double](repeating: 0, count:2*N)
var z     = [Double](repeating: 0, count:N*N)

var n:      LAInt = LAInt(N-1)
var ldz:    LAInt = n
var info:   LAInt = 0
var jobType: Int8 = 86 // = "V" in ASCII

for i in 0 ..< N {
	v[i] =  fabs(Double(i+1) * dx - 5) < 1 ? 0 : 1
	hDiag[i] = 2.0 + 2.0 * dx² * v[i]
}

dstev_( &jobType, &n, &hDiag, &hOff, &z, &ldz, &work, &info )

info == 0 ? "Worked!" : "Failed"

//:### Find the lowest 4 Eigenvalues:
for i in 0 ..< 4 {
	print("\(i): \(hDiag[i] / (2 * dx²))")
}
print()

//:### Lowest 10 energy 1-d wave functions:
for i in 0 ..< N-2 {
	let m = N-1
	z[      i]
	z[  m + i]
	z[2*m + i]
	z[3*m + i]
	z[4*m + i]
	z[5*m + i]
	z[6*m + i]
	z[7*m + i]
	z[8*m + i]
	z[9*m + i]
}
//:### Note: After difficult setup, ONE line of code for solution
