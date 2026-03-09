#!/usr/bin/env swift
import AppKit

// Render Chronoface clock to a thumbnail PNG for System Settings preview
// Standalone script — duplicates drawing logic from ChronofaceView

let width: CGFloat = 640
let height: CGFloat = 480
let cx = width / 2.0
let cy = height / 2.0
let radius = min(width, height) * 0.44

// Turquoise theme colors (default)
let background = NSColor(displayP3Red: 0.69, green: 0.89, blue: 0.89, alpha: 1.0)
let tickColor = NSColor(red: 0.08, green: 0.24, blue: 0.28, alpha: 1.0)
let numberColor = NSColor(red: 0.08, green: 0.24, blue: 0.28, alpha: 1.0)
let capsuleBase = NSColor(white: 0.85, alpha: 1.0)
let capsuleHighlight = NSColor(white: 1.0, alpha: 0.7)
let handColor = NSColor(white: 0.91, alpha: 1.0)
let handHighlight = NSColor(white: 1.0, alpha: 0.6)
let handShadow = NSColor(white: 0.0, alpha: 0.15)
let secondHandColor = NSColor(white: 0.91, alpha: 1.0)

func polarToPoint(angle: CGFloat, r: CGFloat) -> CGPoint {
    let a = angle - .pi / 2.0
    return CGPoint(x: cx + cos(a) * r, y: cy - sin(a) * r)
}

// Create image
let image = NSImage(size: NSSize(width: width, height: height))
image.lockFocus()

guard let ctx = NSGraphicsContext.current?.cgContext else {
    print("Failed to get context")
    exit(1)
}

// Background
ctx.setFillColor(background.cgColor)
ctx.fill(CGRect(x: 0, y: 0, width: width, height: height))

// Minute ticks
for i in 0..<60 {
    if i % 5 == 0 { continue }
    let angle = (CGFloat(i) / 60.0) * .pi * 2.0
    let inner = polarToPoint(angle: angle, r: radius * 0.88)
    let outer = polarToPoint(angle: angle, r: radius * 0.92)
    ctx.setStrokeColor(tickColor.cgColor)
    ctx.setLineWidth(radius * 0.012)
    ctx.setLineCap(.round)
    ctx.move(to: inner)
    ctx.addLine(to: outer)
    ctx.strokePath()
}

// Hour capsules
let capsuleWidth = radius * 0.04
for i in 0..<12 {
    let angle = (CGFloat(i) / 12.0) * .pi * 2.0
    let inner = polarToPoint(angle: angle, r: radius * 0.78)
    let outer = polarToPoint(angle: angle, r: radius * 0.92)

    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: capsuleWidth * 0.2, height: -capsuleWidth * 0.4),
                  blur: capsuleWidth * 1.2, color: handShadow.cgColor)
    ctx.setStrokeColor(capsuleBase.cgColor)
    ctx.setLineWidth(capsuleWidth)
    ctx.setLineCap(.round)
    ctx.move(to: inner)
    ctx.addLine(to: outer)
    ctx.strokePath()
    ctx.restoreGState()

    let perpAngle = angle - .pi / 2.0
    let a = perpAngle - .pi / 2.0
    let dx = cos(a) * capsuleWidth * 0.2
    let dy = -sin(a) * capsuleWidth * 0.2
    ctx.setStrokeColor(capsuleHighlight.cgColor)
    ctx.setLineWidth(capsuleWidth * 0.3)
    ctx.setLineCap(.round)
    ctx.move(to: CGPoint(x: inner.x + dx, y: inner.y + dy))
    ctx.addLine(to: CGPoint(x: outer.x + dx, y: outer.y + dy))
    ctx.strokePath()
}

