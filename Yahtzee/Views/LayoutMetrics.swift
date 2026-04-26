//
//  LayoutMetrics.swift
//  Rollzee
//
//  Created by Tom Hartnett on 4/25/26.
//

import SwiftUI

struct LayoutMetrics {
    let scale: CGFloat

    var maxContentWidth: CGFloat {
        400 * scale
    }

    var horizontalPadding: CGFloat {
        16 * scale
    }

    var bottomPadding: CGFloat {
        16 * scale
    }

    var scoreBoxSize: CGFloat {
        40 * scale
    }

    var scoreBorderWidth: CGFloat {
        2 * scale
    }

    var selectedScoreBorderWidth: CGFloat {
        4 * scale
    }

    var playerScoreImageSize: CGFloat {
        50 * scale
    }

    var playerScoreValueWidth: CGFloat {
        50 * scale
    }

    var playerScoreSpacing: CGFloat {
        8 * scale
    }

    var footerButtonHeight: CGFloat {
        40 * scale
    }

    var rollIndicatorSize: CGFloat {
        20 * scale
    }

    var titleFontSize: CGFloat {
        28 * scale
    }

    var bodyFontSize: CGFloat {
        20 * scale
    }

    var largeSymbolFontSize: CGFloat {
        34 * scale
    }

    var gameOverEmojiFontSize: CGFloat {
        64 * scale
    }

    var gameOverSpacing: CGFloat {
        24 * scale
    }

    var opponentTurnDieSize: CGFloat {
        30 * scale
    }

    var opponentTurnDieSpacing: CGFloat {
        8 * scale
    }

    var opponentTurnTextSize: CGFloat {
        22 * scale
    }

    static let standard = LayoutMetrics(scale: 1)

    static func adaptive(for size: CGSize, safeAreaInsets: EdgeInsets) -> LayoutMetrics {
        let horizontalInset: CGFloat = 32
        let verticalInset: CGFloat = 32
        let availableWidth = size.width - horizontalInset
        let availableHeight = size.height - verticalInset - safeAreaInsets.bottom
        let widthScale = availableWidth / 400
        let heightScale = availableHeight / 780
        let rawScale = min(widthScale, heightScale)
        let flooredScale = max(rawScale, 0.9)
        let scale = min(flooredScale, 1.5)
        return LayoutMetrics(scale: scale)
    }
}

private struct LayoutMetricsKey: EnvironmentKey {
    static let defaultValue = LayoutMetrics.standard
}

extension EnvironmentValues {
    var layoutMetrics: LayoutMetrics {
        get { self[LayoutMetricsKey.self] }
        set { self[LayoutMetricsKey.self] = newValue }
    }
}
