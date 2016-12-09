MovieFinder = {
  search_results: [],
  readInput: function(e){
    e.preventDefault();
    const search_text = $('#search-field').val();
    if(search_text.length > 2){
      $("#search-results").html('');
      $("#loading").animate({'height': '160px'},
        function(){
          MovieFinder.search(search_text);
        }
      );
    }
  },
  search: function(search_term){
    $.ajax({
      method: 'get', 
      dataType: 'json', 
      url: 'http://localhost:3000/search',
      data: {
        q: search_term
      },
      success: function(data){
        $("#loading").css({'height': '0px'});
        MovieFinder.buildSearchResults(data);
      },
      failure: function(){
        console.log('search failure');
      }
    });
  },
  buildSearchResults: function(data){
    var html = '';
    for(var i = 0; i < data.length; i++){
      let year = !!data[i].year ? data[i].year : '';
      html += '<div data-id="' + data[i].id + '" class="search-result-container">';
        html += '<img class="search-image" src="' + data[i].image + '">'
        html += '<div class="search-data-container">';
          html += '<p class="title">' + data[i].name + '</p>';
          html += '<p class="year">' + year + '</p>';
          html += '<p class="search-description">' + data[i].description + '</p>';
          html += '<p class=""></p>';
        html += '</div>'
      html += '</div>';
    }
    $('#search-results').html(html);
    $('.search-result-container').click(MovieFinder.availabilityRequest);
  },
  availabilityRequest: function(event){
    var movie_id = $(this).attr('data-id');
    $.ajax({
      method: 'get',
      dataType: 'json',
      url: 'http://localhost:3000/search',
      data: {
        movie_id: movie_id
      },
      success: function(){
        debugger;
      },
      failure: function(){
        console.log('availability failure failure');
      }
    });
  }
}