// Hour numbers
let hourFontSize = radius * 0.14
let hourFont = NSFont(name: "Futura-Bold", size: hourFontSize) ?? NSFont.boldSystemFont(ofSize: hourFontSize)
let hourAttrs: [NSAttributedString.Key: Any] = [.font: hourFont, .foregroundColor: numberColor]
let numbers = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
for (i, num) in numbers.enumerated() {
    let angle = (CGFloat(i) / 12.0) * .pi * 2.0
    let pos = polarToPoint(angle: angle, r: radius * 0.65)
    let text = "\(num)"
    let size = (text as NSString).size(withAttributes: hourAttrs)
    (text as NSString).draw(at: CGPoint(x: pos.x - size.width / 2, y: pos.y - size.height / 2), withAttributes: hourAttrs)
}

// Minute numbers
let minFontSize = radius * 0.065
let minFont = NSFont(name: "Futura-Medium", size: minFontSize) ?? NSFont.systemFont(ofSize: minFontSize, weight: .medium)
let minAttrs: [NSAttributedString.Key: Any] = [.font: minFont, .foregroundColor: numberColor]
let minuteNums = [60, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
for (i, num) in minuteNums.enumerated() {
    let angle = (CGFloat(i) / 12.0) * .pi * 2.0
    let pos = polarToPoint(angle: angle, r: radius * 1.02)
    let text = String(format: "%02d", num)
    let size = (text as NSString).size(withAttributes: minAttrs)
    (text as NSString).draw(at: CGPoint(x: pos.x - size.width / 2, y: pos.y - size.height / 2), withAttributes: minAttrs)
}

// Date window at 3 o'clock
let dateFontSize = radius * 0.075
let dateFont = NSFont(name: "Futura-Medium", size: dateFontSize) ?? NSFont.systemFont(ofSize: dateFontSize, weight: .medium)
let dateWindowW = radius * 0.13
let dateWindowH = radius * 0.09
let dateWindowX = cx + radius * 0.38 - dateWindowW / 2
let dateWindowY = cy - dateWindowH / 2
let dateCornerR = radius * 0.012
let dateRect = CGRect(x: dateWindowX, y: dateWindowY, width: dateWindowW, height: dateWindowH)
let datePath = CGPath(roundedRect: dateRect, cornerWidth: dateCornerR, cornerHeight: dateCornerR, transform: nil)

ctx.saveGState()
ctx.setShadow(offset: CGSize(width: radius * 0.003, height: -radius * 0.005),
              blur: radius * 0.012, color: handShadow.cgColor)
ctx.addPath(datePath)
ctx.setFillColor(NSColor.white.withAlphaComponent(0.92).cgColor)
ctx.fillPath()
ctx.restoreGState()

// Inner shadows for date window
ctx.saveGState()
ctx.addPath(datePath)
ctx.clip()
let colorSpace = CGColorSpaceCreateDeviceRGB()
let insetH = dateWindowH * 0.3
let shadowColors = [CGColor(gray: 0.0, alpha: 0.12), CGColor(gray: 0.0, alpha: 0.0)]
if let g = CGGradient(colorsSpace: colorSpace, colors: shadowColors as CFArray, locations: [0.0, 1.0]) {
    ctx.drawLinearGradient(g,
        start: CGPoint(x: dateWindowX, y: dateWindowY + dateWindowH),
        end: CGPoint(x: dateWindowX, y: dateWindowY + dateWindowH - insetH), options: [])
}
let hlColors = [CGColor(gray: 1.0, alpha: 0.0), CGColor(gray: 1.0, alpha: 0.2)]
if let g = CGGradient(colorsSpace: colorSpace, colors: hlColors as CFArray, locations: [0.0, 1.0]) {
    ctx.drawLinearGradient(g,
        start: CGPoint(x: dateWindowX, y: dateWindowY + dateWindowH * 0.25),
        end: CGPoint(x: dateWindowX, y: dateWindowY), options: [])
}
ctx.restoreGState()

ctx.addPath(datePath)
ctx.setStrokeColor(numberColor.withAlphaComponent(0.18).cgColor)
ctx.setLineWidth(0.5)
ctx.strokePath()

let day = Calendar.current.component(.day, from: Date())
let dateText = "\(day)"
let dateAttrs: [NSAttributedString.Key: Any] = [
    .font: dateFont,
    .foregroundColor: NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
]
let dateSize = (dateText as NSString).size(withAttributes: dateAttrs)
(dateText as NSString).draw(at: CGPoint(
    x: dateWindowX + (dateWindowW - dateSize.width) / 2,
    y: dateWindowY + (dateWindowH - dateSize.height) / 2), withAttributes: dateAttrs)

// Static time: 10:10:30
let hourAngle = ((10.0 + 10.0 / 60.0) / 12.0) * .pi * 2.0
let minuteAngle = (10.0 / 60.0) * .pi * 2.0
let secondAngle = (30.0 / 60.0) * .pi * 2.0

// Draw hands
func drawHand(angle: CGFloat, length: CGFloat, lineWidth: CGFloat, tailLength: CGFloat) {
    let tip = polarToPoint(angle: angle, r: length)
    let tail = polarToPoint(angle: angle + .pi, r: tailLength)

    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: lineWidth * 0.3, height: -lineWidth * 0.5),
                  blur: lineWidth * 1.5, color: handShadow.cgColor)
    ctx.setStrokeColor(handColor.cgColor)
    ctx.setLineWidth(lineWidth)
    ctx.setLineCap(.round)
    ctx.move(to: tail)
    ctx.addLine(to: tip)
    ctx.strokePath()
    ctx.restoreGState()

    let perpA = angle - .pi / 2.0
    let a2 = perpA - .pi / 2.0
    let dx = cos(a2) * lineWidth * 0.15
    let dy = -sin(a2) * lineWidth * 0.15
    ctx.setStrokeColor(handHighlight.cgColor)
    ctx.setLineWidth(lineWidth * 0.25)
    ctx.setLineCap(.round)
    ctx.move(to: CGPoint(x: tail.x + dx, y: tail.y + dy))
    ctx.addLine(to: CGPoint(x: tip.x + dx, y: tip.y + dy))
    ctx.strokePath()
}

