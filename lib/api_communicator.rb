require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  collect = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash['results'].each do |hash_character|
     if hash_character['name'] == character
      hash_character['films'].select do |film|
        all_films = RestClient.get(film)
        films_hash = JSON.parse(all_films)
        # puts films_hash
        collect << films_hash
        # puts films_hash['title']
      end
      p collect

    end
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  # binding.pry

        films_hash.find do |info|
          film_url = info["films"]
          film_url.map do |url|
            all_films = RestClient.get(url)
            film_hash = JSON.parse(all_films)
            film_titles = film_hash['title']
            puts film_titles
        end
      end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
