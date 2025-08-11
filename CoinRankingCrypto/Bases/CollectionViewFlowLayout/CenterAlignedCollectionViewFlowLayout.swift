
import UIKit

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }

        let leftPadding: CGFloat = 0
        let interItemSpacing = minimumInteritemSpacing
        var leftMargin: CGFloat = leftPadding
        var maxY: CGFloat = -1.0
        var rowSizes: [[CGFloat]] = []
        var currentRow = 0
        for layoutAttribute in attributes {
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = leftPadding
                if rowSizes.count == 0 {
                    rowSizes = [[leftMargin, 0]]
                } else {
                    rowSizes.append([leftMargin, 0])
                    currentRow += 1
                }
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
            rowSizes[currentRow][1] = leftMargin - interItemSpacing
        }

        leftMargin = leftPadding
        maxY = -1.0
        currentRow = 0
        for layoutAttribute in attributes {
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = leftPadding
                let rowWidth = rowSizes[currentRow][1] - rowSizes[currentRow][0]
                let appendedMargin = (collectionView!.frame.width - leftPadding - rowWidth - leftPadding) / 2
                leftMargin += appendedMargin
                currentRow += 1
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }

        return attributes
    }
}