drawHand(angle: hourAngle, length: radius * 0.48, lineWidth: radius * 0.045, tailLength: radius * 0.08)
drawHand(angle: minuteAngle, length: radius * 0.68, lineWidth: radius * 0.035, tailLength: radius * 0.08)

// Second hand
let secTip = polarToPoint(angle: secondAngle, r: radius * 0.78)
let secTail = polarToPoint(angle: secondAngle + .pi, r: radius * 0.15)
ctx.setStrokeColor(secondHandColor.cgColor)
ctx.setLineWidth(radius * 0.01)
ctx.setLineCap(.round)
ctx.move(to: secTail)
ctx.addLine(to: secTip)
ctx.strokePath()

// Center dot
let dotRadius = radius * 0.035
let dotRect = CGRect(x: cx - dotRadius, y: cy - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
ctx.saveGState()
ctx.addEllipse(in: dotRect)
ctx.clip()
let dotColors = [CGColor(gray: 0.96, alpha: 1.0), CGColor(gray: 0.82, alpha: 1.0)]
if let g = CGGradient(colorsSpace: colorSpace, colors: dotColors as CFArray, locations: [0.0, 1.0]) {
    ctx.drawRadialGradient(g,
        startCenter: CGPoint(x: cx - dotRadius * 0.3, y: cy + dotRadius * 0.3), startRadius: 0,
        endCenter: CGPoint(x: cx, y: cy), endRadius: dotRadius,
        options: .drawsAfterEndLocation)
}
ctx.restoreGState()

let innerR = radius * 0.015
ctx.setFillColor(CGColor(gray: 0.75, alpha: 1.0))
ctx.fillEllipse(in: CGRect(x: cx - innerR, y: cy - innerR, width: innerR * 2, height: innerR * 2))

image.unlockFocus()

// Save as PNG
let outputPath = "\(FileManager.default.currentDirectoryPath)/Chronoface/Chronoface/thumbnail.png"
guard let tiff = image.tiffRepresentation,
      let bitmap = NSBitmapImageRep(data: tiff),
      let png = bitmap.representation(using: .png, properties: [:]) else {
    print("Failed to create PNG")
    exit(1)
}

try! png.write(to: URL(fileURLWithPath: outputPath))
print("Thumbnail saved: \(outputPath)")
