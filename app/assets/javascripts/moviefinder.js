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
      url: 'http://localhost:3000/search',
      data: {
        q: search_term
      },
      complete: function(){
        debugger;
      }
    });
  }
}