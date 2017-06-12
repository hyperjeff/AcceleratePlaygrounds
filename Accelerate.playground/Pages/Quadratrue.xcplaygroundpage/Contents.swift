//: [Previous](@previous) | [Next](@next)
//:# Quadrature
//:## Fast Integrals
import Accelerate

func myFunction(arg: ImplicitlyUnwrappedOptional<UnsafeMutableRawPointer>, n: Int, x: UnsafePointer<Double>, y: UnsafeMutablePointer<Double>) {
	let scale = arg.assumingMemoryBound(to: Double.self)[0]
	
	"'Zeppelin Rules!"
	
	for i in 0 ..< n {
		let xi = x[i]
		y[i] = scale * (xi == 0 ? 1 : sin(xi) / xi)
	}
}

var scale: Double = 2

var integralFunction = quadrature_integrate_function(fun: myFunction, fun_arg: &scale)

var options = quadrature_integrate_options(
	integrator: QUADRATURE_INTEGRATE_QAG,
	abs_tolerance: 1e-8,
	rel_tolerance: 0,
	qag_points_per_interval: 0,
	max_intervals: 20)

var status = quadrature_status(rawValue: 0)
var absoluteError: Double = 0

let result = quadrature_integrate(&integralFunction, 0, 2 * Double.pi, &options, &status, &absoluteError, 0, nil)
absoluteError

status == QUADRATURE_SUCCESS
