MovieFinder = {
  search_results: [],
  init: function(){
    $('#search-results').html('');
    $('#availability-results').html('');
  },
  readInput: function(e){
    MovieFinder.init();
    e.preventDefault();
    var search_text = $('#search-field').val();
    if(search_text.length > 2){
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
      url: 'http://moviefinder.amiksch.com/search',
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
  expandSearch: function(e){
    e.preventDefault();
    $("#loading").animate({'height': '160px'}, function(){
      $.ajax({
        method: 'get', 
        dataType: 'json', 
        url: 'http://moviefinder.amiksch.com/expand_search',
        data: {
          q: $('#search-field').val()
        },
        success: function(data){
          $("#loading").css({'height': '0px'});
          MovieFinder.buildSearchResults(data);
        },
        failure: function(){
          console.log('search failure');
        }
      });
    });
  },
  buildSearchResults: function(data){
    var html = '';
    html += '<p class="search-more">Don\'t see your movie? <a class="expand-search">Click here</a> to expand your search.</p>';
    for(var i = 0; i < data.length; i++){
      var year = !!data[i].year ? data[i].year : '';
      var image_src = !!data[i].image ? data[i].image : 'icon128.png';
      html += '<div data-id="' + data[i].id + '" class="search-result-container">';
        html += '<img class="search-image" src="' + image_src + '">';
        html += '<div class="search-data-container">';
          html += '<p class="title">' + data[i].title + '</p>';
          html += '<p class="year">' + year + '</p>';
          html += '<p class="search-description">' + data[i].description + '</p>';
          html += '<p class=""></p>';
        html += '</div>'
      html += '</div>';
    }
    $('#search-results').html(html);
    $('.expand-search').click(MovieFinder.expandSearch);
    $('.search-result-container').click(MovieFinder.availabilityRequest);
  },
  availabilityRequest: function(event){
    var movie_id = $(this).attr('data-id');
    $('.search-result-container').hide();
    $(this).show();
    $("#loading").animate({'height': '160px'},function(){
      $.ajax({
        method: 'get',
        dataType: 'json',
        url: 'http://moviefinder.amiksch.com/availability',
        data: {
          q: movie_id
        },
        success: function(data){
          $("#loading").css({'height': '0px'});
          MovieFinder.buildAvailabilityResults(data);
        },
        failure: function(){
          console.log('availability failure failure');
        }
      });
    });
  },
  buildAvailabilityResults: function(data){
    $("#loading").css({'height': '0px'});
    if(!!data['error']){
      var error_html = '<p class="availability-error">Error: ' + data['error'] + '</p>';
      $('#availability-results').html(error_html);
      return '';
    }
    var availability_html = '';
    availability_html += '<div class="availability-container col-md-6">';
      availability_html += '<div class="logo netflix">Neflix:</div> ';
      availability_html += '<div class="status">' + data.netflix + '</div>';
    availability_html += '</div>';
    if(data.amazon != 'Error'){
      availability_html += '<div class="availability-container col-md-6">';
        availability_html += '<div class="logo amazon">Amazon:</div> ';
        availability_html += '<div class="status">' + data.amazon + '</div>';
      availability_html += '</div>';
    }
    $('#availability-results').html(availability_html);
  }
}