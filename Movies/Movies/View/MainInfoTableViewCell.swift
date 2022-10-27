// MainInfoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Информация о фильме
final class MainInfoTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .black)
        return label
    }()

    let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .black)
        return label
    }()

    let taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()

    let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .label
        label.clipsToBounds = true
        label.backgroundColor = .clear
        return label
    }()

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupUI()
//        setupConstraints()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(overviewLabel)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        addSubview(genresLabel)
        addSubview(taglineLabel)
        addSubview(runtimeLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            originalTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),

            runtimeLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            runtimeLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 10),

            genresLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 1),
            genresLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),

            taglineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            taglineLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 10),
            taglineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            overviewLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }

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
}
