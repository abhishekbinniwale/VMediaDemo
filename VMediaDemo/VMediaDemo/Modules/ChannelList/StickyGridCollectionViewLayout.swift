//
//  StickyGridCollectionViewLayout.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import UIKit

class StickyGridCollectionViewLayout: UICollectionViewFlowLayout {

    var stickyRowsCount = 0 {
        didSet {
            invalidateLayout()
        }
    }

    var stickyColumnsCount = 0 {
        didSet {
            invalidateLayout()
        }
    }

    private var allAttributes: [[UICollectionViewLayoutAttributes]] = []
    private var contentSize = CGSize.zero

    func isItemSticky(at indexPath: IndexPath) -> Bool {
        return indexPath.item < stickyColumnsCount || indexPath.section < stickyRowsCount
    }

    // MARK: - Collection view flow layout methods

    override var collectionViewContentSize: CGSize {
        return contentSize
    }

    override func prepare() {
        setupAttributes()
        updateStickyItemsPositions()

        let lastItemFrame = allAttributes.last?.last?.frame ?? .zero
        contentSize = CGSize(width: round(lastItemFrame.maxX), height: round(lastItemFrame.maxY))
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for rowAttrs in allAttributes {
            for itemAttrs in rowAttrs where rect.intersects(itemAttrs.frame) {
                layoutAttributes.append(itemAttrs)
            }
        }

        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // MARK: - Sizing

    private var rowsCount: Int {
        return collectionView!.numberOfSections
    }

    private func columnsCount(in row: Int) -> Int {
        return collectionView!.numberOfItems(inSection: row)
    }

    private func size(forRow row: Int, column: Int) -> CGSize {
        guard let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout,
            let size = delegate.collectionView?(collectionView!, layout: self, sizeForItemAt: IndexPath(row: row, column: column)) else {
            assertionFailure("Implement collectionView(_,layout:,sizeForItemAt: in UICollectionViewDelegateFlowLayout")
            return .zero
        }

        return size
    }

    // MARK: - Helpers

    private func setupAttributes() {
        allAttributes = []

        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0

        for row in 0..<rowsCount {
            var rowAttrs: [UICollectionViewLayoutAttributes] = []
            xOffset = 0

            for col in 0..<columnsCount(in: row) {
                let itemSize = size(forRow: row, column: col)
                let indexPath = IndexPath(row: row, column: col)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: round(itemSize.width), height: round(itemSize.height)).integral

                rowAttrs.append(attributes)

                xOffset += round(itemSize.width) + (row == 0 ? 0 : 2)
            }

            yOffset += round(rowAttrs.last?.frame.height ?? 0.0) + (row == 0 ? 0 : 2)
            allAttributes.append(rowAttrs)
        }
    }

    private func updateStickyItemsPositions() {
        for row in 0..<rowsCount {
            for col in 0..<columnsCount(in: row) {
                let attributes = allAttributes[row][col]

                if row < stickyRowsCount {
                    var frame = attributes.frame
                    frame.origin.y += round(collectionView!.contentOffset.y)
                    frame.origin.x = round(frame.origin.x)
                    attributes.frame = frame
                }

                if col < stickyColumnsCount {
                    var frame = attributes.frame
                    frame.origin.x += round(collectionView!.contentOffset.x)
                    frame.origin.y = round(frame.origin.y)
                    attributes.frame = frame
                }

                attributes.zIndex = zIndex(forRow: row, column: col)
            }
        }
    }

    private func zIndex(forRow row: Int, column col: Int) -> Int {
        if row < stickyRowsCount && col < stickyColumnsCount {
            return ZOrder.staticStickyItem
        } else if row < stickyRowsCount || col < stickyColumnsCount {
            return ZOrder.stickyItem
        } else {
            return ZOrder.commonItem
        }
    }

}

// MARK: - IndexPath

private extension IndexPath {
    init(row: Int, column: Int) {
        self = IndexPath(item: column, section: row)
    }
}

// MARK: - ZOrder

private enum ZOrder {
    static let commonItem = 0
    static let stickyItem = 1
    static let staticStickyItem = 2
}
