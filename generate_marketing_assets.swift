#!/usr/bin/env swift
import AppKit

// Generates marketing assets from the same drawing primitives as the screen saver:
//   - web/html/og-image.jpg    (1200x630, Noir + amber lume, for og:image / twitter:card)
//   - assets/themes-grid.jpg   (1600x1600, 4x4 grid of all 16 themes, for README)
//
// Standalone script. Mirrors ChronofaceView day/night rendering; if the screen saver
// drawing logic changes, update both files together.

// MARK: - Theme catalogue (mirror of ThemeName / Theme.named in ChronofaceView)

struct MarketingTheme {
    let name: String
    let background: NSColor
    let tickColor: NSColor
    let numberColor: NSColor
    let handColor: NSColor
    let handHighlight: NSColor
    let handShadow: NSColor
    let centerDot: NSColor
    let secondHand: NSColor
}

let secondHandRed = NSColor(displayP3Red: 0.80, green: 0.12, blue: 0.12, alpha: 1.0)

let THEMES: [MarketingTheme] = [
    .init(name: "White",
          background: NSColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
          tickColor: NSColor(white: 0.15, alpha: 1.0),
          numberColor: NSColor(white: 0.15, alpha: 1.0),
          handColor: NSColor(white: 0.98, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Turquoise",
          background: NSColor(displayP3Red: 0.69, green: 0.89, blue: 0.89, alpha: 1.0),
          tickColor: NSColor(red: 0.08, green: 0.24, blue: 0.28, alpha: 1.0),
          numberColor: NSColor(red: 0.08, green: 0.24, blue: 0.28, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Glacier",
          background: NSColor(displayP3Red: 0.659, green: 0.718, blue: 0.749, alpha: 1.0),
          tickColor: NSColor(red: 0.12, green: 0.16, blue: 0.20, alpha: 0.8),
          numberColor: NSColor(red: 0.12, green: 0.16, blue: 0.20, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Ocean",
          background: NSColor(displayP3Red: 0.055, green: 0.125, blue: 0.271, alpha: 1.0),
          tickColor: NSColor(displayP3Red: 0.50, green: 0.88, blue: 0.80, alpha: 0.7),
          numberColor: NSColor(displayP3Red: 0.50, green: 0.88, blue: 0.80, alpha: 0.9),
          handColor: NSColor(white: 0.93, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.5),
          handShadow: NSColor(white: 0.0, alpha: 0.4),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Tennis",
          background: NSColor(displayP3Red: 0.0, green: 0.451, blue: 0.263, alpha: 1.0),
          tickColor: NSColor(red: 0.45, green: 0.72, blue: 0.35, alpha: 0.7),
          numberColor: NSColor(red: 0.75, green: 0.86, blue: 0.12, alpha: 1.0),
          handColor: NSColor(white: 0.93, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.5),
          handShadow: NSColor(white: 0.0, alpha: 0.35),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Signal Blue",
          background: NSColor(displayP3Red: 0.0, green: 0.624, blue: 0.851, alpha: 1.0),
          tickColor: NSColor(white: 1.0, alpha: 0.65),
          numberColor: NSColor(white: 1.0, alpha: 0.85),
          handColor: NSColor(white: 0.93, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.5),
          handShadow: NSColor(white: 0.0, alpha: 0.3),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Salmon",
          background: NSColor(displayP3Red: 0.890, green: 0.694, blue: 0.561, alpha: 1.0),
          tickColor: NSColor(red: 0.28, green: 0.13, blue: 0.08, alpha: 0.8),
          numberColor: NSColor(red: 0.28, green: 0.13, blue: 0.08, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Yellow",
          background: NSColor(displayP3Red: 0.949, green: 0.745, blue: 0.0, alpha: 1.0),
          tickColor: NSColor(red: 0.30, green: 0.16, blue: 0.0, alpha: 0.85),
          numberColor: NSColor(red: 0.30, green: 0.16, blue: 0.0, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Beige",
          background: NSColor(displayP3Red: 0.878, green: 0.808, blue: 0.624, alpha: 1.0),
          tickColor: NSColor(red: 0.25, green: 0.18, blue: 0.08, alpha: 0.8),
          numberColor: NSColor(red: 0.25, green: 0.18, blue: 0.08, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Pistachio",
          background: NSColor(displayP3Red: 0.714, green: 0.769, blue: 0.639, alpha: 1.0),
          tickColor: NSColor(red: 0.14, green: 0.20, blue: 0.10, alpha: 0.8),
          numberColor: NSColor(red: 0.14, green: 0.20, blue: 0.10, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Lavender",
          background: NSColor(displayP3Red: 0.765, green: 0.788, blue: 0.898, alpha: 1.0),
          tickColor: NSColor(red: 0.12, green: 0.12, blue: 0.28, alpha: 0.8),
          numberColor: NSColor(red: 0.12, green: 0.12, blue: 0.28, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Rose",
          background: NSColor(displayP3Red: 0.898, green: 0.757, blue: 0.796, alpha: 1.0),
          tickColor: NSColor(red: 0.28, green: 0.08, blue: 0.12, alpha: 0.8),
          numberColor: NSColor(red: 0.28, green: 0.08, blue: 0.12, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Sky Blue",
          background: NSColor(displayP3Red: 0.733, green: 0.851, blue: 0.941, alpha: 1.0),
          tickColor: NSColor(red: 0.22, green: 0.32, blue: 0.50, alpha: 0.7),
          numberColor: NSColor(red: 0.12, green: 0.20, blue: 0.38, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Cream",
          background: NSColor(displayP3Red: 0.859, green: 0.851, blue: 0.827, alpha: 1.0),
          tickColor: NSColor(red: 0.20, green: 0.18, blue: 0.14, alpha: 0.8),
          numberColor: NSColor(red: 0.20, green: 0.18, blue: 0.14, alpha: 1.0),
          handColor: NSColor(white: 0.91, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.6),
          handShadow: NSColor(white: 0.0, alpha: 0.15),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Slate",
          background: NSColor(displayP3Red: 0.275, green: 0.278, blue: 0.290, alpha: 1.0),
          tickColor: NSColor(white: 0.75, alpha: 0.6),
          numberColor: NSColor(white: 0.85, alpha: 1.0),
          handColor: NSColor(white: 0.93, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.5),
          handShadow: NSColor(white: 0.0, alpha: 0.4),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
    .init(name: "Noir",
          background: NSColor(displayP3Red: 0.055, green: 0.055, blue: 0.059, alpha: 1.0),
          tickColor: NSColor(white: 0.70, alpha: 0.6),
          numberColor: NSColor(white: 0.85, alpha: 1.0),
          handColor: NSColor(white: 0.93, alpha: 1.0),
          handHighlight: NSColor(white: 1.0, alpha: 0.4),
          handShadow: NSColor(white: 0.0, alpha: 0.5),
          centerDot: NSColor(white: 0.75, alpha: 1.0),
          secondHand: secondHandRed),
]

let amberLume = NSColor(displayP3Red: 1.0, green: 0.533, blue: 0.0, alpha: 1.0)

// MARK: - Geometry helpers

func polar(_ cx: CGFloat, _ cy: CGFloat, _ angle: CGFloat, _ r: CGFloat) -> CGPoint {
    let a = angle - .pi / 2.0
    return CGPoint(x: cx + cos(a) * r, y: cy - sin(a) * r)
}

// Marketing time: classic 10:10:30
let hourAngle: CGFloat   = ((10.0 + 10.0 / 60.0) / 12.0) * .pi * 2.0
let minuteAngle: CGFloat = (10.0 / 60.0) * .pi * 2.0
let secondAngle: CGFloat = (30.0 / 60.0) * .pi * 2.0

// MARK: - Clock drawing (drop-in mirror of ChronofaceView for one rect)

func drawClock(
    ctx: CGContext,
    rect: CGRect,
    theme: MarketingTheme,
    isNight: Bool,
    lumeColor: NSColor,
    glow: CGFloat,
    showDate: Bool,
    showCircularBackground: Bool = false
) {
    let cx = rect.midX
    let cy = rect.midY
    let radius = min(rect.width, rect.height) * 0.44

    if showCircularBackground {
        let bgColor: NSColor = isNight
            ? NSColor(displayP3Red: 0.04, green: 0.04, blue: 0.05, alpha: 1.0)
            : theme.background
        ctx.setFillColor(bgColor.cgColor)
        ctx.fillEllipse(in: CGRect(x: cx - radius * 1.12, y: cy - radius * 1.12,
                                   width: radius * 2.24, height: radius * 2.24))
    } else {
        let bgColor: NSColor = isNight ? NSColor.black : theme.background
        ctx.setFillColor(bgColor.cgColor)
        ctx.fill(rect)
    }

    // Minute ticks
    for i in 0..<60 {
        if i % 5 == 0 { continue }
        let angle = (CGFloat(i) / 60.0) * .pi * 2.0
        let inner = polar(cx, cy, angle, radius * 0.88)
        let outer = polar(cx, cy, angle, radius * 0.92)
        let col: NSColor = isNight ? lumeColor.withAlphaComponent(0.2) : theme.tickColor
        ctx.setStrokeColor(col.cgColor)
        ctx.setLineWidth(radius * 0.012)
        ctx.setLineCap(.round)
        ctx.move(to: inner)
        ctx.addLine(to: outer)
        ctx.strokePath()
    }

    // Hour capsules
    let capW = radius * 0.04
    for i in 0..<12 {
        let angle = (CGFloat(i) / 12.0) * .pi * 2.0
        let inner = polar(cx, cy, angle, radius * 0.78)
        let outer = polar(cx, cy, angle, radius * 0.92)

        if isNight {
            ctx.setStrokeColor(NSColor(white: 0.12, alpha: 0.6).cgColor)
            ctx.setLineWidth(capW)
            ctx.setLineCap(.round)
            ctx.move(to: inner); ctx.addLine(to: outer); ctx.strokePath()

            ctx.saveGState()
            ctx.setShadow(offset: .zero, blur: capW * 3.0 * glow,
                          color: lumeColor.withAlphaComponent(0.7 * glow).cgColor)
            ctx.setStrokeColor(lumeColor.cgColor)
            ctx.setLineWidth(capW * 0.4)
            ctx.setLineCap(.round)
            ctx.move(to: inner); ctx.addLine(to: outer); ctx.strokePath()
            ctx.restoreGState()
        } else {
            ctx.saveGState()
            ctx.setShadow(offset: CGSize(width: capW * 0.2, height: -capW * 0.4),
                          blur: capW * 1.2,
                          color: theme.handShadow.cgColor)
            ctx.setStrokeColor(theme.handColor.cgColor)
            ctx.setLineWidth(capW)
            ctx.setLineCap(.round)
            ctx.move(to: inner); ctx.addLine(to: outer); ctx.strokePath()
            ctx.restoreGState()

            ctx.setStrokeColor(NSColor(red: 0.78, green: 0.90, blue: 0.72, alpha: 0.35).cgColor)
            ctx.setLineWidth(capW * 0.4)
            ctx.setLineCap(.round)
            ctx.move(to: inner); ctx.addLine(to: outer); ctx.strokePath()
        }
    }

    // Hour numbers
    let hourFontSize = radius * 0.14
    let hourFont = NSFont(name: "Futura-Bold", size: hourFontSize)
        ?? NSFont.boldSystemFont(ofSize: hourFontSize)
    let hourCol: NSColor = isNight ? lumeColor : theme.numberColor
    let hourAttrs: [NSAttributedString.Key: Any] = [.font: hourFont, .foregroundColor: hourCol]
    let hourNums = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    for (i, num) in hourNums.enumerated() {
        let angle = (CGFloat(i) / 12.0) * .pi * 2.0
        let pos = polar(cx, cy, angle, radius * 0.65)
        let text = "\(num)" as NSString
        let size = text.size(withAttributes: hourAttrs)
        let p = CGPoint(x: pos.x - size.width / 2, y: pos.y - size.height / 2)
        if isNight {
            ctx.saveGState()
            ctx.setShadow(offset: .zero, blur: hourFontSize * 0.4 * glow,
                          color: lumeColor.withAlphaComponent(0.6 * glow).cgColor)
            text.draw(at: p, withAttributes: hourAttrs)
            ctx.restoreGState()
        }
        text.draw(at: p, withAttributes: hourAttrs)
    }

    // Minute numbers (outer ring)
    let minFontSize = radius * 0.065
    let minFont = NSFont(name: "Futura-Medium", size: minFontSize)
        ?? NSFont.systemFont(ofSize: minFontSize, weight: .medium)
    let minCol: NSColor = isNight ? lumeColor.withAlphaComponent(0.25) : theme.numberColor
    let minAttrs: [NSAttributedString.Key: Any] = [.font: minFont, .foregroundColor: minCol]
    let minNums = [60, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    for (i, num) in minNums.enumerated() {
        let angle = (CGFloat(i) / 12.0) * .pi * 2.0
        let pos = polar(cx, cy, angle, radius * 1.02)
        let text = String(format: "%02d", num) as NSString
        let size = text.size(withAttributes: minAttrs)
        text.draw(at: CGPoint(x: pos.x - size.width / 2, y: pos.y - size.height / 2),
                  withAttributes: minAttrs)
    }

    // Date window at 3 o'clock
    if showDate {
        drawDateWindow(ctx: ctx, cx: cx, cy: cy, radius: radius,
                       theme: theme, isNight: isNight, lumeColor: lumeColor, glow: glow)
    }

    // Hands
    drawHand(ctx: ctx, cx: cx, cy: cy, radius: radius,
             angle: hourAngle, length: radius * 0.48, width: radius * 0.045,
             theme: theme, isNight: isNight, lumeColor: lumeColor, glow: glow)
    drawHand(ctx: ctx, cx: cx, cy: cy, radius: radius,
             angle: minuteAngle, length: radius * 0.68, width: radius * 0.045,
             theme: theme, isNight: isNight, lumeColor: lumeColor, glow: glow)

    // Center dot
    let dotR = radius * 0.035
    let dotColor: NSColor = isNight ? NSColor(white: 0.15, alpha: 1.0) : theme.handColor
    ctx.setFillColor(dotColor.cgColor)
    ctx.fillEllipse(in: CGRect(x: cx - dotR, y: cy - dotR, width: dotR * 2, height: dotR * 2))

    // Second hand
    let secTip = polar(cx, cy, secondAngle, radius * 0.78)
    let secTail = polar(cx, cy, secondAngle + .pi, radius * 0.15)
    let secCol: NSColor = isNight ? NSColor(white: 0.25, alpha: 0.6) : theme.secondHand
    ctx.setStrokeColor(secCol.cgColor)
    ctx.setLineWidth(radius * 0.009)
    ctx.setLineCap(.round)
    ctx.move(to: secTail); ctx.addLine(to: secTip); ctx.strokePath()

    // Second hand ring
    let ringR = dotR * 0.8
    let ringColor: NSColor = isNight ? NSColor(white: 0.12, alpha: 1.0) : theme.secondHand
    ctx.setFillColor(ringColor.cgColor)
    ctx.fillEllipse(in: CGRect(x: cx - ringR, y: cy - ringR, width: ringR * 2, height: ringR * 2))

    // Axis pin
    let pinR = radius * 0.01
    ctx.setFillColor(NSColor(white: 0.41, alpha: 1.0).cgColor)
    ctx.fillEllipse(in: CGRect(x: cx - pinR, y: cy - pinR, width: pinR * 2, height: pinR * 2))
}

func drawHand(
    ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat,
    angle: CGFloat, length: CGFloat, width: CGFloat,
    theme: MarketingTheme, isNight: Bool, lumeColor: NSColor, glow: CGFloat
) {
    let neckLen = radius * 0.085
    let neckStart = polar(cx, cy, angle, 0)
    let neckEnd = polar(cx, cy, angle, neckLen)
    let bodyStart = neckEnd
    let tip = polar(cx, cy, angle, length)

    if isNight {
        ctx.setStrokeColor(NSColor(white: 0.12, alpha: 0.6).cgColor)
        ctx.setLineWidth(width)
        ctx.setLineCap(.round)
        ctx.move(to: bodyStart); ctx.addLine(to: tip); ctx.strokePath()

        ctx.setStrokeColor(NSColor(white: 0.12, alpha: 0.6).cgColor)
        ctx.setLineWidth(width * 0.30)
        ctx.setLineCap(.round)
        ctx.move(to: neckStart); ctx.addLine(to: neckEnd); ctx.strokePath()

        ctx.saveGState()
        ctx.setShadow(offset: .zero, blur: width * 2.5 * glow,
                      color: lumeColor.withAlphaComponent(0.7 * glow).cgColor)
        ctx.setStrokeColor(lumeColor.cgColor)
        ctx.setLineWidth(width * 0.45)
        ctx.setLineCap(.round)
        ctx.move(to: bodyStart); ctx.addLine(to: tip); ctx.strokePath()
        ctx.restoreGState()

        ctx.setStrokeColor(lumeColor.cgColor)
        ctx.setLineWidth(width * 0.3)
        ctx.setLineCap(.round)
        ctx.move(to: bodyStart); ctx.addLine(to: tip); ctx.strokePath()
    } else {
        ctx.saveGState()
        ctx.setShadow(offset: CGSize(width: width * 0.3, height: -width * 0.5),
                      blur: width * 1.5,
                      color: theme.handShadow.cgColor)
        ctx.setStrokeColor(theme.handColor.cgColor)
        ctx.setLineWidth(width)
        ctx.setLineCap(.round)
        ctx.move(to: bodyStart); ctx.addLine(to: tip); ctx.strokePath()
        ctx.restoreGState()

        ctx.setStrokeColor(theme.handColor.cgColor)
        ctx.setLineWidth(width * 0.30)
        ctx.setLineCap(.round)
        ctx.move(to: neckStart); ctx.addLine(to: neckEnd); ctx.strokePath()

        ctx.setStrokeColor(NSColor(red: 0.78, green: 0.90, blue: 0.72, alpha: 0.35).cgColor)
        ctx.setLineWidth(width * 0.4)
        ctx.setLineCap(.round)
        ctx.move(to: bodyStart); ctx.addLine(to: tip); ctx.strokePath()
    }
}

func drawDateWindow(
    ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat,
    theme: MarketingTheme, isNight: Bool, lumeColor: NSColor, glow: CGFloat
) {
    let day = Calendar.current.component(.day, from: Date())
    let text = "\(day)" as NSString

    let fontSize = radius * 0.075
    let font = NSFont(name: "Futura-Medium", size: fontSize)
        ?? NSFont.systemFont(ofSize: fontSize, weight: .medium)

    let windowW = radius * 0.13
    let windowH = radius * 0.09
    let windowX = cx + radius * 0.38 - windowW / 2
    let windowY = cy - windowH / 2
    let cornerR = radius * 0.012

    if isNight {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: lumeColor]
        let size = text.size(withAttributes: attrs)
        let p = CGPoint(x: windowX + (windowW - size.width) / 2,
                        y: windowY + (windowH - size.height) / 2)
        ctx.saveGState()
        ctx.setShadow(offset: .zero, blur: fontSize * 0.4 * glow,
                      color: lumeColor.withAlphaComponent(0.6 * glow).cgColor)
        text.draw(at: p, withAttributes: attrs)
        ctx.restoreGState()
        text.draw(at: p, withAttributes: attrs)
        return
    }

    var bgBrightness: CGFloat = 1.0
    if let rgb = theme.background.usingColorSpace(.deviceRGB) {
        bgBrightness = rgb.redComponent * 0.299
                     + rgb.greenComponent * 0.587
                     + rgb.blueComponent * 0.114
    }
    let isDark = bgBrightness < 0.4

    let rect = CGRect(x: windowX, y: windowY, width: windowW, height: windowH)
    let path = CGPath(roundedRect: rect, cornerWidth: cornerR, cornerHeight: cornerR, transform: nil)

    let windowBg: CGColor
    let textColor: NSColor
    if isDark {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        if let rgb = theme.background.usingColorSpace(.deviceRGB) {
            r = rgb.redComponent; g = rgb.greenComponent; b = rgb.blueComponent
        }
        windowBg = NSColor(red: r * 0.55, green: g * 0.55, blue: b * 0.55, alpha: 1.0).cgColor
        textColor = NSColor(white: 0.88, alpha: 1.0)
    } else {
        windowBg = NSColor.white.withAlphaComponent(0.92).cgColor
        textColor = NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
    }

    ctx.saveGState()
    if !isDark {
        ctx.setShadow(offset: CGSize(width: radius * 0.003, height: -radius * 0.005),
                      blur: radius * 0.012,
                      color: theme.handShadow.cgColor)
    }
    ctx.addPath(path)
    ctx.setFillColor(windowBg)
    ctx.fillPath()
    ctx.restoreGState()

    ctx.addPath(path)
    ctx.setStrokeColor(theme.numberColor.withAlphaComponent(0.18).cgColor)
    ctx.setLineWidth(0.5)
    ctx.strokePath()

    let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor]
    let size = text.size(withAttributes: attrs)
    text.draw(at: CGPoint(x: windowX + (windowW - size.width) / 2,
                          y: windowY + (windowH - size.height) / 2),
              withAttributes: attrs)
}

// MARK: - Image writer (JPEG via ImageIO — markedly smaller than NSBitmapImageRep PNG)

import ImageIO
import UniformTypeIdentifiers

func saveJPEG(_ image: NSImage, to path: String, quality: CGFloat = 0.88) {
    guard let tiff = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiff),
          let cgImage = bitmap.cgImage else {
        print("Failed to obtain CGImage for \(path)")
        exit(1)
    }

    let url = URL(fileURLWithPath: path)
    let dir = url.deletingLastPathComponent()
    try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)

    guard let dest = CGImageDestinationCreateWithURL(url as CFURL, UTType.jpeg.identifier as CFString, 1, nil) else {
        print("Failed to create JPEG destination for \(path)")
        exit(1)
    }
    let options: [CFString: Any] = [
        kCGImageDestinationLossyCompressionQuality: quality
    ]
    CGImageDestinationAddImage(dest, cgImage, options as CFDictionary)
    guard CGImageDestinationFinalize(dest) else {
        print("Failed to finalize JPEG \(path)")
        exit(1)
    }
    print("Wrote \(path)")
}

// MARK: - OG image: Noir + amber lume, clock left, type right (1200x630)

func renderOGImage(to path: String) {
    let w: CGFloat = 1200
    let h: CGFloat = 630
    let image = NSImage(size: NSSize(width: w, height: h))
    image.lockFocus()
    guard let ctx = NSGraphicsContext.current?.cgContext else {
        print("No context for OG image"); exit(1)
    }

    // Background: very dark with subtle radial vignette
    let noir = NSColor(displayP3Red: 0.04, green: 0.04, blue: 0.05, alpha: 1.0)
    ctx.setFillColor(noir.cgColor)
    ctx.fill(CGRect(x: 0, y: 0, width: w, height: h))

    let cs = CGColorSpaceCreateDeviceRGB()
    if let g = CGGradient(colorsSpace: cs,
                          colors: [
                            NSColor(displayP3Red: 0.10, green: 0.07, blue: 0.03, alpha: 0.55).cgColor,
                            NSColor.clear.cgColor] as CFArray,
                          locations: [0.0, 1.0]) {
        ctx.drawRadialGradient(g,
                               startCenter: CGPoint(x: 315, y: h / 2), startRadius: 0,
                               endCenter: CGPoint(x: 315, y: h / 2), endRadius: 380,
                               options: .drawsAfterEndLocation)
    }

    let noirTheme = THEMES.first { $0.name == "Noir" }!
    let clockRect = CGRect(x: 30, y: 30, width: 570, height: 570)
    drawClock(ctx: ctx, rect: clockRect,
              theme: noirTheme, isNight: true,
              lumeColor: amberLume, glow: 0.85,
              showDate: true)

    // Right column: wordmark + tagline + URL
    let textX: CGFloat = 660
    let serifSize: CGFloat = 84
    let wordmarkFont = NSFont(name: "Futura-Bold", size: serifSize)
        ?? NSFont.boldSystemFont(ofSize: serifSize)
    let title = "Chronoface" as NSString
    let titleAttrs: [NSAttributedString.Key: Any] = [
        .font: wordmarkFont,
        .foregroundColor: NSColor(displayP3Red: 0.92, green: 0.89, blue: 0.83, alpha: 1.0),
        .kern: 1.5
    ]
    title.draw(at: CGPoint(x: textX, y: 390), withAttributes: titleAttrs)

    // Accent line in amber
    let accent = NSColor(displayP3Red: 0.78, green: 0.66, blue: 0.49, alpha: 1.0)
    ctx.setFillColor(accent.cgColor)
    ctx.fill(CGRect(x: textX, y: 365, width: 56, height: 2))

    // Tagline
    let taglineFont = NSFont(name: "Futura-Medium", size: 30)
        ?? NSFont.systemFont(ofSize: 30, weight: .medium)
    let tagline1 = "Swiss-inspired analog" as NSString
    let tagline2 = "screensaver for macOS." as NSString
    let taglineAttrs: [NSAttributedString.Key: Any] = [
        .font: taglineFont,
        .foregroundColor: NSColor(displayP3Red: 0.78, green: 0.78, blue: 0.74, alpha: 1.0)
    ]
    tagline1.draw(at: CGPoint(x: textX, y: 290), withAttributes: taglineAttrs)
    tagline2.draw(at: CGPoint(x: textX, y: 250), withAttributes: taglineAttrs)

    // Feature line
    let metaFont = NSFont(name: "Futura-Medium", size: 18)
        ?? NSFont.systemFont(ofSize: 18, weight: .medium)
    let meta = "16 dial themes · luminescent night mode · live weather" as NSString
    let metaAttrs: [NSAttributedString.Key: Any] = [
        .font: metaFont,
        .foregroundColor: NSColor(displayP3Red: 0.55, green: 0.50, blue: 0.42, alpha: 1.0),
        .kern: 0.5
    ]
    meta.draw(at: CGPoint(x: textX, y: 180), withAttributes: metaAttrs)

    // URL pill
    let urlFont = NSFont(name: "Futura-Bold", size: 20)
        ?? NSFont.boldSystemFont(ofSize: 20)
    let url = "chronoface.perek.rest" as NSString
    let urlAttrs: [NSAttributedString.Key: Any] = [
        .font: urlFont,
        .foregroundColor: accent,
        .kern: 1.0
    ]
    url.draw(at: CGPoint(x: textX, y: 110), withAttributes: urlAttrs)

    image.unlockFocus()
    saveJPEG(image, to: path)
}

// MARK: - Themes grid (4x4) for README

func renderThemesGrid(to path: String) {
    let cellSize: CGFloat = 400
    let gap: CGFloat = 0
    let cols: CGFloat = 4
    let rows: CGFloat = 4
    let w = cellSize * cols + gap * (cols - 1)
    let h = cellSize * rows + gap * (rows - 1)

    let image = NSImage(size: NSSize(width: w, height: h))
    image.lockFocus()
    guard let ctx = NSGraphicsContext.current?.cgContext else {
        print("No context for themes grid"); exit(1)
    }

    // Backplate so gaps (if any) look intentional
    ctx.setFillColor(NSColor(displayP3Red: 0.05, green: 0.05, blue: 0.06, alpha: 1.0).cgColor)
    ctx.fill(CGRect(x: 0, y: 0, width: w, height: h))

    for (i, theme) in THEMES.enumerated() {
        let col = CGFloat(i % Int(cols))
        // Reverse row order so the visual layout matches reading order top-to-bottom
        let row = rows - 1 - CGFloat(i / Int(cols))
        let cellRect = CGRect(x: col * (cellSize + gap),
                              y: row * (cellSize + gap),
                              width: cellSize, height: cellSize)
        drawClock(ctx: ctx, rect: cellRect,
                  theme: theme, isNight: false,
                  lumeColor: amberLume, glow: 0.0,
                  showDate: true)

        // Theme name in the corner
        let label = theme.name as NSString
        let labelFont = NSFont(name: "Futura-Medium", size: cellSize * 0.038)
            ?? NSFont.systemFont(ofSize: cellSize * 0.038, weight: .medium)

        // Pick a label color that contrasts with the background
        var brightness: CGFloat = 1.0
        if let rgb = theme.background.usingColorSpace(.deviceRGB) {
            brightness = rgb.redComponent * 0.299
                       + rgb.greenComponent * 0.587
                       + rgb.blueComponent * 0.114
        }
        let labelColor: NSColor = brightness < 0.4
            ? NSColor(white: 1.0, alpha: 0.7)
            : NSColor(white: 0.0, alpha: 0.55)
        let labelAttrs: [NSAttributedString.Key: Any] = [
            .font: labelFont,
            .foregroundColor: labelColor,
            .kern: 1.0
        ]
        label.draw(at: CGPoint(x: cellRect.minX + cellSize * 0.06,
                               y: cellRect.minY + cellSize * 0.05),
                   withAttributes: labelAttrs)
    }

    image.unlockFocus()
    saveJPEG(image, to: path)
}

// MARK: - Entry

let cwd = FileManager.default.currentDirectoryPath
renderOGImage(to: "\(cwd)/web/html/og-image.jpg")
renderThemesGrid(to: "\(cwd)/assets/themes-grid.jpg")
print("Done.")
