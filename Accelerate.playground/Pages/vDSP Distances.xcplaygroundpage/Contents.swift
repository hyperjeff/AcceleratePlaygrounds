//: [Previous](@previous) | [Next](@next)
//:# vDSP
//:## example: Vector Distances
import Cocoa
import Accelerate

let pointCount = 10

func rando() -> CGFloat {
	return CGFloat(100 * (Float(arc4random())/Float(RAND_MAX) - 1))
}

var points:[CGPoint] = []
for _ in 0 ..< pointCount {
	points.append(CGPoint(x: rando(), y:rando()))
}

let path = NSBezierPath()
path.move(to: points[0])
for i in 1..<points.count {
	path.line(to: points[i])
}

path

var xs = points.map { Float($0.x) }
var ys = points.map { Float($0.y) }

var distance = [Float](repeating:0, count: points.count)

let stride1:vDSP_Stride = 1
let length = vDSP_Length(points.count)

vDSP_vdist(&xs, stride1, &ys, stride1, &distance, stride1, length)

distance

distance.reduce(0, +)
