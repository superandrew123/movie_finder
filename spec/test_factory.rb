def create_movies
  Movie.create({
      name: 'The Thing',
      year: '1983',
      description: 'Kurt Russel hits aliens.'
    })
  Movie.create({
      name: 'The Thing from Another World',
      year: '1951',
      description: 'Robert Cornthwaite hits aliens.'
    })
  Movie.create({
      name: 'Independence Day',
      year: '1996',
      description: 'Will Smith hits aliens.'
    })
end