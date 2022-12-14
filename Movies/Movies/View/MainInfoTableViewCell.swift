// MainInfoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Информация о фильме
final class MainInfoTableViewCell: UITableViewCell {
    // MARK: - Private Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .black)
        return label
    }()

    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .black)
        return label
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .label
        label.clipsToBounds = true
        label.backgroundColor = .clear
        return label
    }()

    private let clockImageView: UIImageView = {
        let clockImage = UIImageView(image: UIImage(systemName: "clock"))
        clockImage.translatesAutoresizingMaskIntoConstraints = false
        clockImage.contentMode = .scaleAspectFill
        clockImage.tintColor = .gray
        return clockImage
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func updateCell(movie: MovieDetail) {
        var genresSring = ""

        for genre in movie.genres {
            genresSring.append(genre.name + " ")
        }
        runtimeLabel.text = String(format: "%d ч. %d мин.", movie.runtime / 60, movie.runtime % 60)

        titleLabel.attributedText = NSMutableAttributedString().bold("\(movie.title)")

        originalTitleLabel.attributedText =
            NSMutableAttributedString()
                .normal("\(movie.originalTitle) ")
                .normalGray("(\(movie.releaseDate.components(separatedBy: "-").first ?? ""))")
        genresLabel.text = genresSring
        taglineLabel.text = movie.tagline
        overviewLabel.attributedText =
            NSMutableAttributedString()
                .bold("Описание\n")
                .normal("\n\(movie.overview)")
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(overviewLabel)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        addSubview(genresLabel)
        addSubview(taglineLabel)
        addSubview(runtimeLabel)
        addSubview(clockImageView)
        titleLabelConstraints()
        originalTitleLabelConstraints()
        runtimeLabelConstraints()
        clockImageViewConstraints()
        genresLabelConstraints()
        taglineLabelConstraints()
        overviewLabelConstraints()
    }

    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }

    private func originalTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            originalTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
        ])
    }

    private func runtimeLabelConstraints() {
        NSLayoutConstraint.activate([
            runtimeLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor, constant: 10),
            runtimeLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 10),
        ])
    }

    private func clockImageViewConstraints() {
        NSLayoutConstraint.activate([
            clockImageView.centerYAnchor.constraint(equalTo: runtimeLabel.centerYAnchor),
            clockImageView.trailingAnchor.constraint(equalTo: runtimeLabel.leadingAnchor, constant: -5),
            clockImageView.heightAnchor.constraint(equalTo: runtimeLabel.heightAnchor),
        ])
    }

    private func genresLabelConstraints() {
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 5),
            genresLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
        ])
    }

    private func taglineLabelConstraints() {
        NSLayoutConstraint.activate([
            taglineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            taglineLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 10),
            taglineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }

    private func overviewLabelConstraints() {
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            overviewLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
}
