//
//  MainViewController.swift
//  NewApp
//
//  Created by victoria on 02.03.2026.
//

import SwiftUI

struct ScndViewController: View {

    // MARK: - Constants

    private enum Constant {
        enum Layout {
            static let columns: Int = 2
            static let spacing: CGFloat = 12.0
            static let horizontalPadding: CGFloat = 16.0
            static let cardHeight: CGFloat = 140.0
            static let cornerRadius: CGFloat = 16.0
        }
        enum Card {
            static let emojiFontSize: CGFloat = 44.0
            static let emojiOffset: CGFloat = -12.0
            static let titleTopOffset: CGFloat = 8.0
        }
        enum Header {
            static let fontSize: CGFloat = 20.0
            static let bottomPadding: CGFloat = 4.0
        }
    }

    // MARK: - Models

    private struct CardItem {
        let emoji: String
        let title: String
        let color: Color
    }

    private struct CardSection {
        let title: String
        let items: [CardItem]
    }

    // MARK: - Properties

    private let sections: [CardSection] = [
        CardSection(title: "Фркуты", items: [
            CardItem(emoji: "🍎", title: "Яблоко", color: .red),
            CardItem(emoji: "🍊", title: "Апельсин", color: .orange),
            CardItem(emoji: "🍋", title: "Лимон", color: .yellow),
            CardItem(emoji: "🍇", title: "Виноград", color: .purple)
        ]),
        CardSection(title: "Ягоды", items: [
            CardItem(emoji: "🥝", title: "Киви", color: .green),
            CardItem(emoji: "🍓", title: "Клубника", color: .pink),
            CardItem(emoji: "🍉", title: "Арбуз", color: .red),
            CardItem(emoji: "🫐", title: "Черника", color: .indigo),
        ])
    ]

    private let gridColumns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 2
    )

    // MARK: - Body

    var body: some View {
        ScrollView {
            contentView
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Коллекция")
    }

    // MARK: - Content

    private var contentView: some View {
        LazyVGrid(columns: gridColumns, spacing: Constant.Layout.spacing) {
            ForEach(sections, id: \.title) { section in
                sectionView(section)
            }
        }
        .padding(.horizontal, Constant.Layout.horizontalPadding)
    }

    // MARK: - Section

    private func sectionView(_ section: CardSection) -> some View {
        Section {
            ForEach(section.items, id: \.title) { item in
                cardView(item)
            }
        } header: {
            headerView(title: section.title)
        }
    }

    private func headerView(title: String) -> some View {
        Text(title)
            .font(.system(size: Constant.Header.fontSize, weight: .bold))
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, Constant.Header.bottomPadding)
            .padding(.top, Constant.Layout.spacing)
    }

    // MARK: - Card

    private func cardView(_ item: CardItem) -> some View {
        ZStack {
            item.color

            VStack(spacing: 0) {
                Spacer()
                Text(item.emoji)
                    .font(.system(size: Constant.Card.emojiFontSize))
                    .offset(y: Constant.Card.emojiOffset)
                Text(item.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top, Constant.Card.titleTopOffset)
                Spacer()
            }
        }
        .frame(height: Constant.Layout.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: Constant.Layout.cornerRadius))
    }
}

#Preview {
    NavigationStack {
        ScndViewController()
    }
}
