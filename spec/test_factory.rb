def create_movies
  Movie.create({
      name: 'The Thing',
      year: '1983',
      description: 'Kurt Russel hits aliens.',
      image: 'test.jpg'
    })
  Movie.create({
      name: 'The Thing from Another World',
      year: '1951',
      description: 'Robert Cornthwaite hits aliens.',
      image: 'test.jpg'
    })
  Movie.create({
      name: 'Independence Day',
      year: '1996',
      description: 'Will Smith hits aliens.',
      image: 'test.jpg'
    })
  Movie.create({
      name: 'Star Trek: Nemesis',
      year: '2002',
      description: 'Patric Stewart hits aliens.',
      image: 'test.jpg'
    })
  Movie.create({
      name: 'Star Trek II: The Wrath of Khan',
      year: '1982',
      description: 'William Shatner hits aliens.',
      image: 'test.jpg'
    })
  Movie.create({
      name: 'Elf',
      year: '2003',
      description: 'Will Ferrel hits candy.',
      image: 'test.jpg'
    })
end