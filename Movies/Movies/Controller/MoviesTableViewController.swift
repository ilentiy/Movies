// MoviesTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Фильма
final class MoviesTableViewController: UITableViewController {
    // MARK: - Private Visual Component

    lazy var popularButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Популярное", for: .normal)
        button.backgroundColor = .red
        button.tag = 0
        button.addTarget(self, action: #selector(changeCollection), for: .touchUpInside)
        return button
    }()

    lazy var topButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("В топе", for: .normal)
        button.backgroundColor = .red
        button.tag = 1
        button.addTarget(self, action: #selector(changeCollection), for: .touchUpInside)
        return button
    }()

    lazy var upcommingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Скоро", for: .normal)
        button.backgroundColor = .red
        button.tag = 2
        button.addTarget(self, action: #selector(changeCollection), for: .touchUpInside)
        return button
    }()

    let stackView: UIStackView = {
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

    let cellReuseIdendifier = "cell"
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    var movies: [Movie] = []
    var movie: Movie?
    lazy var session = URLSession.shared

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/popular?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
            )
        else { return }
        obtainMovieList(url: url)
        setupUI()
        setupConstraints()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        navigationController?.navigationBar.isTranslucent = false
        stackView.addArrangedSubview(popularButton)
        stackView.addArrangedSubview(topButton)
        stackView.addArrangedSubview(upcommingButton)
        view.addSubview(stackView)
        refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

    @objc private func refreshAction() {
        tableView.refreshControl?.beginRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tableView.refreshControl?.endRefreshing()
    }

    @objc private func changeCollection(_ button: UIButton) {
        var url: URL?
        switch button.tag {
        case 0:
            url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/popular?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
                )
        case 1:
            url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/top_rated?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
                )
        case 2:
            url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/upcoming?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
                )
        default:
            url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/popular?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
                )
        }
        guard let url = url else { return }
        obtainMovieList(url: url)
    }

    func obtainMovieList(url: URL) {
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                print("Error")
            }

            if let data = data {
                do {
                    self.movies = try JSONDecoder().decode(Results.self, from: data).results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
        tableView.register(
            MovieTableViewCell.self,
            forCellReuseIdentifier: cellReuseIdendifier
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = MovieTableViewCell(style: .default, reuseIdentifier: cellReuseIdendifier)
        cell.updateCell(movie: movie)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = movies[indexPath.row].id
        let movieViewController = MovieTableViewController()
        movieViewController.movieID = movieId
        modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(movieViewController, animated: true)
    }
}
