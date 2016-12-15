MovieFinder = {
  init: function(){

  },
  readInput: function(keyPress){
    debugger;
  },
  search: function(search_term){
    $.ajax({
      method: 'get', 
      dataType: 'json', 
      url: 'http://moviefinder.amiksch.com/search',
      data: {
        q: search_term
      },
      complete: function(){
        debugger;
      }
    });
  }
}