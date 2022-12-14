// MoviesTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Фильма
final class MoviesTableViewController: UITableViewController {
    // MARK: - Private Visual Component

    private lazy var popularButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Title.Button.popular, for: .normal)
        button.backgroundColor = .red
        button.tag = 0
        button.addTarget(self, action: #selector(changeCollection), for: .touchUpInside)
        return button
    }()

    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Title.Button.top, for: .normal)
        button.backgroundColor = .red
        button.tag = 1
        button.addTarget(self, action: #selector(changeCollection), for: .touchUpInside)
        return button
    }()

    private lazy var upcommingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Title.Button.upcomming, for: .normal)
        button.backgroundColor = .red
        button.tag = 2
        button.addTarget(self, action: #selector(changeCollection), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = NSLayoutConstraint.Axis.horizontal
        view.distribution = UIStackView.Distribution.fillEqually
        view.alignment = UIStackView.Alignment.center
        view.spacing = 15
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private Property

    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    var movies: [Movie] = []
    var movie: Movie?
    lazy var session = URLSession.shared

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        obtainMovieList(category: Category.popular)
        setupUI()
        setupConstraints()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        navigationController?.navigationBar.isTranslucent = false
        title = Title.Screen.movieList
        view.addSubview(stackView)
        refreshControl = UIRefreshControl()
        stackView.addArrangedSubview(popularButton)
        stackView.addArrangedSubview(topButton)
        stackView.addArrangedSubview(upcommingButton)
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

    private func obtainMovieList(category: String) {
        guard let url =
            URL(
                string: BaseURL.movies + category + BaseURL.apiKey
            )
        else { return }
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                print("Error")
            }

            if let data = data {
                do {
                    self.movies = try JSONDecoder().decode(Results.self, from: data).movies
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        tableView.register(
            MovieTableViewCell.self,
            forCellReuseIdentifier: Identifiers.cell
        )
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
        ])
    }

    private func giveMovieID(index: Int) {
        let movieID = movies[index].id
        let movieViewController = MovieTableViewController()
        movieViewController.movieID = movieID
        modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(movieViewController, animated: true)
    }

    @objc private func refreshAction() {
        tableView.refreshControl?.beginRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tableView.refreshControl?.endRefreshing()
    }

    @objc private func changeCollection(_ button: UIButton) {
        let category: String
        switch button.tag {
        case 0:
            category = Category.popular

        case 1:
            category = Category.top

        case 2:
            category = Category.upcoming

        default:
            category = Category.popular
        }
        obtainMovieList(category: category)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = MovieTableViewCell(style: .default, reuseIdentifier: Identifiers.cell)
        cell.updateCell(movie: movie)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveMovieID(index: indexPath.row)
    }
}
