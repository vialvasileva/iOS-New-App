//
//  ViewController.swift
//  NewApp
//
//  Created by victoria on 02.03.2026.
//

import UIKit

class FrstViewController: UIViewController {

    // MARK: - Constants

    enum Constant {
        enum Layout {
            static let columnCount: Int = 2
            static let cardHeight: CGFloat = 140.0
            static let spacing: CGFloat = 12.0
            static let sectionInset: CGFloat = 16.0
            static let headerHeight: CGFloat = 44.0
        }
        enum Card {
            static let cornerRadius: CGFloat = 16.0
            static let emojiFontSize: CGFloat = 44.0
            static let titleFontSize: CGFloat = 15.0
            static let emojiOffset: CGFloat = -12.0
            static let titleTopOffset: CGFloat = 8.0
            static let titleHorizontalOffset: CGFloat = 8.0
        }
        enum Header {
            static let fontSize: CGFloat = 20.0
            static let leadingOffset: CGFloat = 4.0
        }
    }

    // MARK: - Models

    struct CardItem {
        let emoji: String
        let title: String
        let color: UIColor
    }

    struct CardSection {
        let title: String
        let items: [CardItem]
    }

    // MARK: - Properties

    private let sections: [CardSection] = [
        CardSection(title: "Фркуты", items: [
            CardItem(emoji: "🍎", title: "Яблоко", color: .systemRed),
            CardItem(emoji: "🍊", title: "Апельсин", color: .systemOrange),
            CardItem(emoji: "🍋", title: "Лимон", color: .systemYellow),
            CardItem(emoji: "🍇", title: "Виноград", color: .systemPurple)
        ]),
        CardSection(title: "Новинки", items: [
            CardItem(emoji: "🥝", title: "Киви", color: .systemGreen),
            CardItem(emoji: "🍓", title: "Клубника", color: .systemPink),
            CardItem(emoji: "🍉", title: "Арбуз", color: .systemRed),
            CardItem(emoji: "🫐", title: "Черника", color: .systemIndigo),
        ])
    ]

    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Methods

    private func configureView() {
        navigationItem.title = "Коллекция"
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / CGFloat(Constant.Layout.columnCount)),
                heightDimension: .absolute(Constant.Layout.cardHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: Constant.Layout.spacing / 2,
                bottom: 0,
                trailing: Constant.Layout.spacing / 2
            )

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(Constant.Layout.cardHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = Constant.Layout.spacing
            section.contentInsets = NSDirectionalEdgeInsets(
                top: Constant.Layout.spacing,
                leading: Constant.Layout.sectionInset - Constant.Layout.spacing / 2,
                bottom: Constant.Layout.spacing,
                trailing: Constant.Layout.sectionInset - Constant.Layout.spacing / 2
            )

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(Constant.Layout.headerHeight)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]

            return section
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FrstViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCell.reuseIdentifier,
            for: indexPath
        ) as? CardCell else {
            return UICollectionViewCell()
        }
        let item = sections[indexPath.section].items[indexPath.item]
        cell.configure(with: item)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier,
            for: indexPath
        ) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        header.configure(with: sections[indexPath.section].title)
        return header
    }
}

// MARK: - CardCell

private final class CardCell: UICollectionViewCell {

    static let reuseIdentifier = "CardCell"

    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FrstViewController.Constant.Card.emojiFontSize)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FrstViewController.Constant.Card.titleFontSize, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func configureCellUI() {
        contentView.layer.cornerRadius = FrstViewController.Constant.Card.cornerRadius
        contentView.clipsToBounds = true

        contentView.addSubview(emojiLabel)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: FrstViewController.Constant.Card.emojiOffset),

            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: FrstViewController.Constant.Card.titleTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FrstViewController.Constant.Card.titleHorizontalOffset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FrstViewController.Constant.Card.titleHorizontalOffset)
        ])
    }

    func configure(with item: FrstViewController.CardItem) {
        emojiLabel.text = item.emoji
        titleLabel.text = item.title
        contentView.backgroundColor = item.color
    }
}

// MARK: - SectionHeaderView

private final class SectionHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "SectionHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FrstViewController.Constant.Header.fontSize, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: FrstViewController.Constant.Header.leadingOffset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
