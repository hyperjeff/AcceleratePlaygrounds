//: [Previous](@previous) | [Next](@next)
import simd
//:# simd: 2, 3, 4-d Vectorized Math
//:### Note: CPU vectorization which also mirrors the vectorization available on GPUs via Metal
let a = float3(1, -2, 3)
let b = float3(4, 5, -6)

let m = float3x3([
	[ 2, 1, 0 ],
	[ 0, 0, 5 ],
	[ 0, 0, 1 ]
])

let dotty = dot(a, b)

let crossy = cross(a, b)

let normalA = norm_one(a)

let a™ = a * m

//:## typealias can help give you back nice type cehcking
typealias Vector = float3
typealias Normal = float3
typealias Plane = float3

let v = Vector(1,2,3)
let norm = Normal(1,-0.5,1)
let plane = Plane(1, -0.5, 1)

reflect(v, n: norm)


let moe = float2(1,1)
let curly = float2(-2,1)
let larry = float2(3,-0.5)
let shemp = float2(2,-0.2)

sign(simd_incircle(shemp, moe, curly, larry))
