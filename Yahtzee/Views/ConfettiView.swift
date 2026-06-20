//
//  ConfettiView.swift
//  Rollzee
//
//  Created by Coding Assistant on 6/19/26.
//

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    @Environment(\.layoutMetrics) private var layoutMetrics

    func makeUIView(context: Context) -> ConfettiEmitterView {
        ConfettiEmitterView(scale: layoutMetrics.scale)
    }

    func updateUIView(_ uiView: ConfettiEmitterView, context: Context) {
        uiView.scale = layoutMetrics.scale
    }
}

final class ConfettiEmitterView: UIView {
    var scale: CGFloat {
        didSet {
            guard oldValue != scale else {
                return
            }

            configureEmitter()
        }
    }

    private var particleScale: CGFloat {
        max(1, scale * scale)
    }

    private let emitterLayer = CAEmitterLayer()
    private var hasStartedBurst = false

    init(scale: CGFloat) {
        self.scale = scale
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        backgroundColor = .clear
        layer.addSublayer(emitterLayer)
        configureEmitter()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        startBurstIfReady()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: max(60 * scale, bounds.height * 0.1))
        emitterLayer.emitterSize = CGSize(width: 12 * particleScale, height: 12 * particleScale)
        startBurstIfReady()
    }

    private func configureEmitter() {
        emitterLayer.emitterShape = .point
        emitterLayer.emitterMode = .points
        emitterLayer.renderMode = .oldestLast
        emitterLayer.birthRate = 0
        emitterLayer.emitterCells = ConfettiColor.allCases.map { color in
            makeEmitterCell(color: color)
        }
    }

    private func startBurstIfReady() {
        guard window != nil, bounds.width > 0, bounds.height > 0, !hasStartedBurst else {
            return
        }

        hasStartedBurst = true
        emitterLayer.birthRate = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) { [weak self] in
            self?.emitterLayer.birthRate = 0
        }
    }

    private func makeEmitterCell(color: ConfettiColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = color.image.cgImage
        cell.birthRate = 32
        cell.lifetime = 5.5
        cell.lifetimeRange = 0.4
        cell.velocity = 170
        cell.velocityRange = 65
        cell.emissionLongitude = -.pi / 2
        cell.emissionRange = .pi * 0.95
        cell.yAcceleration = 230
        cell.xAcceleration = 0
        cell.spin = 2.4
        cell.spinRange = 3.5
        cell.scale = 0.65 * particleScale
        cell.scaleRange = 0.18 * particleScale
        return cell
    }
}

private enum ConfettiColor: CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case pink

    var uiColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 0.92, green: 0.42, blue: 0.42, alpha: 1)
        case .orange:
            return UIColor(red: 0.95, green: 0.62, blue: 0.34, alpha: 1)
        case .yellow:
            return UIColor(red: 0.95, green: 0.82, blue: 0.36, alpha: 1)
        case .green:
            return UIColor(red: 0.38, green: 0.76, blue: 0.52, alpha: 1)
        case .blue:
            return UIColor(red: 0.38, green: 0.64, blue: 0.88, alpha: 1)
        case .purple:
            return UIColor(red: 0.68, green: 0.52, blue: 0.86, alpha: 1)
        case .pink:
            return UIColor(red: 0.92, green: 0.52, blue: 0.70, alpha: 1)
        }
    }

    var image: UIImage {
        let width = Int.random(in: 2...5)
        let heightDelta = Int.random(in: 0...4)
        let size = CGSize(width: width, height: width + heightDelta)
        return UIGraphicsImageRenderer(size: size).image { context in
            uiColor.setFill()
            UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()
        }
    }
}

#Preview {
    ConfettiView()
}
