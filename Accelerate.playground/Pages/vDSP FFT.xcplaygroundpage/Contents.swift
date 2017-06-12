//: [Previous](@previous) | [Next](@next)
//:# vDSP
//:## Fast Fourier Transforms
import Accelerate

let sampleCount = 5000
let halfSampleSize = sampleCount / 2
var data = [Float](repeating: 0, count: sampleCount)

for i in 0 ..< sampleCount {
	let x = Float(i)
	let noise = Float(arc4random())/(2 * Float(RAND_MAX))
//	data[i] = noise
//	data[i] = Float(arc4random()) * sin(x) * sin(Float(4*i)) * sin(Float(4*i))/Float(RAND_MAX)
//	data[i] = sin(x/10)
//	data[i] = sin(x/30) * sin(x/60) * sin(x/60)
	data[i] = sin(x/30) + 0.5 * sin(x/10) + noise
//	data[i] = sin(x/30) + Float(arc4random())/(Float(RAND_MAX) * 2)
//	data[i] = Float(arc4random()) * (sin(x/3))/Float(RAND_MAX)
//	data[i] = Float(arc4random()) * (ceil(sin(x/3))-0.5)/Float(RAND_MAX)
}
data[0 ..< sampleCount/6].map { $0 }
//:### Setting up the constants for the FFT functions:
let log2n: vDSP_Length = vDSP_Length(log2f(Float( sampleCount )))

var Arealp = [Float](data)
var Aimagp = [Float](repeating: 0, count: sampleCount)

var A = DSPSplitComplex(realp: &Arealp, imagp: &Aimagp)

let stride1  = vDSP_Stride( 1 )
let stride2 = vDSP_Stride( 2 )

//:### Ok, now let's start actually using some FFT functions!
let fftSetup = vDSP_create_fftsetup(log2n, FFTRadix(FFT_RADIX2))!
vDSP_fft_zrip(fftSetup, &A, 1, log2n, FFTDirection(FFT_FORWARD))

//:### Done! Check out the results.
var frequencies = [Float](repeating: 0, count: sampleCount)
vDSP_zvmags(&A, 1, &frequencies, 1, vDSP_Length(sampleCount))

frequencies[0 ..< sampleCount/20].map { $0 }


vDSP_destroy_fftsetup(fftSetup)
